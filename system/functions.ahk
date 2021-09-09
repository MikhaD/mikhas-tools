; Read a section from an ini file and return a hashmap of keys to values. If the file doesn't exist an empty hashmap is returned
iniReadSection(path, sect) {
	IniRead, sections, %path%, %sect%
	result := {}
	Loop, Parse, sections, `n
	{
		vals := StrSplit(A_LoopField, "=")
		result[vals[1]] := vals[2]
	}
	return result
}

; Write a section sect to the file path with the key value pairs from hashMap. Create the file if it doesn't exist
iniWriteSection(path, sect, hashMap) {
	result := ""
	for key, val in hashMap
	{
		result := result key "=" val "`n"
	}
	IniWrite, %result%, %path%, %sect%
}

; Update a hashmap with the values from the section sect in the settings file at path
updateHashMap(path, sect, hashMap) {
	for setting, val in iniReadSection(path, sect)
	{
		if hashMap.HasKey(setting)
			hashMap[setting] := val
	}
}

; Read in the states of the tools and update them in the tools hashmap and add any tool specific settings to the settings hashmap
readToolValues(path) {
	global tools
	global settings
	updateHashMap(path, "Tools", tools)
	for key in tools
	{
		toolSettings := iniReadSection(path, key)
		if (!settings.HasKey(key) OR settings[key].Count() == 0 OR toolSettings.Count() > 0)
			settings[key] := toolSettings
	}
}