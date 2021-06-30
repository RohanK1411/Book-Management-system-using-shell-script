#! /bin/bash

login()
{
add_book()
{
flag=0
newBook=$(zenity --entry --title "Book Adding" --text "Enter The book Name : ")
Author=$(zenity --entry --title "Book Adding" --text "Enter The Author Name : ")
for (( int=0; int<=i; int++ ))
do
  if [[ ${newBook} == ${books[int]} ]]; then

  if [[ ${Author} = ${auth[int]} ]]; then
    flag=1
    echo  "$newBook Book Already Exists."
    zenity --info --text=$Author" Book Already Exists." --width=400 --height=100
  fi
fi
done

if [ $flag = 0 ]; then
books[$i]=$newBook
auth[$i]=$Author
let i++
echo  "$newBook Added successfully" 
zenity --info --text=$newBook" Added Succesfully" --width=400 --height=100
fi

}
delete_book()
{
book_to_delete=$(zenity --entry --title "Deleting Book" --text "Enter The Book Name For Deletion : ")
book_auth=$(zenity --entry --title "Deleting Book" --text "Enter The Author's Name of Book : ")
available="no"
for (( number=0; number<=i; number++ ))
do
  if [[ ${book_to_delete} == ${books[number]} ]]; then

  if [[ ${book_auth} = ${auth[number]} ]]; then
    available="yes"
    unset books[$number]
    unset auth[$number]
    echo "$book_to_delete Book deleted successfully "
    zenity --info --text=$book_to_delete" Book deleted Successfully." --width=400 --height=100
  fi
fi
done
if [ $available = "no" ]; then
    echo "$book_to_delete Book is not available, cannot be deleted"
    zenity --info --text=$book_to_delete" Book is not available, cannot be deleted." --width=400 --height=100
    echo
fi
}
list_books()
{
if [ ${#books[@]} -eq 0 ]; then
    echo "No Books are available"
    zenity --info --text="List is Empty" --width=400 --height=100
  echo
   return 1
fi
echo "List of all the Available books:"
echo "--------------------------------"
nl='
'
zenity --info --list=${books[@]} ${auth[@]}
for (( int1=0; int1<=i; int1++ ))
do
  ans+=("${books[int1]}" "${auth[int1]}")
done

ans=$(zenity --list --column=Books --column=Author "${ans[@]}" --width=400) 
unset ans
echo
}



declare -a books
declare -a auth
i=0
while [ true ]
do
   title="Select Operation"
    prompt="Pick an option:"
    options=("ADD BOOK" "DELETE BOOK" "LIST OF BOOKS" "EXIT")

    while opt=$(zenity --title="$title" --text="$prompt" --list  --column="Options"  "${options[@]}" --width=400 --height=250); do
        select=""

        case "$opt" in
        "${options[0]}" ) select= add_book ;;
        "${options[1]}" ) select= delete_book ;;
        "${options[2]}" ) select= list_books ;;
        "${options[3]}" ) select= exit 1 ;;
    #    *) zenity --error --text="Invalid option, "OK" to exit" && exit 1;;
        esac

    #       if $select = "A" ;then break ;fi
            if zenity --text=" $select" ; then break ;fi


    done > /dev/null 2>&1
            
done
}

echo "Welcome to Book Management Application"
echo "######################################"
User=$(zenity --entry --title "Login" --text "Enter The Username : " --width=250 --height=100)
password=$(zenity --entry --hide-text --title "Login" --text "Enter The password : " --width=250 --height=100)
if [ $User == "UNKNOWN" ]; then
  if [ $password == "ADMIN" ]; then
    login
  else 
    echo "Invalid Username / Password"
    zenity --info --text="INVALID USERNAME / PASSWORD" --width=400 --height=100
  fi
fi
