-- advanceder.applescript
-- PunyVid


on clicked theObject
	display alert (localized string "advanced")
	tell drawer "advanced" of window "PunyVid" to open drawer on right
	--display dialog (contents of text field "serial" of window "Preferences" as string)
end clicked
