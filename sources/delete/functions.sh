#! /bin/zsh -y
# Author: eli01linux@gmail.com(MengQingshen)
# History:
#	2017-03-25 MengQingshen First release

# @param $1 Array of files to delete.
# @param $2 Path of dir which contains the files to delete.
function start_delete () {
	local FILES_NAME="$1"
	local DIR_OF_FILES="$2"

	# split string into array
	OLD_IFS="$IFS"
    IFS=$'\n'
	local ARR_OF_FILES=($FILES_NAME)
	IFS="$OLD_IFS"

	local LEN=${#ARR_OF_FILES[*]}

	cd ${DIR_OF_FILES}
	if [ $LEN -gt 0 ]
		then
			# print
			for (( i=1; i <= ${LEN}; i++ ))
			do
				local FILE_NAME="${ARR_OF_FILES[$i]}"
				if [ -e "$FILE_NAME" ]
					then
						rm -rf "${FILE_NAME}"
						echo "${FILE_NAME} $(print_success "deleted")"
				fi
			done
		else
			print_error "No file to delete!"
	fi
	return_to_old_pwd
	print_success "Done!"
}

# @param $1 File to delete
# @param $2 Regular expression to select the files to be renamed among all files under the dir.
# @return  All the files to be deleted.
function get_all_files_to_delete () {
	echo "$(echo "${3}\n$(ls $1 | grep $2)" | sort | uniq)"
}

# @param $1 Array of files to delete.
# @param $2 Path of dir which contains the files to delete.
function preview () {
	echo "$(get_info_to_preview "$1" "$2")" | nl
}

# @param $1 Array of files to delete.
# @param $2 Path of dir which contains the files to delete.
function get_info_to_preview () {
	local FILES_NAME="$1"
	local DIR_OF_FILES="$2"

	# split string into array
	OLD_IFS="$IFS"
    IFS=$'\n'
	local ARR_OF_FILES=($FILES_NAME)
	IFS="$OLD_IFS"

	local LEN=${#ARR_OF_FILES[*]}

	cd ${DIR_OF_FILES}
	if [ $LEN -gt 0 ]
		then
			# print
			for (( i=0; i < $LEN; i++ ))
			do
				local FILE_NAME="${ARR_OF_FILES[$i]}"
				if [ -e $FILE_NAME ]
					then
						echo "$FILE_NAME"
					else
						echo -e "\e[1;31m${FILE_NAME} doesn't exisist!\e[0m"
				fi
			done
		else
			print_error "No file to delete!"
	fi
	return_to_old_pwd
}
