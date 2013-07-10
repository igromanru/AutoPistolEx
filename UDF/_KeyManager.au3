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

Func _shootManager($sBut, $sAPkey)
	If $sBut = "Mouse1" And $sAPkey = "Mouse1" Then
		ControlClick("", "", "", "left")
		Return 0
	EndIf
	Switch $sBut
		Case "Mouse1"
			_EnhancedMouseClick($dll, "left")
		Case "Mouse2"
			_EnhancedMouseClick($dll, "right")
		Case "Mouse3"
			_EnhancedMouseClick($dll, "middle")
		Case "Mouse4"
			_EnhancedMouseClick($dll, "x1")
		Case "Mouse5"
			_EnhancedMouseClick($dll, "x2")
		Case "NumPad0"
			Send("{NUMPAD0}")
		Case "NumPad7"
			Send("{NUMPAD7}")
		Case "NumPad8"
			Send("{NUMPAD8}")
		Case "NumPad9"
			Send("{NUMPAD9}")
	EndSwitch
EndFunc   ;==>_shootManager

Func _KeyDownManager($sBut)
	Switch $sBut
		Case "Mouse1"
			_EnhancedMouseDown($dll, "left")
		Case "Mouse2"
			_EnhancedMouseDown($dll, "right")
		Case "Mouse3"
			_EnhancedMouseDown($dll, "middle")
		Case "Mouse4"
			_EnhancedMouseDown($dll, "x1")
		Case "Mouse5"
			_EnhancedMouseDown($dll, "x2")
	EndSwitch
EndFunc   ;==>_KeyDownManager

Func _KeyUpManager($sBut)
	Switch $sBut
		Case "Mouse1"
			_EnhancedMouseUp($dll, "left")
		Case "Mouse2"
			_EnhancedMouseUp($dll, "right")
		Case "Mouse3"
			_EnhancedMouseUp($dll, "middle")
		Case "Mouse4"
			_EnhancedMouseUp($dll, "x1")
		Case "Mouse5"
			_EnhancedMouseUp($dll, "x2")
	EndSwitch
EndFunc   ;==>_KeyUpManager

Func _PressKeysManager($sKey)
	Switch $sKey
		Case "Mouse1"
			$sKey = "01"
		Case "Mouse2"
			$sKey = "02"
		Case "Mouse3"
			$sKey = "04"
		Case "Mouse4"
			$sKey = "05"
		Case "Mouse5"
			$sKey = "06"
		Case "F1"
			$sKey = "70"
		Case "F2"
			$sKey = "71"
		Case "F3"
			$sKey = "72"
		Case "F4"
			$sKey = "73"
		Case "F5"
			$sKey = "74"
		Case "F6"
			$sKey = "75"
		Case "F7"
			$sKey = "76"
		Case "F8"
			$sKey = "77"
		Case "F9"
			$sKey = "78"
		Case "F10"
			$sKey = "79"
		Case "F11"
			$sKey = "7A"
		Case "F12"
			$sKey = "7B"
		Case "Spacebar"
			$sKey = "20"
	EndSwitch
	Return $sKey
EndFunc   ;==>_PressKeysManager