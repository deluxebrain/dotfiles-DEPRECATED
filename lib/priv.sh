# https://gist.github.com/cowboy/3118588
function sudo_keepalive() 
{
	# Ask for administrator password upfront
	sudo -v

	# Keep-alive: update existing sudo timestamp if set
	#+ $$: PID of the parent process (or parent script)
	#+ kill -0 PID: exits with 0 if the process associated with PID is running
	#+ kill -0 "$$" || exit: aborts while loop after process stops running
	while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &
}
	
