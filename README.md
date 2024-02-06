# About
Making this set of tools was my first ever programming project. I had barely learned the basics of AutoHotkey and knew little to nothing about programming fundamentals.
However, I have continued to use these tools daily since I made them, gradualy iterating them as I had new ideas and learned new things.

## How to add a new tool
1) Add its unique name, description and desired default state to the `toolArray` 2d array in [Mikha's Tools.ahk](Mikha's%20Tools.ahk)
1) Create an ahk file with the same name in the hotkeys or hotstrings folder
1) Write the hotkey or hotstring
1) Include the new file

## How to compile a new version
1) Comment out line 16 (`Menu, Tray, Icon, % "img/favicon.ico", , 1`) in [Mikha's Tools.ahk](Mikha's%20Tools.ahk)
1. Run Ahk2Exe and select [Mikha's Tools.ahk](Mikha's%20Tools.ahk) as the source
1. Click browse for destination and set the file name to `Mikha's Tools <version>.exe`. The .exe can't be omitted
1. Set the custom ico
1. Click Convert
1. Uncomment line 16 in [Mikha's Tools.ahk](Mikha's%20Tools.ahk)

## Per tool settings
Every tool has a key in the settings hashmap where it can store a hashmap of data. The tool can save its settings to the settings file using its unique name as a section header by calling `iniWriteSection` on its settings hashmap.

On script start and gui open anthing in the settings file in a given tools section will be loaded to the tools entry in the settings hashmap.
If there are values in a tools settings entry when the gui is opened but there is nothing to load from the settings file (session values) they will not be replaced