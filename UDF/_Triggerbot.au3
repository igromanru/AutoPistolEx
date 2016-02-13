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

#region Triggerbot Functions
Func _ActivXdis()
	If GUICtrlRead($ActivXdis) = $GUI_CHECKED Then
		GUICtrlSetState($leftPoint, $GUI_SHOW)
		GUICtrlSetState($rightPoint, $GUI_SHOW)
	Else
		GUICtrlSetState($leftPoint, $GUI_HIDE)
		GUICtrlSetState($rightPoint, $GUI_HIDE)
	EndIf
EndFunc

Func _ActivYdis()
	If GUICtrlRead($ActivYdis) = $GUI_CHECKED Then
		GUICtrlSetState($topPoint, $GUI_SHOW)
		GUICtrlSetState($botPoint, $GUI_SHOW)
	Else
		GUICtrlSetState($topPoint, $GUI_HIDE)
		GUICtrlSetState($botPoint, $GUI_HIDE)
	EndIf
EndFunc

Func _ActivateTrigger()
	If GUICtrlRead($ActivTrigRun) = $GUI_CHECKED Then
		GUICtrlSetState($TrigRunBut, $GUI_ENABLE)
		$trigRuns = False
	Else
		GUICtrlSetState($TrigRunBut, $GUI_DISABLE)
		$trigRuns = True
	EndIf
EndFunc

Func _ToggleTriggerBot()
	IF $bTriggerRuning Then
		_TriggerStop()
	Else
		_TriggerRun()
	EndIf
EndFunc

Func _TriggerRun()
	Local $sColor, $sMouse
	Local $leftPx = 0, $rightPx = 0, $topPx = 0, $botPx = 0
	Local $leftPy = 0, $rightPy = 0, $topPy = 0, $botPy = 0
	Local $deskX, $deskY
	Local $iShade

	If GUICtrlRead($InColor) = "" Then
		MsgBox(48,"Error", "You can not use the Triggerbot without a Color!")
	Else
		$deskX = @DesktopWidth/2-125
		$deskY = @DesktopHeight/2-125
		FileInstall(".\APEx_Trigger.exe", @TempDir & "\APEx_Trigger.exe", 1)
		$sMouse = GUICtrlRead($cbTrigShootKey)
		$iShade = GUICtrlRead($cbShadeColor)
		$sColor = "0x"&GUICtrlRead($InColor)
		GUICtrlSetBkColor($InColor, $sColor)
		If GUICtrlRead($ActivXdis) = $GUI_CHECKED Then
			$leftPx = $deskX+$aMainPos[0]-1-$aDis[0]
			$leftPy = $deskY+$aMainPos[0]
			$rightPx = $deskX+$aMainPos[0]+1+$aDis[0]
			$rightPy = $deskY+$aMainPos[0]
		EndIf
		If GUICtrlRead($ActivYdis) = $GUI_CHECKED Then
			$topPx = $deskX+$aMainPos[1]
			$topPy = $deskY+$aMainPos[1]-1-$aDis[1]
			$botPx = $deskX+$aMainPos[1]
			$botPy = $deskY+$aMainPos[1]+1+$aDis[1]
		EndIf
		$runTrig = ShellExecute("APEx_Trigger.exe", $sColor&" "&$sMouse&" "&$leftPx&" "&$leftPy&" "& _
								$rightPx&" "&$rightPy&" "&$topPx&" "&$topPy&" "&$botPx&" "&$botPy&" "&$iShade, @TempDir)
		If $runTrig = 0 Then
			MsgBox(48, "Error", "The Triggerbot couldn´t be found!"&@CRLF&"Please contact the coder for more Information.")
			Return -1
		EndIf
		GUICtrlSetState($TrigRunBut, $GUI_DISABLE)
		GUICtrlSetState($TrigStopBut, $GUI_ENABLE)
		GUICtrlSetState($ActivTrigRun, $GUI_DISABLE)
		$bTriggerRuning = True
		SoundPlay(@TempDir & "\activated.wav")
	EndIf
EndFunc

Func _TriggerStop()
	While ProcessExists("APEx_Trigger.exe")
		ProcessClose("APEx_Trigger.exe")
		Sleep(100)
	WEnd
	FileDelete(@TempDir & "\APEx_Trigger.exe")
	GUICtrlSetState($TrigRunBut, $GUI_ENABLE)
	GUICtrlSetState($TrigStopBut, $GUI_DISABLE)
	GUICtrlSetState($ActivTrigRun, $GUI_ENABLE)
	$bTriggerRuning = False
	SoundPlay(@TempDir & "\deactivated.wav")
EndFunc

Func _onXdisChange()
	Local $iValue = GUICtrlRead($SlidXdis)

	GUICtrlSetPos($leftPoint, $aMainPos[0]-5-$iValue, $aMainPos[1])
	GUICtrlSetPos($rightPoint, $aMainPos[0]+1+$iValue, $aMainPos[1])
	$aDis[0] = $iValue
	GUICtrlSetData($LabXdisVal, $iValue)
EndFunc

Func _onXposChange()
	Local $iValue = GUICtrlRead($SlidXpos)

	If $iValue = 50 Then
		$iValue = 0
	Else
		$iValue = $iValue-50
	EndIf
	$aMainPos[0] = 125+$iValue
	GUICtrlSetPos($leftPoint, $aMainPos[0]-5-$aDis[0], $aMainPos[1])
	GUICtrlSetPos($rightPoint, $aMainPos[0]+1+$aDis[0], $aMainPos[1])
	GUICtrlSetPos($topPoint, $aMainPos[0], $aMainPos[1]-5-$aDis[1])
	GUICtrlSetPos($botPoint, $aMainPos[0], $aMainPos[1]+1+$aDis[1])

	GUICtrlSetData($LabXposVal, $iValue)
EndFunc

Func _onYdisChange()
	Local $iValue = GUICtrlRead($SlidYdis)

	GUICtrlSetPos($topPoint, $aMainPos[0], $aMainPos[1]-5-$iValue)
	GUICtrlSetPos($botPoint, $aMainPos[0], $aMainPos[1]+1+$iValue)
	$aDis[1] = $iValue
	GUICtrlSetData($LabYdisVal, $iValue)
EndFunc

Func _onYposChange()
	Local $iValue = GUICtrlRead($SlidYpos)

	If $iValue = 50 Then
		$iValue = 0
	Else
		$iValue = $iValue-50
	EndIf
	$aMainPos[1] = 125+$iValue
	GUICtrlSetPos($leftPoint, $aMainPos[0]-5-$aDis[0], $aMainPos[1])
	GUICtrlSetPos($rightPoint, $aMainPos[0]+1+$aDis[0], $aMainPos[1])
	GUICtrlSetPos($topPoint, $aMainPos[0], $aMainPos[1]-5-$aDis[1])
	GUICtrlSetPos($botPoint, $aMainPos[0], $aMainPos[1]+1+$aDis[1])

	GUICtrlSetData($LabYposVal, $iValue)
EndFunc

Func _ActivTrigCfgClick()
	If GUICtrlRead($ActivTrigCfg) = $GUI_CHECKED Then
		_runCrosshair()
		GUICtrlSetState( $SlidXdis, $GUI_ENABLE)
		GUICtrlSetState( $LabXdisVal, $GUI_ENABLE)
		GUICtrlSetState( $LabXpx, $GUI_ENABLE)
		GUICtrlSetState( $SlidXpos, $GUI_ENABLE)
		GUICtrlSetState( $LabXposVal, $GUI_ENABLE)
		GUICtrlSetState( $LabXpx2, $GUI_ENABLE)
		GUICtrlSetState( $LabYdisVal, $GUI_ENABLE)
		GUICtrlSetState( $LabYpx, $GUI_ENABLE)
		GUICtrlSetState( $SlidYpos, $GUI_ENABLE)
		GUICtrlSetState( $SlidYdis, $GUI_ENABLE)
		GUICtrlSetState( $LabYposVal, $GUI_ENABLE)
		GUICtrlSetState( $LabYpx2, $GUI_ENABLE)
		GUICtrlSetState( $ActivXdis, $GUI_ENABLE)
		GUICtrlSetState( $ActivYdis, $GUI_ENABLE)

	Else
		_stopCrosshair()
		GUICtrlSetState( $SlidXdis, $GUI_DISABLE)
		GUICtrlSetState( $LabXdisVal, $GUI_DISABLE)
		GUICtrlSetState( $LabXpx, $GUI_DISABLE)
		GUICtrlSetState( $SlidXpos, $GUI_DISABLE)
		GUICtrlSetState( $LabXposVal, $GUI_DISABLE)
		GUICtrlSetState( $LabXpx2, $GUI_DISABLE)
		GUICtrlSetState( $LabYdisVal, $GUI_DISABLE)
		GUICtrlSetState( $LabYpx, $GUI_DISABLE)
		GUICtrlSetState( $SlidYpos, $GUI_DISABLE)
		GUICtrlSetState( $SlidYdis, $GUI_DISABLE)
		GUICtrlSetState( $LabYposVal, $GUI_DISABLE)
		GUICtrlSetState( $LabYpx2, $GUI_DISABLE)
		GUICtrlSetState( $ActivXdis, $GUI_DISABLE)
		GUICtrlSetState( $ActivYdis, $GUI_DISABLE)
	EndIf
EndFunc

Func _TrigColorSelClick()
	Local $color
	$color = _ChooseColor(2,0,0,$Form1)
	If $color <> -1 Then
		$color = StringTrimLeft($color,2)
		GUICtrlSetData($InColor, $color)
	EndIf
EndFunc

Func _runCrosshair()
	$Form2 = GUICreate("Triggerbot Crosshair", 250, 250, -1, -1, $WS_POPUPWINDOW, $WS_EX_LAYERED + $WS_EX_TOPMOST)
	GUISetBkColor(0x01, $Form2)
	$leftPoint = GUICtrlCreatePic(@TempDir&"\leftPoint.jpg", $aMainPos[0]-5-$aDis[0], $aMainPos[1], 5, 1 )
	$rightPoint = GUICtrlCreatePic(@TempDir&"\rightPoint.jpg", $aMainPos[0]+1+$aDis[0] , $aMainPos[1], 5, 1 )
	$topPoint = GUICtrlCreatePic(@TempDir&"\topPoint.jpg", $aMainPos[0], $aMainPos[1]-5-$aDis[1], 1, 5 )
	$botPoint = GUICtrlCreatePic(@TempDir&"\botPoint.jpg", $aMainPos[0], $aMainPos[1]+1+$aDis[1], 1, 5 )
	GUISetState(@SW_SHOW, $Form2)
	_WinAPI_SetLayeredWindowAttributes($Form2, 0x01, 0xFF, 3)
EndFunc

Func _stopCrosshair()
	GUIDelete($Form2)
EndFunc
#endregion Triggerbot Functions