"""
Database Connection Setup
==========================

Configures the SQLAlchemy engine and session factory for PostgreSQL.

Responsibilities:
- Reads DATABASE_URL from environment variables (via python-dotenv)
- Creates the SQLAlchemy async/sync engine
- Provides a SessionLocal factory for dependency injection in FastAPI
- Exposes a get_db() dependency for use in route handlers

Environment Variables:
- DATABASE_URL: full PostgreSQL connection string
  e.g. postgresql://upi_user:upi_secret@localhost:5432/upi_optimizer
"""

# TODO: Import create_engine, sessionmaker from sqlalchemy
# TODO: Import declarative_base from sqlalchemy.orm
# TODO: Import os, dotenv

# TODO: Load .env file using dotenv

# TODO: Read DATABASE_URL from environment

# TODO: Create SQLAlchemy engine
#   engine = create_engine(DATABASE_URL, pool_pre_ping=True)

# TODO: Create SessionLocal factory
#   SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)

# TODO: Create Base class for ORM models (if needed later)
#   Base = declarative_base()

# TODO: Define get_db() generator for FastAPI Depends()
#   - Yields a session
#   - Ensures session is closed in finally block
