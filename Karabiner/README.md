# Manual steps

## Karabiner

1.  Grant Karabiner accessility acess 

System Preferences ...
	Securiy & Privacy
		Privacy ...
			Accessibility: Add Karabiner_AXNotifier

NOTE: automated via the tccutil cli utility.

2.  Delegate key repeat control to Karabiner 

Karabiner ...
	Preferences ...
		Key Repeat ...
			Overwrite the key repeat values of sytem: Enable

NOTE: It doesnt appear possible to automate this step either via the Karabiner CLI or via editting the plist.

## Seil

1.  Remove OS X caps lock binding 

System Preferences  ...
	Keyboard ...
		Modifier Keys ...
			Caps Lock: No Action

NOTE: Automated via the unmap_caps.scpt apple script.
