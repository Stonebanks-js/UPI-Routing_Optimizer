-- ============================================================
-- Smart UPI Routing Optimizer — Seed Data
-- ============================================================
-- Dummy rows for local development and testing.
-- Populates all 4 tables with realistic sample data.
-- ============================================================

-- ── Users ───────────────────────────────────────────────────
INSERT INTO users (id, device_id, display_name) VALUES
    ('a1b2c3d4-e5f6-7890-abcd-ef1234567890', 'DEVICE_001_PIXEL7', 'Aarav Sharma'),
    ('b2c3d4e5-f6a7-8901-bcde-f12345678901', 'DEVICE_002_SAMSUNG', 'Priya Patel'),
    ('c3d4e5f6-a7b8-9012-cdef-123456789012', 'DEVICE_003_ONEPLUS', 'Rahul Gupta');

-- ── Transactions ────────────────────────────────────────────
INSERT INTO transactions (user_id, upi_app, status, latency_ms, amount_range, error_code, timestamp) VALUES
    -- Aarav's transactions
    ('a1b2c3d4-e5f6-7890-abcd-ef1234567890', 'google_pay',  'success', 320,  '0-500',     NULL,   '2026-04-06 09:15:00+05:30'),
    ('a1b2c3d4-e5f6-7890-abcd-ef1234567890', 'phonepe',     'failure', 1500, '500-2000',  'U16',  '2026-04-06 14:30:00+05:30'),
    ('a1b2c3d4-e5f6-7890-abcd-ef1234567890', 'google_pay',  'success', 280,  '0-500',     NULL,   '2026-04-06 20:45:00+05:30'),
    ('a1b2c3d4-e5f6-7890-abcd-ef1234567890', 'paytm',       'success', 450,  '500-2000',  NULL,   '2026-04-06 21:10:00+05:30'),
    ('a1b2c3d4-e5f6-7890-abcd-ef1234567890', 'phonepe',     'success', 350,  '0-500',     NULL,   '2026-04-07 08:00:00+05:30'),

    -- Priya's transactions
    ('b2c3d4e5-f6a7-8901-bcde-f12345678901', 'phonepe',     'success', 290,  '0-500',     NULL,   '2026-04-06 10:00:00+05:30'),
    ('b2c3d4e5-f6a7-8901-bcde-f12345678901', 'google_pay',  'failure', 2000, '2000+',     'U28',  '2026-04-06 20:30:00+05:30'),
    ('b2c3d4e5-f6a7-8901-bcde-f12345678901', 'phonepe',     'success', 310,  '500-2000',  NULL,   '2026-04-06 21:00:00+05:30'),
    ('b2c3d4e5-f6a7-8901-bcde-f12345678901', 'paytm',       'failure', 1800, '0-500',     'U67',  '2026-04-07 09:30:00+05:30'),

    -- Rahul's transactions
    ('c3d4e5f6-a7b8-9012-cdef-123456789012', 'paytm',       'success', 400,  '500-2000',  NULL,   '2026-04-06 11:00:00+05:30'),
    ('c3d4e5f6-a7b8-9012-cdef-123456789012', 'google_pay',  'success', 250,  '0-500',     NULL,   '2026-04-06 15:00:00+05:30'),
    ('c3d4e5f6-a7b8-9012-cdef-123456789012', 'phonepe',     'success', 300,  '0-500',     NULL,   '2026-04-06 21:30:00+05:30'),
    ('c3d4e5f6-a7b8-9012-cdef-123456789012', 'google_pay',  'failure', 1700, '2000+',     'U16',  '2026-04-07 10:00:00+05:30');

-- ── App Performance ─────────────────────────────────────────
INSERT INTO app_performance (upi_app, time_window, success_rate, avg_latency_ms, total_txns) VALUES
    ('google_pay', 'all_day',  75.00, 310,  120),
    ('google_pay', 'peak',     65.00, 450,  45),
    ('google_pay', 'off_peak', 82.00, 270,  75),
    ('phonepe',    'all_day',  80.00, 330,  110),
    ('phonepe',    'peak',     78.00, 380,  40),
    ('phonepe',    'off_peak', 81.00, 300,  70),
    ('paytm',      'all_day',  70.00, 420,  95),
    ('paytm',      'peak',     60.00, 520,  35),
    ('paytm',      'off_peak', 76.00, 370,  60);

-- ── Recommendations ─────────────────────────────────────────
INSERT INTO recommendations (user_id, recommended_app, score, reason, was_accepted) VALUES
    ('a1b2c3d4-e5f6-7890-abcd-ef1234567890', 'google_pay', 87.50, 'Highest success rate in off-peak hours with lowest latency', TRUE),
    ('b2c3d4e5-f6a7-8901-bcde-f12345678901', 'phonepe',    82.30, 'Most consistent performance during peak hours',              TRUE),
    ('c3d4e5f6-a7b8-9012-cdef-123456789012', 'google_pay', 79.10, 'Best overall success rate for your transaction range',        NULL);
