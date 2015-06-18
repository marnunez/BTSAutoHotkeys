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
ControlSend, SliderWndClass1, {Right}, Tracklab ahk_class ThunderRT6MDIForm
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
TogglePlatformOnOff("on")
TimetoFrame()
OpenModel("Elic2std.XMF","ThunderRT6CommandButton1")
SendInput !-n!-x
return

e::
TogglePlatformOnOff("on")
TimetoFrame()
OpenModel("piernader.XMF","ThunderRT6OptionButton1")
SendInput !-n!-x
return

r::
TogglePlatformOnOff("on")
TimetoFrame()
OpenModel("Elic2wlk.XMF","ThunderRT6CommandButton1")
SendInput !-n!-x
return

g::
WinMenuSelectItem, Tracklab ahk_class ThunderRT6MDIForm, , 4&, 1&
Return

c::
WinClose, Tracklab ahk_class ThunderRT6MDIForm
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
MouseGetPos, MouseX, MouseY, ,contq, 1
PixelGetColor, colo, %MouseX%, %MouseY%
if colo = 0xFFFFFF
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
	SendInput {Down 10}{Enter}
}
return

~+RButton::
MouseGetPos, MouseX, MouseY, ,contq,1
PixelGetColor, colo, %MouseX%, %MouseY%
if colo = 0xFFFFFF
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
PixelGetColor, colo, %MouseX%, %MouseY%
if colo = 0xFFFFFF
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
PixelGetColor, colo, %MouseX%, %MouseY%
if colo = 0xFFFFFF
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
Control,Check,, Button2, A
WinWaitActive, Output data options ahk_class ThunderRT6FormDC
ControlFocus, ThunderRT6TextBox2, A
SendMessage, 177, 0, -1, ThunderRT6TextBox2, A
Return

#IfWinActive, Output data options ahk_class ThunderRT6FormDC

space::
Enter::
Control,Check,, ThunderRT6CommandButton4, A
Return

tab::
if Control.GetFocus() = "ThunderRT6TextBox2"
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
	If Control.IsEnabled("ThunderRT6CheckBox19")
	{
		If Control.IsChecked("ThunderRT6CheckBox19")
		{
			Control, UnCheck, , ThunderRT6CheckBox19
		}
		Else
		{
			Control, Check, , ThunderRT6CheckBox19
		}
	}
}

TogglePlatformOnOff(onof:="on"){
	If Control.IsEnabled("ThunderRT6CheckBox19")
	{
		If (onof = "on")
		{
			Control, Check, , ThunderRT6CheckBox19
		}
		If (onof = "off")
		{
			Control, UnCheck, , ThunderRT6CheckBox19
		}
	}
}
OpenModel(model,button){
	WinActivate, Tracklab ahk_class ThunderRT6MDIForm
	WinMenuSelectItem, Tracklab, , 6&, 2&
	WinWaitActive, Open model file. ahk_class #32770
	ControlSetText, Edit1, C:\Tracklab\%model%, A
	Control,Check,, Button2, A
	WinWaitActive, Tracklab ahk_class ThunderRT6MDIForm
	Control.WaitVisible(%button%)
	Control, Check, , %button%, A
}