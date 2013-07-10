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

#cs ----------------------------------------------------------------------------
 AutoIt Version: 3.3.8.1
 Author: Igromanru

 Script Description: APB only version of AutoPistolEx

#ce ----------------------------------------------------------------------------

#NoTrayIcon
#RequireAdmin
#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_icon=logitech-G5.ico
#AutoIt3Wrapper_Compression=4
#AutoIt3Wrapper_UseUpx=n
#AutoIt3Wrapper_UseX64=n
#AutoIt3Wrapper_Res_Description=AP APB
#AutoIt3Wrapper_Res_Fileversion=1.0.0.0
#AutoIt3Wrapper_Res_LegalCopyright=Alexander Poplavsky (Igromanru)
#AutoIt3Wrapper_Res_Language=1031
#AutoIt3Wrapper_Res_requestedExecutionLevel=requireAdministrator
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
Global Const $VERSION = "1.0.0"
Global Const $FORM_NAME = "AP APB v" & $VERSION & " "
If WinExists($FORM_NAME) Then
	MsgBox(48,"Error", "This program is already runnung!")
	Exit
EndIf

#include <ButtonConstants.au3>
#include <EditConstants.au3>
#include <ComboConstants.au3>
#include <GUIConstantsEx.au3>
#include <SliderConstants.au3>
#include <StaticConstants.au3>
#include <TabConstants.au3>
#include <WindowsConstants.au3>
#include <Misc.au3>
#include <String.au3>
#include <Constants.au3>
#include <WinAPI.au3>
#Include <WinAPIEx.au3>
#include <INet.au3>

#include "Blowfish_UDF.au3"
#include "EnhancedMouseClick.au3"

; Igromanru HWID: {68A91514-23C2-FDE2-E88E-ED7E4F5EF5F2}
FileInstall(".\activated.wav", @TempDir & "\activated.wav", 1)
FileInstall(".\deactivated.wav", @TempDir & "\deactivated.wav", 1)

#region Global define
Global $Input[10], $Enter[10][2]
Global $sKey
Global $slider1_old, $slider2_old, $slider3_old, $slidRec_old

Global $actAPkey = "7A"
#endregion Global define

Opt("GUIOnEventMode", 1)
Opt("TrayMenuMode", 1)
Opt("TrayOnEventMode", 1)

#region Form1
$Form1 = GUICreate($FORM_NAME, 380, 368, -1, -1)
GUISetOnEvent($GUI_EVENT_CLOSE, "SpecialEvents")
GUISetOnEvent($GUI_EVENT_MINIMIZE, "SpecialEvents")
$Label1337 = GUICtrlCreateLabel("Igromanru © 2011", 135, 347, 100, 23)
GUICtrlSetFont(-1, 9, 400, 0, "Ebrima")
GUICtrlSetColor(-1, 0x000080)
$LabGameSta = GUICtrlCreateLabel("Game status:", 22, 10, 77, 18)
$LabGameStatus = GUICtrlCreateLabel("not found", 90, 10, 77, 18)
GUICtrlSetColor(-1, 0xFF0000)
#region AutoPistol_Tab
;=============Auto Pistol================================
$LabAPkey = GUICtrlCreateLabel("AP HotKey:", 22, 36, 77, 18)
$cbAPkey = GUICtrlCreateCombo("", 85, 34, 73, 25, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
GUICtrlSetData(-1, "Mouse1|Mouse2|Mouse3|Mouse4|Mouse5", "Mouse1")
$LabShootKey = GUICtrlCreateLabel("ShootKey:", 22, 66, 54, 18)
$cbShootKey = GUICtrlCreateCombo("", 85, 62, 73, 25, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
GUICtrlSetData(-1, "Off|Mouse1|Mouse2|Mouse3|Mouse4|Mouse5|NumPad0|NumPad7|NumPad8|NumPad9", "Mouse4")
$LabWhileKey = GUICtrlCreateLabel("Press While:", 22, 92, 65, 18)
$cbWhilekey = GUICtrlCreateCombo("", 85, 89, 73, 25, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
GUICtrlSetData(-1, "Off|Mouse1|Mouse2|Mouse3|Mouse4|Mouse5", "Off")
$LabSpeed = GUICtrlCreateLabel("Speed:", 22, 123, 38, 18)
$Slider1 = GUICtrlCreateSlider(62, 120, 275, 23)
GUICtrlSetLimit(-1, 20, 0)
GUICtrlSetOnEvent(-1, "_onSliderChange")
$LabSPslow = GUICtrlCreateLabel("Slow", 315, 145, 29, 18)
$LabSPFast = GUICtrlCreateLabel("Fast", 63, 145, 25, 18)
$LabSpeedValue = GUICtrlCreateLabel("1", 192, 145, 28, 18)
$LabMS = GUICtrlCreateLabel("ms", 226, 145, 18, 18)
;=============AP Activation and Save================================
$CheckActiv = GUICtrlCreateCheckbox("Activate AP", 190, 36, 75, 17)
GUICtrlSetOnEvent(-1, "CheckActivClick")
$cbAPtoggle = GUICtrlCreateCombo("", 270, 34, 62, 18, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
GUICtrlSetData(-1, "Off|F1|F2|F3|F4|F5|F6|F7|F8|F9|F10|F11|F12|Mouse4|Mouse5", "F11")
$CheckSave = GUICtrlCreateCheckbox("AutoSave on Exit", 190, 63, 111, 17)
GUICtrlSetState(-1, $GUI_CHECKED)
;=============Burst Fire================================
$SlidBurst = GUICtrlCreateSlider(78, 185, 275, 23)
GUICtrlSetLimit(-1, 30, 0)
GUICtrlSetOnEvent(-1, "_onBurstChange")
$LabBurst = GUICtrlCreateLabel("Off", 206, 212, 28, 18)
$LabBurMD = GUICtrlCreateLabel("ms", 235, 212, 18, 18)
$LabBurstTime = GUICtrlCreateLabel("Burst time:", 22, 185, 55, 18)
$SlidDelay = GUICtrlCreateSlider(78, 232, 275, 23)
GUICtrlSetLimit(-1, 30, 1)
GUICtrlSetOnEvent(-1, "_onDelayChange")
$LabDelMS = GUICtrlCreateLabel("ms", 235, 258, 18, 18)
$LabDelay = GUICtrlCreateLabel("0", 206, 258, 28, 18)
$LabDelayTime = GUICtrlCreateLabel("Delay time:", 22, 232, 56, 18)
;=============Recoil Keeper================================
$SlidRecoil = GUICtrlCreateSlider(90, 280, 275, 23)
GUICtrlSetLimit(-1, 50, 0)
GUICtrlSetOnEvent(-1, "_onRecoilChange")
$LabRecoil = GUICtrlCreateLabel("Recoil Keeper:", 16, 283, 74, 18)
$LabRecoilSpeed = GUICtrlCreateLabel("Pixel", 240, 305, 30, 18)
$LabRecoilStr = GUICtrlCreateLabel("Off", 218, 305, 18, 18)
#endregion AutoPistol_Tab
GUISetState(@SW_SHOW)
#endregion #region Form1

If FileExists(@ScriptDir&"\APAPB.ini") = 1 Then
	Call("LoadCfg")
EndIf
$dll = DllOpen("user32.dll")

GUIRegisterMsg( $WM_HSCROLL, "WM_HSCROLL" )
;~ TraySetOnEvent($TRAY_EVENT_PRIMARYDOUBLE, "maxGui")
;~ If @error Then
;~ 	MsgBox(0, "Error", "TraysetOnEvent")
;~ EndIf

#region Main Loop
While 1
	If GUICtrlRead($CheckActiv) = $GUI_UNCHECKED Then
		_getAPactHotkey($actAPkey)
	EndIf
	If _IsPressed($actAPkey, $dll) Then
		While _IsPressed($actAPkey, $dll) = True
			Sleep(100)
		WEnd
		If GUICtrlRead($CheckActiv) = $GUI_CHECKED Then
			GUICtrlSetState($CheckActiv, $GUI_UNCHECKED)
		Else
			GUICtrlSetState($CheckActiv, $GUI_CHECKED)
		EndIf
		CheckActivClick()
	EndIf
	If ProcessExists("APB.exe") Then
		If GUICtrlRead($LabGameStatus) <> "found" Then
			GUICtrlSetData($LabGameStatus, "found")
			GUICtrlSetColor($LabGameStatus, 0x10af23)
		EndIf
	If GUICtrlRead($CheckActiv) = $GUI_CHECKED And WinActive("APB Reloaded") Then
		If GUICtrlRead($cbAPkey) = GUICtrlRead($cbShootKey) Then
;~ 			If GUICtrlRead($cbAPkey) = "Mouse1" And GUICtrlRead($cbShootKey) = "Mouse1" Then
;~ 				_AutoPistol()
;~ 			Else
				MsgBox(16, "Warning", '"AutoPistol Key" and "Shoot Key" can not have the same Value!')
				GUICtrlSetState($CheckActiv, $GUI_UNCHECKED)
				CheckActivClick()
;~ 			EndIf
		ElseIf GUICtrlRead($cbWhilekey) = GUICtrlRead($cbShootKey) Then
			MsgBox(16, "Warning", '"Shoot Key" and "Press While Key" can not have the same Value!')
			GUICtrlSetState($CheckActiv, $GUI_UNCHECKED)
			CheckActivClick()
		Else
			_AutoPistol()
		EndIf
	EndIf
	Else
		If GUICtrlRead($LabGameStatus) = "found" Then
			GUICtrlSetData($LabGameStatus, "not found")
			GUICtrlSetColor($LabGameStatus, 0xFF0000)
		EndIf
	EndIf
WEnd
#endregion Main Loop

Func WM_HSCROLL()
	If GUICtrlRead($Slider1) <> $slider1_old Then
		_onSliderChange()
		$slider1_old = GUICtrlRead($Slider1)
	ElseIf GUICtrlRead($SlidBurst) <> $slider2_old Then
		_onBurstChange()
		$slider2_old = GUICtrlRead($SlidBurst)
	ElseIf GUICtrlRead($SlidDelay) <> $slider3_old Then
		_onDelayChange()
		$slider3_old = GUICtrlRead($SlidDelay)
	ElseIf GUICtrlRead($SlidRecoil) <> $slidRec_old Then
		_onRecoilChange()
		$slidRec_old = GUICtrlRead($SlidRecoil)
	EndIf
EndFunc

#region AutoPistol activation Hotkey
Func _getAPactHotkey(ByRef $actAPkey)
	Switch GUICtrlRead($cbAPtoggle)
		Case "Off"
			$actAPkey = ""
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
Func _AutoPistol()
	Local $keyAP, $keyShoot
	Local $sBut
	Local $iSleep, $goTimer
	Local $iBurst, $iRecoil, $iRecSpeed
	Local $sDownKey
;~ 		$sKey = "51"
	If _IsPressed($sKey, $dll) Then
		$iSleep = _onSliderChange()
		$iBurst = _onBurstChange()
		$iRecoil = _onRecoilChange()
		$sDownKey = GUICtrlRead($cbWhilekey)
		If $iBurst > 0 Then
			$goTimer = TimerInit()
		EndIf
		_KeyDownManager($sDownKey)
		While _IsPressed($sKey, $dll) = 1
			_shootManager(GUICtrlRead($cbShootKey))
			Sleep($iSleep)
			If $iRecoil > 0 Then
				_EnhancedMouseMove($dll, 0, 0 + $iRecoil, 0)
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

Func _shootManager($sBut)
	If $sBut = "Mouse1" And GUICtrlRead($cbAPkey) = "Mouse1" Then
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
	EndSwitch
	Return $sKey
EndFunc   ;==>_PressKeysManager
#endregion AutoPistol

#region OnChange Functions
Func _onSliderChange()
	Local $iSleep = GUICtrlRead($Slider1)

	Switch $iSleep
		Case 0
			$iSleep = 1
		Case Else
			$iSleep *= 50
	EndSwitch
	GUICtrlSetData($LabSpeedValue, $iSleep)
	Return $iSleep
EndFunc   ;==>_onSliderChange

Func _onBurstChange()
	Local $iSleep = GUICtrlRead($SlidBurst)

	Switch $iSleep
		Case 0
			$iSleep = "Off"
			GUICtrlSetState($SlidDelay, $GUI_DISABLE)
			GUICtrlSetState($LabDelay, $GUI_DISABLE)
			GUICtrlSetState($LabDelayTime, $GUI_DISABLE)
			GUICtrlSetState($LabDelMS, $GUI_DISABLE)
		Case Else
			$iSleep *= 100
			GUICtrlSetState($LabDelay, $GUI_ENABLE)
			GUICtrlSetState($SlidDelay, $GUI_ENABLE)
			GUICtrlSetState($LabDelayTime, $GUI_ENABLE)
			GUICtrlSetState($LabDelMS, $GUI_ENABLE)
	EndSwitch
	GUICtrlSetData($LabBurst, $iSleep)
	Return $iSleep
EndFunc   ;==>_onBurstChange

Func _onDelayChange()
	Local $iSleep = GUICtrlRead($SlidDelay)

	Switch $iSleep
		Case 0
			$iSleep = 0
		Case Else
			$iSleep *= 100
	EndSwitch
	GUICtrlSetData($LabDelay, $iSleep)
	Return $iSleep
EndFunc   ;==>_onDelayChange

Func _onRecoilChange()
	Local $iSleep = GUICtrlRead($SlidRecoil)

	Switch $iSleep
		Case 0
			$iSleep = "Off"
	EndSwitch
	GUICtrlSetData($LabRecoilStr, $iSleep)
	Return $iSleep
EndFunc   ;==>_onRecoilChange
#endregion OnChange Functions

Func CheckActivClick()
	If GUICtrlRead($CheckActiv) = $GUI_CHECKED Then
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

#region Save and Load
Func SaveCfg()
	$oFile = FileOpen(@ScriptDir&"\APAPB.ini", 2 + 8 + 32) ;Unicode kodierte ini erstellen
	FileClose($oFile)
	;---------------------Save AutoPistol Cfg-----------------------------------------------
	If GUICtrlRead($CheckSave) = $GUI_CHECKED Then
		IniWrite(@ScriptDir&"\APAPB.ini", "APEx", "APkey", GUICtrlRead($cbAPkey))
		IniWrite(@ScriptDir&"\APAPB.ini", "APEx", "Shootkey", GUICtrlRead($cbShootKey))
		IniWrite(@ScriptDir&"\APAPB.ini", "APEx", "WhileKey", GUICtrlRead($cbWhilekey))
		IniWrite(@ScriptDir&"\APAPB.ini", "APEx", "SpeedSlide", GUICtrlRead($Slider1))
		IniWrite(@ScriptDir&"\APAPB.ini", "APEx", "BurstSlide", GUICtrlRead($SlidBurst))
		IniWrite(@ScriptDir&"\APAPB.ini", "APEx", "DelaySlide", GUICtrlRead($SlidDelay))
		IniWrite(@ScriptDir&"\APAPB.ini", "APEx", "RecoilSlide", GUICtrlRead($SlidRecoil))
		IniWrite(@ScriptDir&"\APAPB.ini", "APEx", "APtoggleKey", GUICtrlRead($cbAPtoggle))
	EndIf
EndFunc   ;==>SaveCfg

Func LoadCfg()
	Local $check = 0
	Local $readvar

	;---------------------Load AutoPistol Cfg-----------------------------------------------
	$readvar = IniRead(@ScriptDir&"\APAPB.ini", "APEx", "APkey", "Mouse1")
	GUICtrlSetData($cbAPkey, $readvar)
	$readvar = IniRead(@ScriptDir&"\APAPB.ini", "APEx", "Shootkey", "Mouse4")
	GUICtrlSetData($cbShootKey, $readvar)
	$readvar = IniRead(@ScriptDir&"\APAPB.ini", "APEx", "WhileKey", "Off")
	GUICtrlSetData($cbWhilekey, $readvar)
	$readvar = IniRead(@ScriptDir&"\APAPB.ini", "APEx", "SpeedSlide", 2)
	GUICtrlSetData($Slider1, $readvar)
	_onSliderChange()
	$readvar = IniRead(@ScriptDir&"\APAPB.ini", "APEx", "BurstSlide", 0)
	GUICtrlSetData($SlidBurst, $readvar)
	_onBurstChange()
	$readvar = IniRead(@ScriptDir&"\APAPB.ini", "APEx", "DelaySlide", 0)
	GUICtrlSetData($SlidDelay, $readvar)
	_onDelayChange()
	$readvar = IniRead(@ScriptDir&"\APAPB.ini", "APEx", "RecoilSlide", 0)
	GUICtrlSetData($SlidRecoil, $readvar)
	_onRecoilChange()
	$readvar = IniRead(@ScriptDir&"\APAPB.ini", "APEx", "APtoggleKey", "F11")
	GUICtrlSetData($cbAPtoggle, $readvar)

EndFunc   ;==>LoadCfg
#endregion Save and Load

#region Form Events
Func SpecialEvents()
	Select
		Case @GUI_CtrlId = $GUI_EVENT_CLOSE
			SplashTextOn("APEx Shutdown","Shutting down, please wait...", 224, 86, -1, -1, 1+32, "", 11)
;~ 			_ShutDownForm()
			DllClose($dll)
			Call("SaveCfg")
			FileDelete(@TempDir & "\activated.wav")
			FileDelete(@TempDir & "\deactivated.wav")

			Exit

		Case @GUI_CtrlId = $GUI_EVENT_RESTORE

	EndSelect
EndFunc   ;==>SpecialEvents

#endregion Form Events
