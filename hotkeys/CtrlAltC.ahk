; High speed togglable autoclicker (Right)
#If tools["CtrlAltC"] == 1
#MaxThreadsPerHotkey 2 ; Enable all hotkeys from this point forth to react to a second press while running, rather than ignoring it.
$^!c::
	if (settings["CtrlAltC"].Count() == 0)
		settings["CtrlAltC"].on := True
	else 
		settings["CtrlAltC"].on := !settings["CtrlAltC"].on
	While (settings["CtrlAltC"].on) {
		Click, right
		ToolTip Clicker Active (Right)
		Sleep 20
		}
	ToolTip
Return
#MaxThreadsPerHotkey 1 ; Reset to default.