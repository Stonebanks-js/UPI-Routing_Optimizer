from uuid import UUID
from typing import List
from pydantic import BaseModel, ConfigDict, field_validator

class RecommendationRequest(BaseModel):
    """
    Schema for incoming GET /recommend parameters.
    Used by the backend to identify the user and filter scoring
    based on the apps they actually have installed on their device.
    """
    model_config = ConfigDict(str_strip_whitespace=True)

    user_id: UUID
    available_apps: List[str]

    @field_validator("available_apps", mode="before")
    @classmethod
    def lowercase_apps(cls, v: list) -> list:
        """Lowercases all app names passed in the request for standardized matching."""
        if isinstance(v, list):
            return [str(app).lower() for app in v]
        return v

class AppScore(BaseModel):
    """
    Internal model used by the Recommendation Engine.
    Represents the calculated score and context for a single
    UPI app route at a specific moment in time.
    """
    model_config = ConfigDict(str_strip_whitespace=True)

    app_name: str
    success_rate: float
    confidence: float
    is_peak_hour: bool

class RecommendationResponse(BaseModel):
    """
    Schema for the outgoing recommendation sent back to the Flutter app.
    Contains the single best suggestion, its confidence rating, a human
    readable reason, and explicitly lists apps that are currently performing poorly.
    """
    model_config = ConfigDict(str_strip_whitespace=True)

    suggested_app: str
    confidence_score: float
    reason: str
    avoid_apps: List[str]
