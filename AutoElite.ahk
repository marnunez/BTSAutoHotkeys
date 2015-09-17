;
; AutoHotkey Version: 1.x
; Language:       English
; Platform:       Win9x/NT
; Author:         A.N.Other <myemail@nowhere.com>
;
; Script Function:
;	Template script (you can customize this template by editing "ShellNew\Template.ahk" in your Windows folder)
;

#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
IfWinNotExist, BTS Bioengineering - EliteClinic ahk_class ThunderRT6MDIForm
{
	Run, "C:\Archivos de programa\BTS Bioengineering\Gaitel30\GaitEl30.exe", "C:\Archivos de programa\BTS Bioengineering\Gaitel30\"	
}
Else
WinActivate, BTS Bioengineering - EliteClinic ahk_class ThunderRT6MDIForm

#Include, BTS.ahk
#Include, Tracklab.ahk