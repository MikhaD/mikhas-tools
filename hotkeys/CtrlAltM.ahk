; Show a ToolTip with your mouses coordinates and copy them to clipboard. Move the mouse to dismiss the ToolTip.
#If tools["CtrlAltM"] == 1
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