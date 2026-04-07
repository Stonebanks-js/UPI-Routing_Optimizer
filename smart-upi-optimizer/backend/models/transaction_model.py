from uuid import UUID
from typing import Optional, Literal
from pydantic import BaseModel, ConfigDict, field_validator

class TransactionCreate(BaseModel):
    """
    Schema for the incoming POST /log-transaction request body.
    Used to validate the payload sent by the Flutter application when
    logging a completed or failed payment attempt.
    """
    model_config = ConfigDict(str_strip_whitespace=True)

    user_id: UUID
    app_used: Literal["gpay", "phonepe", "paytm"]
    status: Literal["success", "failure"]
    latency_ms: Optional[int] = None

    @field_validator("app_used", "status", mode="before")
    @classmethod
    def lowercase_fields(cls, v: str) -> str:
        """Ensures app_used and status are cleanly lowercased before type checking."""
        if isinstance(v, str):
            return v.lower()
        return v

class TransactionResponse(BaseModel):
    """
    Schema for the outgoing response after logging a transaction.
    Sent back to the Flutter app sequentially confirming the receipt
    and returning the generated database txn_id.
    """
    model_config = ConfigDict(str_strip_whitespace=True)

    txn_id: UUID
    message: str
