-- minus.applescript
-- PunyVid

on clicked theObject
	
	set deleteds to (selected data rows of table view "files" of scroll view "files" of window "PunyVid")
	if (count of deleteds) > 0 then
		delete (item 1 of deleteds)
		--		tell button "plus" of window "PunyVid" to set visible to false
		--		tell button "clearall" of window "PunyVid" to set visible to false
		--		tell text field "dragfiles" of window "PunyVid" to set visible to false
		--		tell text field "dragfiles" of window "PunyVid" to set visible to true
		--		tell button "plus" of window "PunyVid" to set visible to true
		--		tell button "clearall" of window "PunyVid" to set visible to true
		update window "PunyVid"
	end if
	
end clicked
