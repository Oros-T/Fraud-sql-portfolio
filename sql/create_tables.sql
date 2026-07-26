-- Создание таблиц
CREATE TABLE IF NOT EXISTS users (
    id SERIAL PRIMARY KEY,
    reg_date TIMESTAMP DEFAULT NOW(),
    ip VARCHAR(20),
    device_fingerprint VARCHAR(50)
);

CREATE TABLE IF NOT EXISTS transactions (
    id SERIAL PRIMARY KEY,
    user_id INTEGER,
    amount DECIMAL(10,2),
    txn_time TIMESTAMP DEFAULT NOW(),
    ip VARCHAR(20),
    device_fingerprint VARCHAR(50),
    status VARCHAR(20),
    location VARCHAR(100)
);

CREATE TABLE IF NOT EXISTS login_attempts (
    id SERIAL PRIMARY KEY,
    user_id INTEGER,
    login_time TIMESTAMP DEFAULT NOW(),
    ip VARCHAR(20),
    success BOOLEAN
);
