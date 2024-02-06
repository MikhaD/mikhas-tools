; Reverse the direction of slashes in the selection or on the clipboard

getSelection() {
	; return the current selection
	_clipHolder := ClipboardAll
	Clipboard :=
	SendInput ^c
	Clipwait, 0.5
	_selection := Clipboard
	Clipboard := _clipHolder
	return _selection
}

#If tools["CtrlAltSlsh"] == 1
$^!/::
	text := getSelection()
	selection := true
	replace_count := 0
	if (text == "") {
		selection := false
		text := Clipboard
	}
	; text := StrReplace(text, "\", "/")
	text := StrReplace(text, "\", "/", replace_count)
	if (selection) {
		SendRaw % text
	} else {
		if (replace_count == 0) {
			ToolTip No slashes to switch
		} else {
			Clipboard := text
			if (replace_count == 1) {
				ToolTip 1 slash reversed on clipboard
			} else {
				ToolTip %replace_count% slashes reversed on clipboard
			}
		}
	}

	Sleep 1000
	ToolTip
Return