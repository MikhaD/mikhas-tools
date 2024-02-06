; These hotstrings auto close inverted commas and brackets.
#If tools["BrackComs"] == 1 && !WinActive("ahk_exe notepad++.exe") && !WinActive("ahk_exe Code.exe")
:*:(::(){Left}

#If tools["BrackComs"] == 1 && !WinActive("ahk_exe notepad++.exe") && !WinActive("ahk_exe Code.exe")
:*:{::{{}{}}{Left}

#If tools["BrackComs"] == 1 && !WinActive("ahk_exe notepad++.exe") && !WinActive("ahk_exe Code.exe")
:*:[::[]{Left}

#If tools["BrackComs"] == 1 && !WinActive("ahk_exe notepad++.exe") && !WinActive("ahk_exe Code.exe")
:*:"::""{Left}

