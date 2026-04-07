"""
Recommendation Model — Pydantic Schemas
=========================================

Defines Pydantic schemas for recommendation-related data:

1. RecommendationResponse (returned by GET /recommend):
   - recommended_app: str   — the best app to use right now
   - score: float           — confidence score (0–100)
   - reason: str            — human-readable explanation
   - alternatives: list     — ranked list of other apps with scores
   - is_peak_hour: bool     — whether the recommendation factors peak traffic
   - timestamp: datetime

2. AppScore (individual app scoring details):
   - upi_app: str
   - success_rate: float
   - avg_latency_ms: int
   - composite_score: float

3. RecommendationRecord (full DB row for analytics):
   - id: UUID
   - user_id: UUID
   - recommended_app: str
   - score: float
   - reason: str
   - was_accepted: bool | None
   - created_at: datetime
"""

# TODO: Import BaseModel, Field, UUID4 from pydantic
# TODO: Import Optional, datetime

# TODO: Define AppScore(BaseModel) schema
# TODO: Define RecommendationResponse(BaseModel) schema
# TODO: Define RecommendationRecord(BaseModel) schema
