from datetime import datetime, timezone
from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from backend.db.database import get_db
from backend.db.queries import get_all_app_performance

router = APIRouter()

@router.get(
    "/performance",
    summary="Retrieves core aggregate performance tracking",
    description="Loads all recent row snapshots generating UI visual tables."
)
def get_performance_route(db: Session = Depends(get_db)):
    try:
        # DB Injection pattern handles fetch without business logic
        stats = get_all_app_performance(db)
        return stats
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))

@router.get(
    "/health",
    summary="Root backend health check",
    description="Fast path verifying connection uptime and backend environment setup."
)
def get_health_route():
    try:
        return {
            "status": "ok", 
            "timestamp": datetime.now(timezone.utc).isoformat()
        }
    except Exception as e:
         raise HTTPException(status_code=500, detail=str(e))
