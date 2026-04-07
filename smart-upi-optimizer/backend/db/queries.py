"""
Database Queries
=================

Contains all read/write database functions used by routers and the engine.
Each function accepts a SQLAlchemy session and returns structured data.

Functions:
-----------
Transactions:
    insert_transaction(db, txn_data)        — logs a new transaction
    get_user_transactions(db, user_id, limit) — fetches recent txns for a user
    get_all_transactions(db, filters)       — fetches txns with optional filters

App Performance:
    get_app_performance(db, upi_app, time_window) — returns aggregated stats
    upsert_app_performance(db, perf_data)          — updates performance snapshot

Recommendations:
    insert_recommendation(db, rec_data)     — logs a recommendation served
    get_user_recommendations(db, user_id)   — fetches recommendation history
    update_recommendation_acceptance(db, rec_id, accepted) — feedback loop

Users:
    get_or_create_user(db, device_id, display_name) — finds or creates a user
    get_user_by_id(db, user_id)                     — fetches user by UUID
"""

# TODO: Import Session from sqlalchemy.orm
# TODO: Import text from sqlalchemy
# TODO: Import UUID

# ── Transaction Queries ──────────────────────────────────────

# TODO: Define insert_transaction(db, txn_data) -> UUID
#   - INSERT INTO transactions (...) VALUES (...) RETURNING id

# TODO: Define get_user_transactions(db, user_id, limit=50) -> list
#   - SELECT * FROM transactions WHERE user_id = ... ORDER BY timestamp DESC LIMIT ...

# TODO: Define get_all_transactions(db, upi_app=None, status=None) -> list
#   - SELECT with optional WHERE filters

# ── App Performance Queries ──────────────────────────────────

# TODO: Define get_app_performance(db, upi_app=None, time_window=None) -> list
#   - SELECT from app_performance with optional filters

# TODO: Define upsert_app_performance(db, perf_data) -> None
#   - INSERT ... ON CONFLICT (upi_app, time_window) DO UPDATE

# ── Recommendation Queries ───────────────────────────────────

# TODO: Define insert_recommendation(db, rec_data) -> UUID
#   - INSERT INTO recommendations (...) VALUES (...) RETURNING id

# TODO: Define get_user_recommendations(db, user_id, limit=20) -> list
#   - SELECT * FROM recommendations WHERE user_id = ... ORDER BY created_at DESC

# TODO: Define update_recommendation_acceptance(db, rec_id, accepted) -> None
#   - UPDATE recommendations SET was_accepted = ... WHERE id = ...

# ── User Queries ─────────────────────────────────────────────

# TODO: Define get_or_create_user(db, device_id, display_name=None) -> dict
#   - SELECT ... WHERE device_id = ...; if not found, INSERT

# TODO: Define get_user_by_id(db, user_id) -> dict | None
#   - SELECT * FROM users WHERE id = ...
