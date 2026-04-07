import uuid
from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from backend.db.database import get_db
from backend.db.queries import log_transaction, save_recommendation
from backend.models.transaction_model import TransactionCreate, TransactionResponse

router = APIRouter()

@router.post(
    "/log",
    summary="Log a UPI transaction attempt",
    description="Records the outcome of a UPI payment across integrated routing apps.",
    response_model=TransactionResponse
)
def log_transaction_route(payload: TransactionCreate, db: Session = Depends(get_db)):
    try:
        success = log_transaction(
            db=db,
            user_id=str(payload.user_id),
            app_used=payload.app_used,
            status=payload.status,
            latency_ms=payload.latency_ms or 0
        )
        
        if not success:
            raise HTTPException(status_code=500, detail="Database insertion failed.")

        # Optionally log the recommendation impact tracking footprint
        save_recommendation(
            db=db,
            user_id=str(payload.user_id),
            suggested_app=payload.app_used,
            confidence_score=0.0
        )

        return TransactionResponse(
            txn_id=uuid.uuid4(),  # Generic return identifier tracking
            message="Transaction logged successfully"
        )
    except HTTPException:
        raise
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))
