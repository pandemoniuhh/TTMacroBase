#SingleInstance Force
#NoEnv
#NoTrayIcon
SetWorkingDir %A_ScriptDir%
SetBatchLines -1
CoordMode, ToolTip, screen
CoordMode, Mouse, screen
CoordMode, Pixel, screen

Menu Tray, Icon, MultiClick.ico
Img0=checkbox_uncheck.png
Img1=checkbox_check.png
startImg=0


; main gui

#Persistent
Gui, 1: -MaximizeBox -MinimizeBox
Gui, 1: Add, Button, gSet x56 y8 w122 h20, Set Windows
Gui, 1: Add, Button, gConfig x120 y32 w58 h20 +Disabled, Config
Gui, 1: Add, Button, gReset x56 y32 w58 h20, Reset
Gui, 1: Add, Picture, x0 y8 w48 h48 vFirstCheckbox, checkbox_uncheck.png
Gui, 1: Add, Picture, x180 y8 w48 h48 vSecondCheckbox, checkbox_uncheck.png
Gui, 1: Add, StatusBar,, Click set windows.

;config gui

Gui, 2: -MinimizeBox -MaximizeBox
Gui, 2: Add, Tab3, x8 y8 w300 h189, Config|Notes
Gui, 2: Font, Italic
Gui, 2: Add, Edit, x16 y104 w116 h20 +ReadOnly, Press a key
Gui, 2: Font
Gui, 2: Add, Text, x16 y48 w178 h28, This is the hotkey used to send a click to both halves to the screen.
Gui, 2: Font, Bold
Gui, 2: Add, Text, x16 y88 w120 h12, Current Hotkey


Gui, 2: Font
Gui, 2: Add, CheckBox, x16 y168 w180 h23 gSpecificWindow vSpecificWindow, Activate on specific windows
Gui, 2: Add, CheckBox, x16 y144 w120 h23 gOnTop vOnTop%OnTop%, Stay on top
Gui, 2: Font


Gui, 2: Tab, Notes
Gui, 2: Add, Text, x16 y32 w120 h20 +0x200, Notes:
Gui, 2: Add, Text, x16 y48 w175 h20 +0x200, Double click to clear the hotkey.
Gui, 2: Tab
Gui, 2: Add, Button, gCancel x226 y200 w80 h23, Cancel
Gui, 2: Add, Button, gOK x138 y200 w80 h23, OK
Gui, 2: Add, Button, gAbout x8 y200 w80 h23, About

;about Gui
Gui 3:-MinimizeBox -MaximizeBox +AlwaysOnTop
Gui 3:Font, s9, Segoe UI
Gui 3:Add, Text, x8 y8 w260 h23 +0x200, Authored and created entirely by Pandemonium
Gui 3:Add, Text, x8 y48 w82 h23 +0x200, Version 1.0.0
Gui 3:Add, Link, x8 y32 w226 h23, <a href="https://github.com/pandemoniuhh">github.com/pandemoniuhh</a>
Gui 3:Add, Button, gOKAbout x192 y72 w80 h23, OK


Gui, 1: Show, w228 h79, Multi-Click
Return



Config:
; Gui, 2:Show,x560 y550 w312 h230,Config
Return

OnTop:
Return

SpecificWindow:
Return

Cancel:
Gui, 2:Cancel
Return

OK:
Gui, 2:Submit
Return

OKAbout:
Gui, 3:Cancel
Return

About:
Gui, 3:Show, w280 h100, About Multi-Click
Return

;then comes the fun shit
Set:
	Gui, +AlwaysOnTop
	GuiControl,,FirstCheckbox, %Img0%
	GuiControl,,SecondCheckbox, %Img0%
    SB_SetText("Click the first window.")
    
	KeyWait, LButton, D
    Sleep, 100
    SysGet, screenx,61
    SysGet, screeny,62
    WinGetPos, x_1, y_1, width_1, height_1, A
    x1:=x_1
    y1:=y_1
    width1:=width_1
    height1:=height_1
	
	GuiControl,,FirstCheckbox, %Img1%
    SB_SetText("Click the second window.")
    KeyWait, LButton, D
    
	Sleep, 100
    WinGetPos, x_2, y_2, width_2, height_2, A
    x2:=x_2
    y2:=y_2
    width2:=width_2
    height2:=height_2
    xconstant := 1
    if (x1 > x2) {
    xconstant*=-1
    }
	
	GuiControl,,SecondCheckbox, %Img1%
    Hotkey, Alt, on
    SB_SetText("MultiClick is now active.")
	Gui, -AlwaysOnTop
    return

$Alt::
    blockinput, on
    Sleep 1
    GetKeyState, LButtonState, LButton, P
    MouseClick, Left
    x_jump := (x2-x1) * xconstant
    x_jump_back := (x1-x2) * xconstant
    MouseMove, %x_jump%, 0, 0, R
    MouseClick, Left
    MouseMove, %x_jump_back%, 0, 0, R
	return

Reset:
    Reload
    return

GuiClose:
    ExitApp
    return