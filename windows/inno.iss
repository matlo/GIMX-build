; Script generated by the Inno Setup Script Wizard.
; SEE THE DOCUMENTATION FOR DETAILS ON CREATING INNO SETUP SCRIPT FILES!

#define MyAppName "GIMX"
#define MyAppId "{DCCE138F-C418-464F-BF07-FD69ED63D20E}"
#define MyAppVersion "0.0"
#define MyAppPublisher "MatLauLab"
#define MyAppURL "http://gimx.fr"
#define MyApp1 "gimx-launcher"
#define MyAppExeName1 "gimx-launcher.exe"
#define MyApp2 "gimx-config"
#define MyAppExeName2 "gimx-config.exe"
#define MyApp3 "gimx-fpsconfig"
#define MyAppExeName3 "gimx-fpsconfig.exe"

#define UsbdkVersion "1.0.12"
#define UsbdkAppIdx64 "{2D9B7372-C3A9-4C50-9149-058EF0CF512B}"
#define UsbdkAppIdx86 "{296A4498-8BC3-4212-8E37-6B8ADFF9399B}"

#define SilabsCP210xAppId "F189C013BFD9D0C73BEC97AD2CFF0CF7CAD1E670"

[Setup]
; NOTE: The value of AppId uniquely identifies this application.
; Do not use the same AppId value in installers for other applications.
; (To generate a new GUID, click Tools | Generate GUID inside the IDE.)
AppId={{#MyAppId}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
;AppVerName={#MyAppName} {#MyAppVersion}
AppPublisher={#MyAppPublisher}
AppPublisherURL={#MyAppURL}
AppSupportURL={#MyAppURL}
AppUpdatesURL={#MyAppURL}
#ifdef W64
ArchitecturesInstallIn64BitMode=x64
#endif
DefaultDirName={pf}\{#MyAppName}
DefaultGroupName={#MyAppName}
OutputDir=.
OutputBaseFilename=gimx-{#MyAppVersion}
Compression=lzma
SolidCompression=yes

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"

[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked

[Files]
Source: "GIMX\setup\*"; DestDir: "{app}"; Flags: ignoreversion recursesubdirs createallsubdirs
#ifdef W64
Source: "tools\CP210x_VCP_Windows\*"; Excludes: "*x86*"; DestDir: "{app}\tools\CP210x_VCP_Windows"; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "tools\usbdk\UsbDk_{#UsbdkVersion}_x64.msi"; DestDir: "{app}\tools\usbdk\"; Flags: ignoreversion recursesubdirs createallsubdirs
#else
Source: "tools\CP210x_VCP_Windows\*"; Excludes: "*x86*"; DestDir: "{app}\tools\CP210x_VCP_Windows"; Check: IsWin64() ; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "tools\CP210x_VCP_Windows\*"; Excludes: "*x64*"; DestDir: "{app}\tools\CP210x_VCP_Windows"; Check: not IsWin64() ; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "tools\usbdk\UsbDk_{#UsbdkVersion}_x64.msi"; DestDir: "{app}\tools\usbdk\"; Check: IsWin64() ; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "tools\usbdk\UsbDk_{#UsbdkVersion}_x86.msi"; DestDir: "{app}\tools\usbdk\"; Check: not IsWin64() ; Flags: ignoreversion recursesubdirs createallsubdirs
#endif
; NOTE: Don't use "Flags: ignoreversion" on any shared system files

[Icons]
Name: "{group}\{#MyApp1}"; Filename: "{app}\{#MyAppExeName1}"
Name: "{commondesktop}\{#MyApp1}"; Filename: "{app}\{#MyAppExeName1}"; Tasks: desktopicon
Name: "{group}\{#MyApp2}"; Filename: "{app}\{#MyAppExeName2}"
Name: "{commondesktop}\{#MyApp2}"; Filename: "{app}\{#MyAppExeName2}"; Tasks: desktopicon
Name: "{group}\{#MyApp3}"; Filename: "{app}\{#MyAppExeName3}"
Name: "{commondesktop}\{#MyApp3}"; Filename: "{app}\{#MyAppExeName3}"; Tasks: desktopicon

[Registry]
Root: HKCU; Subkey: "System\CurrentControlSet\Control\MediaProperties\PrivateProperties\Joystick\OEM\VID_046D&PID_C202"; ValueType: string; ValueName: "OEMName"; ValueData: "Logitech WingMan Formula (Yellow) (USB)"
Root: HKCU; Subkey: "System\CurrentControlSet\Control\MediaProperties\PrivateProperties\Joystick\OEM\VID_046D&PID_C20E"; ValueType: string; ValueName: "OEMName"; ValueData: "Logitech WingMan Formula GP"
Root: HKCU; Subkey: "System\CurrentControlSet\Control\MediaProperties\PrivateProperties\Joystick\OEM\VID_046D&PID_C293"; ValueType: string; ValueName: "OEMName"; ValueData: "Logitech WingMan Formula Force GP USB"
Root: HKCU; Subkey: "System\CurrentControlSet\Control\MediaProperties\PrivateProperties\Joystick\OEM\VID_046D&PID_C294"; ValueType: string; ValueName: "OEMName"; ValueData: "Logitech Driving Force USB"
Root: HKCU; Subkey: "System\CurrentControlSet\Control\MediaProperties\PrivateProperties\Joystick\OEM\VID_046D&PID_C295"; ValueType: string; ValueName: "OEMName"; ValueData: "Logitech MOMO Force USB"
Root: HKCU; Subkey: "System\CurrentControlSet\Control\MediaProperties\PrivateProperties\Joystick\OEM\VID_046D&PID_C298"; ValueType: string; ValueName: "OEMName"; ValueData: "Logitech Driving Force Pro USB"
Root: HKCU; Subkey: "System\CurrentControlSet\Control\MediaProperties\PrivateProperties\Joystick\OEM\VID_046D&PID_C299"; ValueType: string; ValueName: "OEMName"; ValueData: "Logitech G25 Racing Wheel USB"
Root: HKCU; Subkey: "System\CurrentControlSet\Control\MediaProperties\PrivateProperties\Joystick\OEM\VID_046D&PID_C29A"; ValueType: string; ValueName: "OEMName"; ValueData: "Logitech Driving Force GT USB"
Root: HKCU; Subkey: "System\CurrentControlSet\Control\MediaProperties\PrivateProperties\Joystick\OEM\VID_046D&PID_C29B"; ValueType: string; ValueName: "OEMName"; ValueData: "Logitech G27 Racing Wheel USB"
Root: HKCU; Subkey: "System\CurrentControlSet\Control\MediaProperties\PrivateProperties\Joystick\OEM\VID_046D&PID_CA03"; ValueType: string; ValueName: "OEMName"; ValueData: "Logitech MOMO Racing USB"
Root: HKCU; Subkey: "System\CurrentControlSet\Control\MediaProperties\PrivateProperties\Joystick\OEM\VID_046D&PID_CA04"; ValueType: string; ValueName: "OEMName"; ValueData: "Logitech Racing Wheel USB"

[Run]
Filename: "msiexec.exe"; Parameters: "/i ""{app}\tools\usbdk\UsbDk_{#UsbdkVersion}_x64.msi"" /qn"; Description: "Install USBDK (required for most gaming consoles)"; Check: IsWin64() and not AppInstalled(True, False, '{#UsbdkAppIdx64}') ; Flags: runascurrentuser postinstall skipifsilent
Filename: "msiexec.exe"; Parameters: "/i ""{app}\tools\usbdk\UsbDk_{#UsbdkVersion}_x86.msi"" /qn"; Description: "Install USBDK (required for most gaming consoles)"; Check: not IsWin64() and not AppInstalled(True, False, '{#UsbdkAppIdx86}') ; Flags: runascurrentuser postinstall skipifsilent
Filename: "{app}\tools\CP210x_VCP_Windows\CP210xVCPInstaller_x64.exe"; Description: "{cm:LaunchProgram,CP210x driver installer}"; Check: IsWin64() and not AppInstalled(True, False, '{#SilabsCP210xAppId}') ; Flags: runascurrentuser postinstall skipifsilent
Filename: "{app}\tools\CP210x_VCP_Windows\CP210xVCPInstaller_x86.exe"; Description: "{cm:LaunchProgram,CP210x driver installer}"; Check: not IsWin64() and not AppInstalled(True, False, '{#SilabsCP210xAppId}') ; Flags: runascurrentuser postinstall skipifsilent
Filename: "{app}\{#MyAppExeName1}"; Description: "{cm:LaunchProgram,{#StringChange(MyApp1, "&", "&&")}}"; Flags: nowait postinstall skipifsilent
Filename: "{code:GetRunEntryFileName}";

[Code]
function GetNumber(var temp: String): Integer;
var
  part: String;
  pos1: Integer;
begin
  if Length(temp) = 0 then
  begin
    Result := -1;
    Exit;
  end;
	pos1 := Pos('.', temp);
	if (pos1 = 0) then
	begin
	  Result := StrToInt(temp);
	temp := '';
	end
	else
	begin
	part := Copy(temp, 1, pos1 - 1);
	  temp := Copy(temp, pos1 + 1, Length(temp));
	  Result := StrToInt(part);
	end;
end;

function CompareInner(var temp1, temp2: String): Integer;
var
  num1, num2: Integer;
begin
	num1 := GetNumber(temp1);
  num2 := GetNumber(temp2);
  if (num1 = -1) or (num2 = -1) then
  begin
    Result := 0;
    Exit;
  end;
  if (num1 > num2) then
  begin
	Result := 1;
  end
  else if (num1 < num2) then
  begin
	Result := -1;
  end
  else
  begin
	Result := CompareInner(temp1, temp2);
  end;
end;

function CompareVersion(str1, str2: String): Integer;
var
  temp1, temp2: String;
begin
	temp1 := str1;
	temp2 := str2;
	Result := CompareInner(temp1, temp2);
end;

function GetHKLM(isNative: Boolean): Integer;
begin
  if isNative then
  begin
    if IsWin64 then
    begin
      Result := HKLM64;
    end
    else
    begin
      Result := HKLM32;
    end;
  end
  else
  begin
    Result := HKLM;
  end;
end;

function GetUninstallRegKey(appId: String; isInno: Boolean): String;
begin
  Result := 'SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\' + appId;
  if isInno then
  begin
    Result := Result + '_is1';
  end;
end;

function AppInstalled(isNative, isInno: Boolean; appId: String): Boolean;
begin
  Result := RegKeyExists(GetHKLM(isNative), GetUninstallRegKey(appId, isInno));
end;

function InitializeSetup(): Boolean;
var
  oldVersion: String;
  uninstaller: String;
  ErrorCode: Integer;
  compareResult: Integer;
  appId: String;
  appName: String;
  appVersion: String;
begin
  appId := '{#MyAppId}';
  appName := '{#MyAppName}';
  appVersion := '{#MyAppVersion}'

  if not AppInstalled(False, True, appId) then
  begin
    Result := True;
    Exit;
  end;

  RegQueryStringValue(GetHKLM(False), GetUninstallRegKey(appId, TRUE), 'DisplayVersion', oldVersion);
  compareResult := CompareVersion(oldVersion, appVersion);
  if (compareResult = 0) then
  begin
    if (MsgBox(appName + ' ' + oldVersion + ' is already installed. Do you want to repair it now?',
	  mbConfirmation, MB_YESNO) = IDNO) then
	begin
	  Result := False;
	  Exit;
    end;
  end
  else
  begin
    if (MsgBox(appName + ' ' + oldVersion + ' is installed. Do you want to override it with {#MyAppVersion} now?',
	  mbConfirmation, MB_YESNO) = IDNO) then
	begin
	  Result := False;
	  Exit;
    end;
  end;
  // remove old version
  RegQueryStringValue(GetHKLM(False), GetUninstallRegKey(appId, True), 'UninstallString', uninstaller);
  ShellExec('runas', uninstaller, '/SILENT', '', SW_HIDE, ewWaitUntilTerminated, ErrorCode);
  if (ErrorCode <> 0) then
  begin
	MsgBox( 'Failed to uninstall ' + appName + ' version ' + oldVersion + '. Please restart Windows and run setup again.',
	 mbError, MB_OK );
	Result := False;
	Exit;
  end;

  Result := True;
end;

function FileReplaceDevices(const FileName: string):boolean;
var
  MyFile : TStrings;
  MyText : string;
  WriteFile : boolean;
begin
  MyFile := TStringList.Create;
  try
    result := true;
    try
      MyFile.LoadFromFile(FileName);
      MyText := MyFile.Text;
      WriteFile := False;
      // Fix names of wheels plugged before installing Logitech Gaming Software.
      WriteFile := WriteFile OR (StringChangeEx(MyText, '"WingMan Formula (Yellow)"', '"Logitech WingMan Formula (Yellow) (USB)"', True) > 0); // unsure about this one
      WriteFile := WriteFile OR (StringChangeEx(MyText, '"WingMan Formula GP"',       '"Logitech WingMan Formula GP"', True) > 0); // unsure about this one
      WriteFile := WriteFile OR (StringChangeEx(MyText, '"WingMan Formula Force GP"', '"Logitech WingMan Formula Force GP USB"', True) > 0); // unsure about this one
      WriteFile := WriteFile OR (StringChangeEx(MyText, '"Driving Force EX"',         '"Logitech Driving Force EX USB"', True) > 0);
      WriteFile := WriteFile OR (StringChangeEx(MyText, '"Driving Force"',            '"Logitech Driving Force USB"', True) > 0);
      WriteFile := WriteFile OR (StringChangeEx(MyText, '"MOMO Force"',               '"Logitech MOMO Force USB"', True) > 0);
      WriteFile := WriteFile OR (StringChangeEx(MyText, '"Driving Force Pro"',        '"Logitech Driving Force Pro USB"', True) > 0);
      WriteFile := WriteFile OR (StringChangeEx(MyText, '"G25 Racing Wheel"',         '"Logitech G25 Racing Wheel USB"', True) > 0);
      WriteFile := WriteFile OR (StringChangeEx(MyText, '"Driving Force GT"',         '"Logitech Driving Force GT USB"', True) > 0);
      WriteFile := WriteFile OR (StringChangeEx(MyText, '"G27 Racing Wheel"',         '"Logitech G27 Racing Wheel USB"', True) > 0);
      WriteFile := WriteFile OR (StringChangeEx(MyText, '"MOMO Racing"',              '"Logitech MOMO Racing USB"', True) > 0);
      WriteFile := WriteFile OR (StringChangeEx(MyText, '"Racing Wheel"',             '"Logitech Racing Wheel USB"', True) > 0); // unsure about this one
      // Fix Japanese names.
      WriteFile := WriteFile OR (StringChangeEx(MyText, '"Logicool WingMan Formula (Yellow) (USB)"', '"Logitech WingMan Formula (Yellow) (USB)"', True) > 0);
      WriteFile := WriteFile OR (StringChangeEx(MyText, '"Logicool WingMan Formula GP"',             '"Logitech WingMan Formula GP"', True) > 0);
      WriteFile := WriteFile OR (StringChangeEx(MyText, '"Logicool WingMan Formula Force GP USB"',   '"Logitech WingMan Formula Force GP USB"', True) > 0);
      WriteFile := WriteFile OR (StringChangeEx(MyText, '"Logicool Driving Force EX USB"',           '"Logitech Driving Force EX USB"', True) > 0);
      WriteFile := WriteFile OR (StringChangeEx(MyText, '"Logicool Formula Force EX USB"',           '"Logitech Formula Force EX USB"', True) > 0);
      WriteFile := WriteFile OR (StringChangeEx(MyText, '"Logicool Driving Force RX USB"',           '"Logitech Driving Force RX USB"', True) > 0);
      WriteFile := WriteFile OR (StringChangeEx(MyText, '"Logicool Driving Force USB"',              '"Logitech Driving Force USB"', True) > 0);
      WriteFile := WriteFile OR (StringChangeEx(MyText, '"Logicool MOMO Force USB"',                 '"Logitech MOMO Force USB"', True) > 0);
      WriteFile := WriteFile OR (StringChangeEx(MyText, '"Logicool Driving Force Pro USB"',          '"Logitech Driving Force Pro USB"', True) > 0);
      WriteFile := WriteFile OR (StringChangeEx(MyText, '"Logicool G25 Racing Wheel USB"',           '"Logitech G25 Racing Wheel USB"', True) > 0);
      WriteFile := WriteFile OR (StringChangeEx(MyText, '"Logicool Driving Force GT USB"',           '"Logitech Driving Force GT USB"', True) > 0);
      WriteFile := WriteFile OR (StringChangeEx(MyText, '"Logicool G27 Racing Wheel USB"',           '"Logitech G27 Racing Wheel USB"', True) > 0);
      WriteFile := WriteFile OR (StringChangeEx(MyText, '"Logicool MOMO Racing USB"',                '"Logitech MOMO Racing USB"', True) > 0);
      WriteFile := WriteFile OR (StringChangeEx(MyText, '"Logicool Racing Wheel USB"',               '"Logitech Racing Wheel USB"', True) > 0);

      if WriteFile then //Only save if text has been changed.
      begin;
        MyFile.Text := MyText;
        MyFile.SaveToFile(FileName);
      end;
    except
      result := false;
    end;
  finally
    MyFile.Free;
  end;
end;

procedure ListFiles(const Directory: string; Files: TStringList);
var
  FindRec: TFindRec;
begin
  Files.Clear;
  if FindFirst(ExpandConstant(Directory + '*.xml'), FindRec) then
  try
    repeat
      if FindRec.Attributes and FILE_ATTRIBUTE_DIRECTORY = 0 then
        Files.Add(FindRec.Name);
    until
      not FindNext(FindRec);
  finally
    FindClose(FindRec);
  end;
end;

function GetRunEntryFileName(Value: string): string;
var
  MyFile : string;
  MyDir : string;
  MyFiles : TStringList;
  i : Integer;
begin
  MyFiles := TStringList.Create;
  MyDir := ExpandConstant('{userappdata}') + '\gimx\config\';
  ListFiles(MyDir, MyFiles);
  For i := 0 to MyFiles.Count - 1 do
  begin
    MyFile := MyDir + MyFiles[i];
    FileReplaceDevices(MyFile);
  end;
  MyFiles.Free;
  Result := 'hh.exe';
end;