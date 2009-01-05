-- drop.applescript
-- PunyVid

on awake from nib theObject
	
	--clean up all temp files
	try
		do shell script "rm /tmp/punyvid* /tmp/*.m4a /tmp/*.wav /tmp/*.mp4"
	end try
	
	-- Create the data source for the table view
	set theDataSource to make new data source at end of data sources with properties {name:"files"}
	
	--	set allows reordering of table view "files" of drawer "drawer" of window "PunyVid" to true
	
	-- Create the "files" data column
	make new data column at end of data columns of theDataSource with properties {name:"files"}
	
	-- Assign the data source to the table view
	set data source of theObject to theDataSource
	
	-- Register for the "color" and "file names" drag types
	tell theObject to register drag types {"file names"}
	--	set allows reordering of table view "files" of scroll view "files" of window "PunyVid" to true
	
	--	tell button "plus" of window "PunyVid" to set visible to false
	--	tell button "minus" of window "PunyVid" to set visible to false
	--	tell button "clearall" of window "PunyVid" to set visible to false
	--	tell text field "dragfiles" of window "PunyVid" to set visible to false
	--	tell text field "dragfiles" of window "PunyVid" to set visible to true
	--	tell button "plus" of window "PunyVid" to set visible to true
	--	tell button "clearall" of window "PunyVid" to set visible to true
	--	tell button "minus" of window "PunyVid" to set visible to true
	update window "PunyVid"
	
	
	--tell button "cancel" of window "PunyVid" to set visible to true
	if (content of text field "timeremaining" of window "PunyVid") is "" then
		tell button "cancel" of window "PunyVid" to set visible to false
	else
		tell button "cancel" of window "PunyVid" to set visible to true
	end if
end awake from nib

-- The "drop" event handler is called when the appropriate type of data is dropped onto the object. All of the pertinent information about the drop is contained in the "dragInfo" object.
--
on drop theObject drag info dragInfo
	-- Get the list of data types on the pasteboard
	set dataTypes to types of pasteboard of dragInfo
	
	-- We are only interested in either "file names" or "color" data types
	if "file names" is in dataTypes then
		-- Initialize the list of files to an empty list
		set theFiles to {}
		
		-- We want the data as a list of file names, so set the preferred type to "file names"
		set preferred type of pasteboard of dragInfo to "file names"
		
		-- Get the list of files from the pasteboard
		set theFiles to contents of pasteboard of dragInfo
		
		-- Make sure we have at least one item
		if (count of theFiles) > 0 then
			--- Get the data source from the table view
			set theDataSource to data source of theObject
			
			-- Turn off the updating of the views
			set update views of theDataSource to false
			
			-- Delete all of the data rows in the data source
			--		delete every data row of theDataSource
			
			-- For every item in the list, make a new data row and set it's contents
			repeat with theItem in theFiles
				set theDataRow to make new data row at end of data rows of theDataSource
				set contents of data cell "files" of theDataRow to theItem
			end repeat
			
			-- Turn back on the updating of the views
			set update views of theDataSource to true
		end if
	end if
	-- Set the preferred type back to the default
	set preferred type of pasteboard of dragInfo to ""
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
end drop
