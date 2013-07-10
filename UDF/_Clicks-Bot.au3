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

#region Clicks-Bot

Func _checkActivClicksBot()
	If GUICtrlRead($CheckClicksActiv) = $GUI_CHECKED Then
		SoundPlay(@TempDir & "\activated.wav")
		GUICtrlSetState($cbClickHotkey, $GUI_DISABLE)
		GUICtrlSetState($cbClicktKey, $GUI_DISABLE)
		$sClicksKey = _PressKeysManager(GUICtrlRead($cbClickHotkey))
;~ 		MsgBox(0,"",$sClicksKey)
	Else
		SoundPlay(@TempDir & "\deactivated.wav")
		GUICtrlSetState($cbClickHotkey, $GUI_ENABLE)
		GUICtrlSetState($cbClicktKey, $GUI_ENABLE)
	EndIf
EndFunc   ;==>CheckActivClick

Func _ClicksBot()
	If _IsPressed($sClicksKey, $dll) Then
		$iSleep = _onClicksSpeedChange()
		$iClicksNumber = GUICtrlRead($InClicks)
		While _IsPressed($sClicksKey, $dll) = 1
			Sleep(100)
		WEnd
		For $i = 1 to $iClicksNumber
			If _IsPressed($sClicksKey, $dll) Then
				While _IsPressed($sClicksKey, $dll) = 1
					Sleep(100)
				WEnd
				ExitLoop
			EndIf
			If GUICtrlRead($CheckClicksActiv) <> $GUI_CHECKED Then
				ExitLoop
			EndIf
			_shootManager(GUICtrlRead($cbClicktKey), GUICtrlRead($cbClickHotkey))
			Sleep($iSleep)
		Next
	EndIf
EndFunc   ;==>_AutoPistol

#endregion Clicks-Bot