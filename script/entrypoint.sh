#!/bin/bash
set -e

# Install Python packages if requirements.txt exists
if [ -f "/opt/airflow/requirements.txt" ]; then
  python -m pip install --upgrade pip
  pip install -r /opt/airflow/requirements.txt
fi

# Initialize Airflow database and create default admin user if DB doesn't exist
if [ ! -f "/opt/airflow/airflow.db" ]; then
  airflow db init
  airflow users create \
    --username admin \
    --firstname admin \
    --lastname admin \
    --role Admin \
    --email admin@example.com \
    --password admin
fi

# Upgrade the Airflow database schema
airflow db upgrade

# Start the Airflow webserver
exec airflow webserver
