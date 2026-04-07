"""
Stats Router
=============

Handles the GET /stats endpoint.

Responsibilities:
- Returns aggregated performance statistics for all UPI apps
- Supports optional filters: time_window ('peak', 'off_peak', 'all_day'), upi_app
- Returns success rates, average latency, and total transaction counts
- Powers the stats/charts screen in the Flutter app

Response fields:
- stats (list) — array of AppPerformance objects, each containing:
    - upi_app (str)
    - time_window (str)
    - success_rate (float)
    - avg_latency_ms (int)
    - total_txns (int)
"""

# TODO: Import APIRouter from fastapi
# TODO: Import DB query functions from db/

# TODO: Create router = APIRouter(prefix="/stats", tags=["Statistics"])

# TODO: Define GET "/" endpoint
#   - Accept optional query params: upi_app, time_window
#   - Call db.queries.get_app_performance(filters)
#   - Return list of performance records
