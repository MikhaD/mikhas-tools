; Show a tooltip with the hex of the color you're hovering over and copy it to clipboard. Move the mouse to dismiss the tooltip.
#If tools["CtrlAltI"] == 1
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