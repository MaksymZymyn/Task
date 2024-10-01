import pandas as pd
from sqlalchemy import create_engine

# Налаштування бази даних MySQL
config = {
    'user': 'root',
    'password': '12345678qazwsxed',
    'host': '127.0.0.1',
    'database': 'task',
}

# Створення SQLAlchemy engine
engine = create_engine(f"mysql+mysqlconnector://{config['user']}:{config['password']}@{config['host']}/{config['database']}")

# Запит до таблиці campaign_performance
query = "SELECT * FROM campaign_performance"

# Завантаження даних у DataFrame
df_performance = pd.read_sql(query, engine)

# Запис у CSV файл
df_performance.to_csv('campaign_performance.csv', index=False, quoting=1)

print("Дані експортувалися у campaign_performance.csv.")
