#!/bin/bash
#!/bin/bash

echo "WELCOME TO LOGIN SYSTEM"
echo "1.login"
echo "2.forgot password"
read -p "pilihan : " option

if [ "$option" == "1" ]; then

read -p "email: " email
read -s -p "password: " password
echo
#buat ngecek apakah email sudah terdaftar atau belum
infoUser=$(grep "^$email" users/users.txt)

if [ -z "$infoUser" ]; then
	echo "[$(date +'%d/%m/%Y:%M:%S')][LOGIN FAILED]no user found with Email $email." >> users/auth.log
        echo "email tidak terdaftar. Registrasi terlebih dahulu"
        exit 1
fi
#untuk sinkronisasi password
stored_password=$(echo "$infoUser" | cut -d "|" -f 6 | base64 -d)

if [ "$password" == "$stored_password" ]; then
	echo
	role=$(echo "$infoUser" |cut -d "|" -f 5)
 	if [ "$role" == "admin" ]; then
        echo "welcome admin!"
        echo "[$(date +'%d/%m/%Y:%M:%S')][LOGIN SUCCES]admin for Email $email logged in successfully." >> users/auth.log
        echo "admin menu"
        echo "1. add user"
        echo "2. edit user"
        echo "3. delete user"
        read -p "pilihan : " action

        if [ "$action" == "1" ]; then
        bash register.sh

        elif [ "$action" == "2" ]; then
        read -p "enter email: " edit_email
        if grep -q "$email" users/users.txt; then
        read -p "enter username: " new_username
        read -p "enter security question: " new_security_question
        read -p "enter security answer: " new_security_answer
        read -s -p "enter password: " new_password

        if [[ ${#new_password} -lt 8 || !("$new_password" =~ [[:upper:]] && "$new_password" =~ [[:lower:]] && "$new_password" =~ [0-9]) ]]; then
        echo "[$(date +'%d/%m/%Y:%M:%S')][ADD USER FAILED]Password for Email $email does not meet the strength requirements." >> users/auth.log
        echo"password tidak sesuai"
        exit 1

	else
        encrypted_password=$(echo -n "$new_password" | base64)
        sed -i "s/^$edit_email[^|]*/$edit_email|$new_username|$new_security_question|$new_security_answer|$role|$encrypted_password" users/users.txt
        echo "[$(date +'%d/%m/%Y:%M:%S')][EDITED SUCCESS] Email $edit_email edited succesfully." >> users/auth.log
        echo "edited email $edit_email successfully!."
	exit 1
        fi
	fi

	else
        echo "user not found!"
        exit 1
	fi

        elif [ "$action" == "3" ]; then
        read -p "enter email : " email
        if grep -q "$email" users/users.txt; then
        sed -i"/$email/d" users/users.txt
        echo "[$(date +'%d/%m/%Y:%M:%S')][DELETED SUCCESS] deleted succesfully." >> users/auth.log
        echo "deleted successfully"
	else
	echo "pilihan tidak valid"
	exit 1
	fi
	fi

        elif [ "$role" == "user" ]; then
	echo "[$(date +'%d/%m/%Y:%M:%S')][LOGIN SUCCES]user for Email $email logged in successfully." >> users/auth.log
	echo "welcome user!"
        exit 1
        fi
	fi

	else
        echo "[$(date +'%d/%m/%Y:%M:%S')][LOGIN FAILED]ERROR: Failed login attempt on user with Email $email" >> users/auth.log
        echo "incorrect password. try again or choose forgot password"
	fi

#untuk forgot password
if [ "$option" == "2" ]; then
	read -p "enter your email: " email

	infoUser=$(grep "^$email" users/users.txt)

if [ -z "$infoUser" ]; then
	echo "[$(date +'%d/%m/%Y:%M:%S')][REGISTER FAILED]no user found with Email $email." >> users/auth.log
	echo "email tidak terdaftar. Registrasi terlebih dahulu"
	exit 1
fi


#untuk mengubah password
security_question=$(echo "$infoUser" | cut -d "|" -f 3)
security_answer=$(echo "$infoUser" | cut -d "|" -f 4)

read -p "securiy question: $security_question security answer : " userAnswer
if [ "$userAnswer" == "$security_answer" ]; then
	stored_password=$(echo "$infoUser" | cut -d "|" -f 6 | base64 -d)
	echo "[$(date +'%d/%m/%Y:%M:%S')][FORGOT PASSWORD]User with Email $email retrieved password." >> users/auth.log
	echo "your password is : $stored_password"
else
	echo "[$(date +'%d/%m/%Y:%M:%S')][FORGOT PASSWORD]ERROR: Incorrect security answer for user with Email $email." >> users/auth.log
	echo "incorrect security answer."
	exit 1
	fi
	fi

echo "WELCOME TO LOGIN SYSTEM"
echo "1.login"
echo "2.forgot password"
read -p "pilihan : " option

if [ "$option" == "1" ]; then

read -p "email: " email
read -s -p "password: " password
echo
#buat ngecek apakah email sudah terdaftar atau belum
infoUser=$(grep "^$email" users/users.txt)

if [ -z "$infoUser" ]; then
	echo "[$(date +'%d/%m/%Y:%M:%S')][LOGIN FAILED]no user found with Email $email." >> users/auth.log
        echo "email tidak terdaftar. Registrasi terlebih dahulu"
        exit 1
fi
#untuk sinkronisasi password
stored_password=$(echo "$infoUser" | cut -d "|" -f 6 | base64 -d)

if [ "$password" == "$stored_password" ]; then
	echo
	role=$(echo "$infoUser" |cut -d "|" -f 5)
 	if [ "$role" == "admin" ]; then
        echo "welcome admin!"
        echo "[$(date +'%d/%m/%Y:%M:%S')][LOGIN SUCCES]admin for Email $email logged in successfully." >> users/auth.log
        echo "admin menu"
        echo "1. add user"
        echo "2. edit user"
        echo "3. delete user"
        read -p "pilihan : " action

        if [ "$action" == "1" ]; then
        bash register.sh

        elif [ "$action" == "2" ]; then
        read -p "enter email: " edit_email
        if grep -q "$email" users/users.txt; then
        read -p "enter username: " new_username
        read -p "enter security question: " new_security_question
        read -p "enter security answer: " new_security_answer
        read -s -p "enter password: " new_password

        if [[ ${#new_password} -lt 8 || !("$new_password" =~ [[:upper:]] && "$new_password" =~ [[:lower:]] && "$new_password" =~ [0-9]) ]]; then
        echo "[$(date +'%d/%m/%Y:%M:%S')][ADD USER FAILED]Password for Email $email does not meet the strength requirements." >> users/auth.log
        echo"password tidak sesuai"
        exit 1

	else
        encrypted_password=$(echo -n "$new_password" | base64)
        sed -i "s/^$edit_email[^|]*/$edit_email|$new_username|$new_security_question|$new_security_answer|$role|$encrypted_password" users/users.txt
        echo "[$(date +'%d/%m/%Y:%M:%S')][EDITED SUCCESS] Email $edit_email edited succesfully." >> users/auth.log
        echo "edited email $edit_email successfully!."
	exit 1
        fi
	fi

	else
        echo "user not found!"
        exit 1
	fi

        elif [ "$action" == "3" ]; then
        read -p "enter email : " email
        if grep -q "$email" users/users.txt; then
        sed -i"/$email/d" users/users.txt
        echo "[$(date +'%d/%m/%Y:%M:%S')][DELETED SUCCESS] deleted succesfully." >> users/auth.log
        echo "deleted successfully"
	else
	echo "pilihan tidak valid"
	exit 1
	fi
	fi

        elif [ "$role" == "user" ]; then
	echo "[$(date +'%d/%m/%Y:%M:%S')][LOGIN SUCCES]user for Email $email logged in successfully." >> users/auth.log
	echo "welcome user!"
        exit 1
        fi
	fi

	else
        echo "[$(date +'%d/%m/%Y:%M:%S')][LOGIN FAILED]ERROR: Failed login attempt on user with Email $email" >> users/auth.log
        echo "incorrect password. try again or choose forgot password"
	fi

#untuk forgot password
if [ "$option" == "2" ]; then
	read -p "enter your email: " email

	infoUser=$(grep "^$email" users/users.txt)

if [ -z "$infoUser" ]; then
	echo "[$(date +'%d/%m/%Y:%M:%S')][REGISTER FAILED]no user found with Email $email." >> users/auth.log
	echo "email tidak terdaftar. Registrasi terlebih dahulu"
	exit 1
fi


#untuk mengubah password
security_question=$(echo "$infoUser" | cut -d "|" -f 3)
security_answer=$(echo "$infoUser" | cut -d "|" -f 4)

read -p "securiy question: $security_question security answer : " userAnswer
if [ "$userAnswer" == "$security_answer" ]; then
	stored_password=$(echo "$infoUser" | cut -d "|" -f 6 | base64 -d)
	echo "[$(date +'%d/%m/%Y:%M:%S')][FORGOT PASSWORD]User with Email $email retrieved password." >> users/auth.log
	echo "your password is : $stored_password"
else
	echo "[$(date +'%d/%m/%Y:%M:%S')][FORGOT PASSWORD]ERROR: Incorrect security answer for user with Email $email." >> users/auth.log
	echo "incorrect security answer."
	exit 1
	fi
	fi

