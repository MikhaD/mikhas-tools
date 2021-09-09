; Reload script while working in Notepad++ or VS Code
#If tools["CtrlR"] == 1
#If WinActive("ahk_class Notepad++") or WinActive("ahk_exe Code.exe")
$^r::
	MouseGetPos xcoord, ycoord
	If WinActive("ahk_class Notepad++")
		WinGetActiveTitle, title
	else
		{
		ClipSave := ClipboardAll
		Clipboard :=
		SendInput +!c
		Clipwait, 0.5
		title := Clipboard
		Clipboard := ClipSave
		ClipSave := 
		}
	Try
		{
		Run %title%
		ToolTip Script Reloaded
		}
	Catch 
		{
		ToolTip Failed to Reload
		}
	Loop 50000
		{
		MouseGetPos xcoord2, ycoord2
		If (xcoord != xcoord2) or (ycoord != ycoord2)
			{
			ToolTip
			Break
			}
		}
		ToolTip
Return