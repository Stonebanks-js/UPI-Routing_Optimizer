from datetime import datetime, timezone, timedelta

def is_peak_hour() -> bool:
    """
    Checks if the current time falls within UPI peak hours in India.
    Peak hours are defined as 8:00 PM (20:00) to 10:00 PM (22:00) IST.
    
    Returns:
        bool: True if currently in the peak window, False otherwise.
    """
    ist = timezone(timedelta(hours=5, minutes=30))
    current_time_ist = datetime.now(ist)
    return 20 <= current_time_ist.hour < 22

def get_time_weight() -> float:
    """
    Calculates the recency weight multiplier based on the current time window.

    Returns:
        float: 1.5 if currently in peak hours (amplifying recency), 1.0 otherwise.
    """
    return 1.5 if is_peak_hour() else 1.0
