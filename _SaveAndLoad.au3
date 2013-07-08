#include-once
;	AutoPistolEx
;	Copyright (C) 2011-2013 Alexander Poplavsky
#region Save and Load
Func SaveCfg()
	$oFile = FileOpen(@ScriptDir&"\APEx.ini", 2 + 8 + 32) ;Unicode kodierte ini erstellen
	FileClose($oFile)
	If GUICtrlRead($Savebox) = $GUI_CHECKED Then
		;Enter vor und  nach dem Text
		For $x = 0 To 9 Step +1
			IniWrite(@ScriptDir&"\APEx.ini", "Keybinder", "Enter" & $x + 1 & "a", GUICtrlRead($Enter[$x][0]))
			IniWrite(@ScriptDir&"\APEx.ini", "Keybinder", "Enter" & $x + 1 & "b", GUICtrlRead($Enter[$x][1]))
		Next
		;Der Text selbst
		For $i = 0 To 9 Step +1
			IniWrite(@ScriptDir&"\APEx.ini", "Keybinder", "InputBox" & $i + 1, GUICtrlRead($Input[$i]) & "|")
		Next
	EndIf
	;---------------------Save AutoPistol Cfg-----------------------------------------------
	If GUICtrlRead($CheckSave) = $GUI_CHECKED Then
		IniWrite(@ScriptDir&"\APEx.ini", "APEx", "APkey", GUICtrlRead($cbAPkey))
		IniWrite(@ScriptDir&"\APEx.ini", "APEx", "Shootkey", GUICtrlRead($cbShootKey))
		IniWrite(@ScriptDir&"\APEx.ini", "APEx", "WhileKey", GUICtrlRead($cbWhilekey))
		IniWrite(@ScriptDir&"\APEx.ini", "APEx", "SpeedSlide", GUICtrlRead($Slider1))
		IniWrite(@ScriptDir&"\APEx.ini", "APEx", "BurstSlide", GUICtrlRead($SlidBurst))
		IniWrite(@ScriptDir&"\APEx.ini", "APEx", "DelaySlide", GUICtrlRead($SlidDelay))
		IniWrite(@ScriptDir&"\APEx.ini", "APEx", "RecoilSlide", GUICtrlRead($SlidRecoil))
		IniWrite(@ScriptDir&"\APEx.ini", "APEx", "RecoilSpeed", GUICtrlRead($cbRecSpeed))
		IniWrite(@ScriptDir&"\APEx.ini", "APEx", "APtoggleKey", GUICtrlRead($cbAPtoggle))
	EndIf

	;---------------------Save Triggerbot Cfg-----------------------------------------------
	If GUICtrlRead($CheckTrigSave) = $GUI_CHECKED Then
		IniWrite(@ScriptDir&"\APEx.ini", "Triggerbot", "Shootkey", GUICtrlRead($cbTrigShootKey))
		IniWrite(@ScriptDir&"\APEx.ini", "Triggerbot", "TrigColor", GUICtrlRead($InColor))
		IniWrite(@ScriptDir&"\APEx.ini", "Triggerbot", "SlidXdis", GUICtrlRead($SlidXdis))
		IniWrite(@ScriptDir&"\APEx.ini", "Triggerbot", "SlidXpos", GUICtrlRead($SlidXpos))
		IniWrite(@ScriptDir&"\APEx.ini", "Triggerbot", "SlidYdis", GUICtrlRead($SlidYdis))
		IniWrite(@ScriptDir&"\APEx.ini", "Triggerbot", "SlidYpos", GUICtrlRead($SlidYpos))
		IniWrite(@ScriptDir&"\APEx.ini", "Triggerbot", "MainPosX", $aMainPos[0])
		IniWrite(@ScriptDir&"\APEx.ini", "Triggerbot", "MainPosY", $aMainPos[1])
		IniWrite(@ScriptDir&"\APEx.ini", "Triggerbot", "DisX", $aDis[0])
		IniWrite(@ScriptDir&"\APEx.ini", "Triggerbot", "DisY", $aDis[1])
		IniWrite(@ScriptDir&"\APEx.ini", "Triggerbot", "ColorShade", GUICtrlRead($cbShadeColor))
		IniWrite(@ScriptDir&"\APEx.ini", "Triggerbot", "ActivXdis", GUICtrlRead($ActivXdis))
		IniWrite(@ScriptDir&"\APEx.ini", "Triggerbot", "ActivYdis", GUICtrlRead($ActivYdis))
	EndIf

	;---------------------Save Clicks-Bot Cfg-----------------------------------------------
	If GUICtrlRead($CheckClicksSave) = $GUI_CHECKED Then
		IniWrite(@ScriptDir&"\APEx.ini", "Clicks-Bot", "HotKey", GUICtrlRead($cbClickHotkey))
		IniWrite(@ScriptDir&"\APEx.ini", "Clicks-Bot", "ClickKey", GUICtrlRead($cbClicktKey))
		IniWrite(@ScriptDir&"\APEx.ini", "Clicks-Bot", "ClicksNumber", GUICtrlRead($InClicks))
		IniWrite(@ScriptDir&"\APEx.ini", "Clicks-Bot", "ClicksSpeedSlide", GUICtrlRead($SliderClicksSpeed))
	EndIf
EndFunc   ;==>SaveCfg

Func LoadCfg()
	Local $check = 0
	Local $readvar
	For $j = 0 To 9 Step +1
		$readvar = IniRead(@ScriptDir&"\APEx.ini", "Keybinder", "Enter" & $j + 1 & "a", 4)
		GUICtrlSetState($Enter[$j][0], $readvar)
		$readvar = IniRead(@ScriptDir&"\APEx.ini", "Keybinder", "Enter" & $j + 1 & "b", 4)
		GUICtrlSetState($Enter[$j][1], $readvar)
	Next
	For $i = 0 To 9 Step +1
		$readvar = IniRead(@ScriptDir&"\APEx.ini", "Keybinder", "InputBox" & $i + 1, "")
		$readvar = StringTrimRight($readvar, 1)
		GUICtrlSetData($Input[$i], $readvar)
	Next
	;---------------------Load AutoPistol Cfg-----------------------------------------------
	$readvar = IniRead(@ScriptDir&"\APEx.ini", "APEx", "APkey", "Mouse1")
	GUICtrlSetData($cbAPkey, $readvar)
	$readvar = IniRead(@ScriptDir&"\APEx.ini", "APEx", "Shootkey", "Mouse4")
	GUICtrlSetData($cbShootKey, $readvar)
	$readvar = IniRead(@ScriptDir&"\APEx.ini", "APEx", "WhileKey", "Off")
	GUICtrlSetData($cbWhilekey, $readvar)
	$readvar = IniRead(@ScriptDir&"\APEx.ini", "APEx", "SpeedSlide", 2)
	GUICtrlSetData($Slider1, $readvar)
	_onSliderChange()
	$readvar = IniRead(@ScriptDir&"\APEx.ini", "APEx", "BurstSlide", 0)
	GUICtrlSetData($SlidBurst, $readvar)
	_onBurstChange()
	$readvar = IniRead(@ScriptDir&"\APEx.ini", "APEx", "DelaySlide", 0)
	GUICtrlSetData($SlidDelay, $readvar)
	_onDelayChange()
	$readvar = IniRead(@ScriptDir&"\APEx.ini", "APEx", "RecoilSlide", 0)
	GUICtrlSetData($SlidRecoil, $readvar)
	_onRecoilChange()
	$readvar = IniRead(@ScriptDir&"\APEx.ini", "APEx", "RecoilSpeed", 10)
	GUICtrlSetData($cbRecSpeed, $readvar)
	$readvar = IniRead(@ScriptDir&"\APEx.ini", "APEx", "APtoggleKey", "F11")
	GUICtrlSetData($cbAPtoggle, $readvar)

	;---------------------load Triggerbot Cfg-----------------------------------------------
	$readvar = IniRead(@ScriptDir&"\APEx.ini", "Triggerbot", "Shootkey", "Mouse4")
	GUICtrlSetData($cbTrigShootKey, $readvar)
	$readvar = IniRead(@ScriptDir&"\APEx.ini", "Triggerbot", "TrigColor", "")
	GUICtrlSetData($InColor, $readvar)
	$readvar = IniRead(@ScriptDir&"\APEx.ini", "Triggerbot", "SlidXdis", 0)
	GUICtrlSetData($SlidXdis, $readvar)
	_onXdisChange()
	$readvar = IniRead(@ScriptDir&"\APEx.ini", "Triggerbot", "SlidXpos", 50)
	GUICtrlSetData($SlidXpos, $readvar)
	_onXposChange()
	$readvar = IniRead(@ScriptDir&"\APEx.ini", "Triggerbot", "SlidYdis", 0)
	GUICtrlSetData($SlidYdis, $readvar)
	_onYdisChange()
	$readvar = IniRead(@ScriptDir&"\APEx.ini", "Triggerbot", "SlidYpos", 50)
	GUICtrlSetData($SlidYpos, $readvar)
	_onYposChange()
	$readvar = IniRead(@ScriptDir&"\APEx.ini", "Triggerbot", "ColorShade", 15)
	GUICtrlSetData($cbShadeColor, $readvar)
	$aMainPos[0] = IniRead(@ScriptDir&"\APEx.ini", "Triggerbot", "MainPosX", 125)
	$aMainPos[1] = IniRead(@ScriptDir&"\APEx.ini", "Triggerbot", "MainPosY", 125)
	$aDis[0] = IniRead(@ScriptDir&"\APEx.ini", "Triggerbot", "DisX", 0)
	$aDis[1] = IniRead(@ScriptDir&"\APEx.ini", "Triggerbot", "DisY", 0)
	$readvar = IniRead(@ScriptDir&"\APEx.ini", "Triggerbot", "ActivXdis", 1)
	GUICtrlSetState($ActivXdis, $readvar)
	$readvar = IniRead(@ScriptDir&"\APEx.ini", "Triggerbot", "ActivYdis", 1)
	GUICtrlSetState($ActivYdis, $readvar)

	;---------------------Load Clicks-Bot Cfg-----------------------------------------------
	$readvar = IniRead(@ScriptDir&"\APEx.ini", "Clicks-Bot", "HotKey", "Mouse4")
	GUICtrlSetData($cbClickHotkey, $readvar)
	$readvar = IniRead(@ScriptDir&"\APEx.ini", "Clicks-Bot", "ClickKey", "Mouse1")
	GUICtrlSetData($cbClicktKey, $readvar)
	$readvar = IniRead(@ScriptDir&"\APEx.ini", "Clicks-Bot", "ClicksNumber", 1)
	GUICtrlSetData($InClicks, $readvar)
	$readvar = IniRead(@ScriptDir&"\APEx.ini", "Clicks-Bot", "ClicksSpeedSlide", 2)
	GUICtrlSetData($SliderClicksSpeed, $readvar)
	_onClicksSpeedChange()
EndFunc   ;==>LoadCfg
#endregion Save and Load