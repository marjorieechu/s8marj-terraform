aws secretsmanager delete-secret --secret-id DB_USERNAME --force-delete-without-recovery
aws secretsmanager delete-secret --secret-id DB_PASSWORD --force-delete-without-recovery

apt-get update
apt-get install postgresql-client -y

psql -h <endpoint> -p 5432 -U <username> -d <database_name>
psql -h education.cv3uwkomseya.us-east-1.rds.amazonaws.com -p 5432 -U edu -d postgres
psql -h education.cv3uwkomseya.us-east-1.rds.amazonaws.com -p 5432 -U edu -d del

docker run -d \
  --name pgadmin \
  -p 3035:80 \
  -e 'PGADMIN_DEFAULT_EMAIL=admin@example.com' \
  -e 'PGADMIN_DEFAULT_PASSWORD=admin123' \
  dpage/pgadmin4
  