#This script helps to pull members who have access to repository
#!/bin/bash

##########################################################
#Author: Keerthana                                       #
#Date: 05-07-2025                                        #
#Version: V1                                             #
#Desc: This helps to list the users who have repo access #
##########################################################

#GitHub API URL
API_URL="https://api.github.com"

#Get exported GitHub username and token 
USERNAME=$username
TOKEN=$token

#Get Repo owner and Repo name as CLI arguments
REPO_OWNER=$1
REPO_NAME=$2

#This function is to make GET request to GitHub API
function github_api_get {
    local endpoint="$1"
    local url="${API_URL}${endpoint}"
    
    #Send GET Request to GitHub API with authentication
    curl -s -u "${USERNAME}:${TOKEN}" "$url" 

}

#This function is to list the users who have access to repo
function list_users_access {
    local endpoint="/repos/${REPO_OWNER}/${REPO_NAME}/collaborators"
    
    #Need to invoke api creation function 
    collaborators="$(github_api_get "$endpoint" | jq -r '.[] | select( .permissions.pull==true ) | .login')"	

    #If collaborators is empty
    if [[ -z "$collaborators" ]]; then
        echo "No users have access to ${REPO_OWNER}/${REPO_NAME}"
    else
        echo "List of users who have access to ${REPO_OWNER}/${REPO_NAME}"
        echo "$collaborators"
    fi
}

function helper {
    local expected_cmnd_args=2
    if [ $# -ne $expected_cmnd_args ]; then
        echo "Need to pass repo owner and repo name as CLI arguments"
    else 
        #Call list user access function if CLI arguments are passed
        list_users_access       
    fi
}

#Helper function call to check passed CLI arguments
helper "$@"
