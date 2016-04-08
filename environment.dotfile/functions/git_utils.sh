#!/bin/bash

# Change to the specified git repository
# Source the .settings file if it exists
# >>> If the locate index becomes corrupt try:
#$ sudo rm /var/db/locate.database
unset ggo
function ggo()
{
        local repos_name="$1"
        local repos_user="${2:-$(git config user.name)}"
        [[ ! "${repos_name}" || ! "${repos_user}" ]] && { false; return; }

        # Execute main while loop in the main shell process so that
        #+ it can set function level shell variables
        # <<< is a "here string" which allow the output from a subshell
        #+ to be redirected to the main while loop.
        local found_repos=false
        local a_repos_path
        local this_repos_path this_repos_name this_repos_user
        local path

        while -r read a_repos_path
        do
                this_repos_path="${a_repos_path}"
                this_repos_name=$(basename "${this_repos_path}")
                this_repos_user=$(basename "${this_repos_path%/*}")
                
                if [[ "${this_repos_name}" == "${repos_name}" && "${this_repos_user}" == "${repos_user}" ]]; then
                        found_repos=true
                        break
                fi
        done <<< "$( \
                if [ -f "/Users/${USER}/tmp/repos_locatedb" ]; then
                        export LOCATE_PATH="/Users/${USER}/tmp/repos_locatedb"
                else
                        export LOCATE_PATH="/Users/${USER}/tmp/user_locatedb"
                fi
                locate ".git" | while -r read path
                do
                        echo "${path%/.git*}"
                done | sort -u)"

        if $found_repos; then
                cd "${this_repos_path}" || return 1
                # shellcheck source=/dev/null
                [ -f ".settings" ] && source .settings
                true
        else
                false
        fi

        return
}
export -f ggo && readonly -f ggo

# Change to root directory of current git repository
unset ghome
function ghome()
{
        local git_root
        git_root="$(findup .git)"
        if [[ "${git_root}" && -d "${git_root}" ]]; then
                cd "${git_root}" || return 1
                return
        fi

        false
}
export -f ghome && readonly -f ghome

unset gpath
function gpath()
{
        git rev-parse --show-toplevel
}
export -f gpath && readonly -f gpath

