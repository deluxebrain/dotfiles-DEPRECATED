#!/bin/bash
#
# CreateProfile
#
# This creates an iTerm2 dynamic profile based on the supplied template
# and configuration
#

_SCRIPT_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

DEPENDS_ON path \
	exists

USE_GLOBAL_ERROR_HANDLER

form_and_verify_path()
{
	local path

	path="$(path_combine "$@")"
	file_exists? "${path}" ||
	{
		fail "Unable to find file ${path}"
	}
	echo "${path}"
}

setup_permissions()
{
	# Grant accessibility access to iterm and all scripts executed from iterm
	msg_info "Granting accessibility access to iTerm ..."
	sudo tccutil -i com.googlecode.iterm2
}

setup_profile()
{
	local profile_path
	local colorscheme_path

	# Load config
	msg_info "Loading profile config from $(pwd)/profile.conf ..."
        source ./profile.conf

	# form profile plist file path
	dir_exists? "${ITERM_PROFILE_DIR}" || \
		fail "Export variable ITERM_PROFILE_DIR not set or not valid path"
	profile_path="$(path_combine "${ITERM_PROFILE_DIR}" "${_PROFILE_NAME}".plist)"

	# form path to colorscheme plist
	colorscheme_path="$(form_and_verify_path \
		"/Users/${USER}" \
		".themes" \
		"${_PROFILE_COLORSCHEME_NAME}")"
	msg_info "Using colorscheme from ${colorscheme_path}"

	# merge the following to form the profile:
	# - The transformed template
	# - The json converted colorscheme plist
	# ---
	# -s	
	#	slurp; run entire stream into single array and run filters once
	#	i.e. form single array from elements from all files
	# .[0].Profiles[0]
	#	select the first element of the Profiles field of the first outer array
	# +=
	#	append the rhs to the lhs
	# .[1]
	#	select the second element of the outer array
	# | .[0]
	#	run a second filter that only returns the first element
	# <(...)	
	#	use subshells to pipe multiple arguments to jq
	# ---
	msg_info "Transforming profile_template.plist to form profile at ${profile_path}"
	jq -s '.[0].Profiles[0] += .[1] | .[0]' \
		<(envsubst < profile_template.plist) \
		<(plutil -convert json "${colorscheme_path}" -o -) \
		> "${profile_path}"

	msg_info "Configuring iTerm to use ${_PROFILE_NAME}"
	set_iterm_profile "${_PROFILE_NAME}"
	do_iterm_growl "Profile ${_PROFILE_NAME} created and set as current profile"
}

main()
{
	# We are going to be loading files relative to the parent script
	# So just change to the parent directory of the script
	cd "$_SCRIPT_PATH" || exit 1

	setup_permissions
	setup_profile 
}

main
exit $?

