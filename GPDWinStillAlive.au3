#include <File.au3>
#include <MsgBoxConstants.au3>

$iniPath = @ScriptDir & "\" & StringRegExpReplace(@ScriptName, "(.+?)\.(.+?$)", "$1.ini")
$filePath = IniRead($iniPath, "Settings", "filename", "D:\stillalive.txt")
$interval = Int(IniRead($iniPath, "Settings", "interval", 5)) * 1000

$processes = IniReadSection($iniPath, "Processes")


Func runFix()
   For $i = 0 To UBound($processes)-1 Step 1
	  Local $name = $processes[$i][1]

	  If ProcessExists($name) Then

		 If Not _FileCreate($filePath) Then
		 	MsgBox($MB_ICONERROR, "Error", "Failed to write file.")
		 EndIf

		 ExitLoop
	  EndIf
   Next
EndFunc

While True
   runFix()
   Sleep($interval)
WEnd

runFix()