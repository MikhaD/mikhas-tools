; High speed togglable autoclicker (Left)
#If tools["AltC"] == 1
	#MaxThreadsPerHotkey 2 ; Enable all hotkeys from this point forth to react to a second press while running, rather than ignoring it.
$!c::
	if (settings["AltC"].Count() == 0)
		settings["AltC"].on := True
	else 
		settings["AltC"].on := !settings["AltC"].on
	While (settings["AltC"].on) {
		Click
		ToolTip Clicker Active (Left)
		Sleep 20
	}
	ToolTip
Return
#MaxThreadsPerHotkey 1 ; Reset to default.