
#include "Blowfish_UDF.au3"
#Include <String.au3>

Global $key = "IgroAutoPistolEx"
;~ $key = _StringToHex($key)

$hRead = FileOpen(@ScriptDir&"\hwids.txt")
$sRead = FileRead($hRead)
FileClose($hRead)

$sCrypt = Blowfish($key, $sRead)
$hFile = FileOpen(@ScriptDir&"\crypt.html", 2+8)
FileWrite($hFile, $sCrypt)
FileClose($hFile)

;~ $hRead = FileOpen(@ScriptDir&"\crypt.html")
;~ $sRead = FileRead($hRead)
;~ FileClose($hRead)

;~ $sCrypt = Blowfish($key, $sRead, 1)
;~ $hFile = FileOpen(@ScriptDir&"\decrypt.txt", 2+8)
;~ FileWrite($hFile, $sCrypt)
;~ FileClose($hFile)