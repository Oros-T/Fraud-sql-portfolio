-- Вставка тестовых данных
INSERT INTO users (id, reg_date, ip, device_fingerprint)
SELECT 
    generate_series(1, 1000),
    NOW() - (interval '1 day' * (random() * 30)::int),
    '192.168.' || (random() * 255)::int || '.' || (random() * 255)::int,
    'dev_' || (random() * 100)::int
FROM generate_series(1, 1000);

INSERT INTO transactions (user_id, amount, txn_time, ip, device_fingerprint, status, location)
SELECT 
    (random() * 999 + 1)::int,
    round((random() * 10000)::numeric, 2),
    NOW() - (interval '1 day' * (random() * 7)::int) - (interval '1 hour' * (random() * 23)::int),
    '192.168.' || (random() * 255)::int || '.' || (random() * 255)::int,
    'dev_' || (random() * 100)::int,
    CASE WHEN random() < 0.9 THEN 'success' ELSE 'failed' END,
    (ARRAY['Moscow', 'SPB', 'London', 'NY', 'Berlin'])[(random() * 4 + 1)::int]
FROM generate_series(1, 10000);

INSERT INTO login_attempts (user_id, login_time, ip, success)
SELECT 
    (random() * 999 + 1)::int,
    NOW() - (interval '1 day' * (random() * 7)::int) - (interval '1 hour' * (random() * 23)::int),
    '192.168.' || (random() * 255)::int || '.' || (random() * 255)::int,
    CASE WHEN random() < 0.7 THEN TRUE ELSE NULL END
FROM generate_series(1, 5000);
