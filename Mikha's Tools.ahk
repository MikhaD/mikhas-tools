;Version Number When Compiled: 1.13

; SEE README FOR INSTRUCTIONS AND INFORMATION ABOUT ADDING NEW TOOLS

#NoEnv 						; Avoid checking empty variables to see if they are environment variables
#Warn						; Enable warnings to assist with detecting common errors.
#SingleInstance Force
SendMode Input				; Recommended for new scripts due to its superior speed and reliability.
SetBatchLines, -1			; Run script as fast as possible
SetKeyDelay, -1
SetControlDelay, -1
SetMouseDelay, -1
SetWinDelay, -1

SetWorkingDir %A_ScriptDir%
Menu, Tray, Icon, % "img/favicon.ico", , 1

settingsFile 	:= "settings.ini"
MGUIup			:= 0
GUIWidth		:= 830

; 			  Name			Descrption														Default state
toolArray :=[["CtrlAltN",	"Ctrl Alt N  - Open NotePad++",												0]
			,["CtrlAltM",	"Ctrl Alt M  - Show coordinates of the mouse and copy them to clipboard",	0]
			,["CtrlAltI",	"Ctrl Alt I  - Show color under cursor and copy hex to clipboard",			0]
			,["CtrlAltF2",	"Ctrl Alt F2 - Open a new instance of Word if it is not the active window",	0]
			,["CtrlWinI",	"Ctrl Win I  - Open control panel",											0]
			,["CtrlR",		"Ctrl R      - Reload script while working in Notepad++ or VS Code",		0]
			,["AltC",		"Alt C       - Toggle autoclicker (Left)",									0]
			,["CtrlAltC",	"Ctrl Alt C  - Toggle autoclicker (Right)",									0]
			,["AltLMidC",	"Alt Click   - Middle click (useful on mouseless laptops)",					0]
			; ,["NewWorld",	"Ctrl F1     - Create a new minecraft world from the title screen",			0]
			,[]
			,["BackBrackD",	"Type ]d to insert the current date",										0]
			,["BackBrackT",	"Type ]t to insert the current time",										0]
			,["BackBrackPY","Type ]py to insert python script header",									0]
			,[]
			,["BrackComs",	"Automatically close brackets and inverted commas",							0]
			,["ContCorr",	"Add apostrophes to contractions",											0]
			,["AccAdd",		"Add accents to words with accented letters",								0]
			,["SpellCheck",	"Auto correct a few spelling mistakes I frequently make",					0]
			,["CapsLKill",	"Turn CapsLock into a shift key and assign Capslock to Ctrl + CapsLock",	0]]

settings := {"runOnStartup":	1
			,"upOnStart":		1}

; Make hashmap of tool names to states called tools
tools := {}
for i, tool in toolArray
{
	if (tool.Count() != 0)
		tools[tool[1]] := tool[3]
}

; Update settings defualt states from settings file if it exists
updateHashMap(settingsFile, "System", settings)

; If upOnStart is true this activates the Gui
If (settings["upOnStart"] == 1)
	Gosub, ShowGUI
Else {
	readToolValues(settingsFile)
}

;  _____           _                 
; /  ___|         | |                
; \ `--. _   _ ___| |_ ___ _ __ ___  
;  `--. \ | | / __| __/ _ \ '_ ` _ \ 
; /\__/ / |_| \__ \ ||  __/ | | | | |
; \____/ \__, |___/\__\___|_| |_| |_|
;         __/ |                      
;        |___/                       

#Include, %A_ScriptDir%/system/functions.ahk
#Include, %A_ScriptDir%/system/GUI.ahk


;  _   _       _   _
; | | | |     | | | |
; | |_| | ___ | |_| | _____ _   _ ___
; |  _  |/ _ \| __| |/ / _ \ | | / __|
; | | | | (_) | |_|   <  __/ |_| \__ \
; \_| |_/\___/ \__|_|\_\___|\__, |___/
;                            __/ |
;                           |___/

#Include, %A_ScriptDir%/hotkeys/CtrlAltN.ahk
#Include, %A_ScriptDir%/hotkeys/CtrlAltM.ahk
#Include, %A_ScriptDir%/hotkeys/CtrlAltI.ahk
#Include, %A_ScriptDir%/hotkeys/CtrlAltF2.ahk
#Include, %A_ScriptDir%/hotkeys/CtrlWinI.ahk
#Include, %A_ScriptDir%/hotkeys/CtrlR.ahk
#Include, %A_ScriptDir%/hotkeys/AltC.ahk
#Include, %A_ScriptDir%/hotkeys/CtrlAltC.ahk
#Include, %A_ScriptDir%/hotkeys/AltLMidC.ahk
; #Include, %A_ScriptDir%/hotkeys/NewWorld.ahk


;  _   _       _       _        _
; | | | |     | |     | |      (_)
; | |_| | ___ | |_ ___| |_ _ __ _ _ __   __ _ ___
; |  _  |/ _ \| __/ __| __| '__| | '_ \ / _` / __|
; | | | | (_) | |_\__ \ |_| |  | | | | | (_| \__ \
; \_| |_/\___/ \__|___/\__|_|  |_|_| |_|\__, |___/
;                                        __/ |
;                                       |___/

#Include, %A_ScriptDir%/hotstrings/BackBrackD.ahk
#Include, %A_ScriptDir%/hotstrings/BackBrackT.ahk
#Include, %A_ScriptDir%/hotstrings/BackBrackPY.ahk
#Include, %A_ScriptDir%/hotstrings/BrackComs.ahk
#Include, %A_ScriptDir%/hotstrings/ContCorr.ahk
#Include, %A_ScriptDir%/hotstrings/AccAdd.ahk
#Include, %A_ScriptDir%/hotstrings/SpellCheck.ahk
#Include, %A_ScriptDir%/hotstrings/CapsLKill.ahk


$!p::
	pause
return