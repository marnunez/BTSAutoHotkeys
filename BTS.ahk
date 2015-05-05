#SingleInstance, force
#Include, Funciones.ahk
#Persistent
#Hotstring NoMouse

Menu, as, Add, 1 Cinematica, Cinematica
Menu, as, Add, 2 Cinetica, Cinetica
Menu, EMG, Add, 1 EMG8, EMG8
Menu, EMG, Add, 2 EMG4, EMG4
Menu, EMG, Add, 3 EMG5, EMG5
Menu, EMG, Add, 4 EMG4L, EMG4L
Menu, EMG, Add, 5 EMG4R, EMG4R
Menu, EMG, Add, 6 Vastos, Vastos

Menu, as, Add, 3 EMG, :EMG
Menu, as, Add, 4 Abrir archivo..., AbrirArchivo
Menu, as, Add, 5 Interpolar, Interpolar

ProgramFilesWin := GetOS()

#IfWinActive, Select Visualization ahk_class ThunderRT6FormDC
f::
	Control, Check, , ThunderRT6CheckBox4, A
	Control, Check, , ThunderRT6CheckBox3, A
	Control, Choose, 3, ThunderRT6ComboBox1, A
	ControlGet, esta, Enabled, , ThunderRT6CheckBox1, A
	if esta = 1
	{
		Control, Check, , ThunderRT6CheckBox1, A
	}
	ControlFocus, Button1, A
return

#IfWinActive, Preview ahk_class ThunderRT6FormDC
p::
SetControlDelay, -1
ControlClick, ThunderRT6CommandButton2, A
WinWait, Configurar ahk_class #32770
ControlClick, Button7, A
if A_OSVersion = WIN_7
{
	WinWait, PDFCreator 0.9.6 ahk_class ThunderRT6FormDC ahk_exe PDFCreator.exe
	ControlSetText, ThunderRT6TextBox6, %nombreArchivo%
	KeyWait, Enter, D
	ControlClick, ThunderRT6CommandButton7, A
	WinWaitActive, Guardar como ahk_class #32770 ahk_exe PDFCreator.exe
	ControlSetText, Edit1, C:\Users\marcha\Documents\pdf\%nombreArchivo%.pdf, A
}
Return



;**************************************************************
; Atajos de la ventana de trackeo
;**************************************************************
#IfWinActive, Select trials to process ahk_class ThunderRT6FormDC
SetControlDelay, -1
w::
ControlGetFocus, cont, A
if cont = ThunderRT6TextBox1
{
	SendInput w
}
else
{
	ControlFocus, ThunderRT6ListBox1, A
	SendInput {Up}
}
return

+w::
ControlFocus, ThunderRT6ListBox3, A
SendInput {Up}
Return

Up::
ControlFocus, ThunderRT6ListBox1, A
SendInput {Up}
return

s::
ControlGetFocus, cont, A
if cont = ThunderRT6TextBox1
{
	SendInput s
}
else
{
	ControlFocus, ThunderRT6ListBox1, A
	SendInput {Down}
}
return

+s::
ControlFocus, ThunderRT6ListBox3, A
SendInput {Down}
Return

Down::
ControlFocus, ThunderRT6ListBox1, A
SendInput {Down}
return

a::
ControlGetFocus, cont, A
if cont = ThunderRT6TextBox1
{
	SendInput a
}
else
{
	ControlFocus, ThunderRT6ListBox2, A
	SendInput {Left}
}
return

Left::
ControlFocus, ThunderRT6ListBox2, A
SendInput {Up}
return

d::
ControlGetFocus, cont, A
if cont = ThunderRT6TextBox1
{
	SendInput d
}
else
{
	ControlFocus, ThunderRT6ListBox2, A
	SendInput {Down}
}
return
Right::
ControlFocus, ThunderRT6ListBox2, A
SendInput {Down}
return

q::
ControlGetFocus, cont, A
if cont = ThunderRT6TextBox1
{
	SendInput q
}
Else
{
ControlClick, Button5, A
}
Return

Enter::
ControlClick, Button6, A
Loop
{
		if ExisteTrialProcessing()
		{
			Break
		}
}
ControlFocus, Button15, A
Return

Space::
ControlGetFocus, cont, A
if cont = ThunderRT6TextBox1
{
	SendInput {Space}
}
else
{
	ControlClick, Button6, A
	Loop
	{
			if ExisteTrialProcessing()
			break
	}
	ControlFocus, Button15, A
}
Return

f::
ControlGetFocus, cont, A
if cont = ThunderRT6TextBox1
{
	SendInput f
}
else
{
	SetControlDelay, -1
	ControlClick, ThunderRT6CheckBox1, A
}
Return

c::
ControlGetFocus, cont, A
ControlGet, sel, Choice, , ThunderRT6ListBox1, A
if cont = ThunderRT6TextBox1
{
	SendInput c
}
else if sel != ""
{
	ControlGet, a, Enabled,, Button1
	if a = 1
	{
		SetControlDelay, -1
		ControlClick, Button1, A
		WinWaitActive, Notas... ahk_class ThunderRT6FormDC
		ControlFocus, Button2, A
		WinWaitClose, Notas... ahk_class ThunderRT6FormDC
		ControlFocus, ThunderRT6ListBox1, A
	}
}
Return

+c::
ControlGetFocus, cont, A
ControlGet, sel, Choice, , ThunderRT6ListBox2, A
if cont = ThunderRT6TextBox1
{
	SendInput c
}
else if sel != ""
{
	ControlGet, a, Enabled,, Button3
	if a = 1
	{
		SetControlDelay, -1
		ControlClick, Button3, A
		WinWaitActive, Notas... ahk_class ThunderRT6FormDC
		ControlFocus, Button2, A
		WinWaitClose, Notas... ahk_class ThunderRT6FormDC
		ControlFocus, ThunderRT6ListBox2, A
	}
}
Return

^f::
ControlFocus, ThunderRT6TextBox1, A
Return

;**************************************************************
; Atajos de la ventana de procesado de trials
;**************************************************************

#IfWinActive, Select Trials ahk_class ThunderRT6FormDC
SetControlDelay, -1
w::
ControlGetFocus, cont, A
if cont = ThunderRT6TextBox1
{
	SendInput w
}
else
{
	ControlFocus, ThunderRT6ListBox2, A
	SendInput {Up}
}
return

+w::
ControlFocus, ThunderRT6ListBox3, A
SendInput {Up}
Return

Up::
ControlFocus, ThunderRT6ListBox2, A
SendInput {Up}
return

s::
ControlGetFocus, cont, A
if cont = ThunderRT6TextBox1
{
	SendInput s
}
else
{
	ControlFocus, ThunderRT6ListBox2, A
	SendInput {Down}
}
return

+s::
ControlFocus, ThunderRT6ListBox3, A
SendInput {Down}
Return

Down::
ControlFocus, ThunderRT6ListBox2, A
SendInput {Down}
return

a::
ControlGetFocus, cont, A
if cont = ThunderRT6TextBox1
{
	SendInput a
}
else
{
	ControlFocus, ThunderRT6ListBox1, A
	SendInput {Left}
}
return

Left::
ControlFocus, ThunderRT6ListBox1, A
SendInput {Up}
return

d::
ControlGetFocus, cont, A
if cont = ThunderRT6TextBox1
{
	SendInput d
}
else
{
	ControlFocus, ThunderRT6ListBox1, A
	SendInput {Right}
}
return

Right::
ControlFocus, ThunderRT6ListBox1, A
SendInput {Down}
return

c::
ControlGetFocus, cont, A
ControlGet, sel, Choice, , ThunderRT6ListBox2, A
if cont = ThunderRT6TextBox1
{
	SendInput c
}
else if sel != ""
{
	ControlGet, a, Enabled,, Button3
	if a = 1
	{
		SetControlDelay, -1
		ControlClick, Button3, A
		WinWaitActive, Notas... ahk_class ThunderRT6FormDC
		ControlFocus, Button2, A
		WinWaitClose, Notas... ahk_class ThunderRT6FormDC
		ControlFocus, ThunderRT6ListBox2, A
	}
}
Return

+c::
ControlGetFocus, cont, A
ControlGet, sel, Choice, , ThunderRT6ListBox1, A
if cont = ThunderRT6TextBox1
{
	SendInput c
}
else if sel != ""
{
	ControlGet, a, Enabled,, Button2
	if a = 1
	{
		SetControlDelay, -1
		ControlClick, Button2, A
		WinWaitActive, Notas... ahk_class ThunderRT6FormDC
		ControlFocus, Button2, A
		WinWaitClose, Notas... ahk_class ThunderRT6FormDC
		ControlFocus, ThunderRT6ListBox1, A
	}
}
Return

q::
ControlGetFocus, cont, A
if cont = ThunderRT6TextBox1
{
	SendInput q
}
Else
{
ControlClick, Button5, A
}
Return

Enter::
space::
ControlClick, Button6, A
Return

RButton::
AppsKey::
MouseGetPos, , , , cont
if cont = ThunderRT6ListBox2
{
	Click

	ControlGet, tas, Choice, , ThunderRT6ListBox2, A
	ControlGet, tas2, Choice, , ThunderRT6ListBox3, A
	ControlGet, tas3, Choice, , ThunderRT6ListBox1, A
	Loop, Parse, tas2, %A_Space%
	{
		idpaciente = %A_LoopField%
		Break
	}
	Loop, Parse, tas3, %A_Space%
	{
		idSesionNum = %A_LoopField%
		Break
	}
	startId := RegExMatch(tas, "\d\w|__")
	idTrial := SubStr(tas, startId,2)
	startId := RegExMatch(tas, "\w\s\w\s\w\s\w")
	P1 := SubStr(tas, startId,1)
	P2 := SubStr(tas, startId+2,1)
	Clipboard = %P2%
	idSesionNum := Chr(idSesionNum + 96)
	largo := StrLen(idpaciente)
	largo2 := 5 - largo
	Loop, %largo2%
	{
		equis := equis . "x"
	}
	nombreArchivo = %idpaciente%%equis%%idSesionNum%%idTrial%
	equis = 
	
	GuiContextMenu:
	ControlGet, texto, Choice, , ThunderRT6ListBox2, A
	SendMessage, 0x0191, 10, fa, ThunderRT6ListBox2, A 
	if %texto%
	{
			if (P1 = "N" && P2 = "N")
			{
				Menu, as, Disable, 2 Cinetica
			}
			Else
			{
				Menu, as, Enable, 2 Cinetica
			}

			ifExist, %ProgramFilesWin%\BTS Bioengineering\Gaitel30\Protocol\Data\%nombreArchivo%.emg
			{
				Menu, as, Enable, 3 EMG
			}
			Else
			{
				Menu, as, Disable, 3 EMG
			}
			Menu, as, Show
	}
	Return

	Cinematica:
	SetControlDelay, -1
	ControlClick, Button6, A
	WinWaitActive, Select Visualization ahk_class ThunderRT6FormDC
	ControlClick, Button1, A
	WinMenuSelectItem, BTS Bioengineering - EliteClinic ahk_class ThunderRT6MDIForm, , Reporte, Report
	WinWaitActive, Informe ahk_class ThunderRT6FormDC
	Control,Check,,ThunderRT6CheckBox2
	Control,Choose,8,ThunderRT6ComboBox1
	ControlSetText, ThunderRT6TextBox2, ES_km
	ControlClick, ThunderRT6CommandButton3, A
	Return

	Cinetica:
	if (P1 = "L" || P2 = "L")
	{
		nombreArchivo := nombreArchivo . "_izq"
	}
	if (P1 = "R" || P2 = "R")
	{
		nombreArchivo := nombreArchivo . "_der"
	}
	SetControlDelay, -1
	ControlClick, Button6, A
	WinWaitActive, Select Visualization ahk_class ThunderRT6FormDC
	ControlClick, Button1, A
	WinMenuSelectItem, BTS Bioengineering - EliteClinic ahk_class ThunderRT6MDIForm, , Reporte, Report
	WinWaitActive, Informe ahk_class ThunderRT6FormDC
	Control,Check,,ThunderRT6CheckBox2
	Control,Choose,8,ThunderRT6ComboBox1
	ControlSetText, ThunderRT6TextBox2, ES_kt
	ControlClick, ThunderRT6CommandButton3, A
	Clipboard = %nombreArchivo%
	Return

	EMG8:
	nombreArchivo := nombreArchivo . "_EMG8"
	SetControlDelay, -1
	ControlClick, Button6, A
	WinWaitActive, Select Visualization ahk_class ThunderRT6FormDC
	ControlClick, Button1, A
	WinMenuSelectItem, BTS Bioengineering - EliteClinic ahk_class ThunderRT6MDIForm, , Reporte, Report
	WinWaitActive, Informe ahk_class ThunderRT6FormDC
	ControlSetText, ThunderRT6TextBox2, ES_km8e
	ControlClick, ThunderRT6CommandButton3, A
	Return

	EMG4:
	nombreArchivo := nombreArchivo . "_EMG4"
	SetControlDelay, -1
	ControlClick, Button6, A
	WinWaitActive, Select Visualization ahk_class ThunderRT6FormDC
	ControlClick, Button1, A
	WinMenuSelectItem, BTS Bioengineering - EliteClinic ahk_class ThunderRT6MDIForm, , Reporte, Report
	WinWaitActive, Informe ahk_class ThunderRT6FormDC
	ControlSetText, ThunderRT6TextBox2, ES_km4e
	ControlClick, ThunderRT6CommandButton3, A
	Return

	EMG5:
	nombreArchivo := nombreArchivo . "_EMG5"
	SetControlDelay, -1
	ControlClick, Button6, A
	WinWaitActive, Select Visualization ahk_class ThunderRT6FormDC
	ControlClick, Button1, A
	WinMenuSelectItem, BTS Bioengineering - EliteClinic ahk_class ThunderRT6MDIForm, , Reporte, Report
	WinWaitActive, Informe ahk_class ThunderRT6FormDC
	ControlSetText, ThunderRT6TextBox2, ES_km5e
	ControlClick, ThunderRT6CommandButton3, A
	Return

	EMG4L:
	nombreArchivo := nombreArchivo . "_EMG4L"
	SetControlDelay, -1
	ControlClick, Button6, A
	WinWaitActive, Select Visualization ahk_class ThunderRT6FormDC
	ControlClick, Button1, A
	WinMenuSelectItem, BTS Bioengineering - EliteClinic ahk_class ThunderRT6MDIForm, , Reporte, Report
	WinWaitActive, Informe ahk_class ThunderRT6FormDC
	ControlSetText, ThunderRT6TextBox2, ES_km4el
	ControlClick, ThunderRT6CommandButton3, A
	Return

	EMG4R:
	nombreArchivo := nombreArchivo . "_EMG4R"
	SetControlDelay, -1
	ControlClick, Button6, A
	WinWaitActive, Select Visualization ahk_class ThunderRT6FormDC
	ControlClick, Button1, A
	WinMenuSelectItem, BTS Bioengineering - EliteClinic ahk_class ThunderRT6MDIForm, , Reporte, Report
	WinWaitActive, Informe ahk_class ThunderRT6FormDC
	ControlSetText, ThunderRT6TextBox2, ES_km4er
	ControlClick, ThunderRT6CommandButton3, A
	Return

	Vastos:
	nombreArchivo := nombreArchivo . "_Vastos"
	SetControlDelay, -1
	ControlClick, Button6, A
	WinWaitActive, Select Visualization ahk_class ThunderRT6FormDC
	ControlClick, Button1, A
	WinMenuSelectItem, BTS Bioengineering - EliteClinic ahk_class ThunderRT6MDIForm, , Reporte, Report
	WinWaitActive, Informe ahk_class ThunderRT6FormDC
	ControlSetText, ThunderRT6TextBox2, ES_km2e
	ControlClick, ThunderRT6CommandButton3, A
	Return

	AbrirArchivo:
	IfExist, %ProgramFilesWin%\BTS Bioengineering\Gaitel30\Protocol\Data\%nombreArchivo%.RIC
	{
		Run, explorer.exe /select`, %ProgramFilesWin%\BTS Bioengineering\Gaitel30\Protocol\Data\%nombreArchivo%.RIC
	}
	else IfExist, %ProgramFilesWin%\BTS Bioengineering\Gaitel30\Protocol\Data\%nombreArchivo%.RAW
	{
		Run, explorer.exe /select`, %ProgramFilesWin%\BTS Bioengineering\Gaitel30\Protocol\Data\%nombreArchivo%.RAW
	}
	else IfExist, %ProgramFilesWin%\BTS Bioengineering\Gaitel30\Protocol\Data\%nombreArchivo%.dbt
	{
		Run, explorer.exe /select`, %ProgramFilesWin%\BTS Bioengineering\Gaitel30\Protocol\Data\%nombreArchivo%.dbt
	}
	Return

	Interpolar:
	FileCopy, %ProgramFilesWin%\BTS Bioengineering\Gaitel30\Protocol\Data\%nombreArchivo%.RAW, %ProgramFilesWin%\BTS Bioengineering\Gaitel30\Protocol\Data\%nombreArchivo%-%A_Now%.RAW.bkp
	FileMove, %ProgramFilesWin%\BTS Bioengineering\Gaitel30\Protocol\Data\%nombreArchivo%.RAW, %ProgramFilesWin%\BTS Bioengineering\Gaitel30\Exe\%nombreArchivo%.RAW
	RunWait INTERP2.EXE %nombreArchivo%.RAW INTER.RAW 100, C:\Archivos de programa\BTS Bioengineering\Gaitel30\Exe\
	FileMove, %ProgramFilesWin%\BTS Bioengineering\Gaitel30\Exe\INTER.RAW, %ProgramFilesWin%\BTS Bioengineering\Gaitel30\Protocol\Data\%nombreArchivo%.RAW,1
	FileDelete, %ProgramFilesWin%\BTS Bioengineering\Gaitel30\Exe\%nombreArchivo%.RAW
	Return

}
Else
{
	Return
}

^f::
ControlFocus, ThunderRT6TextBox1, A
Return

;**********************************************************
; Atajos de la ventana principal de inicio
;**********************************************************
#Persistent
#IfWinActive BTS Bioengineering - EliteClinic ahk_class ThunderRT6MDIForm

#1::
SetLastMode("Normal")
SetControlDelay, 0
WinMenuSelectItem, BTS Bioengineering - EliteClinic ahk_class ThunderRT6MDIForm, , 1& , 1&, 1&
WinWaitActive, New Trial ahk_class ThunderRT6FormDC
ControlSetText, ThunderRT6TextBox4, Rodilla derecha
ControlClick, Button4, A
WinWaitActive, New Trial ahk_class #32770
ControlClick, Button1, A
WinWaitActive, Acq. Manager - Setup: SetupACQ ahk_class TDaqDlg
Loop
{
	ControlGet, a, Enabled,, TBitBtn5
	if a = 1 
		break
}
ControlClick, TBitBtn5, A
ControlClick, TBitBtn8, A
Sleep, 4000
ControlClick, TBitBtn7, A
WinWaitActive, Platform parameters setup ahk_class TPlaPostCfgDlg

if (IsMarkedLeftFootP1() = true)
{
	UnmarkLeftFootP1()
}
if (IsMarkedRightFootP1() = true)
{
	UnmarkRightFootP1()
}
if (IsMarkedLeftFootP2() = true)
{
	UnmarkLeftFootP2()
}
if (IsMarkedRightFootP2() = true)
{
	UnmarkRightFootP2()
}

Control, Check, , TGroupButton3, A
ControlClick, TButton1, A
WinWaitActive, New Trial ahk_class #32770
ControlClick, Button1, A
WinWaitActive, Trial classification: ahk_class ThunderRT6FormDC
Control, Check, , AfxWnd406, A
ControlSetText, ThunderRT6TextBox1, Rodilla derecha
ControlClick, Button1, A
WinWaitActive, Trial classification: ahk_class #32770
ControlClick, Button1, A
WinWaitActive, Trial classification: C:\Archivos de programa\BTS ahk_class #32770
ControlClick, Button1, A
return

#2::
SetLastMode("Normal")
SetControlDelay, 0
WinMenuSelectItem, BTS Bioengineering - EliteClinic ahk_class ThunderRT6MDIForm, , 1& , 1&, 1&
WinWait ahk_class ThunderRT6FormDC
ControlSetText, ThunderRT6TextBox4, Tobillo derecho
ControlClick, Button4, A
WinWaitActive, New Trial ahk_class #32770
ControlClick, Button1, A
WinWaitActive, Acq. Manager - Setup: SetupACQ ahk_class TDaqDlg
Loop
{
	ControlGet, a, Enabled,, TBitBtn5
	if a = 1 
		break
}
ControlClick, TBitBtn5, A
ControlClick, TBitBtn8, A
Sleep, 4000
ControlClick, TBitBtn7, A
WinWaitActive, Platform parameters setup ahk_class TPlaPostCfgDlg

if (IsMarkedLeftFootP1() = true)
{
	UnmarkLeftFootP1()
}
if (IsMarkedRightFootP1() = true)
{
	UnmarkRightFootP1()
}
if (IsMarkedLeftFootP2() = true)
{
	UnmarkLeftFootP2()
}
if (IsMarkedRightFootP2() = true)
{
	UnmarkRightFootP2()
}

Control, Check, , TGroupButton3, A
ControlClick, TButton1, A
WinWaitActive, New Trial ahk_class #32770
ControlClick, Button1, A
WinWaitActive, Trial classification: ahk_class ThunderRT6FormDC
Control, Check, , AfxWnd406, A
ControlSetText, ThunderRT6TextBox1, Tobillo derecho
ControlClick, Button1, A
WinWaitActive, Trial classification: ahk_class #32770
ControlClick, Button1, A
WinWaitActive, Trial classification: C:\Archivos de programa\BTS ahk_class #32770
ControlClick, Button1, A

return

#3::
SetLastMode("Normal")
SetControlDelay, 0
WinMenuSelectItem, BTS Bioengineering - EliteClinic ahk_class ThunderRT6MDIForm, , 1& , 1&, 1&
WinWait ahk_class ThunderRT6FormDC
ControlSetText, ThunderRT6TextBox4, Rodilla izquierda
ControlClick, Button4, A
WinWaitActive, New Trial ahk_class #32770
ControlClick, Button1, A
WinWaitActive, Acq. Manager - Setup: SetupACQ ahk_class TDaqDlg
Loop
{
	ControlGet, a, Enabled,, TBitBtn5
	if a = 1 
		break
}
ControlClick, TBitBtn5, A
ControlClick, TBitBtn8, A
Sleep, 4000
ControlClick, TBitBtn7, A
WinWaitActive, Platform parameters setup ahk_class TPlaPostCfgDlg

if (IsMarkedLeftFootP1() = true)
{
	UnmarkLeftFootP1()
}
if (IsMarkedRightFootP1() = true)
{
	UnmarkRightFootP1()
}
if (IsMarkedLeftFootP2() = true)
{
	UnmarkLeftFootP2()
}
if (IsMarkedRightFootP2() = true)
{
	UnmarkRightFootP2()
}

Control, Check, , TGroupButton3, A
ControlClick, TButton1, A
WinWaitActive, New Trial ahk_class #32770
ControlClick, Button1, A
WinWaitActive, Trial classification: ahk_class ThunderRT6FormDC
Control, Check, , AfxWnd406, A
ControlSetText, ThunderRT6TextBox1, Rodilla izquierda
ControlClick, Button1, A
WinWaitActive, Trial classification: ahk_class #32770
ControlClick, Button1, A
WinWaitActive, Trial classification: C:\Archivos de programa\BTS ahk_class #32770
ControlClick, Button1, A
return

#4::
SetLastMode("Normal")
SetControlDelay, 0
WinMenuSelectItem, BTS Bioengineering - EliteClinic ahk_class ThunderRT6MDIForm, , 1& , 1&, 1&
WinWait ahk_class ThunderRT6FormDC
ControlSetText, ThunderRT6TextBox4, Tobillo izquierdo
ControlClick, Button4, A
WinWaitActive, New Trial ahk_class #32770
ControlClick, Button1, A
WinWaitActive, Acq. Manager - Setup: SetupACQ ahk_class TDaqDlg
Loop
{
	ControlGet, a, Enabled,, TBitBtn5
	if a = 1 
		break
}
ControlClick, TBitBtn5, A
ControlClick, TBitBtn8, A
Sleep, 4000
ControlClick, TBitBtn7, A
WinWaitActive, Platform parameters setup ahk_class TPlaPostCfgDlg

if (IsMarkedLeftFootP1() = true)
{
	UnmarkLeftFootP1()
}
if (IsMarkedRightFootP1() = true)
{
	UnmarkRightFootP1()
}
if (IsMarkedLeftFootP2() = true)
{
	UnmarkLeftFootP2()
}
if (IsMarkedRightFootP2() = true)
{
	UnmarkRightFootP2()
}

Control, Check, , TGroupButton3, A
ControlClick, TButton1, A
WinWaitActive, New Trial ahk_class #32770
ControlClick, Button1, A
WinWaitActive, Trial classification: ahk_class ThunderRT6FormDC
Control, Check, , AfxWnd406, A
ControlSetText, ThunderRT6TextBox1, Tobillo izquierdo
ControlClick, Button1, A
WinWaitActive, Trial classification: ahk_class #32770
ControlClick, Button1, A
WinWaitActive, Trial classification: C:\Archivos de programa\BTS ahk_class #32770
ControlClick, Button1, A
return

#|::
SetLastMode("Normal")
SetControlDelay, 0
WinMenuSelectItem, BTS Bioengineering - EliteClinic ahk_class ThunderRT6MDIForm, , 1& , 1&, 1&
WinWaitActive, New Trial ahk_class ThunderRT6FormDC
ControlSetText, ThunderRT6TextBox4, Standing
ControlClick, Button4, A
WinWaitActive, New Trial ahk_class #32770
ControlClick, Button1, A
WinWaitActive, Acq. Manager - Setup: SetupACQ ahk_class TDaqDlg
Loop
{
	ControlGet, a, Enabled,, TBitBtn5
	if a = 1 
		break
}
ControlClick, TBitBtn5, A
MsgBox, 1, Captura de peso del paciente, Subir el paciente a la plataforma 1 y aceptar
IfMsgBox OK
{
	ControlClick, TBitBtn3, A
	KeyWait, Space, D
	ControlClick, TBitBtn2, A
	ControlClick, Confirm, A
	ControlClick, TBitBtn9, A
	Sleep, 4000
	ControlClick, TBitBtn8, A
	WinWaitActive, Platform parameters setup ahk_class TPlaPostCfgDlg

	if (IsMarkedLeftFootP1() = false)
	{
		MarkLeftFootP1()
	}
	if (IsMarkedRightFootP1() = false)
	{
		MarkRightFootP1()
	}
	if (IsMarkedLeftFootP2() = true)
	{
		UnmarkLeftFootP2()
	}
	if (IsMarkedRightFootP2() = true)
	{
		UnmarkRightFootP2()
	}

	Control, Check, , TGroupButton3, A
	ControlClick, TButton1, A
	WinWaitActive, New Trial ahk_class #32770
	ControlClick, Button1, A
	WinWaitActive, Trial classification: ahk_class ThunderRT6FormDC
	Control, Check, , AfxWnd407, A
	ControlSetText, ThunderRT6TextBox1, Standing
	ControlClick, Button1, A
	WinWaitActive, Trial classification: ahk_class #32770
	ControlClick, Button1, A
	WinWaitActive, Trial classification: C:\Archivos de programa\BTS ahk_class #32770
	ControlClick, Button1, A
}
IfMsgBox Cancel
{
	ControlClick, TBitBtn6, A
}
return

#space::
SetLastMode("Normal")
SetControlDelay, 0
WinMenuSelectItem, BTS Bioengineering - EliteClinic ahk_class ThunderRT6MDIForm, , 1& , 1&, 1&
WinWaitActive, New Trial ahk_class ThunderRT6FormDC
texto := ReturnFirstLineClipbrd()
ControlSetText, ThunderRT6TextBox4, %texto%
ControlClick, Button4, A
WinWaitActive, New Trial ahk_class #32770
ControlClick, Button1, A
WinWaitActive, Acq. Manager - Setup: SetupACQ ahk_class TDaqDlg
Loop
{
	ControlGet, a, Enabled,, TBitBtn5
	if a = 1 
		break
}
ControlClick, TBitBtn5, A
ControlClick, TBitBtn8, A
KeyWait, Space, D
ControlClick, TBitBtn7, A
WinWaitActive, Platform parameters setup ahk_class TPlaPostCfgDlg

ControlGet, che, Checked, , TGroupButton3, A
ControlGet, che2, Checked, , TGroupButton4, A
if che
{
	Control, Check, , TGroupButton4, A
}
if che2
{
	Control, Check, , TGroupButton3, A
}

if (IsMarkedLeftFootP1() = true)
{
	UnmarkLeftFootP1()
}
if (IsMarkedRightFootP1() = true)
{
	UnmarkRightFootP1()
}
if (IsMarkedLeftFootP2() = true)
{
	UnmarkLeftFootP2()
}
if (IsMarkedRightFootP2() = true)
{
	UnmarkRightFootP2()
}

KeyWait, Space, D
ControlClick, TButton1, A
WinWaitActive, New Trial ahk_class #32770
ControlClick, Button1, A
WinWaitActive, Trial classification: ahk_class ThunderRT6FormDC
ControlSetText, ThunderRT6TextBox1, %texto%
ControlClick, Button1, A
WinWaitActive, Trial classification: ahk_class #32770
ControlClick, Button1, A
WinWaitActive, Trial classification: C:\Archivos de programa\BTS ahk_class #32770
ControlClick, Button2, A
return

#e::
if not ColorChoice or ColorChoice = ""
{
	Gui, Add, Text, , Seleccione el tipo de EMG
	Gui, Add, ListBox, R6 gColorChoice vColorChoice Choose1, ||EMG8E|EMG4E|EMG4L|EMG4R|Vastos|
	Gui, Show
	Return

	ColorChoice:
	Gui, Submit
	WinActivate, BTS Bioengineering - EliteClinic ahk_class ThunderRT6MDIForm
	SetLastMode(ColorChoice)
	Gui, Destroy
	return
}
SetControlDelay, 0
WinMenuSelectItem, BTS Bioengineering - EliteClinic ahk_class ThunderRT6MDIForm, , 1& , 1&, 1&
WinWaitActive, New Trial ahk_class ThunderRT6FormDC
texto := ColorChoice
ControlSetText, ThunderRT6TextBox4, %texto%
ControlClick, Button4, A
WinWaitActive, New Trial ahk_class #32770
ControlClick, Button1, A
WinWaitActive, Acq. Manager - Setup: SetupACQ ahk_class TDaqDlg
Loop
{
	ControlGet, a, Enabled,, TBitBtn5
	if a = 1 
		break
}
ControlClick, TBitBtn5, A
KeyWait, Space, D
ControlClick, TBitBtn8, A
KeyWait, Space, U
ControlClick, TBitBtn7, A
WinWaitActive, Platform parameters setup ahk_class TPlaPostCfgDlg

ControlGet, che, Checked, , TGroupButton3, A
ControlGet, che2, Checked, , TGroupButton4, A
if che
{
	Control, Check, , TGroupButton4, A
}
if che2
{
	Control, Check, , TGroupButton3, A
}

if (IsMarkedLeftFootP1() = true)
{
	UnmarkLeftFootP1()
}
if (IsMarkedRightFootP1() = true)
{
	UnmarkRightFootP1()
}
if (IsMarkedLeftFootP2() = true)
{
	UnmarkLeftFootP2()
}
if (IsMarkedRightFootP2() = true)
{
	UnmarkRightFootP2()
}

KeyWait, Space, D
ControlClick, TButton1, A
return


r::
SetControlDelay, 0
WinMenuSelectItem, BTS Bioengineering - EliteClinic ahk_class ThunderRT6MDIForm, , 1& , 5&
WinWaitActive, Select trials to process ahk_class ThunderRT6FormDC
ControlFocus, ThunderRT6ListBox1, A
Return

t::
SetControlDelay, 0
WinMenuSelectItem, BTS Bioengineering - EliteClinic ahk_class ThunderRT6MDIForm, , 2& , 1&
WinWaitActive, Select Trials ahk_class ThunderRT6FormDC
ControlFocus, ThunderRT6ListBox2, A
Return

;*****************************************************
; Comienzan los atajos de procesado de trials
;*****************************************************

X = 0
Y = 0

Right::
d::
if ExisteBarra()
{
	ControlSend, ThunderRT6HScrollBar3, {Right}
}
else
{
	SendInput {Right}
}
Return

+Right::
+d::
if ExisteBarra()
{
	ControlSend, ThunderRT6HScrollBar3, {PgDn}
}
else
{
	SendInput {PgDn}
}
Return

f::
if ExisteBarra()
{
	OldMatchMode := A_TitleMatchMode
	SetTitleMatchMode, RegEx
	ControlGet, Handle2D, Hwnd, , \s3D$
	ControlGetPos, X, Y, , , , ahk_id %Handle2D%
	X := X + 80
	Y := Y + 30
	Yf := Y - 500
	MouseGetPos, Xo, Yo
	SetMouseDelay, -1
	SendInput, {Click Right down %X%, %Y%}{Click Right up %X%, %Yf%}
	;MouseClickDrag, Right, %X%, %Y%, %X%, %Yf%, 0
	MouseMove, %Xo%, %Yo%, 0
	SetTitleMatchMode, %OldMatchMode%
}
Return

v::
if ExisteBarra()
{
	OldMatchMode := A_TitleMatchMode
	SetTitleMatchMode, RegEx
	ControlGet, Handle2D, Hwnd, , \s3D$
	ControlGetPos, X, Y, , , , ahk_id %Handle2D%
	X := X + 80
	Y := Y + 30
	Yf := Y - 500
	MouseGetPos, Xo, Yo
	MouseClickDrag, Left, %X%, %Y%, %X%, %Yf%, 0
	MouseMove, %Xo%, %Yo%, 0
	SetTitleMatchMode, %OldMatchMode%

	OldMatchMode := A_TitleMatchMode
	SetTitleMatchMode, RegEx
	ControlGet, Handle2D, Hwnd, , \s2D$
	ControlGetPos, X, Y, , , , ahk_id %Handle2D%
	X := X + 30
	Y := Y + 5
	MouseGetPos, Xo, Yo
	MouseClick, , %X%, %Y%, , 0
	MouseMove, %Xo%, %Yo%, 0
	ControlSend, ThunderRT6VScrollBar4, {Up 8}
	SetTitleMatchMode, %OldMatchMode%

	Loop, 5
	{
	OldMatchMode := A_TitleMatchMode
	SetTitleMatchMode, RegEx
	ControlGet, Handle2D, Hwnd, , \s3D$
	ControlGetPos, X, Y, , , , ahk_id %Handle2D%
	X := X + 80
	Y := Y + 30
	Yf := Y - 500
	MouseGetPos, Xo, Yo
	MouseClickDrag, Right, %X%, %Y%, %X%, %Yf%, 0
	MouseMove, %Xo%, %Yo%, 0
	SetTitleMatchMode, %OldMatchMode%
	}
}
Return

g::
if ExisteBarra()
{
	OldMatchMode := A_TitleMatchMode
	SetTitleMatchMode, RegEx
	ControlGet, Handle2D, Hwnd, , \s3D$
	ControlGetPos, X, Y, , , , ahk_id %Handle2D%
	X := X + 80
	Y := Y + 30
	Yf := Y + 500
	MouseGetPos, Xo, Yo
	SetMouseDelay, -1
	SendInput, {Click Right down %X%, %Y%}{Click Right up %X%, %Yf%}
	MouseMove, %Xo%, %Yo%, 0
	SetTitleMatchMode, %OldMatchMode%
}
Return

Left::
a::
if ExisteBarra()
{
	ControlSend, ThunderRT6HScrollBar3, {Left}
}
else
{
	SendInput {Left}
}
Return

+Left::
+a::
if ExisteBarra()
{
	ControlSend, ThunderRT6HScrollBar3, {PgUp}
}
else
{
	SendInput {PgUp}
}
Return

^Left::
^a::
if ExisteBarra()
{
	OldMatchMode := A_TitleMatchMode
	SetTitleMatchMode, RegEx
	ControlGet, Handle2D, Hwnd, , \s2D$
	ControlGetPos, X, Y, , , , ahk_id %Handle2D%
	X := X + 30
	Y := Y + 5
	MouseGetPos, Xo, Yo
	MouseClick, , %X%, %Y%, , 0
	MouseMove, %Xo%, %Yo%, 0
	ControlSend, ThunderRT6HScrollBar2, {Left}
	SetTitleMatchMode, %OldMatchMode%
}
Return

^Right::
^d::
if ExisteBarra()
{
	OldMatchMode := A_TitleMatchMode
	SetTitleMatchMode, RegEx
	ControlGet, Handle2D, Hwnd, , \s2D$
	ControlGetPos, X, Y, , , , ahk_id %Handle2D%
	X := X + 30
	Y := Y + 5
	MouseGetPos, Xo, Yo
	MouseClick, , %X%, %Y%, , 0
	MouseMove, %Xo%, %Yo%, 0
	ControlSend, ThunderRT6HScrollBar2, {Right}
	SetTitleMatchMode, %OldMatchMode%
}
Return

^Up::
^w::
if ExisteBarra()
{
	OldMatchMode := A_TitleMatchMode
	SetTitleMatchMode, RegEx
	ControlGet, Handle2D, Hwnd, , \s2D$
	ControlGetPos, X, Y, , , , ahk_id %Handle2D%
	X := X + 30
	Y := Y + 5
	MouseGetPos, Xo, Yo
	MouseClick, , %X%, %Y%, , 0
	MouseMove, %Xo%, %Yo%, 0
	ControlSend, ThunderRT6VScrollBar4, {Up}
	SetTitleMatchMode, %OldMatchMode%
}
Return

^Down::
^s::
if ExisteBarra()
{
	OldMatchMode := A_TitleMatchMode
	SetTitleMatchMode, RegEx
	ControlGet, Handle2D, Hwnd, , \s2D$
	ControlGetPos, X, Y, , , , ahk_id %Handle2D%
	X := X + 30
	Y := Y + 5
	MouseGetPos, Xo, Yo
	MouseClick, , %X%, %Y%, , 0
	MouseMove, %Xo%, %Yo%, 0
	ControlSend, ThunderRT6VScrollBar4, {Down}
	SetTitleMatchMode, %OldMatchMode%
}
Return

Up::
w::
if ExisteBarra()
{
	MouseGetPos, X0, Y0
	ControlGetPos, X, Y, , , ThunderRT6PictureBoxDC28
	X := X+5
	Y := Y+5
	MouseMove, %X%, %Y% , 0
	Click
	MouseMove, %X0%, %Y0% , 0
}
if ExisteTrialProcessing()
{
	SendInput {Up}
}
Return

+Up::
+w::
if ExisteBarra()
{
	MouseGetPos, X0, Y0
	ControlGetPos, X, Y, , , ThunderRT6PictureBoxDC27
	X := X+5
	Y := Y+5
	MouseMove, %X%, %Y% , 0
	Click
	MouseMove, %X0%, %Y0% , 0
}
Return

Down::
s::
if ExisteBarra()
{
	MouseGetPos, X0, Y0
	ControlGetPos, X, Y, , , ThunderRT6PictureBoxDC1
	X := X+5
	Y := Y+5
	MouseMove, %X%, %Y% , 0
	Click
	MouseMove, %X0%, %Y0% , 0
}
if ExisteTrialProcessing()
{
	SendInput {Down}
}
Return

+Down::
+s::
if ExisteBarra()
{
	MouseGetPos, X0, Y0
	ControlGetPos, X, Y, , , ThunderRT6PictureBoxDC2
	X := X+5
	Y := Y+5
	MouseMove, %X%, %Y% , 0
	Click
	MouseMove, %X0%, %Y0% , 0
}
Return

e::
if ExisteBarra()
{
	WinMenuSelectItem, BTS Bioengineering - EliteClinic ahk_class ThunderRT6MDIForm, , 6& , 2&
}
Return

q::
if ExisteBarra()
{
	OldMatchMode := A_TitleMatchMode
	SetTitleMatchMode, RegEx
	ControlGet, Handle3D, Hwnd, , (2|3)D$, A
	ControlFocus, , %Handle3D%, A
	SendInput ^{F4}
	SetTitleMatchMode, %OldMatchMode%
}
Return

z::
if ExisteBarra()
{
	MsgBox, %X% %Y%
}
else
{
	MsgBox % ReturnFirstLineClipbrd()
}
return

#IfWinActive, Platform parameters setup ahk_class TPlaPostCfgDlg
x::
if IsMarkedRightFootP1()
{
	UnmarkRightFootP1()
}
Else
{
	MarkRightFootP1()
}
Return
;##########################################
;Funciones
;##########################################

ExisteTrialProcessing(){
	WinGet, listacontroles, ControlList, BTS Bioengineering - EliteClinic ahk_class ThunderRT6MDIForm

	Loop, Parse, listacontroles ,`n
	{
		if A_LoopField = ThunderRT6FormDC1
		{
			ControlGet, v, Visible, ,Trial Processing, BTS Bioengineering - EliteClinic ahk_class ThunderRT6MDIForm
			if v = 1 
			{
				return true
			}
		}
	}
	return false
}

ExisteBarra(){
	WinGet, listacontroles, ControlList, BTS Bioengineering - EliteClinic ahk_class ThunderRT6MDIForm

	Loop, Parse, listacontroles ,`n
	{
		if A_LoopField = ThunderRT6ComboBox1
		{
			ControlGet, v, Visible, , ThunderRT6ComboBox1, BTS Bioengineering - EliteClinic ahk_class ThunderRT6MDIForm
			if v = 1 
			{
				return true
			}
		}
	}
	return false
}

varExist(ByRef v) { ; Requires 1.0.46+
   return &v = &n ? 0 : v = "" ? 2 : 1 
}

GetScrollInfo() {
  ControlGet, hand, HWND, , ThunderRT6HScrollBar3
  return DllCall("GetScrollPos","UInt",hand,"Int",SB_CTL := 0x2)
}

SetScrollInfo(pos) {
  	ControlGet, hand, HWND, , ThunderRT6HScrollBar3
  	return DllCall("SetScrollPos","UInt",hand,"Int",SB_CTL := 0x2,"UInt",pos,"UInt",1)
}

ReturnFirstLineClipbrd() {
	Loop, Parse, clipboard,`n,`r
	{
		return %A_LoopField%
	}
	Return
}

IsMarkedLeftFootP1() {
	PixelGetColor, color, 163, 117
	if color = 0x00FF00
	{
		return true
	}
	if color = 0xC08080
	{
		return false
	}
}

MarkLeftFootP1() {
	MouseGetPos, X, Y
	MouseClick, , 163, 203, , 0
	MouseMove, %X%, %Y%, 0
}

UnmarkLeftFootP1() {
	MouseGetPos, X, Y
	MouseClick, , 161, 123, , 0
	MouseMove, %X%, %Y%, 0
}

IsMarkedRightFootP1() {
	PixelGetColor, color, 200, 124
	if color = 0x00FF00
	{
		return true
	}
	if color = 0xC08080
	{
		return false
	}
}

MarkRightFootP1() {
	MouseGetPos, X, Y
	MouseClick, , 200, 202, , 0
	MouseMove, %X%, %Y%, 0
}

UnmarkRightFootP1() {
	MouseGetPos, X, Y
	MouseClick, , 200, 124, , 0
	MouseMove, %X%, %Y%, 0
}

IsMarkedLeftFootP2() {
	PixelGetColor, color, 275, 121
	if color = 0x00FF00
	{
		return true
	}
	if color = 0xC08080
	{
		return false
	}
}

MarkLeftFootP2() {
	MouseGetPos, X, Y
	MouseClick, , 273, 206, , 0
	MouseMove, %X%, %Y%, 0
}

UnmarkLeftFootP2() {
	MouseGetPos, X, Y
	MouseClick, , 275, 121, , 0
	MouseMove, %X%, %Y%, 0
}

IsMarkedRightFootP2() {
	PixelGetColor, color, 312, 117
	if color = 0x00FF00
	{
		return true
	}
	if color = 0xC08080
	{
		return false
	}
}

MarkRightFootP2() {
	MouseGetPos, X, Y
	MouseClick, , 311, 201, , 0
	MouseMove, %X%, %Y%, 0
}

UnmarkRightFootP2() {
	MouseGetPos, X, Y
	MouseClick, , 312, 117, , 0
	MouseMove, %X%, %Y%, 0
}

SetLastMode(mode) {
	ProgramFilesWin := GetOS()
	if mode = Normal
	{
		FileDelete, %ProgramFilesWin%\BTS Bioengineering\Gaitel30\Protocol\Setup\ACQLAST.MOD
		FileAppend, 8TV2PLA.ACQ, %ProgramFilesWin%\BTS Bioengineering\Gaitel30\Protocol\Setup\ACQLAST.MOD
	}
	else if mode = EMG8E
	{
		FileDelete, %ProgramFilesWin%\BTS Bioengineering\Gaitel30\Protocol\Setup\ACQLAST.MOD
		FileAppend, 8TV2PL8E.ACQ, %ProgramFilesWin%\BTS Bioengineering\Gaitel30\Protocol\Setup\ACQLAST.MOD
	}
	else if mode = Vastos
	{
		FileDelete, %ProgramFilesWin%\BTS Bioengineering\Gaitel30\Protocol\Setup\ACQLAST.MOD
		FileAppend, 8TV2PL2E.ACQ, %ProgramFilesWin%\BTS Bioengineering\Gaitel30\Protocol\Setup\ACQLAST.MOD
	}
	else if mode = EMG4E
	{
		FileDelete, %ProgramFilesWin%\BTS Bioengineering\Gaitel30\Protocol\Setup\ACQLAST.MOD
		FileAppend, 8TV2PL4E.ACQ, %ProgramFilesWin%\BTS Bioengineering\Gaitel30\Protocol\Setup\ACQLAST.MOD
	}
	else if mode = EMG4L
	{
		FileDelete, %ProgramFilesWin%\BTS Bioengineering\Gaitel30\Protocol\Setup\ACQLAST.MOD
		FileAppend, 8TV2PL4L.ACQ, %ProgramFilesWin%\BTS Bioengineering\Gaitel30\Protocol\Setup\ACQLAST.MOD
	}
	else if mode = EMG4R
	{
		FileDelete, %ProgramFilesWin%\BTS Bioengineering\Gaitel30\Protocol\Setup\ACQLAST.MOD
		FileAppend, 8TV2PL4R.ACQ, %ProgramFilesWin%\BTS Bioengineering\Gaitel30\Protocol\Setup\ACQLAST.MOD
	}
	else
	{
		FileDelete, %ProgramFilesWin%\BTS Bioengineering\Gaitel30\Protocol\Setup\ACQLAST.MOD
		FileAppend, 8TV2PLA.ACQ, %ProgramFilesWin%\BTS Bioengineering\Gaitel30\Protocol\Setup\ACQLAST.MOD
	}
}