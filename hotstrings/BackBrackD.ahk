; This hotstring replaces "]d" with the current date.
#If tools["BackBrackD"] == 1
:*:]d::
	FormatTime, D, dd/MM/yyyy, ShortDate	; It will look like this: 11/09/2001
	SendInput %D%
Return