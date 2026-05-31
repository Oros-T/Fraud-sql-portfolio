-- =====================================================
-- ЗАДАЧА: Найти брутфорс (неуспешный логин → успешный)
-- =====================================================

-- Таблица logins:
-- user_id | login_time | ip_address | success

-- Решение через оконную функцию LAG
WITH with_prev AS (
    SELECT 
        user_id,
        login_time,
        ip_address,
        success,
        LAG(success) OVER (PARTITION BY user_id ORDER BY login_time) AS prev_success
    FROM logins
)
SELECT 
    user_id,
    login_time AS success_time,
    ip_address AS success_ip
FROM with_prev
WHERE prev_success = FALSE AND success = TRUE;

-- =====================================================
-- ПОЯСНЕНИЕ:
-- 1. PARTITION BY user_id — для каждого пользователя отдельно
-- 2. ORDER BY login_time — сортируем по времени
-- 3. LAG(success) — берем значение success из предыдущей строки
-- 4. WHERE prev_success = FALSE AND success = TRUE — нашли взлом
-- =====================================================
