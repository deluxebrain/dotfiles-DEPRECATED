envsubst is part of the gettext package.
It requires all variables to be part of the environment, hence the following usage:

(export _PROFILE_ID="some_id"; envsubst< profile_template.plist)

which can be shortened to:

_PROFILE_ID="some_id" envsubst< profile_template.plist

