import psycopg2
import random
from datetime import datetime, timedelta

# Подключение к БД
conn = psycopg2.connect(
    host="localhost",
    port=5432,
    dbname="antifrod",
    user="postgres",
    password="123456"
)
cur = conn.cursor()

print("🔄 Начинаем генерацию данных...")

# Генерация пользователей (1000 шт)
print("📊 Генерируем пользователей...")
for i in range(1, 1001):
    ip = f"192.168.{random.randint(0,255)}.{random.randint(0,255)}"
    device = f"dev_{random.randint(1,100)}"
    reg_date = datetime.now() - timedelta(days=random.randint(0, 30))
    cur.execute(
        "INSERT INTO users (id, reg_date, ip, device_fingerprint) VALUES (%s, %s, %s, %s)",
        (i, reg_date, ip, device)
    )

# Генерация транзакций (10000 шт)
print("💰 Генерируем транзакции...")
for _ in range(10000):
    user_id = random.randint(1, 1000)
    amount = round(random.uniform(1, 10000), 2)
    txn_time = datetime.now() - timedelta(minutes=random.randint(0, 10080))
    ip = f"192.168.{random.randint(0,255)}.{random.randint(0,255)}"
    device = f"dev_{random.randint(1,100)}"
    status = random.choices(["success", "failed"], weights=[90, 10])[0]
    location = random.choice(["Moscow", "SPB", "London", "NY", "Berlin"])
    cur.execute(
        "INSERT INTO transactions (user_id, amount, txn_time, ip, device_fingerprint, status, location) VALUES (%s, %s, %s, %s, %s, %s, %s)",
        (user_id, amount, txn_time, ip, device, status, location)
    )

# Генерация логов входов (5000 шт)
print("🔑 Генерируем логи входов...")
for _ in range(5000):
    user_id = random.randint(1, 1000)
    login_time = datetime.now() - timedelta(minutes=random.randint(0, 4320))
    ip = f"192.168.{random.randint(0,255)}.{random.randint(0,255)}"
    success = random.choices([True, False], weights=[70, 30])[0]
    cur.execute(
        "INSERT INTO login_attempts (user_id, login_time, ip, success) VALUES (%s, %s, %s, %s)",
        (user_id, login_time, ip, success)
    )

conn.commit()
cur.close()
conn.close()
print("✅ ВСЕ ДАННЫЕ УСПЕШНО ЗАГРУЖЕНЫ!")