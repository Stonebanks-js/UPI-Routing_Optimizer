"""
Scorer — Success Rate & Latency Calculator
============================================

Computes per-app performance metrics from raw transaction data.

Responsibilities:
- Groups transactions by UPI app name
- Calculates success rate (%) for each app
- Calculates average latency (ms) for each app
- Normalizes scores to a 0–100 scale for the rule engine

Public API:
    calculate_scores(transactions: list[Transaction]) -> dict[str, AppScore]

Where AppScore is a dict with:
    - success_rate: float   (0–100)
    - avg_latency_ms: int
    - total_txns: int
    - normalized_score: float (0–100, lower latency = higher score)
"""

# TODO: Import necessary types/models

# TODO: Define calculate_scores(transactions) function
#   - Group transactions by upi_app
#   - For each app:
#       - Count total, success, failure
#       - success_rate = (success / total) * 100
#       - avg_latency = sum(latency_ms) / total
#   - Normalize latency to a 0–100 score (inverse: lower latency = higher score)
#   - Return dict keyed by app name

# TODO: Define _normalize_latency(avg_latency_ms, min_latency, max_latency) helper
#   - Converts raw latency to a 0–100 score where 100 = fastest
