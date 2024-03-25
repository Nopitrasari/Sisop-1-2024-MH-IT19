#!/bin/bash

echo "WELCOME TO REGISTRASION SYSTEM"
read -p "enter your email : " email
read -p "enter your username : " username
read -p "security question : " security_question
read -p "security answer : " security_answer

#pasword
read -s -p "enter a pasword: " password
echo
while true;do
if [[ ${#password} -lt 8 || !("$password" =~ [[:upper:]] && "$password" =~ [[:lower:]] && "$password" =~ [0-9]) ]]; then
        echo "minimum 8 characters, at least 1 uppercase letter, 1 lowercase letter, 1 digit"
	read -s -p "password: " password
	echo
else
	break
fi
	done

#encrypted passwors
encrypted_password=$(echo -n "$password" | base64)

#ngecek apakah email sudah terdaftar apa blum
if grep -q "^$email" users/users.txt; then
	echo "[$(date +'%d/%m/%Y:%M:%S')][REGISTER FAILED]Email $email already registered." >> users/auth.log
	echo "email $email  is already registered"
	exit 1
fi

#untuk mengelompokkan email yg ada kata adminnya
if [[ "$email" == *"admin"* ]]; then
	role="admin"
	echo "[$(date +'%d/%m/%Y:%M:%S')][REGISTER SUCCESS] Admin $username registered succesfully." >> users/auth.log
        echo "Admin $username registered successfully."
else
	role="user"
	echo "[$(date +'%d/%m/%Y:%M:%S')][REGISTER SUCCESS] Admin $username registered succesfully." >> users/auth.log
        echo "user $username registered successfully."
fi

echo "$email|$username|$security_question|$security_answer|$role|$encrypted_password" >> users/users.txt
