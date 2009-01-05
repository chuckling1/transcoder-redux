-- openfile.applescript
-- PunyVid

on choose menu item theObject
	set video to choose file without invisibles
	set newrow to make new data row at end of data rows of data source of table view "files" of scroll view "files" of window "PunyVid"
	set contents of data cell "Files" of newrow to POSIX path of video as string
	--	tell button "plus" of window "PunyVid" to set visible to false
	--	tell button "minus" of window "PunyVid" to set visible to false
	--	tell button "clearall" of window "PunyVid" to set visible to false
	--	tell text field "dragfiles" of window "PunyVid" to set visible to false
	--	tell text field "dragfiles" of window "PunyVid" to set visible to true
	--	tell button "plus" of window "PunyVid" to set visible to true
	--	tell button "clearall" of window "PunyVid" to set visible to true
	--	tell button "minus" of window "PunyVid" to set visible to true
	update window "PunyVid"
end choose menu item

on clicked theObject
	set video to choose file without invisibles
	set newrow to make new data row at end of data rows of data source of table view "files" of scroll view "files" of window "PunyVid"
	set contents of data cell "Files" of newrow to POSIX path of video as string
	--	tell button "plus" of window "PunyVid" to set visible to false
	--	tell button "minus" of window "PunyVid" to set visible to false
	--	tell button "clearall" of window "PunyVid" to set visible to false
	--	tell text field "dragfiles" of window "PunyVid" to set visible to false
	--	tell text field "dragfiles" of window "PunyVid" to set visible to true
	--	tell button "plus" of window "PunyVid" to set visible to true
	--	tell button "clearall" of window "PunyVid" to set visible to true
	--	tell button "minus" of window "PunyVid" to set visible to true
	update window "PunyVid"
end clicked

on open theObject
	-- For every item in the list, make a new data row and set it's contents
	repeat with theItem in theObject
		set newrow to make new data row at end of data rows of data source of table view "files" of scroll view "files" of window "PunyVid"
		set contents of data cell "files" of newrow to theItem
	end repeat
	
	-- Set the preferred type back to the default
	--	tell button "plus" of window "PunyVid" to set visible to false
	--	tell button "minus" of window "PunyVid" to set visible to false
	--	tell button "clearall" of window "PunyVid" to set visible to false
	--	tell text field "dragfiles" of window "PunyVid" to set visible to false
	--	tell text field "dragfiles" of window "PunyVid" to set visible to true
	--	tell button "plus" of window "PunyVid" to set visible to true
	--	tell button "clearall" of window "PunyVid" to set visible to true
	--	tell button "minus" of window "PunyVid" to set visible to true
	update window "PunyVid"
	
	return true
end open

on resized theObject
	--	tell button "plus" of window "PunyVid" to set visible to false
	--	tell button "minus" of window "PunyVid" to set visible to false
	--	tell button "clearall" of window "PunyVid" to set visible to false
	--	tell text field "dragfiles" of window "PunyVid" to set visible to false
	--	tell text field "dragfiles" of window "PunyVid" to set visible to true
	--	tell button "plus" of window "PunyVid" to set visible to true
	--	tell button "clearall" of window "PunyVid" to set visible to true
	--	tell button "minus" of window "PunyVid" to set visible to true
	update window "PunyVid"
end resized



