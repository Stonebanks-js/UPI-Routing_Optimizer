import os
from sqlalchemy import create_engine
from sqlalchemy.orm import declarative_base, sessionmaker
from dotenv import load_dotenv

# Load environment variables from .env file
load_dotenv()

# We look for DB_URL as instructed, falling back to DATABASE_URL just in case 
# it was configured with the placeholder from the original .env.example
SQLALCHEMY_DATABASE_URL = os.getenv("DB_URL") or os.getenv("DATABASE_URL")

if not SQLALCHEMY_DATABASE_URL:
    raise ValueError("DB_URL environment variable is not set")

# Create the SQLAlchemy engine
# pool_pre_ping checks the connection before returning it from the pool
engine = create_engine(SQLALCHEMY_DATABASE_URL, pool_pre_ping=True)

# Create a local session factory
SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)

# Create a Base class for models
Base = declarative_base()

def get_db():
    """
    FastAPI dependency function to yield a database session
    and automatically ensure it is closed after the request is finished.
    """
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()
