 ; This hotstring replaces "]t" with the current time.
#If tools["BackBrackT"] == 1
:*:]t::
	FormatTime, T, hh:mm:ss tt, Time			; It will look like this: 12:05:20 PM
	SendInput %T%
Return