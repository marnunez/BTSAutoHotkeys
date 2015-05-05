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

GetOS(){
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