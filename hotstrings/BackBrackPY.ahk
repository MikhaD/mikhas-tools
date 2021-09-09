; This hotstring replaces "]py" with my python script header.
#If tools["BackBrackPY"] == 1
:*:]py::
	sendInput """Description"""`n__author__ = `"%A_UserName%`"`n
	SendRaw #
	SendInput %A_MDay%/%A_Mon%/%A_Year%`n
Return