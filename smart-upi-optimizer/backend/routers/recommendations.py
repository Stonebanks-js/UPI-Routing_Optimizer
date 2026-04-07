import uuid
from fastapi import APIRouter, Depends, Query, HTTPException
from sqlalchemy.orm import Session
from backend.db.database import get_db
from backend.engine.rule_engine import get_recommendation
from backend.models.recommendation_model import RecommendationResponse

router = APIRouter()

@router.get(
    "/suggest",
    summary="Suggest the best installed UPI app",
    description="Scores provided installed apps according to recent real-time latency and transaction success logic.",
    response_model=RecommendationResponse
)
def suggest_route(
    user_id: uuid.UUID,
    available_apps: str = Query(..., description="Comma separated list of installed apps e.g. gpay,phonepe"),
    db: Session = Depends(get_db)
):
    try:
        # 1. Parse string into List[str] appropriately avoiding whitespaces and blanks
        parsed_apps = [app.strip().lower() for app in available_apps.split(",") if app.strip()]
        
        # 2. Validation bounds tracking proper literals
        permitted_apps = {"gpay", "phonepe", "paytm"}
        for app in parsed_apps:
            if app not in permitted_apps:
                raise ValueError(f"Invalid app identified: {app}. Allowed values are: {permitted_apps}")
                
        if not parsed_apps:
            raise ValueError("No available apps properly provided for scoring")

        # 3. Request logic via internal Engine
        response = get_recommendation(user_id=user_id, available_apps=parsed_apps, db=db)
        
        # 4. Standard completion block
        return response

    except ValueError as val_e:
        raise HTTPException(status_code=422, detail=str(val_e))
    except Exception as e:
        raise HTTPException(status_code=422, detail=str(e))
