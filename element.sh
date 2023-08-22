#!/bin/bash



PSQL="psql -X --username=freecodecamp --dbname=periodic_table --tuples-only -c"

if [[ $1 ]]
then
  
  EXIST=""

  if [[ "$1" =~ ^[0-9]+$ ]]
  then
    EXIST=$($PSQL "select * from elements inner join properties using(atomic_number) inner join types using(type_id) where atomic_number=$1;")
  else
    EXIST=$($PSQL "select * from elements inner join properties using(atomic_number) inner join types using(type_id) where name='$1' or symbol='$1';")
  fi
  

  if [[ $EXIST ]]
  then
    echo "$EXIST" | while IFS='|' read TYPE_ID ATOMIC_NUMBER SYMBOL NAME ATOMIC_MASS MELTING_POINT BOILING_POINT TYPE 
    do

    echo "The element with atomic number $(echo "$ATOMIC_NUMBER"|sed 's/ //g') is $(echo "$NAME"|sed 's/ //g') ($(echo "$SYMBOL"|sed 's/ //g')). It's a $(echo "$TYPE"|sed 's/ //g'), with a mass of $(echo "$ATOMIC_MASS"|sed 's/ //g') amu. $(echo "$NAME"|sed 's/ //g') has a melting point of $(echo "$MELTING_POINT"|sed 's/ //g') celsius and a boiling point of $(echo "$BOILING_POINT"|sed 's/ //g') celsius."
    
    done 
  else
   echo  "I could not find that element in the database."
  fi
else
  echo "Please provide an element as an argument."
fi
