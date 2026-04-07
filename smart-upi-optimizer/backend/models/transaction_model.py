"""
Transaction Model — Pydantic Schemas
======================================

Defines Pydantic schemas for transaction-related data:

1. TransactionCreate (request body for POST /log-transaction):
   - user_id: UUID
   - upi_app: str          — 'google_pay' | 'phonepe' | 'paytm'
   - status: str            — 'success' | 'failure' | 'pending'
   - latency_ms: int        — response time in ms
   - amount_range: str      — '0-500' | '500-2000' | '2000+'
   - error_code: str | None — UPI error code if applicable

2. TransactionResponse (returned after logging):
   - id: UUID
   - status: str            — confirmation status ('logged')
   - timestamp: datetime

3. TransactionRecord (full DB row representation):
   - All fields from TransactionCreate + id, timestamp
"""

# TODO: Import BaseModel, Field, UUID4 from pydantic
# TODO: Import Optional, datetime

# TODO: Define UpiApp enum or Literal type: 'google_pay' | 'phonepe' | 'paytm'
# TODO: Define TransactionStatus enum or Literal: 'success' | 'failure' | 'pending'
# TODO: Define AmountRange enum or Literal: '0-500' | '500-2000' | '2000+'

# TODO: Define TransactionCreate(BaseModel) schema
# TODO: Define TransactionResponse(BaseModel) schema
# TODO: Define TransactionRecord(BaseModel) schema
