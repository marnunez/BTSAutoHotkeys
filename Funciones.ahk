LB_GETSELCOUNT = 0x0190
LB_GETSELITEMS = 0x0191
LB_GETTEXT = 0x0189
LB_GETCARETINDEX = 0x019F
LB_GETCURSEL = 0x0188
LB_FINDSTRING = 0x018F
LB_SETCURSEL = 0x0186
LB_ERR = -1

;Detecta si en este momento hay un menu contextual presente
DetectContextMenu(){
   GuiThreadInfoSize = 48
   VarSetCapacity(GuiThreadInfo, 48)
   NumPut(GuiThreadInfoSize, GuiThreadInfo, 0)

   if not DllCall("GetGUIThreadInfo", uint, 0, str, GuiThreadInfo)
   {
      MsgBox GetGUIThreadInfo() indicated a failure.
      return
   }

   ; GuiThreadInfo contains a DWORD flags at byte 4
   ; Bit 4 of this flag is set if the thread is in menu mode. GUI_INMENUMODE = 0x4

   if (NumGet(GuiThreadInfo, 4) & 0x4)
      Return true ; we've found a context menu
   Else
      Return false
  }
;Devuelve el valor correcto de "Archivos de Programa" para este sistema operativo
GetProgramFiles(){
   if A_OSVersion = WIN_7
   {
      return A_ProgramFiles . (A_PtrSize=8 ? " (x86)" : "")
   }
   if A_OSVersion = WIN_XP
   {
      return A_ProgramFiles
   }
   Else
   {
      MsgBox, SISTEMA OPERATIVO NO RECONOCIDO
   }
}

; Simple derivative of ExtractInteger, for Win32 integers (4 bytes)
GetInteger(ByRef @source, _pos){
   local result, offset

   offset := (_pos - 1) * 4
   result = 0
   Loop 4  ; Build the integer by adding up its bytes.
   {
      result += *(&@source + offset + A_Index-1) << 8*(A_Index-1)
   }
   Return result
}

;Chequea si existe el Control de Trial Processing
ExisteTrialProcessing(){
      if Control.Exists("ThunderRT6FormDC1","BTS Bioengineering - EliteClinic ahk_class ThunderRT6MDIForm")
      {
         if Control.IsVisible("Trial Processing","BTS Bioengineering - EliteClinic ahk_class ThunderRT6MDIForm")
         {
            Return true
         }
      }
   return false
}

ReturnFirstLineClipbrd() {
   Loop, Parse, clipboard,`n,`r
   {
      return %A_LoopField%
   }
   Return
}


class Control{

   IsEnabled(con,win:="A"){
      ControlGet, b, Enabled, , %con%, %win%
      if b = 1
      {
         return true
      }
      return false
   }

   IsChecked(con,win:="A"){
      ControlGet, b, Checked, , %con%, %win%
      if b = 1
      {
         return true
      }
      return false
   }

   GetFocus(win:="A"){
      ControlGetFocus, con, %win%
      return con
   }

   IsVisible(con,win:="A"){
      ControlGet, b, Visible, , %con%, %win%
      if b = 1
      {
         return true
      }
      return false
   }

   WaitEnabled(con,win:="A"){
      Loop
      {
         if this.IsEnabled(con,win)
         {
            Return
         }
      }
   }

   WaitVisible(con,win:="A"){
      Loop
      {
         if this.IsVisible(con,win)
         {
            Return
         }
      }
   }

   Exists(con,win:="A"){
      WinGet, lista, ControlList, %win%

      Loop, Parse, lista ,`n
      {
         if A_LoopField = %con%
         {
               return true
         }
      }
      return false
   }

   Choose(con,pos,win:="A"){
      Control,Choose,%pos%,%con%,%win%
   }

   Focus(con,win:="A"){
      ControlFocus,%con%,%win%
   }

}