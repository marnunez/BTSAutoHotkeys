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
      Return 1 ; we've found a context menu
   Else
      Return 0
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
