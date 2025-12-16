; SteamLoader Installer Script
; Inno Setup 6.x ile uyumludur

; Sürüm bilgisini Python'dan al (exec kullanarak)
#define MyAppVersion \
  GetEnv("STEAMLOADER_VERSION") != "" ? \
  GetEnv("STEAMLOADER_VERSION") : \
  "1.0.0"

#define MyAppName "SteamLoader"
#define MyAppPublisher "Yekuda"
#define MyAppURL "https://github.com/yekuda/SteamLoader"
#define MyAppExeName "SteamLoader.exe"
#define MyAppIcon "favicon.ico"

[Setup]
; Temel kurulum ayarları
AppId={{B5E3F9A2-8D4C-4A1F-9E2B-7C6D5A4B3E1F}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
AppPublisher={#MyAppPublisher}
AppPublisherURL={#MyAppURL}
AppSupportURL={#MyAppURL}
AppUpdatesURL={#MyAppURL}
DefaultDirName={autopf}\{#MyAppName}
DisableProgramGroupPage=yes
; Lisans dosyası (opsiyonel)
; LicenseFile=LICENSE.txt
; Çıktı dizini ve ismi
OutputDir=installer_output
OutputBaseFilename=SteamLoader_Setup_v{#MyAppVersion}
; İkon
SetupIconFile={#MyAppIcon}
; Sıkıştırma
Compression=lzma2/max
SolidCompression=yes
; Windows 10+ gereksinimi
MinVersion=10.0
; 64-bit kurulum
ArchitecturesAllowed=x64
ArchitecturesInstallIn64BitMode=x64
; Uygulama değişiklikleri bildirimi
PrivilegesRequired=lowest
; Modern görünüm
WizardStyle=modern

[Languages]
Name: "turkish"; MessagesFile: "compiler:Languages\Turkish.isl"
Name: "english"; MessagesFile: "compiler:Default.isl"

[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked

[Files]
; Ana uygulama dosyası (PyInstaller ile derlenmiş)
Source: "dist\{#MyAppExeName}"; DestDir: "{app}"; Flags: ignoreversion
; Not: --onedir modunda kullanırsanız, tüm dosyaları dahil edin:
; Source: "dist\*"; DestDir: "{app}"; Flags: ignoreversion recursesubdirs createallsubdirs

[Icons]
; Başlat menüsü kısayolu
Name: "{autoprograms}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"
; Masaüstü kısayolu
Name: "{autodesktop}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"; Tasks: desktopicon
; Kaldırma kısayolu
Name: "{autoprograms}\{#MyAppName} Kaldır"; Filename: "{uninstallexe}"

[Run]
; Kurulum sonrası uygulamayı çalıştırma seçeneği
Filename: "{app}\{#MyAppExeName}"; Description: "{cm:LaunchProgram,{#StringChange(MyAppName, '&', '&&')}}"; Flags: nowait postinstall skipifsilent

[UninstallDelete]
; Kaldırma sırasında config dosyalarını da sil
Type: filesandordirs; Name: "{localappdata}\SteamLoader"

[Code]
// Kurulum öncesi kontroller
function InitializeSetup(): Boolean;
begin
  Result := True;
end;

// Kurulum sonrası mesajlar
procedure CurStepChanged(CurStep: TSetupStep);
begin
  if CurStep = ssPostInstall then
  begin
    // Kurulum tamamlandıktan sonra yapılacak işlemler
  end;
end;
