#IfWinActive, ahk_exe GitHubDesktop.exe
f1::
RunFix(0)
return

f2::
RunFix(1)
return
#IfWinActive

RunFix(mailOffset)
{
    CoordMode, Mouse, Client
	CoordMode, Pixel, Client
	MouseGetPos, xpos, ypos
	WinGetActiveStats, Title, Width, Height, X, Y
	centerW := Width / 2
	centerH := Height / 2

	waitX := centerW - 150
	waitY := centerH - 199

	Send {RCtrl down}{,}{RCtrl up}
	sleep, 101
	PixelGetColor, color, %waitX%, %waitY%
	_WaitIsPixelColor(0xD66603, waitX, waitY, 10, 900) ; shuld be 0x0366D6, but I get 0xD66603 for some reason (BGR instead of RGB)
	targetX := centerW - 200
	targetY := centerH - 100
	Click, %targetX%, %targetY%
	targetY := centerH - 160
	Click, %centerW%, %targetY%
	Send {RCtrl down}{a}{RCtrl up}{Backspace}
	targetY := centerH - 100
	Click, %centerW%, %targetY%
	targetY := centerH - 80 + (mailOffset * 15)
	Click, %centerW%, %targetY%
	targetX := centerW + 100
	targetY := centerH + 230
	Click, %targetX%, %targetY%
	sleep, 40
	Send {RCtrl down}{,}{RCtrl up}
	sleep, 300
	_WaitIsPixelColor(0xD66603,waitX,waitY, 10, 900)
	Click, %targetX%, %targetY%
	MouseMove, %xpos%, %ypos%
}

_WaitIsPixelColor(p_DesiredColor,p_PosX,p_PosY,p_sleep=1,p_TimeOut=0) {
    l_Start := A_TickCount
    Loop {
        PixelGetColor, color, %p_PosX%, %p_PosY%
        If ( color = p_DesiredColor )
            Return true
        If ( p_TimeOut ) && ( A_TickCount - l_Start >= p_TimeOut )
            Return false
		sleep, %p_sleep%
    }
}