# Fraud SQL Portfolio

Решение антифрод-задач на SQL.

## Файлы

| Файл | Описание |
|------|----------|
| `01_multiacconting.sql` | Поиск мультиаккаунтов (кластеризация по IP и device fingerprint) |
| `02_bruteforce.sql` | Обнаружение брутфорса (неуспешный логин → успешный) |
| `03_droppers.sql` | Выявление дропперов (регистрация + вывод без логина) |

## Используемые технологии

- PostgreSQL
- Оконные функции (`LAG`)
- CTE (Common Table Expressions)
- Агрегации с `CASE WHEN`

## Контакты

Тelegram: @HGK40
