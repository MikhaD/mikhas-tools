## Next Version (1.13.0):
- Added gitignore and ignored release folder
- Made all #include directives use absolute paths
- Added derivitive → derivative spelling correction
- Changed Alt + Click shortcut to Alt + R-Click to prevent it from overriding the vscode add cursor shortcut

## 1.12.1

- Switched to semver versioning system

## 1.12:
- Deleted wynncraft related tools
- Moved changelog from comments to a markdown file
- Removed secret ctrl + p pause hotkey
- Removed secret exit app hotkey because it doesn't work
- Rewrote settings system
- Seperated script code into seperate files
- Seperated gui code and system functions into their own files
- Changed autoclickers to use their key in the settings hashmap to store their state instead of global variables
- Removed all spell check hotstrings that were word variations like receiver and received in favor of a insta activate hotstring for the root word
- Moved todos from comments to a markdown file
- Created a readme with general info about the script, info about existing data structures, and the instructions to make a new tool (moved from the comments)
- Settings now reload from file when gui is opened

## 1.11:
- Added Alt Click to middle mouse button hotkey
- Changed settings file to a variable
- Changed name of settings file to oldSettings.ini
- Changed numlock to Ctrl + numlock for laptop
- Replaced old minecraft enter to play tool with wynnfarmer tool
- Replaced wynnfarmer tool with /class and /lobby hotkeys
- Simplified toggle mechanism for auto clickers

## 1.10
- Moved the code that sets the icon of the script to the top of the script before the initialization of the variables
- Added MIKHADAVIDSLT as a computer name that works
- Removed user name = Mikha as a requirement and put the variable A_UserName into the file path instead
- Added a time limit to the Script Reloaded/Failed to reload Tooltip, which previously only dissapeared when the mouse moved
- Added ]py Hotstring
- Added vs code as a program that can have scripts reloaded by Ctrl + R
- Added SetBatchLines, -1, SetKeyDelay, -1, SetControlDelay, -1, SetMouseDelay, -1, SetWinDelay, -1 in order to make the script faster
- Added a tool to copy the hex color code of whatever the mouse is hovering over

## 1.9
- Added some accented words to contraction corrector tool
- Changed description to include accent correction
- Changed the width of the GUI to a variable and increased it by 60
- Changed position of bottom 2 checkboxes to calculations based on GUIWidth
- Added spelling correction for definitely to CCT
- Added CapsLock Killer tool
- Added how're to contractions tool
- Corrected autoclicker description
- Renamed switch1 variable to AltCSwitch
- Added a right click autoclicker activated with Ctrl Alt C