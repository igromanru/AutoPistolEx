#NoTrayIcon
#RequireAdmin
#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=logitech-G5.ico
#AutoIt3Wrapper_Compression=4
#AutoIt3Wrapper_UseUpx=y
#AutoIt3Wrapper_Res_Description=AutoPistol Expanded Triggerbot
#AutoIt3Wrapper_Res_Field=ProductName|AutoPistol Expanded Triggerbot
#AutoIt3Wrapper_Res_Fileversion=1.0.1.0
#AutoIt3Wrapper_Res_ProductVersion=1.0.1.0
#AutoIt3Wrapper_Res_LegalCopyright=Igromanru
#AutoIt3Wrapper_Res_Language=1031
#AutoIt3Wrapper_Res_requestedExecutionLevel=asInvoker
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
#cs ----------------------------------------------------------------------------
   Copyright (C) 2011-2017 Igromanru

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

 Script Description: AutoIt does not support multithreading, so I made a separate task for the triggerbot.

#ce ----------------------------------------------------------------------------

#Include <Misc.au3>
#include "UDF\EnhancedMouseClick.au3"

OnAutoItExitRegister( "_Cleaner" )

Global $dll = DllOpen("user32.dll")

#include "UDF\_KeyManager.au3"

If $CmdLine[0] < 9 Then
	MsgBox(48,"Error", "Triggerbot can only be startet from APEx!")
	Exit
EndIf

Global Const $sColor 	= $CmdLine[1]
Global Const $sMouse 	= $CmdLine[2]
Global Const $leftPosX 	= $CmdLine[3]
Global Const $leftPosY 	= $CmdLine[4]
Global Const $rightPosX = $CmdLine[5]
Global Const $rightPosY = $CmdLine[6]
Global Const $topPosX 	= $CmdLine[7]
Global Const $topPosY 	= $CmdLine[8]
Global Const $botPosX 	= $CmdLine[9]
Global Const $botPosY 	= $CmdLine[10]
Global Const $iShade 	= $CmdLine[11]

While 1
	If IsArray(PixelSearch($leftPosX-5, $leftPosY, $leftPosX, $leftPosY, $sColor, $iShade)) Or _
		IsArray(PixelSearch($rightPosX, $rightPosY, $rightPosX+5, $rightPosY, $sColor, $iShade)) Or _
		IsArray(PixelSearch($topPosX, $topPosY-5, $topPosX, $topPosY, $sColor, $iShade)) Or _
		IsArray(PixelSearch($botPosX, $botPosY, $botPosX, $botPosY+5, $sColor, $iShade)) Then
		_shootManager($sMouse, "")
	EndIf
	If _IsPressed("79", $dll) Then
		While _IsPressed("79", $dll) = True
			Sleep(100)
		WEnd
		_Cleaner()
	EndIf
	Sleep(1)
WEnd

;~ Func _shootManager($sBut)
;~ 	Switch $sBut
;~ 		Case "Mouse1"
;~ 			_EnhancedMouseClick($dll, "left")
;~ 		Case "Mouse2"
;~ 			_EnhancedMouseClick($dll, "right")
;~ 		Case "Mouse3"
;~ 			_EnhancedMouseClick($dll, "middle")
;~ 		Case "Mouse4"
;~ 			_EnhancedMouseClick($dll, "x1")
;~ 		Case "Mouse5"
;~ 			_EnhancedMouseClick($dll, "x2")
;~ 	EndSwitch
;~ EndFunc

Func _Cleaner()
	ControlClick("AutoPistol Expanded", "", 59, "left", 2)
	DllClose($dll)
	Exit
EndFunc