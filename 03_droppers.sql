-- =====================================================
-- ЗАДАЧА: Найти дропперов (регистрация + вывод без успешного логина)
-- =====================================================

-- Таблица operations:
-- user_id | op_type | result | amount | op_time

-- Решение: CTE + агрегации с CASE
WITH user_stats AS (
    SELECT 
        user_id,
        SUM(CASE WHEN op_type = 'withdraw' THEN amount ELSE 0 END) AS total_withdraw,
        MAX(CASE WHEN op_type = 'login' AND result = 'ok' THEN 1 ELSE 0 END) AS has_successful_login,
        MAX(CASE WHEN op_type = 'withdraw' THEN 1 ELSE 0 END) AS has_withdraw
    FROM operations
    GROUP BY user_id
)
SELECT 
    user_id,
    total_withdraw
FROM user_stats
WHERE has_withdraw = 1 AND has_successful_login = 0
ORDER BY total_withdraw DESC;

-- =====================================================
-- ПОЯСНЕНИЕ:
-- 1. has_withdraw = 1 — пользователь выводил деньги
-- 2. has_successful_login = 0 — ни одного успешного логина
-- 3. Такие аккаунты часто используются как "мулы" (дропперы)
-- =====================================================
