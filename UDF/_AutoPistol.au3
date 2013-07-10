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

#region AutoPistol activation Hotkey
Func _getAPactHotkey(ByRef $actAPkey, $sAPtoggle)
	Switch $sAPtoggle
		Case "Off"
			$actAPkey = ""
		Case "Mouse1"
			$actAPkey = "01"
		Case "Mouse2"
			$actAPkey = "02"
		Case "Mouse3"
			$actAPkey = "03"
		Case "Mouse4"
			$actAPkey = "05"
		Case "Mouse5"
			$actAPkey = "06"
		Case "F1"
			$actAPkey = "70"
		Case "F2"
			$actAPkey = "71"
		Case "F3"
			$actAPkey = "72"
		Case "F4"
			$actAPkey = "73"
		Case "F5"
			$actAPkey = "74"
		Case "F6"
			$actAPkey = "75"
		Case "F7"
			$actAPkey = "76"
		Case "F8"
			$actAPkey = "77"
		Case "F9"
			$actAPkey = "78"
		Case "F10"
			$actAPkey = "79"
		Case "F11"
			$actAPkey = "7A"
		Case "F12"
			$actAPkey = "7B"
	EndSwitch
EndFunc
#endregion AutoPistol activation Hotkey

#region AutoPistol

Func CheckActivClick()
	If GUICtrlRead($CheckActiv) = $GUI_CHECKED Then
;~ 		_checkHWID()
		SoundPlay(@TempDir & "\activated.wav")
		GUICtrlSetState($cbAPkey, $GUI_DISABLE)
		GUICtrlSetState($cbShootKey, $GUI_DISABLE)
		GUICtrlSetState($cbWhilekey, $GUI_DISABLE)
		GUICtrlSetState($cbAPtoggle, $GUI_DISABLE)
		$sKey = _PressKeysManager(GUICtrlRead($cbAPkey))
	Else
		SoundPlay(@TempDir & "\deactivated.wav")
		GUICtrlSetState($cbAPkey, $GUI_ENABLE)
		GUICtrlSetState($cbShootKey, $GUI_ENABLE)
		GUICtrlSetState($cbWhilekey, $GUI_ENABLE)
		GUICtrlSetState($cbAPtoggle, $GUI_ENABLE)
	EndIf
EndFunc   ;==>CheckActivClick

Func _AutoPistol()
	Local $keyAP, $keyShoot
	Local $sBut
	Local $iSleep, $goTimer
	Local $iBurst, $iRecoil, $iXRecoil, $iRecSpeed, $iXRecSpeed
	Local $sDownKey
;~ 		$sKey = "51"
	If _IsPressed($sKey, $dll) Then
		$iSleep = _onSliderChange()
		$iBurst = _onBurstChange()
		$iRecoil = _onRecoilChange()
		$iXRecoil = _onXRecoilChange()
		$iRecSpeed = GUICtrlRead($cbRecSpeed)
		$iXRecSpeed = GUICtrlRead($cbXRecSpeed)
		$sDownKey = GUICtrlRead($cbWhilekey)
		If $iBurst > 0 Then
			$goTimer = TimerInit()
		EndIf
		_KeyDownManager($sDownKey)
		While _IsPressed($sKey, $dll) = 1
			_shootManager(GUICtrlRead($cbShootKey), GUICtrlRead($cbAPkey))
			Sleep($iSleep)
			If $iRecoil > 0 Or $iXRecoil > 0 Or $iXRecoil < 0 Then
				If $iRecoil < 1 Then
					$iRecoil = 0
				EndIf
				_EnhancedMouseMove($dll, 0 + $iXRecoil, 0 + $iRecoil, 0)
			EndIf
			If $iBurst > 0 Then
				If TimerDiff($goTimer) >= $iBurst Then
					Sleep(_onDelayChange())
					$goTimer = TimerInit()
				EndIf
			EndIf
		WEnd
		_KeyUpManager($sDownKey)
	EndIf
EndFunc   ;==>_AutoPistol

#endregion AutoPistol