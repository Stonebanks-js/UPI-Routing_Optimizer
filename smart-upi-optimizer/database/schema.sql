-- ============================================================
-- Smart UPI Routing Optimizer — Database Schema
-- ============================================================
-- This file defines the 4 core tables:
--   1. users              — registered app users
--   2. transactions        — every UPI payment attempt logged
--   3. app_performance     — aggregated success metrics per UPI app
--   4. recommendations     — recommendation history per user
--
-- Database: PostgreSQL 15
-- ============================================================

-- ── 1. Users ────────────────────────────────────────────────
-- Stores basic user profile information.
-- Each user is identified by a unique UUID.
CREATE TABLE users (
    id              UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    device_id       VARCHAR(255) NOT NULL UNIQUE,
    display_name    VARCHAR(100),
    created_at      TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at      TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- ── 2. Transactions ─────────────────────────────────────────
-- Logs every UPI payment attempt with its outcome.
-- No sensitive financial data is stored — only metadata.
CREATE TABLE transactions (
    id              UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id         UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    upi_app         VARCHAR(50) NOT NULL,          -- 'google_pay' | 'phonepe' | 'paytm'
    status          VARCHAR(20) NOT NULL,           -- 'success' | 'failure' | 'pending'
    latency_ms      INTEGER,                        -- response time in milliseconds
    amount_range    VARCHAR(20),                    -- '0-500' | '500-2000' | '2000+' (bucketed, not exact)
    error_code      VARCHAR(50),                    -- UPI error code if failed (nullable)
    timestamp       TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- ── 3. App Performance ──────────────────────────────────────
-- Aggregated performance snapshot for each UPI app.
-- Updated periodically by the scoring engine.
CREATE TABLE app_performance (
    id              UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    upi_app         VARCHAR(50) NOT NULL,           -- 'google_pay' | 'phonepe' | 'paytm'
    time_window     VARCHAR(20) NOT NULL,           -- 'peak' | 'off_peak' | 'all_day'
    success_rate    DECIMAL(5, 2) NOT NULL,         -- percentage (0.00 – 100.00)
    avg_latency_ms  INTEGER,                        -- average response time
    total_txns      INTEGER DEFAULT 0,              -- total transactions in window
    last_updated    TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    UNIQUE (upi_app, time_window)
);

-- ── 4. Recommendations ──────────────────────────────────────
-- Stores every recommendation served to a user.
-- Used for analytics and model feedback loops.
CREATE TABLE recommendations (
    id              UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id         UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    recommended_app VARCHAR(50) NOT NULL,           -- the app we suggested
    score           DECIMAL(5, 2) NOT NULL,         -- confidence score (0–100)
    reason          TEXT,                            -- human-readable explanation
    was_accepted    BOOLEAN DEFAULT NULL,            -- did the user follow our suggestion?
    created_at      TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- ── Indexes ─────────────────────────────────────────────────
CREATE INDEX idx_transactions_user_id ON transactions(user_id);
CREATE INDEX idx_transactions_timestamp ON transactions(timestamp);
CREATE INDEX idx_transactions_upi_app ON transactions(upi_app);
CREATE INDEX idx_recommendations_user_id ON recommendations(user_id);
