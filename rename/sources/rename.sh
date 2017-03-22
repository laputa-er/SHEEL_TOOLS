#! /bin/zsh -y
# This program can renames multiple files.
# Author: eli01linux@gmail.com(MengQingshen)
# History:
# 	2017-03-20 MengQingshen First release
export PATH=$PATH:/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin

. ./lib/mqs_funs.sh
. ./config.sh
. ./functions.sh

# init path
TMP_DIR="$(get_absolute_path_by_relavent_path '../tmp')"
OLD_NAMES_FILE="${TMP_DIR}/old_names_file"
NEW_NAMES_FILE="${TMP_DIR}/new_names_file"

LOG_DIR="$(get_absolute_path_by_relavent_path '../log')"
LOG_FILE="${LOG_DIR}/$(date +"%Y-%m-%d-%H-%M-%S")"

# generate old names to temporary file
OLD_NAMES="$(get_all_files_to_be_rename ${DIR_FOR_FILES_TO_BE_RENAMEED} ${REGEXP_OF_FILES_TO_BE_REPLACED})"
echo "${OLD_NAMES}" | nl > ${OLD_NAMES_FILE}

# generate new names to temporary file
NEW_NAMES="$(echo "${OLD_NAMES}" | sed "s/${REGEXP_OF_SEARCH}/${STR_FOR_REPLACE}/g")"
echo "${NEW_NAMES}" | nl > ${NEW_NAMES_FILE}

# generator log info
join ${OLD_NAMES_FILE} ${NEW_NAMES_FILE} |  awk '{printf $1 "\t" $2 "\t=>\t" $3 "\n"}' > ${LOG_FILE}

print_success "Preview the rename operation."
print_info "$(cat $LOG_FILE)"
read -p "Here we go(Y/N):" ANSWER

if [ "N" == "${ANSWER}" -o "n" == "${ANSWER}" ]
	then

	else
		print_error "Canceled."
fi