; Show message box with all hotkeys and hotstrings
ShowGUI:
#If MGUIup = 0
$^!h::
	Gui, RoS: +AlwaysOnTop -Caption +Border
	Gui, RoS: Margin, 20, 10
	Gui, RoS: Font, s16 w700, Arial Black
	Gui, RoS: Add, Progress, x0 y0 w%GUIWidth% h37 Background808080 Disabled
	Gui, RoS: Add, Text, x0 y3 w%GUIWidth% Center gGuiMove BackGroundTrans, % "Press Ctrl Alt H to list all hotkeys and hotstrings"
	Gui, RoS: Font, s12 w500, Courier New
	padding = 10
	for i, tool in toolArray
	{
		if (tool.Count() == 0)
		{
			padding := 30
			continue
		}
		Gui, RoS: Add, Checkbox, % "v" tool[1] " x20 y+" padding " Checked" tools[tool[1]], % tool[2]
		padding := 10
	}
	Gui, RoS: Font, s17 w900
	Gui, RoS: Add, Button, vOKBtn w120 h30 x320 y+30 Default +Center , OK
	GuiControlGet, B, RoS:Pos, OKBtn
	Gui, RoS: Font, s9 w900, Courier New
	Gui, RoS: Add, Checkbox, % "vrunOnStartup Checked" settings["runOnStartup"] " x" GUIWidth - (GUIWidth*0.2)" y" BY, % "Run on startup"
	GuiControlGet, C1, RoS:Pos, runOnStartup
	Gui, RoS: Add, Checkbox, % "vupOnStart Checked" settings["upOnStart"] " x" GUIWidth - (GUIWidth*0.2) " y+8", % "Show on start"
	GuiControlGet, C2, RoS:Pos, upOnStart
	Gui, RoS: Font, s10 w300, Webdings
	Gui, RoS: Add, Text, % "x" C1X - 20 " y" C1Y - 1 " gQ1", i
	Gui, RoS: Add, Text, % "x" C2X - 20 " y" C2Y - 1 " gQ2", i
	Gui, RoS: Show, % "Center w"GUIWidth " h" C2Y + C2H + 20
	WinSetTitle MikToolsGUI
	MGUIup := 1
Return

Q1:
	Gui, RoS: -AlwaysOnTop
	MsgBox,, % "Run On Startup", % "Check this box if you want this script`nto start when you start your computer."
	Gui, RoS: +AlwaysOnTop
Return

Q2:
	Gui, RoS: -AlwaysOnTop
	MsgBox,, % "Show On Start", % "Check this box if you want this GUI`nto pop up whenever this script is started."
	Gui, RoS: +AlwaysOnTop
Return

GuiMove:
   PostMessage, 0xA1, 2
return

RoSGuiEscape:
RoSButtonOK:
	Gui, RoS: Submit
	Gui, RoS: Destroy

	settings["runOnStartup"] := runOnStartup
	settings["upOnStart"] := upOnStart

	for i, tool in toolArray
	{
		if (tool.Count() != 0)
		{
		toolName := tool[1]
		tools[toolName] := %toolName%
		}
	}

	iniWriteSection(settingsFile, "Tools", tools)
	IniWrite, % runOnStartup, % settingsFile, % "System", % "runOnStartup"
	IniWrite, % upOnStart, % settingsFile, % "System", % "upOnStart"

	if (runOnStartup)
	{
		IfNotExist, % A_Startup "/" A_ScriptName ".lnk"
			FileCreateShortcut, % A_ScriptFullPath, % A_Startup "/" A_ScriptName ".lnk"
	}
	else {
		IfExist, % A_Startup "/" A_ScriptName ".lnk"
			FileDelete, % A_Startup "/" A_ScriptName ".lnk"
	}

	MGUIup := 0
Return