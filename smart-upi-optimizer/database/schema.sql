-- ============================================================
-- Smart UPI Routing Optimizer — Database Schema
-- ============================================================

-- 1. users
-- Stores registered users of the app, identified by device ID.
CREATE TABLE users (
    user_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    device_id TEXT NOT NULL UNIQUE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- 2. transactions
-- Logs each payment attempt, which app was used, and the outcome.
CREATE TABLE transactions (
    txn_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID NOT NULL REFERENCES users(user_id) ON DELETE CASCADE,
    app_used TEXT NOT NULL,
    status TEXT NOT NULL CHECK (status IN ('success', 'failure')),
    timestamp TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    latency_ms INTEGER
);

-- 3. app_performance
-- Maintains aggregate statistics on each UPI app's success/failure rates.
CREATE TABLE app_performance (
    app_name TEXT PRIMARY KEY,
    success_rate FLOAT NOT NULL DEFAULT 0.0,
    failure_rate FLOAT NOT NULL DEFAULT 0.0,
    avg_latency_ms FLOAT NOT NULL DEFAULT 0.0,
    last_updated TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- 4. recommendations
-- Records the recommendations actively provided to users over time.
CREATE TABLE recommendations (
    recommendation_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID NOT NULL REFERENCES users(user_id) ON DELETE CASCADE,
    suggested_app TEXT NOT NULL,
    confidence_score FLOAT NOT NULL,
    timestamp TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- ============================================================
-- Indexes
-- ============================================================
CREATE INDEX idx_transactions_user_id ON transactions(user_id);
CREATE INDEX idx_transactions_timestamp ON transactions(timestamp);
