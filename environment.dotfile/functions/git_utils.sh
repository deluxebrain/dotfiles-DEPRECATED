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
        [ ! "${repos_name}" -o ! "${repos_user}" ] && { false; return; }

        # Execute main while loop in the main shell process so that
        #+ it can set function level shell variables
        # <<< is a "here string" which allow the output from a subshell
        #+ to be redirected to the main while loop.
        local found_repos=false
        while -r read a_repos_path
        do
                local this_repos_path="${a_repos_path}"
                local this_repos_name=$(basename "${this_repos_path}")
                local this_repos_user=$(basename "${this_repos_path%/*}")
                if [ "${this_repos_name}" == "${repos_name}" -a \
                        "${this_repos_user}" == "${repos_user}" ]; then
                        local found_repos=true
                        break
                fi
        done <<< "$( \
                if [ -f "/Users/${USER}/tmp/repos_locatedb" ]; then
                        LOCATE_PATH="/Users/${USER}/tmp/repos_locatedb"
                else
                        LOCATE_PATH="/Users/${USER}/tmp/user_locatedb"
                fi
                locate ".git" | \
                while read path
                do
                        echo "${path%/.git*}"
                done | \
                sort -u)"

        if $found_repos; then
                cd "${this_repos_path}"
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
        local git_root=$(findup .git)
        if [ "${git_root}" -a -d "${git_root}" ]; then
                cd "${git_root}"
                return
        fi

        false
}
export -f ghome && readonly -f ghome

unset gpath
gpath()
{
        git rev-parse --show-toplevel
}
export -f gpath && readonly -f gpath

