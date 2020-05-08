#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

#If WinActive("ahk_class CabinetWClass") or WinActive("ahk_class WorkerW") ; explorer or desktop
	F1::
		getActiveExplorerPath()
		Run cmd /k cd /d %path% ; cmd to current explorer directory
		return
	F2::
		getActiveExplorerPath()
		Run cmd /k cd /d %path% && wsl ; windows subsystem for linux to current directory
		return


GetActiveExplorerPath() {
	explorerHwnd := WinActive("ahk_class CabinetWClass")
	if (explorerHwnd)
	{
		for window in ComObjCreate("Shell.Application").Windows
		{
			if (window.hwnd==explorerHwnd)
				global path := window.Document.Folder.Self.Path				
		}
	}
	if (path = "")
			path := A_Desktop
}