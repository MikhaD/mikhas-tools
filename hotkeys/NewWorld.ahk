; Create a new minecraft world from the title screen in full screen mode gui scale 3
#If tools["NewWorld"] == 1
$^F1::
	minecraftClass := "GLFW30"	; The window class of minecraft
	if (!settings["NewWorld"].HasKey("worldCount"))
			settings["NewWorld"].worldCount := 1
	if (!settings["NewWorld"].HasKey("clickDelay"))
		settings["NewWorld"].clickDelay := 1000
	MouseGetPos, , , id
	WinGetClass, targetclass, ahk_id %id%
	; Check is Class of program is a Minecraft Java Class
	if InStr(targetclass, minecraftClass) {
		click, 950, 450
		sleep, % settings["NewWorld"].clickDelay
		click, 1200, 950
		sleep, % settings["NewWorld"].clickDelay

		Send, % " " settings["NewWorld"].worldCount
		++settings["NewWorld"].worldCount
		iniWriteSection(settingsFile, "NewWorld", settings["NewWorld"])

		click, 1200, 350
		click, 2
		sleep, % settings["NewWorld"].clickDelay
		click, 700, 1050
	}
return