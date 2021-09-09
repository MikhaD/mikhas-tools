; Have a different file for each hotkey/hotstring group
; Put the shortcut keys into either a groupbox or outline the text and standardise the size, and use a different font for the description
; Ask or test if Notepad++/Word/Minecraft and any other non default programs are on the hosts computer (Test with run command) Inform user that there are tools that apply to nonexistant programs, and have radio buttons asking whether they want to show those tools anyway. If yes, color them differently in the gui. If it gets installed, change it back, or if hidden, ask if the user now want to show them. If not, have the option available in the settings.
; - Write mini keyboard with small translucent dot to enable it, like a phone.
; - Change autoclicker to click when Alt - C is pressed, and bring up settings when Win - Alt - C is pressed
; - Remove tool if the program it is intended for does not exist

;Version Number When Compiled: 1.12
; Added recieved -> received auto correction hotstring
; Added recieve -> receive auto correction hotstring
; Deleted wynncraft related tools
; Moved autoclicker state variables from the top to where the clickers are implemented
; Removed secret ctrl + p pause hotkey

; startup variable:				A_Startup
; common startup folder path:	C:\ProgramData\Microsoft\Windows\Start Menu\Programs\StartUp
; startup folder path:			C:\Users\Mikha\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup

; TO ADD A TOOL: 1) Add the tool's description to the ToolInfo array. 2) Add the hotkey to Trigger array. 3) Program the tool.

; Add settings and help (little cog image required)
#NoEnv 						; Avoid checking empty variables to see if they are environment variables
#Warn						; Enable warnings to assist with detecting common errors.
#SingleInstance Force
SendMode Input				; Recommended for new scripts due to its superior speed and reliability.
SetBatchLines, -1			; Run script as fast as possible
SetKeyDelay, -1
SetControlDelay, -1
SetMouseDelay, -1
SetWinDelay, -1
SetWorkingDir %A_ScriptDir%	; Ensures a consistent starting directory.
Menu, Tray, Icon, images\favicon.ico, , 1
settingsFile 	:= "oldSettings.ini"
MGUIup			:= 0
GUIWidth		:= 830
; Initial state of auto clickers
AltCOn := false
CtrlAltCOn := false

ToolInfo		:= [  "Ctrl Alt N  - Open NotePad++"
					, "Ctrl Alt M  - Show ToolTip with mouse's coordinates and copy them"
					, "Ctrl Alt I  - Show ToolTip with the color under the mouse and copy the hex"
					, "Ctrl Alt F2 - Open a new instance of Word if it is not the active window"
					, "Ctrl Win I  - Open control panel"
					, "Ctrl R      - Reload script while working in Notepad++ or VS Code"
					, "Alt C       - Toggle autoclicker (Left)"
					, "Ctrl Alt C  - Toggle autoclicker (Right)"
					, "Alt Click   - Middle click (useful on mouseless laptops)"
					, "Type ]d to insert the current date"
					, "Type ]t to insert the current time"
					, "Type ]py to insert python script header"
					, "Automatically close brackets and inverted commas"
					, "Add the apostrophe to contractions, and accents to words with accented letters"
					, "Turn CapsLock into a shift key and assign Capslock to Ctrl + CapsLock"]

Trigger			:= [  "CtrlAltN"
					, "CtrlAltM"
					, "CtrlAltI"
					, "CtrlAltF2"
					, "CtrlWinI"
					, "CtrlR"
					, "AltC"
					, "CtrlAltC"
					, "AltLMidC"
					, "BackBrackD"
					, "BackBrackT"
					, "BackBrackPY"
					, "BrackComs"
					, "ContCorr"
					, "CapsLKill"]

Loop % Trigger.Length()
	{
	Carrier		:= Trigger[A_Index]
	%Carrier%	:= A_Index
	}

Gosub, Initialize
If (upOnStart = 1)			; If Show on startup is checked this activates the Gui
	Gosub, ShowGUI

;  _   _       _   _
; | | | |     | | | |
; | |_| | ___ | |_| | _____ _   _ ___
; |  _  |/ _ \| __| |/ / _ \ | | / __|
; | | | | (_) | |_|   <  __/ |_| \__ \
; \_| |_/\___/ \__|_|\_\___|\__, |___/
;                            __/ |
;                           |___/

; Show message box with all hotkeys and hotstrings
ShowGUI:
#If MGUIup = 0
$^!h::

	Gosub, Initialize
	Gui, RoS: +AlwaysOnTop -Caption +Border
	Gui, RoS: Margin, 20, 10
	Gui, RoS: Font, s16 w700, Arial Black
	Gui, RoS: Add, Progress, x0 y0 w%GUIWidth% h37 Background808080 Disabled
	Gui, RoS: Add, Text, x0 y3 w%GUIWidth% Center gGuiMove BackGroundTrans, Press Ctrl Alt H to list all hotkeys and hotstrings
	Gui, RoS: Font, s12 w500, Courier New
	Loop % Trigger.Length()
		{
		If (ToolInfo[A_Index] = "Type ]d to insert the current date") or (ToolInfo[A_Index] = "Automatically close brackets and inverted commas")
			Padding = 30
		else
			Padding = 10
		Carrier := ToolInfo[A_Index]
		Gui, RoS: Add, Checkbox, % "vTool" A_Index " x20 y+" Padding " " Checked%A_Index%, %Carrier%
		}
	Gui, RoS: Font, s17 w900
	Gui, RoS: Add, Button, vOKBtn w120 h30 x320 y+30 Default +Center , OK
	GuiControlGet, B, RoS:Pos, OKBtn
	Gui, RoS: Font, s9 w900, Courier New
	Gui, RoS: Add, Checkbox, % "vrunOnStartup " startupChecked " x" GUIWidth - (GUIWidth*0.2) " y" BY "", Run on startup
	GuiControlGet, C1, RoS:Pos, runOnStartup
	Gui, RoS: Add, Checkbox, % "vupOnStart " startChecked " x" GUIWidth - (GUIWidth*0.2) " y+8", Show on start
	GuiControlGet, C2, RoS:Pos, upOnStart
	Gui, RoS: Font, s10 w300, Webdings
	Gui, RoS: Add, Text, % "x" C1X - 20 " y" C1Y - 1 " gQ1 ", i
	Gui, RoS: Add, Text, % "x" C2X - 20 " y" C2Y - 1 " gQ2 ", i
	Gui, RoS: Show, % "Center w" GUIWidth " h" C2Y + C2H + 20
	WinSetTitle MikToolsGUI
	MGUIup := 1
Return

Q1:
	Gui, RoS: -AlwaysOnTop
	MsgBox,, Run On Startup Explination, Check this box if you want this script`nto start when you start your computer.
	Gui, RoS: +AlwaysOnTop
Return

Q2:
	Gui, RoS: -AlwaysOnTop
	MsgBox,, Show On Start Explination, Check this box if you want this GUI`nto pop up whenever this script is started.
	Gui, RoS: +AlwaysOnTop
Return

GuiMove:
   PostMessage, 0xA1, 2
return

RoSGuiEscape:
RoSButtonOK:
	Gui, RoS: Submit
	Gui, RoS: Destroy
	FileDelete %A_ScriptDir%\%settingsFile%
	Loop % Trigger.Length() {
		FileAppend % Tool%A_Index% "#", %A_ScriptDir%\%settingsFile%
	}

	FileAppend `n%runOnStartup%`n%upOnStart%, %A_ScriptDir%\%settingsFile%
	If runOnStartup = 1
		{
		IfNotExist %A_Startup%\%A_ScriptName%.lnk
			FileCreateShortcut %A_ScriptFullPath%, %A_Startup%\%A_ScriptName%.lnk
		}
	else
		{
		IfExist %A_Startup%\%A_ScriptName%.lnk
			FileDelete %A_Startup%\%A_ScriptName%.lnk
		}
	MGUIup := 0
Return

#If Tool%CtrlAltN% = 1
$^!n::
	Run, Notepad++.exe							; Open Notepad++
Return

; Show a ToolTip with your mouses coordinates and copy them to clipboard. Move the mouse to dismiss the ToolTip.
#If Tool%CtrlAltM% = 1
$^!m::
	MouseGetPos, xcoord, ycoord
	ToolTip, X:%xcoord% Y:%ycoord%
	clipboard = %xcoord%, %ycoord%
	loop
		{
		MouseGetPos, xcoord2, ycoord2
		if (xcoord != xcoord2) or (ycoord != ycoord2)
			{
			ToolTip
			break
			}
		}
Return

; Show a tooltip with the hex of the color you're hovering over and copy it to clipboard. Move the mouse to dismiss the tooltip.
#If Tool%CtrlAltI% = 1
$^!i::
	MouseGetPos, xcoord, ycoord
	PixelGetColor, pixColor, xcoord, ycoord, RGB
	ToolTip, % "#" SubStr(pixColor, 3)
	clipboard = % "#" SubStr(pixColor, 3)
	loop
		{
		MouseGetPos, xcoord2, ycoord2
		if (xcoord != xcoord2) or (ycoord != ycoord2)
			{
			ToolTip
			break
			}
		}
Return

; Open a new instance of word if word is not the active window. The $ ensures the hotkey only runs if the keys are pressed.
#If Tool%CtrlAltF2% = 1
#ifWinNotActive ahk_class OpusApp
$^!F2::
	Run, winword.exe
Return

#If Tool%CtrlWinI% = 1
$^#i::
	Run, control.exe							; Open Control pannel
Return

#IfTool%CtrlR% = 1
#If WinActive("ahk_class Notepad++") or WinActive("ahk_exe Code.exe")
$^r::											; Reload script while working in Notepad++ or VS Code
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
		If (xcoord <> xcoord2) or (ycoord <> ycoord2)
			{
			ToolTip
			Break
			}
		}
		ToolTip
Return

; High speed togglable autoclicker (Left)
#If Tool%AltC% = 1
#MaxThreadsPerHotkey 2 ; Enable all hotkeys from this point forth to react to a second press while running, rather than ignoring it.
$!c::
	AltCOn := !AltCOn
	While (AltCOn == true) {
		Click
		ToolTip Clicker Active (Left)
		Sleep 200
		}
	ToolTip
Return
#MaxThreadsPerHotkey 1 ; Reset to default.

; High speed togglable autoclicker (Right)
#If Tool%CtrlAltC% = 1
#MaxThreadsPerHotkey 2 ; Enable all hotkeys from this point forth to react to a second press while running, rather than ignoring it.
$^!c::
	CtrlAltCOn := !CtrlAltCOn
	While (CtrlAltCOn == true) {
		Click, right
		ToolTip Clicker Active (Right)
		Sleep 20
		}
	ToolTip
Return
#MaxThreadsPerHotkey 1 ; Reset to default.

#If Tool%AltLMidC% == 1
$!LButton:: SendInput {MButton}

;  _   _       _       _        _
; | | | |     | |     | |      (_)
; | |_| | ___ | |_ ___| |_ _ __ _ _ __   __ _ ___
; |  _  |/ _ \| __/ __| __| '__| | '_ \ / _` / __|
; | | | | (_) | |_\__ \ |_| |  | | | | | (_| \__ \
; \_| |_/\___/ \__|___/\__|_|  |_|_| |_|\__, |___/
;                                        __/ |
;                                       |___/

; This hotstring replaces "]d" with the current date.
#If Tool%BackBrackD% = 1
:*:]d::
	FormatTime, D, dd/MM/yyyy, ShortDate	; It will look like this: 11/09/2001
	SendInput %D%
Return

 ; This hotstring replaces "]t" with the current time.
#If Tool%BackBrackT% = 1
:*:]t::
	FormatTime, T, hh:mm:ss tt, Time			; It will look like this: 12:05:20 PM
	SendInput %T%
Return

; This hotstring replaces "]py" with my python script header.
#If Tool%BackBrackPY% = 1
:*:]py::
	sendInput """Description"""`n__author__ = `"%A_UserName%`"`n
	SendRaw #
	SendInput %A_MDay%/%A_Mon%/%A_Year%`n
Return

; These hotstrings auto close inverted commas and brackets.
#IfWinNotActive ahk_class Notepad++
#If Tool%BrackComs% = 1
:*:(::(){Left}
;	+{Right}
;	Send ^c
;	Clipwait
;	if Clipboard = 

#IfWinNotActive ahk_class Notepad++
#If Tool%BrackComs% = 1
:*:{::{{}{}}{Left}

#IfWinNotActive ahk_class Notepad++
#If Tool%BrackComs% = 1
:*:[::[]{Left}

#IfWinNotActive ahk_class Notepad++
#If Tool%BrackComs% = 1
:*:"::""{Left}

; These hotstrings add the apostrophe to contractions, add accents to letters and correct certain words

#If Tool%ContCorr% = 1
::arent::aren't

#If Tool%ContCorr% = 1
::cafe::café

#If Tool%ContCorr% = 1
::canape::canapé

#If Tool%ContCorr% = 1
::cant::can't

#If Tool%ContCorr% = 1
::cliche::cliché

#If Tool%ContCorr% = 1
::couldnt::couldn't

#If Tool%ContCorr% = 1
::couldve::could've

#If Tool%ContCorr% = 1
::definate::definite

#If Tool%ContCorr% = 1
::definately::definitely

#If Tool%ContCorr% = 1
::didnt::didn't

#If Tool%ContCorr% = 1
::divorcee::divorcée

#If Tool%ContCorr% = 1
::doesnt::doesn't

#If Tool%ContCorr% = 1
::dont::don't

#If Tool%ContCorr% = 1
::doppelganger::doppelgänger

#If Tool%ContCorr% = 1
::eclair::éclair

#If Tool%ContCorr% = 1
::entree::entrée

#If Tool%ContCorr% = 1
::facade::façade

#If Tool%ContCorr% = 1
::fiance::fiancé

#If Tool%ContCorr% = 1
::hadnt::hadn't

#If Tool%ContCorr% = 1
::hasnt::hasn't

#If Tool%ContCorr% = 1
::havent::haven't

#If Tool%ContCorr% = 1
::hed::he'd

#If Tool%ContCorr% = 1
::hes::he's

#If Tool%ContCorr% = 1
::howd::how'd

#If Tool%ContCorr% = 1
::howll::how'll

#If Tool%ContCorr% = 1
::howre::how're

#If Tool%ContCorr% = 1
::hows::how's

#If Tool%ContCorr% = 1
::Im::I'm

#If Tool%ContCorr% = 1
::isnt::isn't

#If Tool%ContCorr% = 1
::itd::it'd

#If Tool%ContCorr% = 1
::itll::it'll

#If Tool%ContCorr% = 1
::Ive::I've

#If Tool%ContCorr% = 1
::jalapeno::jalapeño

#If Tool%ContCorr% = 1
::maynt::mayn't

#If Tool%ContCorr% = 1
::mayve::may've

#If Tool%ContCorr% = 1
::mightnt::mightn't

#If Tool%ContCorr% = 1
::mightve::might've

#If Tool%ContCorr% = 1
::mustnt::mustn't

#If Tool%ContCorr% = 1
::mustve::must've

#If Tool%ContCorr% = 1
::neednt::needn't

#If Tool%ContCorr% = 1
::oclock::o'clock

#If Tool%ContCorr% = 1
::ole::olé

#If Tool%ContCorr% = 1
::ombre::ombré

#If Tool%ContCorr% = 1
::onenote::OneNote

#If Tool%ContCorr% = 1
::oughtnt::oughtn't

#If Tool%ContCorr% = 1
::pinata::piñata

#If Tool%ContCorr% = 1
::Quebec::Québec

#If Tool%ContCorr% = 1
::recieved::received

#If Tool%ContCorr% = 1
::recieve::receive

#If Tool%ContCorr% = 1
::seance::séance

#If Tool%ContCorr% = 1
::shant::shan't

#If Tool%ContCorr% = 1
::shes::she's

#If Tool%ContCorr% = 1
::shouldnt::shouldn't

#If Tool%ContCorr% = 1
::shouldve::should've

#If Tool%ContCorr% = 1
::thatd::that'd

#If Tool%ContCorr% = 1
::thatll::that'll

#If Tool%ContCorr% = 1
::thatre::that're

#If Tool%ContCorr% = 1
::thats::that's

#If Tool%ContCorr% = 1
::thered::there'd

#If Tool%ContCorr% = 1
::therere::there're

#If Tool%ContCorr% = 1
::theres::there's

#If Tool%ContCorr% = 1
::thesere::these're

#If Tool%ContCorr% = 1
::theyd::they'd

#If Tool%ContCorr% = 1
::theyll::they'll

#If Tool%ContCorr% = 1
::theyre::they're

#If Tool%ContCorr% = 1
::theyve::they've

#If Tool%ContCorr% = 1
::thiss::this's

#If Tool%ContCorr% = 1
::thosere::those're

#If Tool%ContCorr% = 1
::touche::touché

#If Tool%ContCorr% = 1
::wasnt::wasn't

#If Tool%ContCorr% = 1
::wed::we'd

#If Tool%ContCorr% = 1
::werent::weren't

#If Tool%ContCorr% = 1
::weve::we've

#If Tool%ContCorr% = 1
::whatd::what'd

#If Tool%ContCorr% = 1
::whatll::what'll

#If Tool%ContCorr% = 1
::whatre::what're

#If Tool%ContCorr% = 1
::whats::what's

#If Tool%ContCorr% = 1
::whatve::what've

#If Tool%ContCorr% = 1
::whens::when's

#If Tool%ContCorr% = 1
::whered::where'd

#If Tool%ContCorr% = 1
::wherere::where're

#If Tool%ContCorr% = 1
::wheres::where's

#If Tool%ContCorr% = 1
::whereve::where've

#If Tool%ContCorr% = 1
::whichs::which's

#If Tool%ContCorr% = 1
::whod::who'd

#If Tool%ContCorr% = 1
::wholl::who'll

#If Tool%ContCorr% = 1
::whos::who's

#If Tool%ContCorr% = 1
::whyd::why'd

#If Tool%ContCorr% = 1
::whyre::why're

#If Tool%ContCorr% = 1
::whys::why's

#If Tool%ContCorr% = 1
::wont::won't

#If Tool%ContCorr% = 1
::wouldnt::wouldn't

#If Tool%ContCorr% = 1
::wouldve::would've

#If Tool%ContCorr% = 1
::yall::y'all

#If Tool%ContCorr% = 1
::youd::you'd

#If Tool%ContCorr% = 1
::youll::you'll

#If Tool%ContCorr% = 1
::youre::you're

#If Tool%ContCorr% = 1
::youve::you've

#If Tool%ContCorr% = 1
:c:Id::I'd

#If Tool%ContCorr% = 1
:c:Ill::I'll

; This hotstring replaces ahk with AutoHotkey in chrome and word
#If WinActive("ahk_class Chrome_WidgetWin_1", , "Visual Studio Code") or WinActive("ahk_class OpusApp")
;::ahk::AutoHotkey

; This hotkey turns CapsLock into a Shift key and reassigns Capslock to Ctrl + CapsLock
#If Tool%CapsLKill% = 1
$^CapsLock::CapsLock

#If Tool%CapsLKill% = 1
$CapsLock::Shift


Initialize:
	IfExist, %A_ScriptDir%\%settingsFile%
		{
		FileReadLine, runOnStartup, %A_ScriptDir%\%settingsFile%, 2
		FileReadLine, upOnStart, %A_ScriptDir%\%settingsFile%, 3
		FileReadLine, Settings, %A_ScriptDir%\%settingsFile%, 1
		StringSplit Settings, Settings, #
		Loop % Trigger.Length()
			Tool%A_Index% := Settings%A_Index%
		}
	else {
		runOnStartup := 1
		upOnStart := 1
		Loop % Trigger.Length()
			Tool%A_Index% := 1
		}
	If runOnStartup = 1
		{
		startupChecked := "Checked"
		IfNotExist %A_Startup%\%A_ScriptName%.lnk
			FileCreateShortcut %A_ScriptFullPath%, %A_Startup%\%A_ScriptName%.lnk
		}
	else {
		startupChecked :=
		IfExist %A_Startup%\%A_ScriptName%.lnk
			FileDelete %A_Startup%\%A_ScriptName%.lnk
		}
	If upOnStart = 1
		startChecked := "Checked"
	else startChecked :=
	Loop % Trigger.Length()
		{
		if Tool%A_Index% = 1
			Checked%A_Index% := "Checked"
		else Checked%A_Index% :=
		}
Return

$^!Esc::
ExitApp