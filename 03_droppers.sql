-- =====================================================
-- ЗАДАЧА: Найти подозрительных пользователей (реальная логика)
-- =====================================================
-- Признаки дроппера:
-- 1. Вывел деньги (withdraw)
-- 2. Зарегистрировался и вывел в течение 10 минут (быстрый вывод)
-- 3. Нет ни одной покупки (purchase)

WITH fast_withdraw AS (
    SELECT 
        f.user_id,
        f.amount,
        f.op_time AS withdraw_time,
        r.op_time AS reg_time
    FROM operations f
    JOIN operations r ON f.user_id = r.user_id
    WHERE f.op_type = 'withdraw'
      AND r.op_type = 'register'
      AND f.op_time - r.op_time < INTERVAL '10 minutes'
)
SELECT 
    f.user_id,
    SUM(f.amount) AS total_withdraw,
    COUNT(*) AS withdraw_count
FROM fast_withdraw f
LEFT JOIN operations p ON f.user_id = p.user_id AND p.op_type = 'purchase'
WHERE p.op_type IS NULL
GROUP BY f.user_id
ORDER BY total_withdraw DESC;
