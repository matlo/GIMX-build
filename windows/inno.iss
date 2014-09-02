; Script generated by the Inno Setup Script Wizard.
; SEE THE DOCUMENTATION FOR DETAILS ON CREATING INNO SETUP SCRIPT FILES!

#define MyAppName "GIMX"
#define MyAppVersion "0.00"
#define MyAppPublisher "MatLauLab"
#define MyAppURL "http://gimx.fr"
#define MyApp1 "gimx-launcher"
#define MyAppExeName1 "gimx-launcher.exe"
#define MyApp2 "gimx-config"
#define MyAppExeName2 "gimx-config.exe"
#define MyApp3 "gimx-fpsconfig"
#define MyAppExeName3 "gimx-fpsconfig.exe"

[Setup]
; NOTE: The value of AppId uniquely identifies this application.
; Do not use the same AppId value in installers for other applications.
; (To generate a new GUID, click Tools | Generate GUID inside the IDE.)
AppId={{DCCE138F-C418-464F-BF07-FD69ED63D20E}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
;AppVerName={#MyAppName} {#MyAppVersion}
AppPublisher={#MyAppPublisher}
AppPublisherURL={#MyAppURL}
AppSupportURL={#MyAppURL}
AppUpdatesURL={#MyAppURL}
ArchitecturesInstallIn64BitMode=x64
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
; NOTE: Don't use "Flags: ignoreversion" on any shared system files

[Icons]
Name: "{group}\{#MyApp1}"; Filename: "{app}\{#MyAppExeName1}"
Name: "{commondesktop}\{#MyApp1}"; Filename: "{app}\{#MyAppExeName1}"; Tasks: desktopicon
Name: "{group}\{#MyApp2}"; Filename: "{app}\{#MyAppExeName2}"
Name: "{commondesktop}\{#MyApp2}"; Filename: "{app}\{#MyAppExeName2}"; Tasks: desktopicon
Name: "{group}\{#MyApp3}"; Filename: "{app}\{#MyAppExeName3}"
Name: "{commondesktop}\{#MyApp3}"; Filename: "{app}\{#MyAppExeName3}"; Tasks: desktopicon

[Run]
Filename: "{app}\{#MyAppExeName1}"; Description: "{cm:LaunchProgram,{#StringChange(MyApp1, "&", "&&")}}"; Flags: nowait postinstall skipifsilent
