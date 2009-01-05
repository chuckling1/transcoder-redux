-- saveas.applescript
-- PunyVid

on clicked theObject
	--	set saveas to choose folder with prompt "Choose a destination location for your converted file(s)." as text
	set saveas to choose folder with prompt (localized string "saveloc") as string
	set saveasposix to POSIX path of saveas
	set content of text field "path" of window "PunyVid" to saveasposix as string
end clicked
