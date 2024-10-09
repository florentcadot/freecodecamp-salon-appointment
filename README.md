# Worldcup database

A freecodecamp project to practice some SQL and bash.
I've done it locally using a postgres docker container.
I've used [shellcheck](https://www.shellcheck.net/) as a linter.

Here are some useful commands:

````bash
# Start the container
docker run --name postgres-freecodecamp -p 5432:5432 -e POSTGRES_USER=florent -e POSTGRES_PASSWORD=mysecretpassword -d postgres:16-alpine

# Connect to psql
docker exec -it postgres-freecodecamp psql -U florent -d postgres

# Run PSQL command from local bash script 
docker exec postgres-freecodecamp psql -U florent --dbname=salon -t --no-align -c "SELECT * FROM services;"

# Variable used locally in salon.sh
PSQL="docker exec postgres-freecodecamp psql -U florent --dbname=salon -t --no-align -c"
````

