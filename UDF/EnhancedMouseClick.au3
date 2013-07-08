#include-once
;	Copyright (C) 2011-2013 Alexander Poplavsky
#include <Constants.au3>

;=#CONSTANTS# ==================================================================
Global Const $XBUTTON1	= 0x0001
Global Const $XBUTTON2	= 0x0002
;===============================================================================

#region _EnhancedMouseClick
;===============================================================================
;
; Function Name:  _EnhancedMouseClick()
; Description:    Same as MouseClick but faster and can press mouse buttons x1 and x2.
; Parameter(s):   $hUser32     =  handle of the User32.dll
;                 $sMaus       =  "left", "right", "middle", "x1" or "x2" mouse buttons
;                 $iPosX       =  X coordinate, 0 = current position
;                 $iPosY       =  Y coordinate, 0 = current position
;                 $iAbsolute   =  Absolute coordinates, 1 = on, 0 = off
;
; Author(s):      Igromanru
;===============================================================================
Func _EnhancedMouseClick($hUser32 = "User32.dll", $sMaus = "left", $iPosX = 0, $iPosY = 0, $iAbsolute = 1)
	Local $iButtonDown
	Local $iButtonUp
	Local $iDWData = 0

	Switch $sMaus
		Case "left"
			$iButtonDown = $MOUSEEVENTF_LEFTDOWN
			$iButtonUp	 = $MOUSEEVENTF_LEFTUP
		Case "right"
			$iButtonDown = $MOUSEEVENTF_RIGHTDOWN
			$iButtonUp	 = $MOUSEEVENTF_RIGHTUP
		Case "middle"
			$iButtonDown = $MOUSEEVENTF_MIDDLEDOWN
			$iButtonUp	 = $MOUSEEVENTF_MIDDLEUP
		Case "x1"
			$iButtonDown = $MOUSEEVENTF_XDOWN
			$iButtonUp	 = $MOUSEEVENTF_XUP
			$iDWData 	 = $XBUTTON1
		Case "x2"
			$iButtonDown = $MOUSEEVENTF_XDOWN
			$iButtonUp	 = $MOUSEEVENTF_XUP
			$iDWData 	 = $XBUTTON2
	EndSwitch
	If $iAbsolute = 1 Then
		$iButtonDown += $MOUSEEVENTF_ABSOLUTE
		$iButtonUp	 += $MOUSEEVENTF_ABSOLUTE
	EndIf
	DllCall($hUser32, "none", "mouse_event", "int", $iButtonDown, "int", $iPosX, "int", $iPosY, "int", $iDWData, "int", 0)
    DllCall($hUser32, "none", "mouse_event", "int", $iButtonUp, "int", $iPosX, "int", $iPosY, "int", $iDWData, "int", 0)
EndFunc

;===============================================================================
;
; Function Name:  _EnhancedMouseMove()
; Description:    Same as MouseMove but faster and works in most games.
; Parameter(s):   $hUser32     =  handle of the User32.dll
;                 $iPosX       =  X coordinate, 0 = current position
;                 $iPosY       =  Y coordinate, 0 = current position
;                 $iAbsolute   =  Absolute coordinates, 1 = on, 0 = off
;
; Author(s):      Igromanru
;===============================================================================
Func _EnhancedMouseMove($hUser32 = "User32.dll", $iPosX = 0, $iPosY = 0, $iAbsolute = 1)
	Local $iMouseMove = $MOUSEEVENTF_MOVE
	If $iAbsolute = 1 Then
		$iMouseMove += $MOUSEEVENTF_ABSOLUTE
	EndIf
    DllCall($hUser32, "none", "mouse_event", "int", $iMouseMove, "int", $iPosX, "int", $iPosY, "int", 0, "int", 0)
EndFunc

;===============================================================================
;
; Function Name:  _EnhancedMouseDown()
; Description:    Same as MouseDown but faster and can press down mouse buttons x1 and x2.
; Parameter(s):   $hUser32     =  handle of the User32.dll
;                 $sMaus       =  "left", "right", "middle", "x1" or "x2" mouse buttons
;                 $iPosX       =  X coordinate, 0 = current position
;                 $iPosY       =  Y coordinate, 0 = current position
;                 $iAbsolute   =  Absolute coordinates, 1 = on, 0 = off
;
; Author(s):      Igromanru
;===============================================================================
Func _EnhancedMouseDown($hUser32 = "User32.dll", $sMaus = "left", $iPosX = 0, $iPosY = 0, $iAbsolute = 1)
	Local $iButtonDown
	Local $iDWData = 0

	Switch $sMaus
		Case "left"
			$iButtonDown = $MOUSEEVENTF_LEFTDOWN
		Case "right"
			$iButtonDown = $MOUSEEVENTF_RIGHTDOWN
		Case "middle"
			$iButtonDown = $MOUSEEVENTF_MIDDLEDOWN
		Case "x1"
			$iButtonDown = $MOUSEEVENTF_XDOWN
			$iDWData 	 = $XBUTTON1
		Case "x2"
			$iButtonDown = $MOUSEEVENTF_XDOWN
			$iDWData 	 = $XBUTTON2
	EndSwitch
	If $iAbsolute = 1 Then
		$iButtonDown += $MOUSEEVENTF_ABSOLUTE
	EndIf
	DllCall($hUser32, "none", "mouse_event", "int", $iButtonDown, "int", $iPosX, "int", $iPosY, "int", $iDWData, "int", 0)
EndFunc

;===============================================================================
;
; Function Name:  _EnhancedMouseUp()
; Description:    Same as MouseUp but faster and can release mouse buttons x1 and x2.
; Parameter(s):   $hUser32     =  handle of the User32.dll
;                 $sMaus       =  "left", "right", "middle", "x1" or "x2" mouse buttons
;                 $iPosX       =  X coordinate, 0 = current position
;                 $iPosY       =  Y coordinate, 0 = current position
;                 $iAbsolute   =  Absolute coordinates, 1 = on, 0 = off
;
; Author(s):      Igromanru
;===============================================================================
Func _EnhancedMouseUp($hUser32 = "User32.dll", $sMaus = "left", $iPosX = 0, $iPosY = 0, $iAbsolute = 1)
	Local $iButtonUp
	Local $iDWData = 0

	Switch $sMaus
		Case "left"
			$iButtonUp	 = $MOUSEEVENTF_LEFTUP
		Case "right"
			$iButtonUp	 = $MOUSEEVENTF_RIGHTUP
		Case "middle"
			$iButtonUp	 = $MOUSEEVENTF_MIDDLEUP
		Case "x1"
			$iButtonUp	 = $MOUSEEVENTF_XUP
			$iDWData 	 = $XBUTTON1
		Case "x2"
			$iButtonUp	 = $MOUSEEVENTF_XUP
			$iDWData 	 = $XBUTTON2
	EndSwitch
	If $iAbsolute = 1 Then
		$iButtonUp	 += $MOUSEEVENTF_ABSOLUTE
	EndIf
    DllCall($hUser32, "none", "mouse_event", "int", $iButtonUp, "int", $iPosX, "int", $iPosY, "int", $iDWData, "int", 0)
EndFunc

#endregion