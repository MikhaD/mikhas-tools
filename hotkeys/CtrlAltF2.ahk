; Open a new instance of word if word is not the active window. The $ ensures the hotkey only runs if the keys are pressed.
#If tools["CtrlAltF2"] == 1
#ifWinNotActive ahk_class OpusApp
$^!F2::
	Run, winword.exe
Return