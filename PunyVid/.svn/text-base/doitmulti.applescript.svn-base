-- doitmulti.applescript
-- PunyVid

on clicked theObject
	
	set decimal to ""
	if (0.73 as string) is "0,73" then
		set decimal to "comma"
	end if
	--This is where animation is neat.
	--	set uses threaded animation of progress indicator "spinner" of window "PunyVid" to true	
	set visible of progress indicator "spinner" of window "PunyVid" to true
	tell progress indicator "spinner" of window "PunyVid" to start
	set theList to (data source of table view "files" of scroll view "files" of window "PunyVid")
	
	--This is where we figure out how many files and make the progress bar fit, and set some global variables
	set howmany to (number of data rows of data column "Files" of theList)
	set minimum value of progress indicator "bar" of window "PunyVid" to 1
	set the content of progress indicator "bar" of window "PunyVid" to 1
	set maximum value of progress indicator "bar" of window "PunyVid" to howmany + 1
	set whichone to 1
	set thePath to path of the main bundle as string
	set thequotedapppath to quoted form of thePath
	
	--This is where we start off with absolutely no problems whatsoever.
	set errors to 0
	
	
	--This is where everything happens Sometimes multiple times.
	repeat with theRow in every data row of data column "Files" of theList
		
		--Start the loop and give some initial feedback.
		set isrunning to "1"
		set the content of text field "timeremaining" of window "PunyVid" to (localized string "startingfile") & whichone & "..."
		
		--Get the file's path, as well as important tidbits, like the filename itself.
		set theorigpath to contents of data cell 1 of theRow as POSIX file
		set quotedorigfile to quoted form of POSIX path of theorigpath
		--		try
		tell application "Finder" to set theFilepath to get (container of file theorigpath) as Unicode text
		--		on error
		--			error "DVDs and VIDEO_TS folders can't be directly converted. Sorry."
		--		end try
		tell application "Finder" to set theFile to get (name of file theorigpath) as Unicode text
		set thequotedpath to (quoted form of POSIX path of theFilepath)
		set thequotedfile to (quoted form of POSIX path of theFile)
		set thequotedorigpath to (quoted form of POSIX path of (theFilepath & theFile))
		tell application "Finder" to set ext to get name extension of file theorigpath
		set text item delimiters to ""
		set filenoext to text 1 thru -5 of (theFile)
		
		
		
		
		
		--If no default save location is specified, just put it in the original file\"s location.
		if contents of text field "path" of window "PunyVid" = "" then
			set destpath to (quoted form of POSIX path of theFilepath)
		else
			set destpath to (quoted form of (contents of text field "path" of window "PunyVid" as string))
		end if
		--Assemble some nice looking text strings.
		set outputfile to (destpath & thequotedfile & ".temp.mp4")
		
		--Leave these variables empty for non-QuickTimeable files.
		set forcepipe to ""
		set extaudiofile to ""
		set extaudio to ""
		set pipe to ""
		set movfps to ""
		set ismov to ""
		set qtproc to false
		set ar to ""
		
		--This is where we put the progress bar foreshadowing.
		do shell script thequotedapppath & "/Contents/Resources/ffmpeg -i " & quotedorigfile & " 2> /tmp/punyvid_dur ; cp /tmp/punyvid_dur /tmp/punyvid_time ; exit 0"
		if (do shell script "echo thisis`/bin/cat /tmp/punyvid_dur | grep -c adpcm_xa`") is "thisis1" then
			set forcepipe to " -f mpeg "
			do shell script thequotedapppath & "/Contents/Resources/ffmpeg " & forcepipe & " -i " & quotedorigfile & " 2> /tmp/punyvid_dur ; cp /tmp/punyvid_dur /tmp/punyvid_time ; exit 0"
		end if
		if ext is "mpg" or ext is "mpeg" then
			if (do shell script "echo thisis`/bin/cat /tmp/punyvid_dur | grep -c mov,mp4,m4a`") is "thisis1" then
				set forcepipe to " -f mpeg "
				do shell script thequotedapppath & "/Contents/Resources/ffmpeg " & forcepipe & " -i " & quotedorigfile & " 2> /tmp/punyvid_dur ; cp /tmp/punyvid_dur /tmp/punyvid_time ; exit 0"
			end if
		end if
		do shell script thequotedapppath & "/Contents/Resources/durfinder"
		--**Set the encoding variables**--
		--Basically, for earch category, check if there\"s an advanced setting set, and use that instead of the default Easy Settings.		
		
		--Set crops. Default is 0 for all.
		if (contents of text field "croptop" of drawer "advanced" of window "PunyVid") is "0" then
			set croptop to " "
		else
			set croptop to " -croptop " & (contents of text field "croptop" of drawer "advanced" of window "PunyVid")
		end if
		if (contents of text field "cropbottom" of drawer "advanced" of window "PunyVid") is "0" then
			set cropbottom to " "
		else
			set cropbottom to " -cropbottom " & (contents of text field "cropbottom" of drawer "advanced" of window "PunyVid")
		end if
		if (contents of text field "cropleft" of drawer "advanced" of window "PunyVid") is "0" then
			set cropleft to " "
		else
			set cropleft to " -cropleft " & (contents of text field "cropleft" of drawer "advanced" of window "PunyVid")
		end if
		if (contents of text field "cropright" of drawer "advanced" of window "PunyVid") is "0" then
			set cropright to " "
		else
			set cropright to " -cropright " & (contents of text field "cropright" of drawer "advanced" of window "PunyVid")
		end if
		
		set dashr to " -r "
		--Someday, this code will provide H.264 encoding. Not today.
		--set tempvid to "'/tmp/" & theFile2 & ".m4v'"
		--set tempaac to "'/tmp/" & theFile2 & ".aac'"
		--set h264level to " "
		set vn to ""
		set vcodec to " -vcodec mpeg4 "
		set x264stuff to ""
		--set pipe264 to ""
		--set x264string to ""
		set normalnuller to " 1> /dev/null "
		set syncer to " -async 50 "
		if content of button "h264" of window "PunyVid" is true then
			set vcodec to " -vcodec h264 "
		end if
		set mpegaspect to ""
		if ext = "vob" then
			set mpegaspect to do shell script thequotedapppath & "/Contents/Resources/mpgtx -i " & quotedorigfile & " /dev/null | grep Aspect | /usr/bin/awk -F ratio '{print $2}' | /usr/bin/awk '{print $1}' | bc -l"
		end if
		
		if ext = "mpg" then
			set mpegaspect to do shell script thequotedapppath & "/Contents/Resources/mpgtx -i " & quotedorigfile & " /dev/null | grep Aspect | /usr/bin/awk -F ratio '{print $2}' | /usr/bin/awk '{print $1}' | bc -l"
		end if
		
		set origwidth to (do shell script "cat /tmp/punyvid_dur | grep fps | /usr/bin/rev | /usr/bin/awk -F ,p '{print $1}' | /usr/bin/awk -F , '{print $1}' | /usr/bin/rev | sed 's/ //g' | /usr/bin/awk -F x '{print $1}'")
		set origheight to (do shell script "cat /tmp/punyvid_dur | grep fps | /usr/bin/rev | /usr/bin/awk -F ,p '{print $1}' | /usr/bin/awk -F , '{print $1}' | /usr/bin/rev | sed 's/ //g' | /usr/bin/awk -F x '{print $2}'")
		
		--Set either iPod or TV size, and figure out the ratio/size of the finished product.
		
		
		
		if contents of text field "width" of drawer "advanced" of window "PunyVid" is "" then
			set origoptim to "ipod"
			if content of cell "optim2" of matrix "optim" of window "PunyVid" is true then
				set origoptim to "tv"
			end if
			try
				if content of cell "optim3" of matrix "optim" of window "PunyVid" is true then
					set origoptim to "ipodav"
				end if
			end try
			
			
			if content of slider "quality" of window "PunyVid" as number is 1 then
				set tiny to "tiny"
			else
				set tiny to "nottiny"
			end if
			if vcodec = " -vcodec h264 " and origoptim is "tv" then
				set tiny to "h264"
			end if
			set optim to do shell script thequotedapppath & "/Contents/Resources/ratiofinder " & origoptim & " " & tiny & " " & mpegaspect
			set thewidth to getmult((do shell script "/bin/echo " & optim & " | /usr/bin/awk -F x '{print $1}'"), 2)
			set theheight to getmult((do shell script "/bin/echo " & optim & " | /usr/bin/awk -F x '{print $2}'"), 2)
		else
			-- ...or use the user's settings.
			set thewidth to getmult((contents of text field "width" of drawer "advanced" of window "PunyVid"), 2)
			set theheight to getmult((contents of text field "height" of drawer "advanced" of window "PunyVid"), 2)
			if thewidth > 320 then
				set origoptim to "tv"
			else
				set origoptim to "ipod"
			end if
		end if
		set optim to thewidth & "x" & theheight
		
		
		--If the file is a QuickTime .mov file, use QuickTime frameworks to decode for better compatibility
		if ext = "mov" then
			--	try
			--The audio needs to be extracted seperately. No real need to put this in the background, so give feedback about the UI stall.
			set the content of text field "timeremaining" of window "PunyVid" to (localized string "prepaud") & whichone & "..."
			delay 0.1
			--Decode audio to WAV and place it in the /tmp folder out of the way.
			set extaudio to " -i /tmp/" & thequotedfile & ".wav "
			set extaudiofile to "/tmp/" & thequotedfile & ".wav"
			try
				do shell script "rm /tmp/" & thequotedfile & ".wav"
			end try
			try
				do shell script thequotedapppath & "/Contents/Resources/movtowav -o /tmp/" & thequotedfile & ".wav " & thequotedorigpath
			on error
				try
					do shell script "rm /tmp/" & thequotedfile & ".wav"
				end try
				set extaudio to "  "
				set extaudiofile to ""
			end try
			--Generate the pipe command strings based off the width, height and fps settings above.
			try
				if decimal is not "comma" then
					set movfps2 to (do shell script thequotedapppath & "/Contents/Resources/movinfo " & thequotedorigpath & " | /usr/bin/awk '{print $4}'") as number
					set movfps to (round movfps2)
				else
					set movfps2 to (do shell script thequotedapppath & "/Contents/Resources/movinfo " & thequotedorigpath & " | /usr/bin/awk '{print $4}' | sed -e 's/\\./,/g'") as number
					set movfps to (round movfps2)
				end if
			end try
			if movfps < 1 then
				set movfps to 30
			end if
			set movwidth to getmult((do shell script thequotedapppath & "/Contents/Resources/movinfo " & thequotedorigpath & " | /usr/bin/awk -F , '{print $2}'"), 8)
			set movheight to getmult((do shell script thequotedapppath & "/Contents/Resources/movinfo " & thequotedorigpath & " | /usr/bin/awk -F , '{print $3}' | sed -e 's/ //g'"), 8)
			set pipe to (thequotedapppath & "/Contents/Resources/movtoy4m -w " & movwidth & " -h " & movheight & " -F " & movfps & ":1 -a " & movwidth & ":" & movheight & " " & thequotedorigpath & " | ")
			set forcepipe to " -f yuv4mpegpipe "
			set thequotedorigpath to "-"
			set qtproc to true
			set syncer to " "
			set ismov to "mov"
			--	end try
		end if
		
		if ext = "3gp" then
			--	try
			--The audio needs to be extracted seperately. No real need to put this in the background, so give feedback about the UI stall.
			set the content of text field "timeremaining" of window "PunyVid" to (localized string "prepaud") & whichone & "..."
			delay 0.1
			--Decode audio to WAV and place it in the /tmp folder out of the way.
			set extaudio to " -i /tmp/" & thequotedfile & ".wav "
			set extaudiofile to "/tmp/" & thequotedfile & ".wav"
			try
				do shell script "rm /tmp/" & thequotedfile & ".wav"
			end try
			try
				do shell script thequotedapppath & "/Contents/Resources/movtowav -o /tmp/" & thequotedfile & ".wav " & thequotedorigpath
			on error
				try
					do shell script "rm /tmp/" & thequotedfile & ".wav"
				end try
				set extaudio to "  "
				set extaudiofile to ""
			end try
			--Generate the pipe command strings based off the width, height and fps settings above.
			try
				if decimal is not "comma" then
					set movfps2 to (do shell script thequotedapppath & "/Contents/Resources/movinfo " & thequotedorigpath & " | /usr/bin/awk '{print $4}'") as number
					set movfps to (round movfps2)
				else
					set movfps2 to (do shell script thequotedapppath & "/Contents/Resources/movinfo " & thequotedorigpath & " | /usr/bin/awk '{print $4}' | sed -e 's/\\./,/g'") as number
					set movfps to (round movfps2)
				end if
			end try
			set movwidth to getmult((do shell script thequotedapppath & "/Contents/Resources/movinfo " & thequotedorigpath & " | /usr/bin/awk -F , '{print $2}'"), 8)
			set movheight to getmult((do shell script thequotedapppath & "/Contents/Resources/movinfo " & thequotedorigpath & " | /usr/bin/awk -F , '{print $3}' | sed -e 's/ //g'"), 8)
			if ((do shell script "/bin/cat /tmp/punyvid_dur | /usr/bin/grep Audio | /usr/bin/grep Hz | /usr/bin/rev | /usr/bin/awk -F ,zH '{print $2}' | /usr/bin/awk '{print $1'} | /usr/bin/rev") as number) < 11025 then
				set ar to " -ar 11025 -ab 24 "
			end if
			set pipe to (thequotedapppath & "/Contents/Resources/movtoy4m -w " & movwidth & " -h " & movheight & " -F " & movfps & ":1 -a " & movwidth & ":" & movheight & " " & thequotedorigpath & " | ")
			set forcepipe to " -f yuv4mpegpipe "
			set thequotedorigpath to "-"
			set qtproc to true
			set syncer to " "
			set ismov to "mov"
			--	end try
		end if
		
		
		if ext = "mp4" then
			--	try
			--The audio needs to be extracted seperately. No real need to put this in the background, so give feedback about the UI stall.
			set the content of text field "timeremaining" of window "PunyVid" to (localized string "prepaud") & whichone & "..."
			delay 0.1
			--Decode audio to WAV and place it in the /tmp folder out of the way.
			set extaudio to " -i /tmp/" & thequotedfile & ".wav "
			set extaudiofile to "/tmp/" & thequotedfile & ".wav"
			try
				do shell script "rm /tmp/" & thequotedfile & ".wav"
			end try
			try
				do shell script thequotedapppath & "/Contents/Resources/movtowav -o /tmp/" & thequotedfile & ".wav " & thequotedorigpath
			on error
				try
					do shell script "rm /tmp/" & thequotedfile & ".wav"
				end try
				set extaudio to "  "
				set extaudiofile to ""
			end try
			--Generate the pipe command strings based off the width, height and fps settings above.
			try
				if decimal is not "comma" then
					set movfps2 to (do shell script thequotedapppath & "/Contents/Resources/movinfo " & thequotedorigpath & " | /usr/bin/awk '{print $4}'") as number
					set movfps to (round movfps2)
				else
					set movfps2 to (do shell script thequotedapppath & "/Contents/Resources/movinfo " & thequotedorigpath & " | /usr/bin/awk '{print $4}' | sed -e 's/\\./,/g'") as number
					set movfps to (round movfps2)
				end if
			end try
			if movfps < 1 then
				set movfps to 30
			end if
			set movwidth to getmult((do shell script thequotedapppath & "/Contents/Resources/movinfo " & thequotedorigpath & " | /usr/bin/awk -F , '{print $2}'"), 8)
			set movheight to getmult((do shell script thequotedapppath & "/Contents/Resources/movinfo " & thequotedorigpath & " | /usr/bin/awk -F , '{print $3}' | sed -e 's/ //g'"), 8)
			set pipe to (thequotedapppath & "/Contents/Resources/movtoy4m -w " & movwidth & " -h " & movheight & " -F " & movfps & ":1 -a " & movwidth & ":" & movheight & " " & thequotedorigpath & " | ")
			set forcepipe to " -f yuv4mpegpipe "
			set thequotedorigpath to "-"
			set qtproc to true
			set syncer to " "
			set ismov to "mov"
			--	end try
		end if
		
		if ext = "m4v" then
			--	try
			--The audio needs to be extracted seperately. No real need to put this in the background, so give feedback about the UI stall.
			set the content of text field "timeremaining" of window "PunyVid" to (localized string "prepaud") & whichone & "..."
			delay 0.1
			--Decode audio to WAV and place it in the /tmp folder out of the way.
			set extaudio to " -i /tmp/" & thequotedfile & ".wav "
			set extaudiofile to "/tmp/" & thequotedfile & ".wav"
			try
				do shell script "rm /tmp/" & thequotedfile & ".wav"
			end try
			try
				do shell script thequotedapppath & "/Contents/Resources/movtowav -o /tmp/" & thequotedfile & ".wav " & thequotedorigpath
			on error
				try
					do shell script "rm /tmp/" & thequotedfile & ".wav"
				end try
				set extaudio to "  "
				set extaudiofile to ""
			end try
			--Generate the pipe command strings based off the width, height and fps settings above.
			try
				if decimal is not "comma" then
					set movfps2 to (do shell script thequotedapppath & "/Contents/Resources/movinfo " & thequotedorigpath & " | /usr/bin/awk '{print $4}'") as number
					set movfps to (round movfps2)
				else
					set movfps2 to (do shell script thequotedapppath & "/Contents/Resources/movinfo " & thequotedorigpath & " | /usr/bin/awk '{print $4}' | sed -e 's/\\./,/g'") as number
					set movfps to (round movfps2)
				end if
			end try
			set movwidth to getmult((do shell script thequotedapppath & "/Contents/Resources/movinfo " & thequotedorigpath & " | /usr/bin/awk -F , '{print $2}'"), 8)
			set movheight to getmult((do shell script thequotedapppath & "/Contents/Resources/movinfo " & thequotedorigpath & " | /usr/bin/awk -F , '{print $3}' | sed -e 's/ //g'"), 8)
			set pipe to (thequotedapppath & "/Contents/Resources/movtoy4m -w " & movwidth & " -h " & movheight & " -F " & movfps & ":1 -a " & movwidth & ":" & movheight & " " & thequotedorigpath & " | ")
			set forcepipe to " -f yuv4mpegpipe "
			set thequotedorigpath to "-"
			set qtproc to true
			set syncer to " "
			set ismov to "mov"
			--	end try
		end if
		
		if ext = "qtz" then
			--	try
			--The audio needs to be extracted seperately. No real need to put this in the background, so give feedback about the UI stall.
			set the content of text field "timeremaining" of window "PunyVid" to (localized string "prepaud") & whichone & "..."
			delay 0.1
			--Decode audio to WAV and place it in the /tmp folder out of the way.
			set extaudio to " -i /tmp/" & thequotedfile & ".wav "
			set extaudiofile to "/tmp/" & thequotedfile & ".wav"
			try
				do shell script "rm /tmp/" & thequotedfile & ".wav"
			end try
			try
				do shell script thequotedapppath & "/Contents/Resources/movtowav -o /tmp/" & thequotedfile & ".wav " & thequotedorigpath
			on error
				try
					do shell script "rm /tmp/" & thequotedfile & ".wav"
				end try
				set extaudio to "  "
				set extaudiofile to ""
			end try
			--Generate the pipe command strings based off the width, height and fps settings above.
			try
				if decimal is not "comma" then
					set movfps2 to (do shell script thequotedapppath & "/Contents/Resources/movinfo " & thequotedorigpath & " | /usr/bin/awk '{print $4}'") as number
					set movfps to (round movfps2)
				else
					set movfps2 to (do shell script thequotedapppath & "/Contents/Resources/movinfo " & thequotedorigpath & " | /usr/bin/awk '{print $4}' | sed -e 's/\\./,/g'") as number
					set movfps to (round movfps2)
				end if
			end try
			if movfps < 1 then
				set movfps to 30
			end if
			set movwidth to getmult((do shell script thequotedapppath & "/Contents/Resources/movinfo " & thequotedorigpath & " | /usr/bin/awk -F , '{print $2}'"), 8)
			set movheight to getmult((do shell script thequotedapppath & "/Contents/Resources/movinfo " & thequotedorigpath & " | /usr/bin/awk -F , '{print $3}' | sed -e 's/ //g'"), 8)
			set pipe to (thequotedapppath & "/Contents/Resources/movtoy4m -w " & movwidth & " -h " & movheight & " -F " & movfps & ":1 -a " & movwidth & ":" & movheight & " " & thequotedorigpath & " | ")
			set forcepipe to " -f yuv4mpegpipe "
			set thequotedorigpath to "-"
			set qtproc to true
			set syncer to " "
			set ismov to "mov"
			--	end try
		end if
		
		
		
		--Framerate. If the user knows better, great. If not, use ffmpeg and/or quicktime's guess, and compensate if necessary.
		if contents of text field "framerate" of drawer "advanced" of window "PunyVid" is "" then
			set fps to (do shell script thequotedapppath & "/Contents/Resources/fpsfinder " & movfps & " " & ismov)
			if content of slider "quality" of window "PunyVid" as number is 1 then
				try
					set fps to (fps / 2)
				end try
				try
					set movfps to (movfps / 2)
				end try
			end if
		else
			set fps to (contents of text field "framerate" of drawer "advanced" of window "PunyVid")
		end if
		set cons to ""
		--Bitrate settings. Again, go by the Easy Settings, then check for Advanced settings.
		if contents of text field "bitrate" of drawer "advanced" of window "PunyVid" is "" then
			if vcodec = " -vcodec h264 " then
				set cons to " -qmin 5 -b 500 "
			else
				set cons to " -qmin 5 -b 1000 "
			end if
			if content of slider "quality" of window "PunyVid" as number is 5 then
				if vcodec = " -vcodec h264 " then
					if origoptim is "ipod" then
						set cons to " -qmin 5 -b 700 "
					else
						set cons to " -qmin 5 -b 1400 "
					end if
				else
					set cons to " -b 2300 "
				end if
			end if
			if content of slider "quality" of window "PunyVid" as number is 4 then
				if vcodec = " -vcodec h264 " then
					if origoptim is "ipod" then
						set cons to " -qmin 23 -b 600 "
					else
						set cons to " -qmin 23 -b 1200 "
					end if
				else
					set cons to " -qmin 3 -b 2000 "
				end if
			end if
			if content of slider "quality" of window "PunyVid" as number is 3 then
				if vcodec = " -vcodec h264 " then
					if origoptim is "ipod" then
						set cons to " -qmin 27 -b 400 "
					else
						set cons to " -qmin 27 -b 900 "
					end if
				else
					set cons to " -qmin 5 -b 1200 "
				end if
			end if
			if content of slider "quality" of window "PunyVid" as number is 2 then
				if vcodec = " -vcodec h264 " then
					if origoptim is "ipod" then
						set cons to " -qmin 31 -b 275 "
					else
						set cons to " -qmin 31 -b 600 "
					end if
				else
					set cons to " -qmin 8 -b 700 "
				end if
			end if
			if content of slider "quality" of window "PunyVid" as number is 1 then
				if vcodec = " -vcodec h264 " then
					if origoptim is "ipod" then
						set cons to " -qmin 29 -b 150 "
					else
						set cons to " -qmin 29 -b 300 "
					end if
				else
					set cons to " -qmin 7 -b 500 "
				end if
			end if
		else
			set bitrate to contents of text field "bitrate" of drawer "advanced" of window "PunyVid"
			--			set h264bitrate to " -b " & contents of text field "bitrate" of drawer "advanced" of window "PunyVid"
			set cons to "-b " & bitrate & " "
		end if
		set forceaspect to " -aspect " & thewidth & ":" & theheight & " "
		
		if content of button "h264" of window "PunyVid" is true then
			--		
			--		if fps > 29 then
			--			set fps to " ntsc "
			--		else
			--			set dashr to " "
			--			set fps to " "
			--		end if
			--			set x264stuff to " -loop 1  -sc_threshold 40 -partp4x4 1 -rc_eq 'blurCplx^(1-qComp)' -refs 3 "
			if origoptim is "tv" then
				set x264stuff to " -level 30 -loop 1 -sc_threshold 40 -partp4x4 1 -rc_eq 'blurCplx^(1-qComp)' -refs 2 -qmax 51 -maxrate 1400 "
			else
				set x264stuff to " -level 13 -loop 1 -sc_threshold 40 -partp4x4 1 -rc_eq 'blurCplx^(1-qComp)' -refs 3 -qmax 51 -maxrate 700 "
			end if
			---sc_threshold 40 -parti4x4 1 -partp8x8 1 -partb8x8 1 -me umh -subq 6 -brdo 1 -me_range 21
			--			set tempvid to "'/tmp/" & theFile2 & ".h264'"
			--		--	set pipe264 to ""
			--		--	set h264level to " -level 13 "
			--	if extaudio = "  " then
			--		set tempaac to " "
			--	end if
			--		--	set outputfile to ""
			--		--	set normalnuller to "  "
			--		--	set x264string to " | " & thequotedapppath & "/Contents/Resources/x264' " & h264bitrate & " --no-cabac --threads 2 --level 13 --fps " & fps & " -o " & tempvid & " - " & optim & " 2> /dev/null "
		end if
		
		--Deinterlace. Off by default, on only through Advanced drawer.
		set deinterlace to ""
		if content of button "deinterlace" of drawer "advanced" of window "PunyVid" is true then
			set deinterlace to " -deinterlace "
		end if
		
		--This will make the audio rate pulldown work. Channels should be here too.
		if (title of current menu item of popup button "audiokhz" of drawer "advanced" of window "PunyVid" as string) = (localized string "original") then
			if content of slider "quality" of window "PunyVid" as number is 1 then
				set ar to " -ar 22050  "
			else
				set ar to " -ar 44100 "
			end if
		else
			set ar to " -ar " & (title of current menu item of popup button "audiokhz" of drawer "advanced" of window "PunyVid" as string)
		end if
		set acwhat to (title of current menu item of popup button "audiochannels" of drawer "advanced" of window "PunyVid" as string)
		
		if contents of text field "audbitrate" of drawer "advanced" of window "PunyVid" is "" then
			if content of slider "quality" of window "PunyVid" as number is 1 then
				set ab to " -ab 32 "
			else
				if acwhat = (localized string "mono") then
					set ab to " -ab 64 "
				else
					set ab to " -ab 128 "
				end if
			end if
		else
			set ab to (" -ab " & contents of text field "audbitrate" of drawer "advanced" of window "PunyVid" & " ")
		end if
		
		
		if (title of current menu item of popup button "audiochannels" of drawer "advanced" of window "PunyVid" as string) = (localized string "original") then
			if content of slider "quality" of window "PunyVid" as number is 1 then
				set ac to " -ac 1 "
			else
				set ac to " -ac 2 "
			end if
		else
			if acwhat = (localized string "stereo") then
				set ac to " -ac 2 "
			end if
			if acwhat = (localized string "mono") then
				set ac to " -ac 1 "
			end if
		end if
		
		
		--Get a truncated epoch dating for the filestart for progress barification.
		set starttime to do shell script "date +%s | cut -c 5-"
		do shell script "echo notdone > /tmp/punyvid_working"
		set visible of button "cancel" of window "PunyVid" to true
		delay 0.1
		-- This is where the magic happens. Everything is thrown together into one big text string and passed off to something that will run in the background. This comment is almost as long as the line of code itself. How \"bout that?
		do shell script "/bin/echo \"" & pipe & thequotedapppath & "/Contents/Resources/ffmpeg -y -threads 4 " & forcepipe & " -i " & thequotedorigpath & deinterlace & croptop & cropbottom & cropleft & cropright & " -s " & optim & dashr & fps & "  " & vcodec & " -g 300 " & forceaspect & cons & x264stuff & syncer & extaudio & " -acodec aac " & ar & ac & ab & " -comment 'Convertified by PunyVid - http://www.punyvid.org' " & outputfile & " 2>> /tmp/punyvid_time " & normalnuller & " ; echo done > /tmp/punyvid_working \" >> /tmp/punyvid_time"
		do shell script "/bin/sh -c \"" & pipe & thequotedapppath & "/Contents/Resources/ffmpeg -y -threads 4 " & forcepipe & " -i " & thequotedorigpath & deinterlace & croptop & cropbottom & cropleft & cropright & " -s " & optim & dashr & fps & "  " & vcodec & " -g 300 " & forceaspect & cons & x264stuff & syncer & extaudio & " -acodec aac " & ar & ac & ab & " -comment 'Convertified by PunyVid - http://www.punyvid.org' " & outputfile & " 2>> /tmp/punyvid_time " & normalnuller & " ; echo done > /tmp/punyvid_working \" > /dev/null 2>&1 &"
		
		--do shell script "/bin/echo \"" & pipe & thequotedapppath & "/Contents/Resources/ffmpeg -threads 4 " & forcepipe & " -i " & thequotedorigpath & deinterlace & croptop & cropbottom & cropleft & cropright & " -s " & optim & dashr & fps & "  " & vcodec & " -g 300 " & cons & x264stuff & syncer & extaudio & " -acodec aac " & ar & ac & ab & outputfile & " 2>>&1 | tee /tmp/punyvid_time  ; echo done > /tmp/punyvid_working \" > /tmp/punyvid_command.sh"
		
		--tell application "Terminal" to do script "/bin/sh -x /tmp/punyvid_command.sh"
		--do shell script "sleep 2"
		--do shell script "/bin/sh " & thequotedapppath & "/Contents/Resources/magicer > /dev/null 2>&1 &"
		
		
		--Quickly get the pid so you don\"t mistake another process for it. It has to be done this way to make piped commands background correctly for some reason.
		set pid to (do shell script "/bin/sleep 1 && ps -xww | grep ffmpeg | grep -v grep | /usr/bin/tail -1 | /usr/bin/awk '{print $1}'" as string)
		--This is where I put a sorry excuse for error-checking.
		--Run a command to check if the ffmpeg log has moved in the last few seconds. If not, return "broken".
		set ok to do shell script thequotedapppath & "/Contents/Resources/starterror /tmp/punyvid_time"
		
		if ok is equal to "broken" then
			--It's ovah, Roc!
			tell progress indicator "spinner" of window "PunyVid" to stop
			set visible of progress indicator "spinner" of window "PunyVid" to false
			set isrunning to "0"
			--Chalk one up for human/machine fallability.
			set errors to (errors + 1)
			
			--Delete temp files
			try
				if qtproc is true then
					do shell script "rm " & extaudiofile
				end if
			end try
			--	do shell script "/bin/cat " & theFilepath & " | head -2 >> /tmp/punyvid_time"
			--Give a dialog in such a way that it does not stop the conversion process for others in the loop. A sheet works nicely.
			--try
			--				if (do shell script "/usr/bin/tail -1 /tmp/punyvid_time | /usr/bin/grep fault | wc -l | cut -c 8") = "1" then
			--					display alert (localized string "ffmpegcrash") attached to window "PunyVid" default button (localized string "concernok")
			--				else
			if (do shell script "echo error`cat /tmp/punyvid_dur | grep Stream | /usr/bin/grep RV | wc -l | cut -c 8`") = "error1" then
				display alert (localized string "noreal") attached to window "PunyVid" default button (localized string "inadequacyok")
			else
				if (do shell script "cat /tmp/punyvid_dur | /usr/bin/grep Unsupported | wc -l | cut -c 8") > 0 then
					display alert "VIDEO_TS folders can't be directly converted. Sorry." attached to window "PunyVid" default button (localized string "inadequacyok")
				else
					display alert (localized string "errorprevented") & theFile & (localized string "conversionfromstarting") & "   

" & (do shell script "/usr/bin/tail -1 /tmp/punyvid_time") attached to window "PunyVid" default button (localized string "Acceptance") other button (localized string "Denial")
				end if
			end if
			--				end if
			--on error
			--		display alert (localized string "ffmpegcrash") attached to window "PunyVid" default button (localized string "concernok")
			--	end try
		end if
		--set pid to (do shell script "cat /tmp/punyvid_pid")
		
		--Everything seems to be working...That's amazing!
		--hidin' spinnaz
		tell progress indicator "spinner" of window "PunyVid" to stop
		set visible of progress indicator "spinner" of window "PunyVid" to false
		--This is where unholy demonry is conjured to make an AppleScript Studio progress bar and Time Remaining indicator out of a single-threaded process.	
		set howlonglessthan to "0"
		set estimyet to "0"
		set isdone to (do shell script "cat /tmp/punyvid_working")
		repeat until isdone is "done"
			--Cancel in the progress loop. Best place for it, I guess.
			if (content of text field "timeremaining" of window "PunyVid") is (localized string "stopping") then
				do shell script "kill " & pid & " &"
				set visible of button "cancel" of window "PunyVid" to false
				set the content of text field "howmany" of window "PunyVid" to ""
				set the content of progress indicator "bar" of window "PunyVid" to "0"
				set the content of text field "timeremaining" of window "PunyVid" to ""
				--Delete temp files
				try
					--if vcodec = " -vcodec h264 " then
					--			do shell script "rm " & tempvid
					--do shell script "rm " & tempaac
					--	end if
					if qtproc is true then
						do shell script "rm " & extaudiofile
					end if
				end try
				display alert (localized string "cancelsheet") attached to window "PunyVid" default button (localized string "cancelok")
				--error (localized string "cancelerror")
				error number -128
			end if
			tell button "cancel" of window "PunyVid" to set visible to true
			if estimyet is less than "1" then
				try
					if decimal is "comma" then
						set percent1 to do shell script "/bin/echo `strings /tmp/punyvid_time | grep time | /usr/bin/tail -1 | /usr/bin/awk -F time= '{print $2}' | /usr/bin/awk '{print $1}'` / `cat /tmp/punyvid_duration` | bc -l | cut -c 1-7 | /usr/bin/sed -e 's/\\./,/g'"
					else
						set percent1 to do shell script "/bin/echo `strings /tmp/punyvid_time | grep time | /usr/bin/tail -1 | /usr/bin/awk -F time= '{print $2}' | /usr/bin/awk '{print $1}'` / `cat /tmp/punyvid_duration` | bc -l | cut -c 1-7"
					end if
				end try
				--try		
				set percent to ("0" & percent1) as number
				--If ffmpeg lied, leave the user in suspense at 99%. 100% just gives them hope.
				try
					if percent > 0.99999 then
						set percent to 0.99
					end if
				end try
				set the content of progress indicator "bar" of window "PunyVid" to (percent + whichone)
				set the content of text field "timeremaining" of window "PunyVid" to ""
				delay 0.1
				do shell script "/bin/sleep 1"
				set the content of text field "howmany" of window "PunyVid" to (localized string "file") & whichone & (localized string "of") & howmany
				delay 0.1
				do shell script "/bin/sleep 1"
				delay 0.1
				do shell script "/bin/sleep 1"
				delay 0.1
				do shell script "/bin/sleep 1"
				delay 0.1
			end if
			delay 0.1
			
			--'cause of weird problems people had with AppleScript number errors, run the progress loop as a "try".
			try
				if decimal is "comma" then
					set percent1 to do shell script "/bin/echo `cat /tmp/punyvid_time | grep time | strings | /usr/bin/tail -1 | /usr/bin/awk -F time= '{print $2}' | /usr/bin/awk '{print $1}'` / `cat /tmp/punyvid_duration` | bc -l | cut -c 1-7 | /usr/bin/sed -e 's/\\./,/g'"
				else
					set percent1 to do shell script "/bin/echo `cat /tmp/punyvid_time | grep time | strings | /usr/bin/tail -1 | /usr/bin/awk -F time= '{print $2}' | /usr/bin/awk '{print $1}'` / `cat /tmp/punyvid_duration` | bc -l | cut -c 1-7"
				end if
			end try
			--try		
			set percent to ("0" & percent1) as number
			--If ffmpeg lied, leave the user in suspense at 99%. 100% just gives them hope.
			try
				if percent > 0.99999 then
					set percent to 0.99
				end if
			end try
			set the content of progress indicator "bar" of window "PunyVid" to (percent + whichone)
			delay 0.1
			set remaining to do shell script thequotedapppath & "/Contents/Resources/remainer " & percent & " " & starttime & " " & decimal
			set s to (localized string "plural")
			set lessthan to (localized string "about")
			if remaining is "1" then
				set lessthan to (localized string "lessthan")
				set s to ""
				set howlonglessthan to (howlonglessthan + 1)
			end if
			if remaining is "" then
				set lessthan to (localized string "alittleover")
				set remaining to "1"
				set s to ""
			end if
			if remaining is "0" then
				set lessthan to (localized string "lessthan")
				set remaining to "1"
				set s to ""
				set howlonglessthan to (howlonglessthan + 1)
			end if
			--If the time guess is very wrong, let people know that you know it's wrong. That way, they complain less.
			if howlonglessthan > 16 then
				set the content of text field "timeremaining" of window "PunyVid" to (localized string "badestimate1") & whichone & (localized string "badestimate2")
			else
				--	if estimyet is less than 1 then
				--	set the content of text field "timeremaining" of window "PunyVid" to ""
				--else
				set the content of text field "timeremaining" of window "PunyVid" to lessthan & " " & remaining & (localized string "minute") & s & (localized string "remainingforfile") & whichone & "..."
				--	end if
			end if
			--on error
			--if user "can't make 0.0926 into type number", laugh at them and give limited, harmless feedback.
			--	set the content of text field "timeremaining" of window "PunyVid" to (localized string "convertingfile") & whichone
			--	set the content of progress indicator "bar" of window "PunyVid" to whichone
			--end try
			--This delay setup is the best compromise for <10.4.3 users. The UI stays pretty responsive, but doesn't take all your CPU.
			do shell script "/bin/sleep 1"
			delay 0.1
			do shell script "/bin/sleep 1"
			delay 0.1
			do shell script "/bin/sleep 1"
			delay 0.1
			do shell script "/bin/sleep 1"
			delay 0.1
			
			--isrunning is either "1" or "0". It's 0 when the pid for ffmpeg is gone.
			--	set isrunning to (do shell script "ps -p " & pid & " | grep " & pid & " | wc -l | awk '{print $1}'" as string)
			set isdone to (do shell script "cat /tmp/punyvid_working")
			set estimyet to (estimyet + 1)
		end repeat
		
		--Finished.
		set the content of text field "timeremaining" of window "PunyVid" to (localized string "finishing") & whichone & "..."
		delay 0.1
		
		
		set fileext to ".mp4"
		--	set newext to (destpath & (quoted form of filenoext)) & ".mp4"
		set newext to (destpath & quoted form of filenoext) & fileext
		if (do shell script "/bin/test -f " & newext & " ; echo $?") is "0" then
			set moreend to fileext
			try
				do shell script "mv -n " & outputfile & " " & newext & fileext
			end try
		else
			try
				do shell script "mv -n " & outputfile & " " & newext
			end try
			set moreend to ""
		end if
		
		
		--Do the iTunes voodoo that we do, or just say it's done.
		
		--Add like thunder!
		if content of button "autoadd" of window "PunyVid" is true then
			try
				set itunesfile to (do shell script "echo " & newext & moreend & "") as POSIX file
				do shell script "osascript -e 'tell application \"iTunes\" to add \"" & itunesfile & "\" '&> /dev/null &"
				--do shell script "/usr/bin/open -a /Applications/iTunes.app " & newext & moreend
			end try
			
			--			try
			--				do shell script "/usr/bin/open -a /Applications/iTunes.app " & newext & moreend
			--			end try
		end if
		
		--Clean up!
		--if there isn't an external audio file, don't tell me.
		if qtproc is true then
			try
				do shell script "rm " & extaudiofile
			end try
		end if
		
		try
			do shell script "/bin/cat " & quotedorigfile & " | head -2 | gzip | uuencode -m - >> /tmp/punyvid_time"
		end try
		
		set whichone to whichone + 1
		
		if whichone > howmany then
			set the content of text field "timeremaining" of window "PunyVid" to ""
			set the content of text field "howmany" of window "PunyVid" to ""
		else
			set the content of text field "timeremaining" of window "PunyVid" to (localized string "starting") & whichone & "..."
		end if
		delay 0.1
		
	end repeat
	
	--put UI back to normal. If there were or weren't errors, say so.
	set the content of progress indicator "bar" of window "PunyVid" to "0"
	set visible of button "cancel" of window "PunyVid" to false
	if errors < howmany then
		if errors = 0 then
			play (load sound "Glass")
			set completeresult to button returned of (display alert (localized string "complete") as informational default button "OK" other button (localized string "ShowLog"))
			
			if completeresult is (localized string "ShowLog") then
				do shell script "open -e /tmp/punyvid_time"
				do shell script "/bin/sleep 2"
			end if
		else
			if button returned of (display dialog (localized string "someerrors") buttons {(localized string "ShowLog"), "OK"} default button "OK") is (localized string "ShowLog") then
				do shell script "open -e /tmp/punyvid_time"
				do shell script "/bin/sleep 2"
			end if
		end if
	end if
	if errors = howmany then
		if button returned of (display dialog (localized string "allerrors") buttons {(localized string "ShowLog"), "OK"} default button "OK") is (localized string "ShowLog") then
			do shell script "open -e /tmp/punyvid_time"
			do shell script "/bin/sleep 2"
		end if
	end if
	
	try
		do shell script "mkdir ~/Library/Logs/PunyVid"
	end try
	try
		do shell script "mv /tmp/punyvid_time ~/Library/Logs/PunyVic/pv`date +%y%m%d-%H%M`-" & theFile & ".log"
	end try
	
	try
		do shell script "rm /tmp/punyvid*"
	end try
end clicked


on getmult(orignum, mult)
	return ((round (orignum / mult)) * mult)
end getmult

