#cs ----------------------------------------------------------------------------
   Copyright (C) 2011-2014 Igromanru

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

 Script Description: This is a helpful tool wich works for most FPS-Games.
						It´s help you to fire very fast with a pistol or other similar weapons.
						Feel free to discover other features by yourself.

#ce ----------------------------------------------------------------------------

#NoTrayIcon
#RequireAdmin
#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=logitech-G5.ico
#AutoIt3Wrapper_Compression=4
#AutoIt3Wrapper_UseUpx=n
#AutoIt3Wrapper_Res_Description=AutoPistol Expanded
#AutoIt3Wrapper_Res_Fileversion=1.7.8.0
#AutoIt3Wrapper_Res_ProductVersion=1.7.8.0
#AutoIt3Wrapper_Res_LegalCopyright=Igromanru
#AutoIt3Wrapper_Res_requestedExecutionLevel=requireAdministrator
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****

Global Const $VERSION = "1.7.8"
Global Const $FORM_NAME = "AutoPistol Expanded v" & $VERSION & " : : by Igromanru"
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
;~ #Include <WinAPIEx.au3>
;~ #include <INet.au3>

;~ #include "Blowfish_UDF.au3"
#include "UDF\EnhancedMouseClick.au3"

Global Const $PROG = "AutoPistolEx v" & $VERSION
Global Const $STARTED_TIME = @HOUR & ":" & @MIN

SplashTextOn("APEx Starting","Booting, please wait...", 224, 86, -1, -1, 1+32, "", 11)
;~ Global Const $HWID = _WinAPI_UniqueHardwareID($UHID_All)
SplashOff()
;~ _checkHWID()

; Igromanru HWID: {68A91514-23C2-FDE2-E88E-ED7E4F5EF5F2}
FileInstall(".\data\activated.wav", @TempDir & "\activated.wav", 1)
FileInstall(".\data\deactivated.wav", @TempDir & "\deactivated.wav", 1)
FileInstall(".\data\leftPoint.jpg", @TempDir & "\leftPoint.jpg", 1)
FileInstall(".\data\rightPoint.jpg", @TempDir & "\rightPoint.jpg", 1)
FileInstall(".\data\topPoint.jpg", @TempDir & "\topPoint.jpg", 1)
FileInstall(".\data\botPoint.jpg", @TempDir & "\botPoint.jpg", 1)

#region Global define
Global Const $COPYRIGHT = _StringToHex("Igromanru © 2011-2014")

Global $Input[10], $Enter[10][2]
Global $sKey, $sClicksKey
Global $iXRecoilValue = 0
Global $slider1_old, $slider2_old, $slider3_old, $slidRec_old, $slidXRec_old, $slidXdis_old, $slidXpos_old, $slidYdis_old, $slidYpos_old, $sliderClicks_old
Global $sendphp, $rdyprog
;~ Global $oIE
Global $Form2, $leftPoint, $rightPoint, $topPoint, $botPoint
Global $aMainPos[2], $aDis[2]
Global $trigRuns = True
Global $sShadeItems
Global $FromLog
Global $actAPkey = "7A"
$aMainPos[0] = 125
$aMainPos[1] = 125
$aDis[0] = 0
$aDis[1] = 0
#endregion Global define

Opt("GUIOnEventMode", 1)
Opt("TrayMenuMode", 1)
Opt("TrayOnEventMode", 1)

#region Form1
$Form1 = GUICreate($FORM_NAME, 400, 430, -1, -1)
GUISetOnEvent($GUI_EVENT_CLOSE, "SpecialEvents")
GUISetOnEvent($GUI_EVENT_MINIMIZE, "SpecialEvents")
$Label1337 = GUICtrlCreateLabel(_HexToString($COPYRIGHT), 110, 408, 150, 23)
GUICtrlSetFont(-1, 9, 400, 0, "Ebrima")
GUICtrlSetColor(-1, 0x000080)
$LabelChanges = GUICtrlCreateLabel("Changelog", 310, 408, 100, 23)
GUICtrlSetFont(-1, 9, 400, 0, "Ebrima")
GUICtrlSetColor(-1, 0xc11c20)
GUICtrlSetOnEvent(-1, "_showChangelog")
GUICtrlSetCursor(-1, 0)
$Tab1 = GUICtrlCreateTab(10, 1, 380, 405)
#region AutoPistol_Tab
;=============Auto Pistol================================
$APtab = GUICtrlCreateTabItem("AutoPistol")
$LabAPkey = GUICtrlCreateLabel("AP HotKey:", 39, 36, 77, 18)
GUICtrlSetBkColor(-1, 0xFFFFFF)
GUICtrlSetTip(-1, "Hotkey for AutoShooting")
$cbAPkey = GUICtrlCreateCombo("", 98, 34, 73, 25, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
GUICtrlSetData(-1, "Mouse1|Mouse2|Mouse3|Mouse4|Mouse5|NumPad0|NumPad1|NumPad2|NumPad3|NumPad4|NumPad5|NumPad6|NumPad7|NumPad8|NumPad9|F1|F2|F3|F4|F5", "Mouse1")
GUICtrlSetTip(-1, "Hotkey for AutoShooting")
$LabShootKey = GUICtrlCreateLabel("ShootKey:", 44, 66, 54, 18)
GUICtrlSetBkColor(-1, 0xFFFFFF)
GUICtrlSetTip(-1, "AutoPistolEx hiting on this key, while you hold the AutoPistol key")
$cbShootKey = GUICtrlCreateCombo("", 98, 62, 73, 25, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
GUICtrlSetData(-1, "Off|Mouse1|Mouse2|Mouse3|Mouse4|Mouse5|NumPad0|NumPad7|NumPad8|NumPad9", "Mouse4")
GUICtrlSetTip(-1, "AutoPistolEx hitting on this key, while you hold the AutoPistol key")
$LabWhileKey = GUICtrlCreateLabel("Press While:", 36, 92, 65, 18)
GUICtrlSetBkColor(-1, 0xFFFFFF)
GUICtrlSetTip(-1, "AutoPistolEx pressing on this key, while you hold the AutoPistol key")
$cbWhilekey = GUICtrlCreateCombo("", 98, 89, 73, 25, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
GUICtrlSetData(-1, "Off|Mouse1|Mouse2|Mouse3|Mouse4|Mouse5", "Off")
GUICtrlSetTip(-1, "AutoPistolEx pressing on this key, while you hold the AutoPistol key")
$LabSpeed = GUICtrlCreateLabel("Speed:", 22, 123, 38, 18)
GUICtrlSetBkColor(-1, 0xFFFFFF)
GUICtrlSetTip(-1, "Speed of AutoPistol shooting")
$Slider1 = GUICtrlCreateSlider(62, 120, 275, 23)
GUICtrlSetLimit(-1, 20, 0)
GUICtrlSetOnEvent(-1, "_onSliderChange")
GUICtrlSetTip(-1, "Speed of AutoPistol shooting")
$LabSPslow = GUICtrlCreateLabel("Slow", 315, 145, 29, 18)
GUICtrlSetBkColor(-1, 0xFFFFFF)
$LabSPFast = GUICtrlCreateLabel("Fast", 63, 145, 25, 18)
GUICtrlSetBkColor(-1, 0xFFFFFF)
$LabSpeedValue = GUICtrlCreateLabel("1", 192, 145, 28, 18)
GUICtrlSetBkColor(-1, 0xFFFFFF)
$LabMS = GUICtrlCreateLabel("ms", 226, 145, 18, 18)
GUICtrlSetBkColor(-1, 0xFFFFFF)
;=============AP Activation and Save================================
$CheckActiv = GUICtrlCreateCheckbox("Activate AutoPistol", 190, 36, 105, 17)
GUICtrlSetOnEvent(-1, "CheckActivClick")
$cbAPtoggle = GUICtrlCreateCombo("", 300, 34, 62, 18, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
GUICtrlSetData(-1, "Off|F1|F2|F3|F4|F5|F6|F7|F8|F9|F10|F11|F12|Mouse4|Mouse5", "F11")
GUICtrlSetTip(-1, "Activation/Deactivation Hotkey")
$CheckSave = GUICtrlCreateCheckbox("AutoSave on Exit", 190, 63, 111, 17)
GUICtrlSetState(-1, $GUI_CHECKED)
;=============Burst Fire================================
$SlidBurst = GUICtrlCreateSlider(78, 185, 275, 23)
GUICtrlSetLimit(-1, 30, 0)
GUICtrlSetTip(-1, "Burstfire time")
GUICtrlSetOnEvent(-1, "_onBurstChange")
$LabBurst = GUICtrlCreateLabel("Off", 206, 212, 28, 18)
GUICtrlSetBkColor(-1, 0xFFFFFF)
$LabBurMD = GUICtrlCreateLabel("ms", 235, 212, 18, 18)
GUICtrlSetBkColor(-1, 0xFFFFFF)
$LabBurstTime = GUICtrlCreateLabel("Burst time:", 22, 185, 55, 18)
GUICtrlSetTip(-1, "Burstfire time")
GUICtrlSetBkColor(-1, 0xFFFFFF)
$SlidDelay = GUICtrlCreateSlider(78, 232, 275, 23)
GUICtrlSetLimit(-1, 30, 1)
GUICtrlSetTip(-1, "Sleeping time afte the Burstfire")
GUICtrlSetOnEvent(-1, "_onDelayChange")
$LabDelMS = GUICtrlCreateLabel("ms", 235, 258, 18, 18)
GUICtrlSetBkColor(-1, 0xFFFFFF)
$LabDelay = GUICtrlCreateLabel("0", 206, 258, 28, 18)
GUICtrlSetBkColor(-1, 0xFFFFFF)
$LabDelayTime = GUICtrlCreateLabel("Delay time:", 22, 232, 56, 18)
GUICtrlSetTip(-1, "Sleeping time afte the Burstfire")
GUICtrlSetBkColor(-1, 0xFFFFFF)
;=============Recoil Keeper================================
$SlidRecoil = GUICtrlCreateSlider(90, 280, 275, 23)
GUICtrlSetLimit(-1, 50, 0)
GUICtrlSetOnEvent(-1, "_onRecoilChange")
GUICtrlSetTip(-1, "Moving the mouse  down in Pixel")
$LabRecoil = GUICtrlCreateLabel("Recoil Keeper:", 16, 283, 74, 18)
GUICtrlSetBkColor(-1, 0xFFFFFF)
GUICtrlSetTip(-1, "Moving the mouse down in Pixel")
$LabRecoilSpeed = GUICtrlCreateLabel("Pixel", 240, 305, 30, 18)
GUICtrlSetBkColor(-1, 0xFFFFFF)
GUICtrlSetTip(-1, "Moving the mouse down in Pixel")
$LabRecoilStr = GUICtrlCreateLabel("Off", 218, 305, 18, 18)
GUICtrlSetBkColor(-1, 0xFFFFFF)
GUICtrlSetTip(-1, "Moving the mouse down in Pixel")
$LabRecSpeed = GUICtrlCreateLabel("Speed:", 52, 319, 38, 18)
GUICtrlSetTip(-1, "20 Fast, 1 Slow (not in ms)")
$cbRecSpeed = GUICtrlCreateCombo("", 90, 315, 42, 25, BitOR($CBS_DROPDOWN, $CBS_AUTOHSCROLL, $WS_VSCROLL))
GUICtrlSetData(-1, "20|19|18|17|16|15|14|13|12|11|10|9|8|7|6|5|4|3|2|1", "10")
GUICtrlSetTip(-1, "20 Fast, 1 Slow (not in ms)")
;=============Recoil Keeper X==============================
$SlidXRecoil = GUICtrlCreateSlider(100, 345, 275, 23)
GUICtrlSetLimit(-1, 50, 0)
GUICtrlSetData(-1, 25)
GUICtrlSetOnEvent(-1, "_onXRecoilChange")
GUICtrlSetTip(-1, "Moving the mouse left or right in Pixel")
$LabXRecoil = GUICtrlCreateLabel("Recoil Keeper X:", 16, 350, 80, 18)
GUICtrlSetBkColor(-1, 0xFFFFFF)
GUICtrlSetTip(-1, "Moving the mouse left or right in Pixel")
$LabXRecoilSpeed = GUICtrlCreateLabel("Pixel", 250, 370, 30, 18)
GUICtrlSetBkColor(-1, 0xFFFFFF)
GUICtrlSetTip(-1, "Moving the mouse left or right in Pixel")
$LabXRecoilStr = GUICtrlCreateLabel("Off", 228, 370, 18, 18)
GUICtrlSetBkColor(-1, 0xFFFFFF)
GUICtrlSetTip(-1, "Moving the mouse left or right in Pixel")
$LabXRecSpeed = GUICtrlCreateLabel("Speed:", 52, 379, 38, 18)
GUICtrlSetTip(-1, "20 Fast, 1 Slow (NOT in ms)")
$cbXRecSpeed = GUICtrlCreateCombo("", 90, 375, 42, 25, BitOR($CBS_DROPDOWN, $CBS_AUTOHSCROLL, $WS_VSCROLL))
GUICtrlSetData(-1, "20|19|18|17|16|15|14|13|12|11|10|9|8|7|6|5|4|3|2|1", "10")
GUICtrlSetTip(-1, "20 Fast, 1 Slow (NOT in ms)")
_onXRecoilChange()
#endregion AutoPistol_Tab

#region	Triggerbot_Tab
$keyTrigTab = GUICtrlCreateTabItem("Triggerbot")
$ActivTrigCfg = GUICtrlCreateCheckbox("Position Configuration", 26, 38, 133, 17)
GUICtrlSetOnEvent(-1, "_ActivTrigCfgClick")
$CheckTrigSave = GUICtrlCreateCheckbox("AutoSave on Exit", 260, 290, 100, 17)
GUICtrlSetState(-1, $GUI_CHECKED)
$cbTrigShootKey = GUICtrlCreateCombo("", 290, 38, 65, 25, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
GUICtrlSetData(-1, "Mouse1|Mouse2|Mouse3|Mouse4|Mouse5", "Mouse4")
GUICtrlSetTip(-1, "AutoPistolEx hitting on this key, if the trigger color has been found")
$LabTrigShootKey = GUICtrlCreateLabel("ShootKey:", 235, 42, 54, 18)
GUICtrlSetBkColor(-1, 0xFFFFFF)
$LabTrigShade = GUICtrlCreateLabel("Shade:", 250, 74, 50, 18)
GUICtrlSetBkColor(-1, 0xFFFFFF)
GUICtrlSetTip(-1, "AutoPistolEx hitting on this key, if the trigger color has been found")
$cbShadeColor = GUICtrlCreateCombo("", 290, 70, 65, 25, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL, $WS_VSCROLL))
For $i = 0 To 255
	$sShadeItems &= $i
	If $i < 255 Then
		$sShadeItems &= "|"
	EndIf
Next
GUICtrlSetData(-1, $sShadeItems, "15")
;=============Select Color================================
$InColor = GUICtrlCreateInput("", 80, 68, 60, 22)
$LabTrigColor = GUICtrlCreateLabel("Color Hex:", 26, 72, 54, 18)
GUICtrlSetBkColor(-1, 0xFFFFFF)
$TrigColorSel = GUICtrlCreateButton("Select Color", 142, 67, 75, 25)
GUICtrlSetOnEvent(-1, "_TrigColorSelClick")
;=============X Distance==================================
$SlidXdis = GUICtrlCreateSlider(80, 102, 275, 23)
GUICtrlSetOnEvent(-1, "_onXdisChange")
GUICtrlSetState( -1, $GUI_DISABLE)
$LabXdis = GUICtrlCreateLabel("x distance:", 22, 104, 57, 18)
GUICtrlSetBkColor(-1, 0xFFFFFF)
$LabXdisVal = GUICtrlCreateLabel("0", 210, 128, 22, 18)
GUICtrlSetBkColor(-1, 0xFFFFFF)
GUICtrlSetState( -1, $GUI_DISABLE)
$LabXpx = GUICtrlCreateLabel("Pixel", 230, 128, 26, 18)
GUICtrlSetState( -1, $GUI_DISABLE)
GUICtrlSetBkColor(-1, 0xFFFFFF)
$ActivXdis = GUICtrlCreateCheckbox("Activate X", 80, 130, 80, 17)
GUICtrlSetOnEvent(-1, "_ActivXdis")
GUICtrlSetState( -1, $GUI_CHECKED)
GUICtrlSetState( -1, $GUI_DISABLE)
;=============Y Distance==================================
$SlidYdis = GUICtrlCreateSlider(80, 151, 275, 23)
GUICtrlSetOnEvent(-1, "_onYdisChange")
GUICtrlSetState( -1, $GUI_DISABLE)
$LabYdis = GUICtrlCreateLabel("y distance:", 22, 151, 57, 18)
GUICtrlSetBkColor(-1, 0xFFFFFF)
$LabYdisVal = GUICtrlCreateLabel("0", 210, 176, 22, 18)
GUICtrlSetBkColor(-1, 0xFFFFFF)
GUICtrlSetState( -1, $GUI_DISABLE)
$LabYpx = GUICtrlCreateLabel("Pixel", 230, 176, 26, 18)
GUICtrlSetBkColor(-1, 0xFFFFFF)
GUICtrlSetState( -1, $GUI_DISABLE)
$ActivYdis = GUICtrlCreateCheckbox("Activate Y", 80, 185, 80, 17)
GUICtrlSetOnEvent(-1, "_ActivYdis")
GUICtrlSetState( -1, $GUI_CHECKED)
GUICtrlSetState( -1, $GUI_DISABLE)
;============X Position==================================
$SlidXpos = GUICtrlCreateSlider(80, 210, 275, 23)
GUICtrlSetData(-1, 50)
GUICtrlSetOnEvent(-1, "_onXposChange")
GUICtrlSetState( -1, $GUI_DISABLE)
$LabXpos = GUICtrlCreateLabel("x position:", 22, 210, 57, 18)
GUICtrlSetBkColor(-1, 0xFFFFFF)
$LabXposVal = GUICtrlCreateLabel("0", 210, 236, 22, 18)
GUICtrlSetBkColor(-1, 0xFFFFFF)
GUICtrlSetState( -1, $GUI_DISABLE)
$LabXpx2 = GUICtrlCreateLabel("Pixel", 230, 236, 26, 18)
GUICtrlSetBkColor(-1, 0xFFFFFF)
GUICtrlSetState( -1, $GUI_DISABLE)
;============Y Position=================================
$SlidYpos = GUICtrlCreateSlider(80, 260, 275, 23)
GUICtrlSetData(-1, 50)
GUICtrlSetOnEvent(-1, "_onYposChange")
GUICtrlSetState( -1, $GUI_DISABLE)
$LabYpos = GUICtrlCreateLabel("y position:", 22, 260, 57, 18)
GUICtrlSetBkColor(-1, 0xFFFFFF)
$LabYposVal = GUICtrlCreateLabel("0", 210, 285, 22, 18)
GUICtrlSetBkColor(-1, 0xFFFFFF)
GUICtrlSetState( -1, $GUI_DISABLE)
$LabYpx2 = GUICtrlCreateLabel("Pixel", 230, 285, 26, 18)
GUICtrlSetBkColor(-1, 0xFFFFFF)
GUICtrlSetState( -1, $GUI_DISABLE)
;============Run and Stop=================================
$ActivTrigRun = GUICtrlCreateCheckbox("Allow to run", 26, 290, 133, 17)
GUICtrlSetOnEvent(-1, "_ActivateTrigger")
$TrigRunBut = GUICtrlCreateButton("Run (F10)", 80, 310, 75, 31)
GUICtrlSetOnEvent(-1, "_TriggerRun")
GUICtrlSetState( -1, $GUI_DISABLE)
$TrigStopBut = GUICtrlCreateButton("Stop (F10)", 220, 310, 75, 31)
GUICtrlSetOnEvent(-1, "_TriggerStop")
GUICtrlSetState( -1, $GUI_DISABLE)
#endregion Triggerbot_Tab

#region Keybinder_Tab
$keyBinderTab = GUICtrlCreateTabItem("Keybinder")
$Input[0] = GUICtrlCreateInput("", 145, 30, 125, 21)
$Input[1] = GUICtrlCreateInput("", 145, 60, 125, 21)
$Input[2] = GUICtrlCreateInput("", 145, 90, 125, 21)
$Input[3] = GUICtrlCreateInput("", 145, 118, 125, 21)
$Input[4] = GUICtrlCreateInput("", 145, 148, 125, 21)
$Input[5] = GUICtrlCreateInput("", 145, 178, 125, 21)
$Input[6] = GUICtrlCreateInput("", 145, 208, 125, 21)
$Input[7] = GUICtrlCreateInput("", 145, 236, 125, 21)
$Input[8] = GUICtrlCreateInput("", 145, 264, 125, 21)
$Input[9] = GUICtrlCreateInput("", 145, 294, 125, 21)
$Label1 = GUICtrlCreateLabel("Numpad 0:", 25, 32, 56, 17)
GUICtrlSetBkColor(-1, 0xFFFFFF)
$Enter[0][0] = GUICtrlCreateCheckbox("Enter", 90, 30, 47, 17)
$Enter[0][1] = GUICtrlCreateCheckbox("Enter", 280, 30, 45, 17)
$Label2 = GUICtrlCreateLabel("Numpad 1:", 25, 64, 56, 17)
GUICtrlSetBkColor(-1, 0xFFFFFF)
$Enter[1][0] = GUICtrlCreateCheckbox("Enter", 90, 62, 47, 17)
$Enter[1][1] = GUICtrlCreateCheckbox("Enter", 280, 62, 45, 17)
$Label3 = GUICtrlCreateLabel("Numpad 2:", 25, 94, 56, 17)
GUICtrlSetBkColor(-1, 0xFFFFFF)
$Enter[2][0] = GUICtrlCreateCheckbox("Enter", 90, 92, 47, 17)
$Enter[2][1] = GUICtrlCreateCheckbox("Enter", 280, 92, 45, 17)
$Label4 = GUICtrlCreateLabel("Numpad 3:", 25, 122, 56, 17)
GUICtrlSetBkColor(-1, 0xFFFFFF)
$Enter[3][0] = GUICtrlCreateCheckbox("Enter", 90, 120, 47, 17)
$Enter[3][1] = GUICtrlCreateCheckbox("Enter", 280, 120, 45, 17)
$Label5 = GUICtrlCreateLabel("Numpad 4:", 25, 152, 56, 17)
GUICtrlSetBkColor(-1, 0xFFFFFF)
$Enter[4][0] = GUICtrlCreateCheckbox("Enter", 90, 150, 47, 17)
$Enter[4][1] = GUICtrlCreateCheckbox("Enter", 280, 150, 45, 17)
$Label6 = GUICtrlCreateLabel("Numpad 5:", 25, 182, 56, 17)
GUICtrlSetBkColor(-1, 0xFFFFFF)
$Enter[5][0] = GUICtrlCreateCheckbox("Enter", 90, 180, 47, 17)
$Enter[5][1] = GUICtrlCreateCheckbox("Enter", 280, 180, 45, 17)
$Label7 = GUICtrlCreateLabel("Numpad 6:", 25, 212, 60, 17)
GUICtrlSetBkColor(-1, 0xFFFFFF)
$Enter[6][0] = GUICtrlCreateCheckbox("Enter", 90, 210, 47, 17)
$Enter[6][1] = GUICtrlCreateCheckbox("Enter", 280, 210, 45, 17)
$Label8 = GUICtrlCreateLabel("Numpad 7:", 25, 240, 56, 17)
GUICtrlSetBkColor(-1, 0xFFFFFF)
$Enter[7][0] = GUICtrlCreateCheckbox("Enter", 90, 238, 47, 17)
$Enter[7][1] = GUICtrlCreateCheckbox("Enter", 280, 238, 45, 17)
$Label9 = GUICtrlCreateLabel("Numpad 8:", 25, 268, 56, 17)
GUICtrlSetBkColor(-1, 0xFFFFFF)
$Enter[8][0] = GUICtrlCreateCheckbox("Enter", 90, 266, 47, 17)
$Enter[8][1] = GUICtrlCreateCheckbox("Enter", 280, 266, 45, 17)
$Label10 = GUICtrlCreateLabel("Numpad 9:", 25, 298, 56, 17)
GUICtrlSetBkColor(-1, 0xFFFFFF)
$Enter[9][0] = GUICtrlCreateCheckbox("Enter", 90, 296, 47, 17)
$Enter[9][1] = GUICtrlCreateCheckbox("Enter", 280, 296, 45, 17)
$Savebox = GUICtrlCreateCheckbox("AutoSave on Exit", 223, 324, 97, 17)
GUICtrlSetBkColor(-1, 0xFFFFFF)
GUICtrlSetState(-1, $GUI_CHECKED)
$checkAct = GUICtrlCreateCheckbox("Activate Keybinder", 25, 324, 110, 17)
GUICtrlSetBkColor(-1, 0xFFFFFF)
For $a = 0 To 9
	GUICtrlSetBkColor($Enter[$a][0], 0xFFFFFF)
	GUICtrlSetBkColor($Enter[$a][1], 0xFFFFFF)
Next
#endregion Keybinder_Tab

#region Clicks-Bot
;=============Clicks-Bot================================
$keyClicksTab = GUICtrlCreateTabItem("Clicks-Bot")
$LabClickHotkey = GUICtrlCreateLabel("HotKey:", 20, 36, 77, 18)
GUICtrlSetBkColor(-1, 0xFFFFFF)
GUICtrlSetTip(-1, "Start Hotkey for the Clicker")
$cbClickHotkey = GUICtrlCreateCombo("", 68, 34, 73, 25, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
GUICtrlSetData(-1, "Mouse1|Mouse2|Mouse3|Mouse4|Mouse5|F1|F2|F3|F4|F5|F6|F7|F8|F9|F10|F11|F12|Spacebar|NumPad0|NumPad1|NumPad2|NumPad3|NumPad4|NumPad5|NumPad6|NumPad7|NumPad8|NumPad9", "Mouse4")
GUICtrlSetTip(-1, "Start Hotkey for the Clicker")
$LabClickKey = GUICtrlCreateLabel("ClickOn:", 20, 66, 54, 18)
GUICtrlSetBkColor(-1, 0xFFFFFF)
GUICtrlSetTip(-1, "Which kind of Key should be clicked")
$cbClicktKey = GUICtrlCreateCombo("", 68, 62, 73, 25, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
GUICtrlSetData(-1, "Off|Mouse1|Mouse2|Mouse3|Mouse4|Mouse5", "Mouse1")
GUICtrlSetTip(-1, "Which kind of Key should be clicked")
$LabClickKey = GUICtrlCreateLabel("Clicks:", 28, 96, 30, 18)
GUICtrlSetBkColor(-1, 0xFFFFFF)
GUICtrlSetTip(-1, "Number of Clicks")
$InClicks = GUICtrlCreateInput("1", 68, 92, 70, 22)
$SliderClicksSpeed = GUICtrlCreateSlider(62, 120, 275, 23)
GUICtrlSetLimit(-1, 20, 0)
GUICtrlSetOnEvent(-1, "_onClicksSpeedChange")
GUICtrlSetTip(-1, "Speed of AutoPistol shooting")
$LabClicksSpeed = GUICtrlCreateLabel("Speed:", 22, 123, 38, 18)
GUICtrlSetBkColor(-1, 0xFFFFFF)
GUICtrlSetTip(-1, "Speed of AutoPistol shooting")
$LabClicksSPslow = GUICtrlCreateLabel("Slow", 315, 145, 29, 18)
GUICtrlSetBkColor(-1, 0xFFFFFF)
$LabClicksSPFast = GUICtrlCreateLabel("Fast", 63, 145, 25, 18)
GUICtrlSetBkColor(-1, 0xFFFFFF)
$LabClicksSpeedValue = GUICtrlCreateLabel("1", 192, 145, 28, 18)
GUICtrlSetBkColor(-1, 0xFFFFFF)
$LabClicksMS = GUICtrlCreateLabel("ms", 226, 145, 18, 18)
GUICtrlSetBkColor(-1, 0xFFFFFF)
;=============Clicker Activation and Save================================
$CheckClicksActiv = GUICtrlCreateCheckbox("Activate Clicks-Bot", 190, 36, 105, 17)
GUICtrlSetOnEvent(-1, "_checkActivClicksBot")
$CheckClicksSave = GUICtrlCreateCheckbox("AutoSave on Exit", 190, 63, 111, 17)
GUICtrlSetState(-1, $GUI_CHECKED)
#endregion Clicks-Bot

#region Settings
$keySettingsTab = GUICtrlCreateTabItem("Settings")
#endregion Settings

GUICtrlCreateTabItem("")
GUISetState(@SW_SHOW)
#endregion #region Form1

If FileExists(@ScriptDir&"\APEx.ini") = 1 Then
	Call("LoadCfg")
EndIf
$dll = DllOpen("user32.dll")

#include "UDF\_KeyManager.au3"

GUIRegisterMsg( $WM_HSCROLL, "WM_HSCROLL" )
;~ TraySetOnEvent($TRAY_EVENT_PRIMARYDOUBLE, "maxGui")
;~ If @error Then
;~ 	MsgBox(0, "Error", "TraysetOnEvent")
;~ EndIf

#region Main Loop
While 1
	; Triggerbot part
	If $trigRuns = False Then
		If _IsPressed("79", $dll) Then
			While _IsPressed("79", $dll) = True
				Sleep(100)
			WEnd
			_TriggerRun()
		EndIf
	EndIf
	; AutoPistol part
	If GUICtrlRead($CheckActiv) = $GUI_UNCHECKED Then
		_getAPactHotkey($actAPkey, GUICtrlRead($cbAPtoggle))
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
	If GUICtrlRead($CheckActiv) = $GUI_CHECKED Then
		If GUICtrlRead($cbAPkey) = GUICtrlRead($cbShootKey) Then
			If GUICtrlRead($cbAPkey) = "Mouse1" And GUICtrlRead($cbShootKey) = "Mouse1" Then
				_AutoPistol()
			Else
				MsgBox(16, "Warning", '"AutoPistol Key" and "Shoot Key" can not have the same Value!')
				GUICtrlSetState($CheckActiv, $GUI_UNCHECKED)
				CheckActivClick()
			EndIf
		ElseIf GUICtrlRead($cbWhilekey) = GUICtrlRead($cbShootKey) Then
			MsgBox(16, "Warning", '"Shoot Key" and "Press While Key" can not have the same Value!')
			GUICtrlSetState($CheckActiv, $GUI_UNCHECKED)
			CheckActivClick()
		Else
			_AutoPistol()
		EndIf
	EndIf
;~ 	If _IsPressed("7B", $dll) Then
;~ 		While _IsPressed("7B", $dll) = 1
;~ 			Sleep(1)
;~ 		WEnd
;~ 		If $logOn = True Then
;~ 			SoundPlay(@TempDir & "\record_stopped.wav")
;~ 			$logOn = False
;~ 		Else
;~ 			SoundPlay(@TempDir & "\record_started.wav")
;~ 			$logOn = True
;~ 		EndIf
;~ 	ElseIf _IsPressed("7A", $dll) Then
;~ 		SoundPlay(@TempDir & "\record_deleted.wav")
;~ 		GUICtrlSetData($Input[9], "")
;~ 	EndIf
    ; Keybinder part
	If GUICtrlRead($checkAct) = $GUI_CHECKED Then
		If keyState() = 1 Then
			Sleep(500)
		EndIf
	EndIf
	; Clicks-Bot Part
	If GUICtrlRead($CheckClicksActiv) = $GUI_CHECKED Then
		_ClicksBot()
	EndIf
	Sleep(1)
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
	ElseIf GUICtrlRead($SlidXRecoil) <> $slidXRec_old Then
		_onXRecoilChange()
		$slidXRec_old = GUICtrlRead($SlidXRecoil)
	EndIf
	If GUICtrlRead($SlidXdis) <> $slidXdis_old Then
		_onXdisChange()
		$slidXdis_old = GUICtrlRead($SlidXdis)
	ElseIf GUICtrlRead($SlidXpos) <> $slidXpos_old Then
		_onXposChange()
		$slidXpos_old = GUICtrlRead($SlidXpos)
	ElseIf GUICtrlRead($SlidYdis) <> $slidYdis_old Then
		_onYdisChange()
		$slidYdis_old = GUICtrlRead($SlidYdis)
	ElseIf GUICtrlRead($SlidYpos) <> $slidYpos_old Then
		_onYposChange()
		$slidYpos_old = GUICtrlRead($SlidYpos)
	EndIf
	; Clicks-Bot
	If GUICtrlRead($SliderClicksSpeed) <> $sliderClicks_old Then
		_onClicksSpeedChange()
		$sliderClicks_old = GUICtrlRead($SliderClicksSpeed)
	EndIf
EndFunc

#include "UDF\_Keybinder.au3"
#include "UDF\_AutoPistol.au3"
#include "UDF\_Clicks-Bot.au3"

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
	Local $iValue = GUICtrlRead($SlidRecoil)

	Switch $iValue
		Case 0
			$iValue = "Off"
			GUICtrlSetState($cbRecSpeed, $GUI_DISABLE)
			GUICtrlSetState($LabRecSpeed, $GUI_DISABLE)
		Case Else
			GUICtrlSetState($cbRecSpeed, $GUI_ENABLE)	;enable MouseMove speed
			GUICtrlSetState($LabRecSpeed, $GUI_ENABLE)
	EndSwitch
	GUICtrlSetData($LabRecoilStr, $iValue)
	Return $iValue
EndFunc   ;==>_onRecoilChange

Func _onXRecoilChange()
	Local $iValue = GUICtrlRead($SlidXRecoil)

	Switch $iValue
		Case 25
			GUICtrlSetData($LabXRecoilStr, "Off")
			$iXRecoilValue = 0
			GUICtrlSetState($cbXRecSpeed, $GUI_DISABLE)
			GUICtrlSetState($LabXRecSpeed, $GUI_DISABLE)
		Case Else
			$iXRecoilValue = $iValue - 25
			GUICtrlSetState($cbXRecSpeed, $GUI_ENABLE)
			GUICtrlSetState($LabXRecSpeed, $GUI_ENABLE)
			GUICtrlSetData($LabXRecoilStr, $iXRecoilValue)
	EndSwitch
	Return $iXRecoilValue
EndFunc   ;==>_onXRecoilChange

Func _onClicksSpeedChange()
	Local $iSleep = GUICtrlRead($SliderClicksSpeed)

	Switch $iSleep
		Case 0
			$iSleep = 1
		Case Else
			$iSleep *= 50
	EndSwitch
	GUICtrlSetData($LabClicksSpeedValue, $iSleep)
	Return $iSleep
EndFunc
#endregion OnChange Functions

#include "UDF\_Triggerbot.au3"

#region Changelog
Func _showChangelog()
	Local $fopen, $sChangeLog

	FileInstall(".\APEx_Changelog.txt", @TempDir & "\APEx_Changelog.txt")
	$FromLog = GUICreate("Changelog", 453, 367, -1, -1, BitOR($DS_MODALFRAME, $DS_SETFOREGROUND, $WS_SYSMENU), $WS_EX_TOOLWINDOW, $Form1)
	GUISetOnEvent($GUI_EVENT_CLOSE, "_changeLogClose")
	$ChangeEdit = GUICtrlCreateEdit("", 4, 4, 441, 337, BitOR($GUI_SS_DEFAULT_EDIT,$ES_READONLY))
	GUISetState(@SW_SHOW)
	GUISetState(@SW_DISABLE, $Form1)
	$fopen = FileOpen(@TempDir & "\APEx_Changelog.txt")
	$sChangeLog = FileRead($fopen)
	FileClose($fopen)
	GUICtrlSetData($ChangeEdit, $sChangeLog)
EndFunc

Func _changeLogClose()
	GUISetState(@SW_ENABLE, $Form1)
	GUIDelete($FromLog)
	FileDelete(@TempDir & "\APEx_Changelog.txt")
EndFunc
#endregion Changelog

#include "UDF\_SaveAndLoad.au3"

;~ Func _checkHWID()
;~ 	Local $sCrypt =	_INetGetSource("http://web1.hc121089.tuxtools.net/crypt.html")
;~ 	Local $sDeCrypt = Blowfish(_HexToString("4967726f4175746f506973746f6c4578"), $sCrypt, 1)
;~ 	If StringInStr($sDeCrypt, $HWID) = 0 Then
;~ 		ClipPut($HWID)
;~ 		MsgBox(48, "Error", "HWID: "&$HWID&" is not in the list!")
;~ 		Exit
;~ 	EndIf
;~ 	ClipPut("Congratulation! Your HWID is in the list!")
;~ EndFunc

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
			FileDelete(@TempDir & "\leftPoint.jpg")
			FileDelete(@TempDir & "\rightPoint.jpg")
			FileDelete(@TempDir & "\topPoint.jpg")
			FileDelete(@TempDir & "\botPoint.jpg")
			FileDelete(@TempDir & "\APEx_Changelog.txt")

			_TriggerStop()
			Exit

;~         Case @GUI_CtrlId = $GUI_EVENT_MINIMIZE
;~ 			GUISetState(@SW_HIDE, $Form1)
;~ 			Opt("TrayIconHide", 0)
;~ 			TrayTip("I am here now!", "Restore me with a doubleclick", 5)

		Case @GUI_CtrlId = $GUI_EVENT_RESTORE

	EndSelect
EndFunc   ;==>SpecialEvents

;~ Func _ShutDownForm()
;~ 	$ShutForm = GUICreate("AutoPistol Expanded Shutting Down", 224, 86, -1, -1, BitOR($WS_SIZEBOX,$WS_THICKFRAME,$WS_SYSMENU,$WS_POPUP,$DS_MODALFRAME), -1, $Form1)
;~ 	$Label1 = GUICtrlCreateLabel("Shutting down, please wait...", 22, 34, 169, 20)
;~ 	GUICtrlSetFont(-1, 10, 400, 0, "MS Sans Serif")
;~ 	GUISetState(@SW_SHOW)
;~ EndFunc
#endregion Form Events
;~ Func maxGui()
;~ 	$ergui = GUISetState(@SW_SHOW, $Form1)
;~ 	If $ergui = 0 Then
;~ 		MsgBox(0, "Error", "Restore Error")
;~ 	EndIf
;~ 	Opt("TrayIconHide", 1)
;~ EndFunc   ;==>maxGui