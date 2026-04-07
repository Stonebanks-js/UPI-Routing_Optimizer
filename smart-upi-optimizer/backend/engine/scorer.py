from backend.models.recommendation_model import AppScore
from backend.engine.time_context import is_peak_hour

def calculate_success_rate(transactions: list) -> float:
    """
    Calculates the success rate from a given list of transactions.
    
    Args:
        transactions (list): List of transaction dictionaries for a specific app.
        
    Returns:
        float: Success rate (0.0 to 1.0). Returns 0.5 (neutral) if there is 
               no data in the list, ensuring no strict penalty for missing data.
    """
    if not transactions:
        return 0.5
    
    success_count = sum(1 for txn in transactions if txn.get("status") == "success")
    return success_count / len(transactions)

def calculate_confidence(success_rate: float, sample_size: int) -> float:
    """
    Calculates a confidence score derived from the success rate and sample size.
    A low sample size significantly lowers confidence even if the success rate is high.
    
    Args:
        success_rate (float): The calculated success rate for the app.
        sample_size (int): Total number of transaction logs available.
        
    Returns:
        float: Calculated confidence score, capped at 1.0.
    """
    confidence = success_rate * min(sample_size / 10.0, 1.0)
    return min(confidence, 1.0)

def get_app_score(app_name: str, transactions: list) -> AppScore:
    """
    Computes all components necessary to generate a fully populated AppScore.
    
    Args:
        app_name (str): Identifier for the requested UPI app.
        transactions (list): Recent transaction logs related to this app.
        
    Returns:
        AppScore: A generated Pydantic internal model populated with calculated metrics.
    """
    success_rate = calculate_success_rate(transactions)
    confidence = calculate_confidence(success_rate, len(transactions))
    
    return AppScore(
        app_name=app_name,
        success_rate=success_rate,
        confidence=confidence,
        is_peak_hour=is_peak_hour()
    )
