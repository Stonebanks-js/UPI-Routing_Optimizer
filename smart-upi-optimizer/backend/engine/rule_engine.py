from uuid import UUID
from typing import List
from sqlalchemy.orm import Session
from backend.db.queries import get_recent_transactions
from backend.engine.scorer import get_app_score
from backend.engine.time_context import is_peak_hour
from backend.models.recommendation_model import RecommendationResponse

def get_recommendation(user_id: UUID, available_apps: List[str], db: Session) -> RecommendationResponse:
    """
    Core brain of the app that retrieves recent transaction performances,
    scores each available UPI app via analytical rules, and returns the highest
    confidence suggestion.

    Args:
        user_id (UUID): The UUID of the requesting user.
        available_apps (List[str]): List of UPI apps physically installed on the user's device.
        db (Session): The database session.

    Returns:
        RecommendationResponse: Final calculated recommendation payload to return to the mobile client.
    """
    app_scores = []
    
    # 1. Fetch recent data and calculate base scores for each available app
    for app in available_apps:
        transactions = get_recent_transactions(db=db, app_name=app, minutes=10)
        score = get_app_score(app_name=app, transactions=transactions)
        app_scores.append(score)
        
    # 2. Sort available apps descending by their raw generated confidence
    app_scores.sort(key=lambda s: s.confidence, reverse=True)
    
    avoid_apps = []
    peak_hour = is_peak_hour()
    
    # 3. Apply penalty rules
    for score in app_scores:
        if score.success_rate < 0.4:
            avoid_apps.append(score.app_name)
            if peak_hour:
                score.confidence *= 0.5  # Double penalty during peak hour
                
    # 4. Re-rank based on any newly penalized confidence adjustments
    app_scores.sort(key=lambda s: s.confidence, reverse=True)
    
    valid_options = [score for score in app_scores if score.app_name not in avoid_apps]
    
    # 5. Determine the final fallback or best app logic and reason
    if len(available_apps) == 1:
        # Edge Case: User only has one app installed at all
        best_app = app_scores[0]
        reason = "Only available option"
    elif not valid_options:
        # Edge Case: All apps are sitting structurally below acceptable bounds
        best_app = app_scores[0]
        reason = "All options degraded — choosing least bad"
    else:
        # Standard Operating Procedure
        best_app = valid_options[0]
        reason = "Best option during peak hours" if peak_hour else "Highest success rate in last 10 mins"

    return RecommendationResponse(
        suggested_app=best_app.app_name,
        confidence_score=best_app.confidence,
        reason=reason,
        avoid_apps=avoid_apps
    )
