# About
Making this set of tools was my first ever programming project. I had barely learned the basics of AutoHotkey and knew little to nothing about programming fundamentals.
However, I have continued to use these tools daily since I made them, gradualy iterating them as I had new ideas and learned new things.

## How to add a new tool
1) Add its unique name, description and desired default state to the `toolArray` 2d array in [Mikha's Tools.ahk](Mikha's%20Tools.ahk)
1) Create an ahk file with the same name in the hotkeys or hotstrings folder
1) Write the hotkey or hotstring
1) Include the new file

## Per tool settings
Every tool has a key in the settings hashmap where it can store a hashmap of data. The tool can save its settings to the settings file using its unique name as a section header by calling `iniWriteSection` on its settings hashmap.

On script start and gui open anthing in the settings file in a given tools section will be loaded to the tools entry in the settings hashmap.
If there are values in a tools settings entry when the gui is opened but there is nothing to load from the settings file (session values) they will not be replaced