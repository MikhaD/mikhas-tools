; These hotstrings auto close inverted commas and brackets.
#IfWinNotActive ahk_class Notepad++
#If tools["BrackComs"] == 1
:*:(::(){Left}

#IfWinNotActive ahk_class Notepad++
#If tools["BrackComs"] == 1
:*:{::{{}{}}{Left}

#IfWinNotActive ahk_class Notepad++
#If tools["BrackComs"] == 1
:*:[::[]{Left}

#IfWinNotActive ahk_class Notepad++
#If tools["BrackComs"] == 1
:*:"::""{Left}