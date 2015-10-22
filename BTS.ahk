#SingleInstance, force
#Include, Funciones.ahk
#Persistent
#Hotstring NoMouse

Menu, 2:TrialSelectionContextualMenu, Add, 1 Cinematica, Cinematica
Menu, 2:TrialSelectionContextualMenu, Add, 2 Cinetica, Cinetica
Menu, EMG, Add, 1 EMG8, EMG8
Menu, EMG, Add, 2 EMG4, EMG4
Menu, EMG, Add, 3 EMG5, EMG5
Menu, EMG, Add, 4 EMG2L, EMG2L
Menu, EMG, Add, 5 EMG2R, EMG2R
Menu, EMG, Add, 6 EMG4L, EMG4L
Menu, EMG, Add, 7 EMG4R, EMG4R
Menu, EMG, Add, 8 EMG5L, EMG5L
Menu, EMG, Add, 9 EMG5R, EMG5R
Menu, EMG, Add, 10 Vastos, Vastos

Menu, 2:TrialSelectionContextualMenu, Add, 3 EMG, :EMG
Menu, 2:TrialSelectionContextualMenu, Add, 4 Abrir archivo..., AbrirArchivo
Menu, 2:TrialSelectionContextualMenu, Add, 5 Interpolar, 2:Interpolar

Menu, 1:TrialProcessingContextualMenu, Add, 1 Interpolar, 1:Interpolar

SetTimer, AlertaOrtesis, 420000

ProgramFilesWin := GetProgramFiles()

#s::Suspend ;Inicio + S --> Deshabilita/Habilita todos los atajos (menos a sí mismo)

#IfWinActive, Nueva  Sesión ahk_class ThunderRT6FormDC ahk_exe GaitEl30.exe
SetTimer, AlertaOrtesis, 600000

#IfWinActive, New Patient ahk_class ThunderRT6FormDC ahk_exe GaitEl30.exe
SetTimer, AlertaOrtesis, 600000

#IfWinActive, Select Visualization ahk_class ThunderRT6FormDC
f::
Control, Check, , ThunderRT6CheckBox4, A
Control, Check, , ThunderRT6CheckBox3, A
Control, Choose, 3, ThunderRT6ComboBox1, A
if Control.IsEnabled("ThunderRT6CheckBox1")
{
	Control, Check, , ThunderRT6CheckBox1, A
}
Control.Focus("Button1")
return

q::
Escape::
Control, Check, , Button2, A
Return

#IfWinActive, Data Computing ahk_class #32770
space::
Enter::
Control,Check,, Button1, A
WinWaitActive, BTS Bioengineering - EliteClinic ahk_class ThunderRT6MDIForm
if ExisteTrialProcessing()
{
	Control,Check,, Button16, A
}
OpenTrialProcessing()
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
	ControlSetText, ThunderRT6TextBox6, % TrialActual.nombreArchivo
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
ControlSetText, Edit1, % "C:\Users\marcha\Documents\pdf\" . TrialActual.nombreArchivo . ".pdf", A

;**************************************************************
; Atajos de la ventana de trackeo ("Select trials to process")
;**************************************************************
#IfWinActive, Select trials to process ahk_class ThunderRT6FormDC

w::
if Control.GetFocus() = "ThunderRT6TextBox1"
{
	SendInput w
}
else
{
	Control.Focus("ThunderRT6ListBox1")
	SendInput {Up}
	t := GetCurrentTrial("ThunderRT6ListBox3","ThunderRT6ListBox2","ThunderRT6ListBox1")
	SetLastTrialAccesed(t)
}
return

+w::
Control.Focus("ThunderRT6ListBox3")
SendInput {Up}
Return

Up::
Control.Focus("ThunderRT6ListBox1")
SendInput {Up}
return

s::
if Control.GetFocus() = "ThunderRT6TextBox1"
{
	SendInput s
}
else
{
	Control.Focus("ThunderRT6ListBox1")
	SendInput {Down}
	t := GetCurrentTrial("ThunderRT6ListBox3","ThunderRT6ListBox2","ThunderRT6ListBox1")
	SetLastTrialAccesed(t)
}
return

+s::
Control.Focus("ThunderRT6ListBox3")
SendInput {Down}
Return

Down::
Control.Focus("ThunderRT6ListBox1")
SendInput {Down}
return

a::
if Control.GetFocus() = "ThunderRT6TextBox1"
{
	SendInput a
}
else
{
	Control.Focus("ThunderRT6ListBox2")
	SendInput {Left}
	GenerarInfoSesion()
}
return

Left::
Control.Focus("ThunderRT6ListBox2")
SendInput {Up}
GenerarInfoSesion()
return

d::
if Control.GetFocus() = "ThunderRT6TextBox1"
{
	SendInput d
}
else
{
	Control.Focus("ThunderRT6ListBox2")
	SendInput {Down}
	GenerarInfoSesion()
}
return

Right::
Control.Focus("ThunderRT6ListBox2")
SendInput {Down}
GenerarInfoSesion()
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
Control,Check,, Button6, A
WinWaitActive, BTS Bioengineering - EliteClinic ahk_class ThunderRT6MDIForm
Loop
{
		if ExisteTrialProcessing()
		{
			Break
		}
}
Control.Focus("Button15")
Return

Space::
if Control.GetFocus() = "ThunderRT6TextBox1"
{
	SendInput {Space}
}
else
{
	Control,Check,, Button6, A
	Loop
	{
			if ExisteTrialProcessing()
			{
				break
			}
	}
	WinActivate, BTS Bioengineering - EliteClinic ahk_class ThunderRT6MDIForm
	Control.Focus("Button15")
}
Return

f::
if Control.GetFocus() = "ThunderRT6TextBox1"
{
	SendInput f
}
else
{
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
		Control.Focus("Button2")
		WinWaitClose, Notas... ahk_class ThunderRT6FormDC
		Control.Focus("ThunderRT6ListBox1")
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
		Control.Focus("Button2")
		WinWaitClose, Notas... ahk_class ThunderRT6FormDC
		Control.Focus("ThunderRT6ListBox2")
	}
}
Return

^f::
Control.Focus("ThunderRT6TextBox1")
Return

;^r::
;Control.Focus("ThunderRT6ListBox1")
;ControlGet

RButton::
AppsKey::
MouseGetPos, , , , cont
if cont = ThunderRT6ListBox1
{
	TrialActual := GetCurrentTrial("ThunderRT6ListBox3","ThunderRT6ListBox2","ThunderRT6ListBox1")

	1:GuiContextMenu:
	ControlGet, texto, Choice, , ThunderRT6ListBox2, A
	SendMessage, LB_GETSELCOUNT, 0, 0, ThunderRT6ListBox2, A ; Chequear cuantos trials hay seleccionados
	Cantidad = %ErrorLevel%
	if %texto%
	{
		if (FileExist(ProgramFilesWin . "\BTS Bioengineering\Gaitel30\Protocol\Data\" . TrialActual.nombreArchivo . ".raw"))
		{
			Menu, 2:TrialSelectionContextualMenu, Enable, 5 Interpolar
		}
		Else
		{
			Menu, 2:TrialSelectionContextualMenu, Disable, 5 Interpolar
		}
		
		Menu, 1:TrialProcessingContextualMenu, Show
	}
	return

	1:Interpolar:
	Sleep 20
	FileCopy % ProgramFilesWin . "\BTS Bioengineering\Gaitel30\Protocol\Data\" . TrialActual.nombreArchivo . ".RAW", % ProgramFilesWin . "\BTS Bioengineering\Gaitel30\Protocol\Data\" . TrialActual.nombreArchivo . "-" . A_Now . ".RAW.bkp"
	FileMove % ProgramFilesWin . "\BTS Bioengineering\Gaitel30\Protocol\Data\" . TrialActual.nombreArchivo . ".RAW", % ProgramFilesWin . "\BTS Bioengineering\Gaitel30\Exe\" . TrialActual.nombreArchivo . ".RAW"
	RunWait % "INTERP2.EXE " . TrialActual.nombreArchivo . ".RAW INTER.RAW 100", C:\Archivos de programa\BTS Bioengineering\Gaitel30\Exe\
	FileMove % ProgramFilesWin . "\BTS Bioengineering\Gaitel30\Exe\INTER.RAW", % ProgramFilesWin . "\BTS Bioengineering\Gaitel30\Protocol\Data\" . TrialActual.nombreArchivo . ".RAW",1
	FileDelete % ProgramFilesWin . "\BTS Bioengineering\Gaitel30\Exe\" . TrialActual.nombreArchivo . ".RAW"
	Return
}

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
	Control.Focus("ThunderRT6ListBox2")
	SendInput {Up}
}
return

+w::
Control.Focus("ThunderRT6ListBox3")
SendInput {Up}
Return

Up::
Control.Focus("ThunderRT6ListBox2")
SendInput {Up}
return

s::
if Control.GetFocus() = "ThunderRT6TextBox1"
{
	SendInput s
}
else
{
	Control.Focus("ThunderRT6ListBox2")
	SendInput {Down}
}
return

+s::
Control.Focus("ThunderRT6ListBox3")
SendInput {Down}
Return

Down::
Control.Focus("ThunderRT6ListBox2")
SendInput {Down}
return

a::
if Control.GetFocus() = "ThunderRT6TextBox1"
{
	SendInput a
}
else
{
	Control.Focus("ThunderRT6ListBox1")
	SendInput {Left}
}
return

Left::
Control.Focus("ThunderRT6ListBox1")
SendInput {Up}
return

d::
if Control.GetFocus() = "ThunderRT6TextBox1"
{
	SendInput d
}
else
{
	Control.Focus("ThunderRT6ListBox1")
	SendInput {Right}
}
return

Right::
Control.Focus("ThunderRT6ListBox1")
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
		Control.Focus("Button2")
		WinWaitClose, Notas... ahk_class ThunderRT6FormDC
		Control.Focus("ThunderRT6ListBox2")
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
		Control.Focus("Button2")
		WinWaitClose, Notas... ahk_class ThunderRT6FormDC
		Control.Focus("ThunderRT6ListBox1")
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

space::
if Control.GetFocus() = "ThunderRT6TextBox1"
{
	SendInput {Space}
}
Else
{
	Control,Check,, Button6, A
	WinWaitActive, Select Visualization ahk_class ThunderRT6FormDC
	Control, Check, , ThunderRT6CheckBox4, A
	Control, Check, , ThunderRT6CheckBox3, A
	Control, Choose, 3, ThunderRT6ComboBox1, A
	if Control.IsEnabled("ThunderRT6CheckBox1")
	{
		Control, Check, , ThunderRT6CheckBox1, A
	}
	Control.Focus("Button1")
}
Return

Enter::
Control,Check,, Button6, A
WinWaitActive, Select Visualization ahk_class ThunderRT6FormDC
Control, Check, , ThunderRT6CheckBox4, A
Control, Check, , ThunderRT6CheckBox3, A
Control, Choose, 3, ThunderRT6ComboBox1, A
if Control.IsEnabled("ThunderRT6CheckBox1")
{
	Control, Check, , ThunderRT6CheckBox1, A
}
Control.Focus("Button1")
Return

RButton::
AppsKey::
MouseGetPos, , , , cont
if cont = ThunderRT6ListBox2
{
	TrialActual := GetCurrentTrial("ThunderRT6ListBox3","ThunderRT6ListBox1","ThunderRT6ListBox2")

	2:GuiContextMenu:
	ControlGet, texto, Choice, , ThunderRT6ListBox2, A
	SendMessage, LB_GETSELCOUNT, 0, 0, ThunderRT6ListBox2, A ; Chequear cuantos trials hay seleccionados
	Cantidad = %ErrorLevel%
	if %texto%
	{
		if Cantidad = 1
		{

			if (TrialActual.Plat1 = "N" && TrialActual.Plat2 = "N")
			{
				Menu, 2:TrialSelectionContextualMenu, Disable, 2 Cinetica
			}
			Else
			{
				Menu, 2:TrialSelectionContextualMenu, Enable, 2 Cinetica
			}

			if (FileExist(ProgramFilesWin . "\BTS Bioengineering\Gaitel30\Protocol\Data\" . TrialActual.nombreArchivo . ".emg"))
			{
				Menu, 2:TrialSelectionContextualMenu, Enable, 3 EMG
			}
			Else
			{
				Menu, 2:TrialSelectionContextualMenu, Disable, 3 EMG
			}

			if (FileExist(ProgramFilesWin . "\BTS Bioengineering\Gaitel30\Protocol\Data\" . TrialActual.nombreArchivo . ".raw"))
			{
				Menu, 2:TrialSelectionContextualMenu, Enable, 5 Interpolar
			}
			Else
			{
				Menu, 2:TrialSelectionContextualMenu, Disable, 5 Interpolar
			}

			Menu, 2:TrialSelectionContextualMenu, Show
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
			
			SelectList := 0
			
			startId := RegExMatch(trial1_texto, "\d\w|__")
			idTrial1 := SubStr(trial1_texto, startId,2)
			estudio1 := TrialActual.idPaciente . TrialActual.CantidadDeEquis . TrialActual.idSesionChar . idTrial1
			trial1_texto := 0

			startId := RegExMatch(trial2_texto, "\d\w|__")
			idTrial2 := SubStr(trial2_texto, startId,2)
			estudio2 := TrialActual.idPaciente . TrialActual.CantidadDeEquis . TrialActual.idSesionChar . idTrial2
			trial2_texto := 0
			
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
	Sleep 20
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
	Sleep 20
	if (TrialActual.Plat1 = "L" || TrialActual.Plat2 = "L")
	{
		TrialActual.nombreArchivo := TrialActual.nombreArchivo . "_izq"
	}
	if (TrialActual.Plat1 = "R" || TrialActual.Plat2 = "R")
	{
		TrialActual.nombreArchivo := TrialActual.nombreArchivo . "_der"
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
	Sleep 20
	TrialActual.nombreArchivo := TrialActual.nombreArchivo . "_EMG8"
	Control,Check,, Button6, A
	WinWaitActive, Select Visualization ahk_class ThunderRT6FormDC
	Control,Check,, Button1, A
	WinMenuSelectItem, BTS Bioengineering - EliteClinic ahk_class ThunderRT6MDIForm, , Reporte, Report
	WinWaitActive, Informe ahk_class ThunderRT6FormDC
	ControlSetText, ThunderRT6TextBox2, ES_km8e
	Control,Check,, ThunderRT6CommandButton3, A
	Return

	EMG4:
	Sleep 20
	TrialActual.nombreArchivo := TrialActual.nombreArchivo . "_EMG4"
	Control,Check,, Button6, A
	WinWaitActive, Select Visualization ahk_class ThunderRT6FormDC
	Control,Check,, Button1, A
	WinMenuSelectItem, BTS Bioengineering - EliteClinic ahk_class ThunderRT6MDIForm, , Reporte, Report
	WinWaitActive, Informe ahk_class ThunderRT6FormDC
	ControlSetText, ThunderRT6TextBox2, ES_km4e
	Control,Check,, ThunderRT6CommandButton3, A
	Return

	EMG5:
	Sleep 20
	TrialActual.nombreArchivo := TrialActual.nombreArchivo . "_EMG5"
	Control,Check,, Button6, A
	WinWaitActive, Select Visualization ahk_class ThunderRT6FormDC
	Control,Check,, Button1, A
	WinMenuSelectItem, BTS Bioengineering - EliteClinic ahk_class ThunderRT6MDIForm, , Reporte, Report
	WinWaitActive, Informe ahk_class ThunderRT6FormDC
	ControlSetText, ThunderRT6TextBox2, ES_km5e
	Control,Check,, ThunderRT6CommandButton3, A
	Return

	EMG2L:
	Sleep 20
	TrialActual.nombreArchivo := TrialActual.nombreArchivo . "_EMG2L"
	Control,Check,, Button6, A
	WinWaitActive, Select Visualization ahk_class ThunderRT6FormDC
	Control,Check,, Button1, A
	WinMenuSelectItem, BTS Bioengineering - EliteClinic ahk_class ThunderRT6MDIForm, , Reporte, Report
	WinWaitActive, Informe ahk_class ThunderRT6FormDC
	ControlSetText, ThunderRT6TextBox2, ES_km2el
	Control,Check,, ThunderRT6CommandButton3, A
	Return

	EMG2R:
	Sleep 20
	TrialActual.nombreArchivo := TrialActual.nombreArchivo . "_EMG2R"
	Control,Check,, Button6, A
	WinWaitActive, Select Visualization ahk_class ThunderRT6FormDC
	Control,Check,, Button1, A
	WinMenuSelectItem, BTS Bioengineering - EliteClinic ahk_class ThunderRT6MDIForm, , Reporte, Report
	WinWaitActive, Informe ahk_class ThunderRT6FormDC
	ControlSetText, ThunderRT6TextBox2, ES_km2er
	Control,Check,, ThunderRT6CommandButton3, A
	Return

	EMG4L:
	Sleep 20
	TrialActual.nombreArchivo := TrialActual.nombreArchivo . "_EMG4L"
	Control,Check,, Button6, A
	WinWaitActive, Select Visualization ahk_class ThunderRT6FormDC
	Control,Check,, Button1, A
	WinMenuSelectItem, BTS Bioengineering - EliteClinic ahk_class ThunderRT6MDIForm, , Reporte, Report
	WinWaitActive, Informe ahk_class ThunderRT6FormDC
	ControlSetText, ThunderRT6TextBox2, ES_km4el
	Control,Check,, ThunderRT6CommandButton3, A
	Return

	EMG4R:
	Sleep 20
	TrialActual.nombreArchivo := TrialActual.nombreArchivo . "_EMG4R"
	Control,Check,, Button6, A
	WinWaitActive, Select Visualization ahk_class ThunderRT6FormDC
	Control,Check,, Button1, A
	WinMenuSelectItem, BTS Bioengineering - EliteClinic ahk_class ThunderRT6MDIForm, , Reporte, Report
	WinWaitActive, Informe ahk_class ThunderRT6FormDC
	ControlSetText, ThunderRT6TextBox2, ES_km4er
	Control,Check,, ThunderRT6CommandButton3, A
	Return

	EMG5L:
	Sleep 20
	TrialActual.nombreArchivo := TrialActual.nombreArchivo . "_EMG5L"
	Control,Check,, Button6, A
	WinWaitActive, Select Visualization ahk_class ThunderRT6FormDC
	Control,Check,, Button1, A
	WinMenuSelectItem, BTS Bioengineering - EliteClinic ahk_class ThunderRT6MDIForm, , Reporte, Report
	WinWaitActive, Informe ahk_class ThunderRT6FormDC
	ControlSetText, ThunderRT6TextBox2, ES_km5el
	Control,Check,, ThunderRT6CommandButton3, A
	Return

	EMG5R:
	Sleep 20
	TrialActual.nombreArchivo := TrialActual.nombreArchivo . "_EMG5R"
	Control,Check,, Button6, A
	WinWaitActive, Select Visualization ahk_class ThunderRT6FormDC
	Control,Check,, Button1, A
	WinMenuSelectItem, BTS Bioengineering - EliteClinic ahk_class ThunderRT6MDIForm, , Reporte, Report
	WinWaitActive, Informe ahk_class ThunderRT6FormDC
	ControlSetText, ThunderRT6TextBox2, ES_km5er
	Control,Check,, ThunderRT6CommandButton3, A
	Return

	Vastos:
	Sleep 20
	TrialActual.nombreArchivo := TrialActual.nombreArchivo . "_Vastos"
	Control,Check,, Button6, A
	WinWaitActive, Select Visualization ahk_class ThunderRT6FormDC
	Control,Check,, Button1, A
	WinMenuSelectItem, BTS Bioengineering - EliteClinic ahk_class ThunderRT6MDIForm, , Reporte, Report
	WinWaitActive, Informe ahk_class ThunderRT6FormDC
	ControlSetText, ThunderRT6TextBox2, ES_km2e
	Control,Check,, ThunderRT6CommandButton3, A
	Return

	AbrirArchivo:
	Sleep 20
	if (FileExist(ProgramFilesWin . "\BTS Bioengineering\Gaitel30\Protocol\Data\" . TrialActual.nombreArchivo . ".ric"))
	{
		Run % "explorer.exe /select," . """" . ProgramFilesWin . "\BTS Bioengineering\Gaitel30\Protocol\Data\" . TrialActual.nombreArchivo . ".ric"""
	}
	else if (FileExist(ProgramFilesWin . "\BTS Bioengineering\Gaitel30\Protocol\Data\" . TrialActual.nombreArchivo . ".RAW"))
	{
		Run % "explorer.exe /select," . """" . ProgramFilesWin . "\BTS Bioengineering\Gaitel30\Protocol\Data\" . TrialActual.nombreArchivo . ".RAW"""
	}
	else if (FileExist(ProgramFilesWin . "\BTS Bioengineering\Gaitel30\Protocol\Data\" . TrialActual.nombreArchivo . ".dbt"))
	{
		Run % "explorer.exe /select," . """" . ProgramFilesWin . "\BTS Bioengineering\Gaitel30\Protocol\Data\" . TrialActual.nombreArchivo . ".dbt"""
	}
	Return

	2:Interpolar:
	Sleep 20
	FileCopy % ProgramFilesWin . "\BTS Bioengineering\Gaitel30\Protocol\Data\" . TrialActual.nombreArchivo . ".RAW", % ProgramFilesWin . "\BTS Bioengineering\Gaitel30\Protocol\Data\" . TrialActual.nombreArchivo . "-" . A_Now . ".RAW.bkp"
	FileMove % ProgramFilesWin . "\BTS Bioengineering\Gaitel30\Protocol\Data\" . TrialActual.nombreArchivo . ".RAW", % ProgramFilesWin . "\BTS Bioengineering\Gaitel30\Exe\" . TrialActual.nombreArchivo . ".RAW"
	RunWait % "INTERP2.EXE " . TrialActual.nombreArchivo . ".RAW INTER.RAW 100", C:\Archivos de programa\BTS Bioengineering\Gaitel30\Exe\
	FileMove % ProgramFilesWin . "\BTS Bioengineering\Gaitel30\Exe\INTER.RAW", % ProgramFilesWin . "\BTS Bioengineering\Gaitel30\Protocol\Data\" . TrialActual.nombreArchivo . ".RAW",1
	FileDelete % ProgramFilesWin . "\BTS Bioengineering\Gaitel30\Exe\" . TrialActual.nombreArchivo . ".RAW"
	Return

}
Else
{
	Return
}

^f::
Control.Focus("ThunderRT6TextBox1")
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
	Gui, Add, ListBox, R10 gColorChoice vColorChoice Choose1, ||EMG8E|EMG4E|EMG4L|EMG4R|EMG5L|EMG5R|EMG2L|EMG2R|Vastos|
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
		
		ptab := Control.GetFocus()
		if ptab = Button15
		{
			Control.Focus("Button17")
		}
		else if ptab = Button17
		{
			Control.Focus("Button16")
		}
		else if ptab = Button16
		{
			Control.Focus("Button15")
		}
	}
	Else
	{
		SendInput, {tab}
	}
}
Return

r::
t := GetLastTrialAccesed()
;MsgBox, % """" . t.idSesionNum . """"
WinMenuSelectItem, BTS Bioengineering - EliteClinic ahk_class ThunderRT6MDIForm, , 1& , 5&
WinWaitActive, Select trials to process ahk_class ThunderRT6FormDC
Sleep 100
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

GoToTrial("ThunderRT6ListBox3","ThunderRT6ListBox2","ThunderRT6ListBox1",t)
GenerarInfoSesion()
Return

t::
OpenTrialProcessing()
Return

#n::
WinMenuSelectItem, BTS Bioengineering - EliteClinic ahk_class ThunderRT6MDIForm, , 1& , 1& , 3&
WinWaitActive, New Patient ahk_class ThunderRT6FormDC
Control.Choose("ThunderRT6ComboBox1",1)
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
	MouseMove, %Xo%, %Yo%, 0
	SetTitleMatchMode, %OldMatchMode%
}
Return

v::
if ExisteBarra()
{
	WinMenuSelectItem, BTS Bioengineering - EliteClinic ahk_class ThunderRT6MDIForm, , 6& , 2&
	BlockInput On
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
	
	BlockInput Off
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
	if not ColorChoice or ColorChoice = ""
	{
		ColorChoice := ""
	}
	NumChoice := Object("", 1, "EMG8E", 2, "EMG4E", 3,"EMG4L", 4,"EMG4R", 5,"EMG5L", 6,"EMG5R", 7, "EMG2L", 8, "EMG2R", 9,"Vastos", 10)
	Gui, Add, ListBox,% "R10 gColorChoices vColorChoice Choose" . NumChoice[ColorChoice], ||EMG8E|EMG4E|EMG4L|EMG4R|EMG5L|EMG5R|EMG2L|EMG2R|Vastos|
	Gui, Add, Edit, , % "Portapapeles: " . ReturnFirstLineClipbrd()
	Gui, -MinimizeBox -MaximizeBox
	Gui, Show, AutoSize Center
	Return

	ColorChoices:
	Gui, Submit
	WinActivate, BTS Bioengineering - EliteClinic ahk_class ThunderRT6MDIForm
	SetLastMode(ColorChoice)
	Gui, Destroy
	Return

	GuiClose:
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
	else if mode = EMG2L
	{
		FileDelete, %ProgramFilesWin%\BTS Bioengineering\Gaitel30\Protocol\Setup\ACQLAST.MOD
		FileAppend, 8TV2PL2L.ACQ, %ProgramFilesWin%\BTS Bioengineering\Gaitel30\Protocol\Setup\ACQLAST.MOD
	}
	else if mode = EMG2R
	{
		FileDelete, %ProgramFilesWin%\BTS Bioengineering\Gaitel30\Protocol\Setup\ACQLAST.MOD
		FileAppend, 8TV2PL2R.ACQ, %ProgramFilesWin%\BTS Bioengineering\Gaitel30\Protocol\Setup\ACQLAST.MOD
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
	SoundBeep
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
		SoundBeep
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

GetLastTrialAccesed(){
	ProgramFilesWin := GetProgramFiles()
	FileReadLine, idPatient, %ProgramFilesWin%\BTS Bioengineering\Gaitel30\Protocol\Setup\LASTPATI.ENT, 1
	FileReadLine, idSesion, %ProgramFilesWin%\BTS Bioengineering\Gaitel30\Protocol\Setup\LASTPATI.ENT, 2
	FileReadLine, idTrial, %ProgramFilesWin%\BTS Bioengineering\Gaitel30\Protocol\Setup\LASTPATI.ENT, 3

	StringReplace , idPatient, idPatient, %A_Space%,,All
	StringReplace , idSesion, idSesion, %A_Space%,,All

	Trial := {idPaciente: idPatient, idSesionNum: idSesion, idTrial: idTrial}
	return Trial
}

GoToTrial(PatientListBox,SessionListBox,TrialListBox,Trial){
	;Control, ChooseString, % Trial.idPaciente . "  ", %PatientListBox%, A
	VarSetCapacity(resul,512)
	resul := Trial.idPaciente . A_Space
	SendMessage, 0x018F, -1, &resul, %PatientListBox%, A
	if ErrorLevel = 4294967295
	{
		MsgBox % "No se ha encontrado el idPaciente " . """" . resul . """"
		return
	}
	Else
	{
		SendMessage, 0x0186, %ErrorLevel%, 0, %PatientListBox%, A
		Sleep 10
	}
	
	resul := Trial.idSesionNum . A_Space . A_Space

	SendMessage, 0x018F, -1, &resul, %SessionListBox%, A
	if ErrorLevel = 4294967295
	{
		MsgBox % "No se ha encontrado el idSesion " . """" . resul . """"
		return
	}
	Else
	{
		afa = %ErrorLevel%
		SendMessage, 0x0186, %afa%, 0, %SessionListBox%, A
		SendMessage, 0x019E, %afa%, 0, %SessionListBox%, A
	
		ControlGet, es, Checked, , ThunderRT6CheckBox1, A
		if es
		{
			Control, UnCheck, , ThunderRT6CheckBox1, A
			Control, Check, , ThunderRT6CheckBox1, A
		}
		Else
		{
			Control, Check, , ThunderRT6CheckBox1, A
			Control, UnCheck, , ThunderRT6CheckBox1, A
		}
			Sleep 10
		}

	if (Trial.idTrial <> "___")
	{
		resul := "Normal walking      " . SubStr(Trial.idTrial,2)
	}
	else
	{
		resul := "Standing "
	}
	
	SendMessage, 0x018F, -1, &resul, %TrialListBox%, A
	if ErrorLevel = 4294967295
	{
		MsgBox % "No se ha encontrado el trial " . """" . resul . """"
		return
	}
	Else
	{
		SendMessage, 0x0186, %ErrorLevel%, 0, %TrialListBox%, A
		Sleep 10
	}
	resul := 0
	return
}

SetLastTrialAccesed(t){
	if ((t.idTrial = "") or (t.idSesionNum = "") or (t.idPaciente = ""))
	{
		return
	}
	
	ProgramFilesWin := GetProgramFiles()
	filename := ProgramFilesWin . "\BTS Bioengineering\Gaitel30\Protocol\Setup\LASTPATI.ENT"
	file := FileOpen(filename, "w")
	if !IsObject(file)
	{
		MsgBox Can't open "%filename%" for writing.
		return
	}
	if t.idTrial == "__"
	{
		trial := A_Space . t.idPaciente . A_Space . "`n" . A_Space . t.idSesionNum . A_Space . "`n" . "_" . t.idTrial . "`n"
	}
	else
	{
		trial := A_Space . t.idPaciente . A_Space . "`n" . A_Space . t.idSesionNum . A_Space . "`n" . "N" . t.idTrial . "`n"
	}
		
	;MsgBox, %trial%
	file.Write(trial)
	file.Close()
}

GetCurrentTrial(PatientListBox,SessionListBox,TrialListBox){
	ControlGet, tas, Choice, , %TrialListBox%, A
	ControlGet, tas2, Choice, , %PatientListBox%, A
	ControlGet, tas3, Choice, , %SessionListBox%, A
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
	idSesionChar := Chr(idSesionNum + 96)
	equis := CantidadDeEquis(idpaciente)
	nombreArchivo = %idpaciente%%equis%%idSesionChar%%idTrial%
	ret := {idPaciente: idpaciente, idSesionChar: idSesionChar, idSesionNum: idSesionNum, idTrial: idTrial, nombreArchivo: nombreArchivo, Plat1: P1, Plat2: P2, CantidadDeEquis: equis}
	;MsgBox, %nombreArchivo%
	Return ret
}

CantidadDeEquis(idPaciente){
	largo := StrLen(idpaciente)
	largo2 := 5 - largo
	equis = 
	Loop, %largo2%
	{
		equis := equis . "x"
	}
	return equis
}

GenerarInfoSesion(){
	ControlGet, Lista, List, , ThunderRT6ListBox1, A
	
	adquiridos := 0 , trackeados := 0 , elaborados := 0 , procesados := 0 , standing := "NO"
	izquierdas_adquiridas := 0 , izquierdas_trackeadas := 0 , izquierdas_elaboradas := 0 , izquierdas_procesadas := 0
	derechas_adquiridas := 0 , derechas_trackeadas := 0 , derechas_elaboradas := 0 , derechas_procesadas := 0
	
	Loop, Parse, Lista, `n
	{
		if InStr(A_LoopField, "Standing")
		{
			if InStr(A_LoopField, "Elaborated")
			{
				standing := "OK"
			}
		}
		else
		{
			if InStr(A_LoopField,"Acquired")
			{
				adquiridos += 1
				if EsIzquierda(A_LoopField) 
				{
					izquierdas_adquiridas += 1
				}
				if EsDerecha(A_LoopField) 
				{
					derechas_adquiridas += 1
				}
			}
			else if  InStr(A_LoopField,"Tracked")
			{
				trackeados += 1
				if EsIzquierda(A_LoopField)
				{
					izquierdas_trackeadas += 1
				}
				if EsDerecha(A_LoopField) 
				{
					derechas_trackeadas += 1
				}
			}
			else if  InStr(A_LoopField,"Elaborated")
			{
				elaborados += 1
				if EsIzquierda(A_LoopField)
				{
					izquierdas_elaboradas += 1
				}
				if EsDerecha(A_LoopField)
				{
					derechas_elaboradas += 1
				}
			}
			else if  InStr(A_LoopField,"Gait")
			{
				procesados += 1
				if EsIzquierda(A_LoopField)
				{
					izquierdas_procesadas += 1
				}

				if EsDerecha(A_LoopField) 
				{
					derechas_procesadas += 1
				}
			}
		}
	}
	ControlMove ThunderRT6CheckBox1, , , 360,34 , A

	str .= "Adquiridos: " . adquiridos
	str .= "       Trackeados: " . trackeados
	str .= "      Elaborados: " . elaborados
	str .= "      Procesados: " . procesados
	str .= "`n"
	str .= "Standing: " . standing
	str .= "      Izquierdas: " . (izquierdas_procesadas + izquierdas_trackeadas + izquierdas_elaboradas + izquierdas_adquiridas)
	str .= " (" . izquierdas_procesadas
	str .= " | " . izquierdas_elaboradas
	str .= " | " . izquierdas_trackeadas
	str .= " | " . izquierdas_adquiridas . ")"
	str .= "      Derechas: " . (derechas_procesadas + derechas_trackeadas + derechas_elaboradas + derechas_adquiridas)
	str .= " (" . derechas_procesadas
	str .= " | " . derechas_elaboradas
	str .= " | " . derechas_trackeadas
	str .= " | " . derechas_adquiridas . ")"


	ControlSetText  ThunderRT6CheckBox1, %str%   , A
	ControlFocus ThunderRT6ListBox1, A
}

EsIzquierda(fila){
	if InStr(fila, " L ", True)
	{
		return True
	}
	else return False
}

EsDerecha(fila){
	if InStr(fila, " R ", True)
	{
		return True
	}
	else return False		
}

;GetNextLeft(control){
;	ControlGet, Lista, List, , %control%, A
;	Loop, Parse, Lista, `n
;	{
;		if EsIzquierda()
;	}
;}

OpenTrialProcessing(){
	IfWinActive, BTS Bioengineering - EliteClinic ahk_class ThunderRT6MDIForm
	{
		WinMenuSelectItem, BTS Bioengineering - EliteClinic ahk_class ThunderRT6MDIForm, , 2& , 1&
	}
	WinWaitActive, Select Trials ahk_class ThunderRT6FormDC
	Control.Focus("ThunderRT6ListBox2")
}


AlertaOrtesis:
cadena := ReturnFirstLineClipbrd()
if (InStr(cadena, "ortesis",false) or InStr(cadena, "valva",false))
{
	SoundBeep, 440, 500
	MsgBox, 52, Alerta Ortesis, No olvidar sacar video de las ortesis!`nConservar la alerta?
	IfMsgBox, No
	{
		SetTimer, AlertaOrtesis, Delete
	}
}
Return