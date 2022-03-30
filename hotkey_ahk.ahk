; brightness adjustment 
; Variables
Increments 			:= 10 ; < lower for a more granular change, higher for larger jump in brightness 
CurrentBrightness 	:= GetCurrentBrightNess()

; Hot Keys
+F4::ChangeBrightness( CurrentBrightness -= Increments ) ; decrease brightness
+F5::ChangeBrightness( CurrentBrightness += Increments ) ; increase brightness

; Functions
ChangeBrightness( ByRef brightness, timeout = 1 )
{
	if ( brightness > -10 && brightness < 110 )
	{
		For property in ComObjGet( "winmgmts:\\.\root\WMI" ).ExecQuery( "SELECT * FROM WmiMonitorBrightnessMethods" )
			property.WmiSetBrightness( timeout, brightness )	
	}
 	else if ( brightness >= 100 )
 	{
 		brightness := 100
 	}
 	else if ( brightness <= 0 )
 	{
 		brightness := 0
 	}
}

GetCurrentBrightNess()
{
	For property in ComObjGet( "winmgmts:\\.\root\WMI" ).ExecQuery( "SELECT * FROM WmiMonitorBrightness" )
		currentBrightness := property.CurrentBrightness	

	return currentBrightness
}

; sound adjustment

+F1::SoundSet, +1, , mute  ; Toggle the master mute (set it to the opposite state)
+F2::SoundSet,-2      	; press Shift ("+") and left arrow key ("Left")
+F3::SoundSet,+2    		; Shift and right arrow
; + as shift
; Escape & F1