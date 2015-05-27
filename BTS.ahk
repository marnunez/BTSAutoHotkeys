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
Menu, EMG, Add, 6 EMG5L, EMG5L
Menu, EMG, Add, 7 EMG5R, EMG5R
Menu, EMG, Add, 8 Vastos, Vastos

Menu, as, Add, 3 EMG, :EMG
Menu, as, Add, 4 Abrir archivo..., AbrirArchivo
Menu, as, Add, 5 Interpolar, Interpolar

ProgramFilesWin := GetProgramFiles()

VarSetCapacity(ante,512)
VarSetCapacity(next,512)
VarSetCapacity(last,512)

#s::Suspend ;Inicio + S --> Deshabilita/Habilita todos los atajos (menos a sí mismo)

#IfWinActive, Select Visualization ahk_class ThunderRT6FormDC
f::
	Control, Check, , ThunderRT6CheckBox4, A
	Control, Check, , ThunderRT6CheckBox3, A
	Control, Choose, 3, ThunderRT6ComboBox1, A
	if Control.IsEnabled("ThunderRT6CheckBox1")
	{
		Control, Check, , ThunderRT6CheckBox1, A
	}
	ControlFocus, Button1, A
return

#IfWinActive, Data Computing ahk_class #32770
space::
Enter::
Control,Check,, Button1, A
WinWaitActive, BTS Bioengineering - EliteClinic ahk_class ThunderRT6MDIForm
if ExisteTrialProcessing()
{
	Control,Check,, Button16, A
}
return

#IfWinActive, Preview ahk_class ThunderRT6FormDC
e::
ControlGetPos, , , PicWidth, PicHeight, ThunderRT6PictureBoxDC1, A
MsgBox, %PicWidth%`t%PicHeight%
Return

p::
Control,Check,, ThunderRT6CommandButton2, A
WinWaitActive, Configurar ahk_class #32770
Control,Check,, Button7, A
if A_OSVersion = WIN_7
{
	WinWaitActive, PDFCreator 0.9.6 ahk_class ThunderRT6FormDC ahk_exe PDFCreator.exe
	ControlSetText, ThunderRT6TextBox6, %nombreArchivo%
}
Return

q::
Escape::
Control,Check,,ThunderRT6CommandButton1,A
Return

#IfWinActive, PDFCreator 0.9.6 ahk_class ThunderRT6FormDC ahk_exe PDFCreator.exe
space::
Enter::
Control,Check,, ThunderRT6CommandButton7, A
WinWaitActive, Guardar como ahk_class #32770 ahk_exe PDFCreator.exe
ControlSetText, Edit1, C:\Users\marcha\Documents\pdf\%nombreArchivo%.pdf, A

;**************************************************************
; Atajos de la ventana de trackeo
;**************************************************************
#IfWinActive, Select trials to process ahk_class ThunderRT6FormDC

w::
if Control.GetFocus() = "ThunderRT6TextBox1"
{
	SendInput w
}
else
{
	ControlFocus, ThunderRT6ListBox1, A
	SendInput {Up}
	/*
	SendMessage, LB_GETCURSEL, 0, 0, ThunderRT6ListBox1, A ;Posicion de la fila seleccionada
	SendMessage, LB_GETTEXT, %ErrorLevel%, &last, ThunderRT6ListBox1, A ;Texto de la fila seleccionada
	last := SubStr(last, 1,30)
	*/
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
if Control.GetFocus() = "ThunderRT6TextBox1"
{
	SendInput s
}
else
{
	ControlFocus, ThunderRT6ListBox1, A
	SendInput {Down}
	/*
	SendMessage, LB_GETCURSEL, 0, 0, ThunderRT6ListBox1, A ;Posicion de la fila seleccionada
	SendMessage, LB_GETTEXT, %ErrorLevel%, &last, ThunderRT6ListBox1, A ;Texto de la fila seleccionada
	last := SubStr(last, 1,30)
	*/
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
if Control.GetFocus() = "ThunderRT6TextBox1"
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
if Control.GetFocus() = "ThunderRT6TextBox1"
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
if Control.GetFocus() = "ThunderRT6TextBox1"
{
	SendInput q
}
Else
{
Control,Check,, Button5, A
}
Return

Escape::
Control,Check,, Button5, A
Return

Enter::
SendMessage, LB_GETCURSEL, 0, 0, ThunderRT6ListBox1, A ;Posicion de la fila seleccionada
SendMessage, LB_GETTEXT, %ErrorLevel%, &next, ThunderRT6ListBox1, A ;Texto de la fila seleccionada
next := SubStr(next, 1,30)

Control,Check,, Button6, A
WinWaitActive, BTS Bioengineering - EliteClinic ahk_class ThunderRT6MDIForm
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
if Control.GetFocus() = "ThunderRT6TextBox1"
{
	SendInput {Space}
}
else
{
	SendMessage, LB_GETCURSEL, 0, 0, ThunderRT6ListBox1, A ;Posicion de la fila seleccionada
	SendMessage, LB_GETTEXT, %ErrorLevel%, &next, ThunderRT6ListBox1, A ;Texto de la fila seleccionada
	next := SubStr(next, 1,30)
	
	Control,Check,, Button6, A
	Loop
	{
			if ExisteTrialProcessing()
			{
				break
			}
	}
	WinActivate, BTS Bioengineering - EliteClinic ahk_class ThunderRT6MDIForm
	ControlFocus, Button15, A
}
Return

f::
if Control.GetFocus() = "ThunderRT6TextBox1"
{
	SendInput f
}
else
{
	if next
	{
		ante := next
		next =
		goto va
	}

	SendMessage, LB_GETCURSEL, 0, 0, ThunderRT6ListBox1, A ;Posicion de la fila seleccionada
	SendMessage, LB_GETTEXT, %ErrorLevel%, &ante, ThunderRT6ListBox1, A ;Texto de la fila seleccionada
	ante := SubStr(ante, 1,30)
	
	va:
	ControlGet, es, Checked, , ThunderRT6CheckBox1, A
	if es
	{
		Control, UnCheck, , ThunderRT6CheckBox1, A
	}
	Else
	{
		Control, Check, , ThunderRT6CheckBox1, A
	}

	Sleep 1

	SendMessage, LB_FINDSTRING, -1, &ante, ThunderRT6ListBox1, A ;Busco el texto
	;MsgBox, %ErrorLevel%
	if ErrorLevel = 4294967295
	{
		next := ante
		;MsgBox, %ante%`n%next%
		return
	}
	SendMessage, LB_SETCURSEL, %ErrorLevel%, 0, ThunderRT6ListBox1, A ;Me muevo al encontrado
}
Return

c::
ControlGet, sel, Choice, , ThunderRT6ListBox1, A
if Control.GetFocus() = "ThunderRT6TextBox1"
{
	SendInput c
}
else if sel != ""
{
	if Control.IsEnabled("Button1")
	{
		
		Control,Check,, Button1, A
		WinWaitActive, Notas... ahk_class ThunderRT6FormDC
		ControlFocus, Button2, A
		WinWaitClose, Notas... ahk_class ThunderRT6FormDC
		ControlFocus, ThunderRT6ListBox1, A
	}
}
Return

+c::
ControlGet, sel, Choice, , ThunderRT6ListBox2, A
if Control.GetFocus() = "ThunderRT6TextBox1"
{
	SendInput c
}
else if sel != ""
{
	if Control.IsEnabled("Button3")
	{
		
		Control,Check,, Button3, A
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

w::
if Control.GetFocus() = "ThunderRT6TextBox1"
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
if Control.GetFocus() = "ThunderRT6TextBox1"
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
if Control.GetFocus() = "ThunderRT6TextBox1"
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
if Control.GetFocus() = "ThunderRT6TextBox1"
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
ControlGet, sel, Choice, , ThunderRT6ListBox2, A
if Control.GetFocus() = "ThunderRT6TextBox1"
{
	SendInput c
}
else if sel != ""
{
	if Control.IsEnabled("Button3")
	{
		
		Control,Check,, Button3, A
		WinWaitActive, Notas... ahk_class ThunderRT6FormDC
		ControlFocus, Button2, A
		WinWaitClose, Notas... ahk_class ThunderRT6FormDC
		ControlFocus, ThunderRT6ListBox2, A
	}
}
Return

+c::
ControlGet, sel, Choice, , ThunderRT6ListBox1, A
if Control.GetFocus() = "ThunderRT6TextBox1"
{
	SendInput c
}
else if sel != ""
{
	if Control.IsEnabled("Button2")
	{
		
		Control,Check,, Button2, A
		WinWaitActive, Notas... ahk_class ThunderRT6FormDC
		ControlFocus, Button2, A
		WinWaitClose, Notas... ahk_class ThunderRT6FormDC
		ControlFocus, ThunderRT6ListBox1, A
	}
}
Return

q::
if Control.GetFocus() = "ThunderRT6TextBox1"
{
	SendInput q
}
Else
{
	Control,Check,, Button5, A
}
Return

Escape::
Control,Check,, Button5, A
Return

Enter::
space::
Control,Check,, Button6, A
WinWaitActive, Select Visualization ahk_class ThunderRT6FormDC
Control, Check, , ThunderRT6CheckBox4, A
Control, Check, , ThunderRT6CheckBox3, A
Control, Choose, 3, ThunderRT6ComboBox1, A
if Control.IsEnabled("ThunderRT6CheckBox1")
{
	Control, Check, , ThunderRT6CheckBox1, A
}
ControlFocus, Button1, A
Return

RButton::
AppsKey::
MouseGetPos, , , , cont
if cont = ThunderRT6ListBox2
{
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
	idSesionNum := Chr(idSesionNum + 96)
	largo := StrLen(idpaciente)
	largo2 := 5 - largo
	equis = 
	Loop, %largo2%
	{
		equis := equis . "x"
	}
	nombreArchivo = %idpaciente%%equis%%idSesionNum%%idTrial%

	GuiContextMenu:
	ControlGet, texto, Choice, , ThunderRT6ListBox2, A
	SendMessage, LB_GETSELCOUNT, 0, 0, ThunderRT6ListBox2, A ; Chequear cuantos trials hay seleccionados
	Cantidad = %ErrorLevel%
	if %texto%
	{
		if Cantidad = 1
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
		else if Cantidad = 2
		{
			capacity := Cantidad * 4 ; 4 = size of integer
			VarSetCapacity(SelectList, capacity, 0)
			result =
			VarSetCapacity(trial1_texto,512)
			VarSetCapacity(trial2_texto,512)
			SendMessage, LB_GETSELITEMS , capacity, &SelectList, ThunderRT6ListBox2, A
		   	selPos := GetInteger(SelectList, 1)
			SendMessage, LB_GETTEXT, %selPos%, &trial1_texto, ThunderRT6ListBox2, A
			selPos := GetInteger(SelectList, 2)
			SendMessage, LB_GETTEXT, %selPos%, &trial2_texto, ThunderRT6ListBox2, A
			
			startId := RegExMatch(trial1_texto, "\d\w|__")
			idTrial1 := SubStr(trial1_texto, startId,2)
			estudio1 = %idPaciente%%equis%%idSesionNum%%idTrial1%

			startId := RegExMatch(trial2_texto, "\d\w|__")
			idTrial2 := SubStr(trial2_texto, startId,2)
			estudio2 = %idPaciente%%equis%%idSesionNum%%idTrial2%
			Menu, merge, Add, Intercambiar %estudio1% por %estudio2%, Intercambiar
			Menu, merge, Show
			Menu, merge, DeleteAll
		}
	}
	Return

	Intercambiar:
	MsgBox,52,Intercambiar estudios, Intercambiar %estudio1%`n por %estudio2%?
	IfMsgBox, Yes
	{
		IfNotExist, %ProgramFilesWin%\BTS Bioengineering\Gaitel30\Protocol\Data\SWAP
		{
			FileCreateDir, %ProgramFilesWin%\BTS Bioengineering\Gaitel30\Protocol\Data\SWAP
		}
		FileMove, %ProgramFilesWin%\BTS Bioengineering\Gaitel30\Protocol\Data\%estudio1%.* ,%ProgramFilesWin%\BTS Bioengineering\Gaitel30\Protocol\Data\SWAP\%estudio2%.*
		If ErrorLevel
		{
			MsgBox, 16, Error, Error al mover %ErrorLevel% archivos de Data\%estudio1% a Data\SWAP\%estudio2%
			Return
		}
		FileMove, %ProgramFilesWin%\BTS Bioengineering\Gaitel30\Protocol\Data\%estudio2%.* ,%ProgramFilesWin%\BTS Bioengineering\Gaitel30\Protocol\Data\%estudio1%.*
		If ErrorLevel
		{
			MsgBox, 16, Error, Error al mover %ErrorLevel% archivos de Data\%estudio2% a Data\%estudio1%
			Return
		}		
		FileMove, %ProgramFilesWin%\BTS Bioengineering\Gaitel30\Protocol\Data\SWAP\%estudio2%.* ,%ProgramFilesWin%\BTS Bioengineering\Gaitel30\Protocol\Data\%estudio2%.*
		If ErrorLevel
		{
			MsgBox, 16, Error, Error al mover %ErrorLevel% archivos de Data\SWAP\%estudio2% a Data\%estudio2%
			Return
		}
	}
	Return

	Cinematica:
	Control,Check,, Button6, A
	WinWaitActive, Select Visualization ahk_class ThunderRT6FormDC
	Control,Check,, Button1, A
	WinMenuSelectItem, BTS Bioengineering - EliteClinic ahk_class ThunderRT6MDIForm, , Reporte, Report
	WinWaitActive, Informe ahk_class ThunderRT6FormDC
	Control,Check,,ThunderRT6CheckBox2
	Control,Choose,8,ThunderRT6ComboBox1
	ControlSetText, ThunderRT6TextBox2, ES_km
	Control,Check,, ThunderRT6CommandButton3, A
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
	Control,Check,, Button6, A
	WinWaitActive, Select Visualization ahk_class ThunderRT6FormDC
	Control,Check,, Button1, A
	WinMenuSelectItem, BTS Bioengineering - EliteClinic ahk_class ThunderRT6MDIForm, , Reporte, Report
	WinWaitActive, Informe ahk_class ThunderRT6FormDC
	Control,Check,,ThunderRT6CheckBox2
	Control,Choose,8,ThunderRT6ComboBox1
	ControlSetText, ThunderRT6TextBox2, ES_kt
	Control,Check,, ThunderRT6CommandButton3, A
	Return

	EMG8:
	nombreArchivo := nombreArchivo . "_EMG8"
	Control,Check,, Button6, A
	WinWaitActive, Select Visualization ahk_class ThunderRT6FormDC
	Control,Check,, Button1, A
	WinMenuSelectItem, BTS Bioengineering - EliteClinic ahk_class ThunderRT6MDIForm, , Reporte, Report
	WinWaitActive, Informe ahk_class ThunderRT6FormDC
	ControlSetText, ThunderRT6TextBox2, ES_km8e
	Control,Check,, ThunderRT6CommandButton3, A
	Return

	EMG4:
	nombreArchivo := nombreArchivo . "_EMG4"
	Control,Check,, Button6, A
	WinWaitActive, Select Visualization ahk_class ThunderRT6FormDC
	Control,Check,, Button1, A
	WinMenuSelectItem, BTS Bioengineering - EliteClinic ahk_class ThunderRT6MDIForm, , Reporte, Report
	WinWaitActive, Informe ahk_class ThunderRT6FormDC
	ControlSetText, ThunderRT6TextBox2, ES_km4e
	Control,Check,, ThunderRT6CommandButton3, A
	Return

	EMG5:
	nombreArchivo := nombreArchivo . "_EMG5"
	Control,Check,, Button6, A
	WinWaitActive, Select Visualization ahk_class ThunderRT6FormDC
	Control,Check,, Button1, A
	WinMenuSelectItem, BTS Bioengineering - EliteClinic ahk_class ThunderRT6MDIForm, , Reporte, Report
	WinWaitActive, Informe ahk_class ThunderRT6FormDC
	ControlSetText, ThunderRT6TextBox2, ES_km5e
	Control,Check,, ThunderRT6CommandButton3, A
	Return

	EMG4L:
	nombreArchivo := nombreArchivo . "_EMG4L"
	Control,Check,, Button6, A
	WinWaitActive, Select Visualization ahk_class ThunderRT6FormDC
	Control,Check,, Button1, A
	WinMenuSelectItem, BTS Bioengineering - EliteClinic ahk_class ThunderRT6MDIForm, , Reporte, Report
	WinWaitActive, Informe ahk_class ThunderRT6FormDC
	ControlSetText, ThunderRT6TextBox2, ES_km4el
	Control,Check,, ThunderRT6CommandButton3, A
	Return

	EMG4R:
	nombreArchivo := nombreArchivo . "_EMG4R"
	Control,Check,, Button6, A
	WinWaitActive, Select Visualization ahk_class ThunderRT6FormDC
	Control,Check,, Button1, A
	WinMenuSelectItem, BTS Bioengineering - EliteClinic ahk_class ThunderRT6MDIForm, , Reporte, Report
	WinWaitActive, Informe ahk_class ThunderRT6FormDC
	ControlSetText, ThunderRT6TextBox2, ES_km4er
	Control,Check,, ThunderRT6CommandButton3, A
	Return

	EMG5R:
	nombreArchivo := nombreArchivo . "_EMG5R"
	Control,Check,, Button6, A
	WinWaitActive, Select Visualization ahk_class ThunderRT6FormDC
	Control,Check,, Button1, A
	WinMenuSelectItem, BTS Bioengineering - EliteClinic ahk_class ThunderRT6MDIForm, , Reporte, Report
	WinWaitActive, Informe ahk_class ThunderRT6FormDC
	ControlSetText, ThunderRT6TextBox2, ES_km5er
	Control,Check,, ThunderRT6CommandButton3, A
	Return

	EMG5L:
	nombreArchivo := nombreArchivo . "_EMG5L"
	Control,Check,, Button6, A
	WinWaitActive, Select Visualization ahk_class ThunderRT6FormDC
	Control,Check,, Button1, A
	WinMenuSelectItem, BTS Bioengineering - EliteClinic ahk_class ThunderRT6MDIForm, , Reporte, Report
	WinWaitActive, Informe ahk_class ThunderRT6FormDC
	ControlSetText, ThunderRT6TextBox2, ES_km5el
	Control,Check,, ThunderRT6CommandButton3, A
	Return

	Vastos:
	nombreArchivo := nombreArchivo . "_Vastos"
	Control,Check,, Button6, A
	WinWaitActive, Select Visualization ahk_class ThunderRT6FormDC
	Control,Check,, Button1, A
	WinMenuSelectItem, BTS Bioengineering - EliteClinic ahk_class ThunderRT6MDIForm, , Reporte, Report
	WinWaitActive, Informe ahk_class ThunderRT6FormDC
	ControlSetText, ThunderRT6TextBox2, ES_km2e
	Control,Check,, ThunderRT6CommandButton3, A
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

AdquireBarStanding("Rodilla derecha")
return

#2::
SetLastMode("Normal")

AdquireBarStanding("Tobillo derecho")
return

#3::
SetLastMode("Normal")

AdquireBarStanding("Rodilla izquierda")
return

#4::
SetLastMode("Normal")

AdquireBarStanding("Tobillo izquierdo")
return

#|::
SetLastMode("Normal")

AdquireStanding()
return

#space::
SetLastMode("Normal")
WinMenuSelectItem, BTS Bioengineering - EliteClinic ahk_class ThunderRT6MDIForm, , 1& , 1&, 1&
WinWaitActive, New Trial ahk_class ThunderRT6FormDC
texto := ReturnFirstLineClipbrd()
ControlSetText, ThunderRT6TextBox4, %texto%
Control,Check,, Button4, A
WinWaitActive, New Trial ahk_class #32770
Control,Check,, Button1, A
WinWaitActive, Acq. Manager - Setup: SetupACQ ahk_class TDaqDlg
Control.WaitEnabled("TBitBtn5")
Control,Check,, TBitBtn5, A
Control,Check,, TBitBtn8, A
Input,tecla,,{space}{enter}
Control,Check,, TBitBtn7, A
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

Input,tecla,,{space}{enter}
Control,Check,, TButton1, A
WinWaitActive, New Trial ahk_class #32770
Control,Check,, Button1, A
WinWaitActive, Trial classification: ahk_class ThunderRT6FormDC
ControlSetText, ThunderRT6TextBox1, %texto%
Control,Check,, Button1, A
WinWaitActive, Trial classification: ahk_class #32770
Control,Check,, Button1, A
WinWaitActive, Trial classification: C:\Archivos de programa\BTS ahk_class #32770
Control,Check,, Button2, A
return

#e::
if not ColorChoice or ColorChoice = ""
{
	Gui, Add, Text, , Seleccione el tipo de EMG
	Gui, Add, ListBox, R8 gColorChoice vColorChoice Choose1, ||EMG8E|EMG4E|EMG4L|EMG4R|EMG5L|EMG5R|Vastos|
	Gui, Show
	Return

	ColorChoice:
	Gui, Submit
	WinActivate, BTS Bioengineering - EliteClinic ahk_class ThunderRT6MDIForm
	SetLastMode(ColorChoice)
	Gui, Destroy
	return
}

WinMenuSelectItem, BTS Bioengineering - EliteClinic ahk_class ThunderRT6MDIForm, , 1& , 1&, 1&
WinWaitActive, New Trial ahk_class ThunderRT6FormDC
texto := ColorChoice
ControlSetText, ThunderRT6TextBox4, %texto%
Control,Check,, Button4, A
WinWaitActive, New Trial ahk_class #32770
Control,Check,, Button1, A
WinWaitActive, Acq. Manager - Setup: SetupACQ ahk_class TDaqDlg
Loop
{
	if Control.IsEnabled("TBitBtn5")
	{
		Break
	}
}
Control,Check,, TBitBtn5, A
KeyWait, Space, D
Control,Check,, TBitBtn8, A
KeyWait, Space, U
Control,Check,, TBitBtn7, A
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

Input,tecla,,{space}{enter}
Control,Check,, TButton1, A
return

tab::
{
	if ExisteTrialProcessing()
	{
		
		ControlGetFocus, ptab, A
		if ptab = Button15
		{
			ControlFocus, Button17, A
		}
		else if ptab = Button17
		{
			ControlFocus, Button16, A
		}
		else if ptab = Button16
		{
			ControlFocus, Button15, A
		}
	}
	Else
	{
		SendInput, {tab}
	}
}
Return

r::

WinMenuSelectItem, BTS Bioengineering - EliteClinic ahk_class ThunderRT6MDIForm, , 1& , 5&
WinWaitActive, Select trials to process ahk_class ThunderRT6FormDC

if next
{
	ante := next
	next =
	goto va2
}

SendMessage, LB_GETCURSEL, 0, 0, ThunderRT6ListBox1, A ;Posicion de la fila seleccionada
SendMessage, LB_GETTEXT, %ErrorLevel%, &ante, ThunderRT6ListBox1, A ;Texto de la fila seleccionada
ante := SubStr(ante, 1,30)

va2:
ControlGet, es, Checked, , ThunderRT6CheckBox1, A
if es
{
	Control, UnCheck, , ThunderRT6CheckBox1, A
}
Else
{
	Control, Check, , ThunderRT6CheckBox1, A
}
Sleep 1

SendMessage, LB_FINDSTRING, -1, &ante, ThunderRT6ListBox1, A ;Busco el texto
;MsgBox, %ErrorLevel%
if ErrorLevel = 4294967295
{
	next := ante
	;MsgBox, %ante%`n%next%
	return
}
SendMessage, LB_SETCURSEL, %ErrorLevel%, 0, ThunderRT6ListBox1, A ;Me muevo al encontrado
Return

t::

WinMenuSelectItem, BTS Bioengineering - EliteClinic ahk_class ThunderRT6MDIForm, , 2& , 1&
WinWaitActive, Select Trials ahk_class ThunderRT6FormDC
ControlFocus, ThunderRT6ListBox2, A
Return

n::

WinMenuSelectItem, BTS Bioengineering - EliteClinic ahk_class ThunderRT6MDIForm, , 1& , 1& , 3&
WinWaitActive, New Patient ahk_class ThunderRT6FormDC
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
	WinMenuSelectItem, BTS Bioengineering - EliteClinic ahk_class ThunderRT6MDIForm, , 6& , 2&

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


	OldMatchMode := A_TitleMatchMode
	SetTitleMatchMode, RegEx
	ControlGet, Handle2D, Hwnd, , \s3D$
	ControlGetPos, X, Y, , , , ahk_id %Handle2D%
	X := X + 80
	Y := Y + 30
	Yf := Y - 500
	MouseGetPos, Xo, Yo
	Loop, 8
	{
		MouseClickDrag, Right, %X%, %Y%, %X%, %Yf%, 0
	}
		MouseMove, %Xo%, %Yo%, 0
		SetTitleMatchMode, %OldMatchMode%

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
	;AutoAdjustScroll()
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
	SendInput {Down}
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
	SendInput {Up}
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
Escape::
if ExisteBarra()
{
	OldMatchMode := A_TitleMatchMode
	SetTitleMatchMode, RegEx
	ControlGet, Handle3D, Hwnd, , (2|3)D$, A
	ControlFocus, , %Handle3D%, A
	SendInput ^{F4}
	SetTitleMatchMode, %OldMatchMode%
}
else if ExisteTrialProcessing()
{
	Control,Check,, Button16, A
}
Return

z::
if ExisteBarra()
{
	;FindFirstCyan()
}
else
{
	Gui, Add, Text, , Seleccione el tipo de EMG
	Gui, Add, ListBox,% "R8" "gColorChoices" "vColorChoice" "Choose".ColorChoice, ||EMG8E|EMG4E|EMG4L|EMG4R|EMG5L|EMG5R|Vastos|
	Gui, Add, Text, , % "Portapapeles: " . ReturnFirstLineClipbrd()
	Gui, Show
	Return

	ColorChoices:
	Gui, Submit
	WinActivate, BTS Bioengineering - EliteClinic ahk_class ThunderRT6MDIForm
	SetLastMode(ColorChoice)
	Gui, Destroy
	Return
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

ExisteBarra(){

	if Control.Exists("ThunderRT6ComboBox1","BTS Bioengineering - EliteClinic ahk_class ThunderRT6MDIForm")
	{
		if Control.IsVisible("ThunderRT6ComboBox1","BTS Bioengineering - EliteClinic ahk_class ThunderRT6MDIForm")
		{
			Return true
		}
	}
	return False
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
	ProgramFilesWin := GetProgramFiles()
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
	else if mode = EMG5R
	{
		FileDelete, %ProgramFilesWin%\BTS Bioengineering\Gaitel30\Protocol\Setup\ACQLAST.MOD
		FileAppend, 8TV2PL5R.ACQ, %ProgramFilesWin%\BTS Bioengineering\Gaitel30\Protocol\Setup\ACQLAST.MOD
	}
	else if mode = EMG5L
	{
		FileDelete, %ProgramFilesWin%\BTS Bioengineering\Gaitel30\Protocol\Setup\ACQLAST.MOD
		FileAppend, 8TV2PL5L.ACQ, %ProgramFilesWin%\BTS Bioengineering\Gaitel30\Protocol\Setup\ACQLAST.MOD
	}
	else
	{
		FileDelete, %ProgramFilesWin%\BTS Bioengineering\Gaitel30\Protocol\Setup\ACQLAST.MOD
		FileAppend, 8TV2PLA.ACQ, %ProgramFilesWin%\BTS Bioengineering\Gaitel30\Protocol\Setup\ACQLAST.MOD
	}
}

AdquireBarStanding(texto){
	WinMenuSelectItem, BTS Bioengineering - EliteClinic ahk_class ThunderRT6MDIForm, , 1& , 1&, 1&
	WinWaitActive, New Trial ahk_class ThunderRT6FormDC
	ControlSetText, ThunderRT6TextBox4, %texto%
	Control,Check,, Button4, A
	WinWaitActive, New Trial ahk_class #32770
	Control,Check,, Button1, A
	WinWaitActive, Acq. Manager - Setup: SetupACQ ahk_class TDaqDlg
	Control.WaitEnabled("TBitBtn5")
	Control,Check,, TBitBtn5, A
	Control,Check,, TBitBtn8, A
	Sleep, 4000
	Control,Check,, TBitBtn7, A
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
	Control,Check,, TButton1, A
	WinWaitActive, New Trial ahk_class #32770
	Control,Check,, Button1, A
	WinWaitActive, Trial classification: ahk_class ThunderRT6FormDC
	Control, Check, , AfxWnd406, A
	ControlSetText, ThunderRT6TextBox1, %texto%
	Control,Check,, Button1, A
	WinWaitActive, Trial classification: ahk_class #32770
	Control,Check,, Button1, A
	WinWaitActive, Trial classification: C:\Archivos de programa\BTS ahk_class #32770
	Control,Check,, Button1, A
}

AdquireStanding(){
	WinMenuSelectItem, BTS Bioengineering - EliteClinic ahk_class ThunderRT6MDIForm, , 1& , 1&, 1&
	WinWaitActive, New Trial ahk_class ThunderRT6FormDC
	ControlSetText, ThunderRT6TextBox4, Standing
	Control,Check,, Button4, A
	WinWaitActive, New Trial ahk_class #32770
	Control,Check,, Button1, A
	WinWaitActive, Acq. Manager - Setup: SetupACQ ahk_class TDaqDlg
	Control.WaitEnabled("TBitBtn5")
	Control,Check,, TBitBtn5, A
	MsgBox, 1, Captura de peso del paciente, Subir el paciente a la plataforma 1 y aceptar
	IfMsgBox OK
	{
		Control,Check,, TBitBtn3, A
		Input,tecla,,{space}{enter}
		Control,Check,, TBitBtn2, A
		Control,Check,, Confirm, A
		Control,Check,, TBitBtn9, A
		Sleep, 4000
		Control,Check,, TBitBtn8, A
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
		Control,Check,, TButton1, A
		WinWaitActive, New Trial ahk_class #32770
		Control,Check,, Button1, A
		WinWaitActive, Trial classification: ahk_class ThunderRT6FormDC
		Control, Check, , AfxWnd407, A
		ControlSetText, ThunderRT6TextBox1, Standing
		Control,Check,, Button1, A
		WinWaitActive, Trial classification: ahk_class #32770
		Control,Check,, Button1, A
		WinWaitActive, Trial classification: C:\Archivos de programa\BTS ahk_class #32770
		Control,Check,, Button1, A
	}
	IfMsgBox Cancel
	{
		Control,Check,, TBitBtn6, A
	}
}