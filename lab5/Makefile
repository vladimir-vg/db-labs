
populate:
	- psql postgres postgres -c "DROP DATABASE lab6;"
	psql postgres postgres -c "CREATE DATABASE lab6;"
	psql lab6 postgres -f schema.sql
	python3 generate_data.py
