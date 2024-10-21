#!/bin/bash

# Update and Install PostgreSQL
sudo apt update
sudo apt install -y postgresql postgresql-contrib

# Start and enable PostgreSQL service
sudo systemctl start postgresql
sudo systemctl enable postgresql

# Switch to postgres user and create a new role and database
sudo -u postgres psql -c "CREATE ROLE singhera WITH LOGIN SUPERUSER PASSWORD 'singhera';"
sudo -u postgres psql -c "CREATE DATABASE singhera OWNER singhera;"

# Modify pg_hba.conf for md5 authentication
# PG_VERSION=$(psql -V | egrep -o '[0-9]+\.[0-9]+')
PG_VERSION=14
PG_HBA="/etc/postgresql/$PG_VERSION/main/pg_hba.conf"
sudo sed -i 's/local   all             all                                     peer/local   all             all                                     md5/' "$PG_HBA"
sudo sed -i 's/host    all             all             127.0.0.1\/32            md5/host    all             all             0.0.0.0\/0            md5/' "$PG_HBA"
sudo sed -i 's/host    all             all             ::1\/128                 md5/host    all             all             ::\/0                 md5/' "$PG_HBA"

# Modify postgresql.conf to listen on all addresses
PG_CONF="/etc/postgresql/$PG_VERSION/main/postgresql.conf"
sudo sed -i "s/#listen_addresses = 'localhost'/listen_addresses = '*'/" "$PG_CONF"

# Reload PostgreSQL configuration
sudo systemctl restart postgresql

echo "PostgreSQL installation and configuration complete."
#sudo systemctl stop postgresql