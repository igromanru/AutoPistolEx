#include-once
;	AutoPistolEx
;	Copyright (C) 2011-2013 Alexander Poplavsky
#region Keybinder
Func keyState()
	For $i = 60 To 69 Step +1
		If _IsPressed($i, $dll) Then
			While _IsPressed($i, $dll) = 1
				Sleep(1)
			WEnd
			Call("sendFunc", $i)
			Return 1
		EndIf
	Next
EndFunc   ;==>keyState

Func sendFunc($i)
	$i -= 60
	BlockInput(1)
	If GUICtrlRead($Enter[$i][0]) = $GUI_CHECKED Then
		Send("{enter}")
	EndIf
	Sleep(100)
	;ControlSend("", "", 0, GUICtrlRead($Input[$i]), 1)
	Send(GUICtrlRead($Input[$i]))
	Sleep(100)

	If GUICtrlRead($Enter[$i][1]) = $GUI_CHECKED Then
		Send("{enter}")
	EndIf
	BlockInput(0)
EndFunc   ;==>sendFunc
#endregion Keybinder