from sqlalchemy import text
from sqlalchemy.exc import SQLAlchemyError
from sqlalchemy.orm import Session

def create_user(db: Session, device_id: str):
    """
    Inserts a user into the users table if their device_id does not exist,
    otherwise returns the existing user's user_id.

    Args:
        db (Session): The database session.
        device_id (str): The unique string identifying the user's device.

    Returns:
        str: The user_id UUID of the created or existing user, or None if an error occurs.
    """
    sql = text('''
        INSERT INTO users (device_id)
        VALUES (:device_id)
        ON CONFLICT (device_id) DO UPDATE SET device_id = EXCLUDED.device_id
        RETURNING user_id;
    ''')
    try:
        result = db.execute(sql, {"device_id": device_id})
        db.commit()
        row = result.fetchone()
        return str(row[0]) if row else None
    except SQLAlchemyError as e:
        db.rollback()
        print(f"Database error in create_user: {e}")
        return None

def log_transaction(db: Session, user_id: str, app_used: str, status: str, latency_ms: int):
    """
    Logs a UPI payment attempt into the transactions table.

    Args:
        db (Session): The database session.
        user_id (str): The UUID of the user making the transaction.
        app_used (str): The name of the UPI app used (e.g., 'google_pay').
        status (str): The transaction outcome ('success' or 'failure').
        latency_ms (int): Latency of the transaction in milliseconds.

    Returns:
        bool: True if the log was inserted successfully, False otherwise.
    """
    sql = text('''
        INSERT INTO transactions (user_id, app_used, status, latency_ms)
        VALUES (:user_id, :app_used, :status, :latency_ms);
    ''')
    try:
        db.execute(sql, {
            "user_id": user_id,
            "app_used": app_used,
            "status": status,
            "latency_ms": latency_ms
        })
        db.commit()
        return True
    except SQLAlchemyError as e:
        db.rollback()
        print(f"Database error in log_transaction: {e}")
        return False

def get_recent_transactions(db: Session, app_name: str, minutes: int = 10):
    """
    Retrieves all transactions for a specific UPI app within the last N minutes.

    Args:
        db (Session): The database session.
        app_name (str): The name of the UPI app to query.
        minutes (int): Time window lookback in minutes (defaults to 10).

    Returns:
        list of dicts: A list containing dictionaries of the recent transaction records,
                       or an empty list if an error occurs.
    """
    sql = text('''
        SELECT txn_id, user_id, app_used, status, timestamp, latency_ms
        FROM transactions
        WHERE app_used = :app_name 
          AND timestamp >= NOW() - (:minutes * INTERVAL '1 minute')
        ORDER BY timestamp DESC;
    ''')
    try:
        result = db.execute(sql, {"app_name": app_name, "minutes": minutes})
        # Map SQL row into a python dict
        return [dict(row._mapping) for row in result]
    except SQLAlchemyError as e:
        print(f"Database error in get_recent_transactions: {e}")
        return []

def get_all_app_performance(db: Session):
    """
    Retrieves the latest aggregated performance rows for all UPI apps.

    Args:
        db (Session): The database session.

    Returns:
        list of dicts: A list containing dictionaries of app performance metrics,
                       or an empty list if an error occurs.
    """
    sql = text('''
        SELECT app_name, success_rate, failure_rate, avg_latency_ms, last_updated
        FROM app_performance;
    ''')
    try:
        result = db.execute(sql)
        return [dict(row._mapping) for row in result]
    except SQLAlchemyError as e:
        print(f"Database error in get_all_app_performance: {e}")
        return []

def save_recommendation(db: Session, user_id: str, suggested_app: str, confidence_score: float):
    """
    Records a recommendation provided to a user in the recommendations table.

    Args:
        db (Session): The database session.
        user_id (str): UUID of the user receiving the recommendation.
        suggested_app (str): Name of the suggested UPI app.
        confidence_score (float): The generated confidence score for the route.

    Returns:
        bool: True if insertion was successful, False otherwise.
    """
    sql = text('''
        INSERT INTO recommendations (user_id, suggested_app, confidence_score)
        VALUES (:user_id, :suggested_app, :confidence_score);
    ''')
    try:
        db.execute(sql, {
            "user_id": user_id,
            "suggested_app": suggested_app,
            "confidence_score": confidence_score
        })
        db.commit()
        return True
    except SQLAlchemyError as e:
        db.rollback()
        print(f"Database error in save_recommendation: {e}")
        return False
