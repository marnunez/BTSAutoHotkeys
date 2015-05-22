;Tracklab
;SetTitleMatchMode, 3
;SetTitleMatchMode, Slow

#SingleInstance, force
#Include, Funciones.ahk
#IfWinActive Tracklab ahk_class ThunderRT6MDIForm

space::
SendInput {Enter}
Return

s::
SendInput {Down}
Return

w::
SendInput {Up}
Return

Right::
d::

ControlSend, SliderWndClass1, {Right}, Tracklab
return

+Right::
+d::
	OldControlDelay := A_ControlDelay
	OldKeyDelay := A_KeyDelay
	
	SetKeyDelay, 0, 0
	ControlSend, SliderWndClass1, {PgDn}, Tracklab
	SetControlDelay, %OldControlDelay%
	SetKeyDelay, %OldKeyDelay%
return

Left::
a::

ControlSend, SliderWndClass1, {Left}, Tracklab
return

+Left::
+a::
	OldControlDelay := A_ControlDelay
	OldKeyDelay := A_KeyDelay
	
	SetKeyDelay, 0, 0
	ControlSend, SliderWndClass1, {PgUp}, Tracklab
	SetControlDelay, %OldControlDelay%
	SetKeyDelay, %OldKeyDelay%
return

q::
BlockInput, On

WinMenuSelectItem, Tracklab, , 6&, 2&
WinWaitActive, Open model file. ahk_class #32770
ControlSetText, Edit1, C:\Tracklab\Elic2std.XMF, A
ControlClick, Button2, A
WinWaitActive, Tracklab ahk_class ThunderRT6MDIForm
;Send C:\Tracklab\Elic2std.XMF{Enter}
;WinWait, Model Editor ahk_class ThunderRT6PictureBoxDC9
WaitForControlVisible("ThunderRT6CommandButton1")
ControlClick, ThunderRT6CommandButton1, A
SendInput !-n!-x
TimetoFrame()
BlockInput, Off
return

e::
BlockInput, On
WinMenuSelectItem, Tracklab, , 6&, 2&
WinWaitActive, Open model file. ahk_class #32770
ControlSetText, Edit1, C:\Tracklab\piernader.XMF, A
ControlClick, Button2, A
WinWaitActive, Tracklab ahk_class ThunderRT6MDIForm
;Send C:\Tracklab\Elic2std.XMF{Enter}
;WinWait, Model Editor ahk_class ThunderRT6PictureBoxDC9
WaitForControlVisible("ThunderRT6OptionButton1")
ControlClick, ThunderRT6OptionButton1, A
SendInput !-n!-x
TimetoFrame()
BlockInput, Off
return

r::
BlockInput, On
if IsControlEnabled("ThunderRT6CheckBox19")
{
	ControlClick, ThunderRT6CheckBox19
}
TimetoFrame()
WinMenuSelectItem, Tracklab, , 6&, 2&
WinWaitActive, Open model file. ahk_class #32770
ControlSetText, Edit1, C:\Tracklab\Elic2wlk.XMF, A
ControlClick, Button2, A
WinWaitActive, Tracklab ahk_class ThunderRT6MDIForm
;Send C:\Tracklab\Elic2std.XMF{Enter}
;WinWait, Model Editor ahk_class ThunderRT6PictureBoxDC9
WaitForControlVisible("ThunderRT6CommandButton1")
ControlClick, ThunderRT6CommandButton1, A
SendInput !-n!-x
TimetoFrame()
BlockInput, Off
return

g::
WinMenuSelectItem, Tracklab, , 4&, 1&
Return

c::
WinClose, Tracklab
WinWaitActive, BTS Bioengineering - EliteClinic ahk_class ThunderRT6MDIForm
Loop 400
{
		if ExisteTrialProcessing()
		{
			Break
		}
}
ControlFocus, Button17, A
Return

~LButton::
MouseGetPos, MouseX, MouseY, ,contq,1
if contq = AfxOleControl421
{
	si := 0
	Loop 100
	{
		if (DetectContextMenu() = 1)
		{
			si := 1
			Break
		}
		Sleep 10
	}
	if si = 1
	{
		SendInput {Down 2}
	}
}
return

~^RButton::
MouseGetPos, MouseX, MouseY, ,contq,1
if contq = AfxOleControl421
{
	SendInput {Down 9}{Enter}
	Loop 1000
	{
		Click right %MouseX%, %MouseY%
		if DetectContextMenu()
		{
			break
		}
	}
	;Sleep, 600
	SendInput {Down 10}{Enter}
}
return

~+RButton::
MouseGetPos, MouseX, MouseY, ,contq,1
if contq = AfxOleControl421
{
	Loop 100
	{
		if DetectContextMenu()
		{
			SendInput {Down 9}{Enter}
		}
	}
}
return

~!RButton::
MouseGetPos, MouseX, MouseY, ,contq,1
if contq = AfxOleControl421
{
	Loop 100
	{
		if DetectContextMenu()
		{
			SendInput {Down 10}{Enter}
		}
	}
}
return

MButton::
MouseGetPos, MouseX, MouseY, ,contq
if contq = AfxOleControl421
{
	SendInput {Click Right}{Down 8}{Enter}
}
return

f::
TogglePlatform()
Return

y::
TimetoFrame()
Return

#IfWinActive, Save reconstructed data as ... ahk_class #32770
space::
ControlClick, Button2, A
WinWaitActive, Output data options ahk_class ThunderRT6FormDC
ControlFocus, ThunderRT6TextBox2, A
SendMessage, 177, 0, -1, ThunderRT6TextBox2, A
Return

#IfWinActive, Output data options ahk_class ThunderRT6FormDC

space::
Enter::
ControlClick, ThunderRT6CommandButton4, A
Return

tab::
if ControlGetFocus() = ThunderRT6TextBox2
{
	ControlFocus, ThunderRT6TextBox1, A
	SendMessage, 177, 0, -1, ThunderRT6TextBox1, A
}
else 
{
	SendInput {tab}
}
Return

;Cambia el display verde de tiempo a cuadros.
TimetoFrame(){
	BlockInput, MouseMove
	MouseGetPos, Xo, Yo
	
	SetMouseDelay, -1
	MouseClick, , 332, 128, , 0
	MouseMove, %Xo%, %Yo%, 0
	BlockInput, MouseMoveOff
}

TogglePlatform(){
	If IsControlEnabled("ThunderRT6CheckBox19")
	{
		ControlClick, ThunderRT6CheckBox19
	}
}