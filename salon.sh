#! /bin/bash

PSQL="psql --username=freecodecamp --dbname=salon -t --no-align -c"
AVAILABLE_SERVICES=$($PSQL "SELECT service_id, name FROM services;")

enterSalon() {
 if [[ -z $AVAILABLE_SERVICES ]]; then
  exitSalon "Sorry we are closed."
 else
  echo -e "\nWelcome to our climbing salon. What can we do for you ?\n"
  selectService
 fi
}

selectService() {
if [[ $1 ]]; then
 echo -e "\n$1"
fi
 echo "$AVAILABLE_SERVICES" | sed 's/|/) /'
 read SERVICE_ID_SELECTED
 if [[ ! $SERVICE_ID_SELECTED =~ ^[0-9]+$ ]]; then
  selectService
  else 
   SERVICE_NAME=$($PSQL "SELECT name FROM services WHERE service_id=$SERVICE_ID_SELECTED;")
   if [[ -z $SERVICE_NAME ]]; then
   selectService
   else 
    echo -e "\nWhat is your phone number ?"
    read CUSTOMER_PHONE
    CUSTOMER_NAME=$($PSQL "SELECT name FROM customers WHERE phone='$CUSTOMER_PHONE';")
    if [[ -z $CUSTOMER_NAME ]]; then
     echo -e "\nWhat is your name ?"
     read CUSTOMER_NAME
     INSERT_CUSTOMER=$($PSQL "INSERT INTO customers(name,phone) VALUES('$CUSTOMER_NAME', '$CUSTOMER_PHONE');")
    fi
    CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE name='$CUSTOMER_NAME' AND phone='$CUSTOMER_PHONE'")
    echo -e "\nWhat time do you want to schedule this service ?"
    read SERVICE_TIME
    INSERT_APPOINTMENT=$($PSQL "INSERT INTO appointments(customer_id,service_id,time) VALUES($CUSTOMER_ID,$SERVICE_ID_SELECTED,'$SERVICE_TIME')")
    echo "I have put you down for a $SERVICE_NAME at $SERVICE_TIME, $CUSTOMER_NAME."
   fi
 fi
}

exitSalon() {
 if [[ $1 ]]; then
  echo -e "\n $1"
 fi
 echo -e "\n See you soon!"
}

enterSalon
