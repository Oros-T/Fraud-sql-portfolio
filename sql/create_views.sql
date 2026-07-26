-- Представления для антифрода
CREATE OR REPLACE VIEW v_malicious_clusters AS
SELECT 
    t1.ip,
    t1.device_fingerprint,
    COUNT(DISTINCT t1.user_id) AS user_count,
    MIN(t1.txn_time) AS first_txn,
    MAX(t1.txn_time) AS last_txn,
    COUNT(*) AS total_txns
FROM transactions t1
JOIN users u ON t1.user_id = u.id
GROUP BY t1.ip, t1.device_fingerprint
HAVING COUNT(DISTINCT t1.user_id) >= 3
ORDER BY user_count DESC;

CREATE OR REPLACE VIEW v_bruteforce_attacks AS
SELECT 
    user_id,
    ip,
    COUNT(*) AS failed_attempts,
    MIN(login_time) AS first_fail,
    MAX(login_time) AS last_fail
FROM login_attempts
WHERE (success IS NULL OR success = FALSE)
GROUP BY user_id, ip
HAVING COUNT(*) >= 3
ORDER BY failed_attempts DESC;

CREATE OR REPLACE VIEW v_droppers AS
SELECT 
    u.id AS user_id,
    u.reg_date,
    u.ip,
    u.device_fingerprint,
    COUNT(t.id) AS txn_count,
    SUM(t.amount) AS total_withdrawn
FROM users u
LEFT JOIN transactions t ON u.id = t.user_id
LEFT JOIN login_attempts l ON u.id = l.user_id
WHERE l.id IS NULL
  AND u.reg_date > NOW() - INTERVAL '30 days'
GROUP BY u.id, u.reg_date, u.ip, u.device_fingerprint
HAVING SUM(t.amount) > 0
ORDER BY total_withdrawn DESC;
