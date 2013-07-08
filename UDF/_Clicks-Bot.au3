
#include-once
;	AutoPistolEx
;	Copyright (C) 2011-2013 Alexander Poplavsky
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