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
SetControlDelay, -1
ControlSend, SliderWndClass1, {Right}, Tracklab
return

+Right::
+d::
	OldControlDelay := A_ControlDelay
	OldKeyDelay := A_KeyDelay
	SetControlDelay, -1
	SetKeyDelay, 0, 0
	ControlSend, SliderWndClass1, {PgDn}, Tracklab
	SetControlDelay, %OldControlDelay%
	SetKeyDelay, %OldKeyDelay%
return

Left::
a::
SetControlDelay, -1
ControlSend, SliderWndClass1, {Left}, Tracklab
return

+Left::
+a::
	OldControlDelay := A_ControlDelay
	OldKeyDelay := A_KeyDelay
	SetControlDelay, -1
	SetKeyDelay, 0, 0
	ControlSend, SliderWndClass1, {PgUp}, Tracklab
	SetControlDelay, %OldControlDelay%
	SetKeyDelay, %OldKeyDelay%
return

q::
BlockInput, On
SetControlDelay, -1
WinMenuSelectItem, Tracklab, , 6&, 2&
WinWaitActive, Open model file. ahk_class #32770
ControlSetText, Edit1, C:\Tracklab\Elic2std.XMF, A
ControlClick, Button2, A
WinWaitActive, Tracklab ahk_class ThunderRT6MDIForm
;Send C:\Tracklab\Elic2std.XMF{Enter}
;WinWait, Model Editor ahk_class ThunderRT6PictureBoxDC9
Loop,
{
	ControlGet, esta, Visible, ,ThunderRT6CommandButton1
	if esta = 1 
		break
}
ControlClick, ThunderRT6CommandButton1, A
IfWinActive, Tracklab ahk_class #32770, A
{
	MsgBox, UFA
}
SendInput !-n!-x
TimetoFrame()
BlockInput, Off
return

e::
BlockInput, On
SetControlDelay, -1
WinMenuSelectItem, Tracklab, , 6&, 2&
WinWaitActive, Open model file. ahk_class #32770
ControlSetText, Edit1, C:\Tracklab\piernader.XMF, A
ControlClick, Button2, A
WinWaitActive, Tracklab ahk_class ThunderRT6MDIForm
;Send C:\Tracklab\Elic2std.XMF{Enter}
;WinWait, Model Editor ahk_class ThunderRT6PictureBoxDC9
Loop,
{
	ControlGet, esta, Visible, ,ThunderRT6OptionButton1
	if esta = 1 
		break
}
ControlClick, ThunderRT6OptionButton1, A
SendInput !-n!-x
TimetoFrame()
BlockInput, Off
return

r::
SetControlDelay, -1
WinMenuSelectItem, Tracklab, , 6&, 2&
WinWaitActive, Open model file. ahk_class #32770
ControlSetText, Edit1, C:\Tracklab\Elic2wlk.XMF, A
ControlClick, Button2, A
WinWaitActive, Tracklab ahk_class ThunderRT6MDIForm
;Send C:\Tracklab\Elic2std.XMF{Enter}
;WinWait, Model Editor ahk_class ThunderRT6PictureBoxDC9
Loop,
{
	ControlGet, esta, Visible, ,ThunderRT6CommandButton1
	if esta = 1 
		break
}
ControlClick, ThunderRT6CommandButton1, A
SendInput !-n!-x
return

g::
SetControlDelay, -1
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
	Loop 1000
	{
		if (DetectContextMenu() = 1)
		{
			si := 1
			Break
		}
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
SetControlDelay, -1
ControlGet, b, Enabled, , ThunderRT6CheckBox19, A
if b = 1
{
	ControlClick, ThunderRT6CheckBox19
}
Return

y::
TimetoFrame()
Return

#IfWinActive, Save reconstructed data as ... ahk_class #32770
space::
SetControlDelay, -1
ControlClick, Button2, A
WinWaitActive, Output data options ahk_class ThunderRT6FormDC
ControlFocus, ThunderRT6TextBox2, A
SendMessage, 177, 0, -1, ThunderRT6TextBox2, A
Return

#IfWinActive, Output data options ahk_class ThunderRT6FormDC

space::
Enter::
SetControlDelay, -1
ControlClick, ThunderRT6CommandButton4, A
Return

tab::
SetControlDelay, -1
ControlGetFocus, a, A
if a = ThunderRT6TextBox2
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
TimetoFrame() {
	BlockInput, MouseMove
	MouseGetPos, Xo, Yo
	SetControlDelay, 0
	SetMouseDelay, -1
	MouseClick, , 332, 128, , 0
	MouseMove, %Xo%, %Yo%, 0
	BlockInput, MouseMoveOff
}