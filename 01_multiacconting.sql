-- =====================================================
-- ЗАДАЧА: Найти мультиаккаунты (кластеры по IP и device)
-- =====================================================

-- Таблица users:
-- user_id | name | ip_address | device_fingerprint | reg_date

-- Часть 1. Кластеры по IP (2+ пользователя с одного IP)
WITH ip_clusters AS (
    SELECT 
        ip_address,
        STRING_AGG(user_id::text, ',' ORDER BY user_id) AS user_ids,
        COUNT(*) AS users_count,
        'ip' AS cluster_type
    FROM users
    GROUP BY ip_address
    HAVING COUNT(*) >= 2
),

-- Часть 2. Кластеры по device fingerprint (2+ пользователя с одного device)
device_clusters AS (
    SELECT 
        device_fingerprint,
        STRING_AGG(user_id::text, ',' ORDER BY user_id) AS user_ids,
        COUNT(*) AS users_count,
        'device' AS cluster_type
    FROM users
    GROUP BY device_fingerprint
    HAVING COUNT(*) >= 2
)

-- Объединяем оба результата
SELECT 
    ip_address AS cluster_key,
    user_ids,
    users_count,
    cluster_type
FROM ip_clusters

UNION

SELECT 
    device_fingerprint AS cluster_key,
    user_ids,
    users_count,
    cluster_type
FROM device_clusters

ORDER BY users_count DESC, cluster_type;
