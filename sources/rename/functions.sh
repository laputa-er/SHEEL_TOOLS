#! /bin/zsh -y
# Author: eli01linux@gmail.com(MengQingshen)
# History:
#	2017-03-21 MengQingshen First release

# @param {array} $1 Old name list.
# @param {array} $2 New Name list.
function preview () {
    OLD_IFS="$IFS"
    IFS=$'\n'
    declare -a local OLD_NAMES_ARR=($1)
    declare -a local NEW_NAMES_ARR=($2)
    IFS="$OLD_IFS"
    
    local LEN=${#NEW_NAMES_ARR[@]}
    local NEW_MSG
    local I=1
    if [ ${LEN} -gt 0 ]
        then
            cd ${DIR_FOR_FILES_TO_BE_RENAMEED}
            while [ ${I} -le ${LEN} ]
            do
                local OLD_NAME=${OLD_NAMES_ARR[${I}]}
                local NEW_NAME=${NEW_NAMES_ARR[${I}]}
                if [ -e "${OLD_NAME}" ]
                    then
                        printf "%-3s\n" "${I}    ${OLD_NAME}"
                        NEW_MSG="  => ${NEW_NAME}"
                        if [ -e "${NEW_NAME}" ]
                            then
                                echo -e "\e[1;31m${NEW_MSG} alread exisisted!\e[0m"
                            else
                                echo -e "\e[1;34m${NEW_MSG}\e[0m"
                        fi
                fi
                I=$((${I}+1))
            done
            return_to_old_pwd
    fi
}

# @param {string} $1 Parent dir of the files to be renamed.
# @param {string} $2 Regular expression to select the files to be renamed among all files under the dir.
# @return {array} All the files to be renamed.
function get_all_files_to_be_rename () {
    echo "$(ls $1 | grep $2)"
}

# @param {array} $1 Old name list.
# @param {array} $2 New Name list.
function start_rename () {
    OLD_IFS="$IFS"
    IFS=$'\n'
    declare -a local OLD_NAMES_ARR=($1)
    declare -a local NEW_NAMES_ARR=($2)
    IFS="$OLD_IFS"

    local LEN=${#NEW_NAMES_ARR[@]}
    local I=1
    if [ ${LEN} -gt 0 ]
        then
            cd ${DIR_FOR_FILES_TO_BE_RENAMEED}
            while [ ${I} -le ${LEN} ]
            do
                local OLD_NAME=${OLD_NAMES_ARR[${I}]}
                local NEW_NAME=${NEW_NAMES_ARR[${I}]}
                if [ -e "${OLD_NAME}" ]
                    then
                        if [ -e "${NEW_NAME}" ]
                            then
                                rm -rf "${NEW_NAME}"
                                mv -- "${OLD_NAME}" "${NEW_NAME}"
                                # print_info "${OLD_NAME} escaped!"
                                echo "$(ls -l "${NEW_NAME}") $(print_success "renamed")"
                            else
                               mv -- "${OLD_NAME}" "${NEW_NAME}"
                               echo "$(ls -l "${NEW_NAME}") $(print_success "renamed")"
                        fi       
                fi
                I=$((${I}+1))
            done
            return_to_old_pwd
    fi
    print_success "Done!"
}

