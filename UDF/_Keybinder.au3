#cs ----------------------------------------------------------------------------
   Copyright (C) 2011-2013 Igromanru

   Licensed under the Apache License, Version 2.0 (the "License");
   you may not use this file except in compliance with the License.
   You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

   Unless required by applicable law or agreed to in writing, software
   distributed under the License is distributed on an "AS IS" BASIS,
   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
   See the License for the specific language governing permissions and
   limitations under the License.
#ce ----------------------------------------------------------------------------

#include-once

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