@echo off
chcp 65001 >nul

:: Sürümü al ve environment variable olarak set et
for /f "delims=" %%a in ('python -c "import version; print(version.__version__)"') do set VERSION=%%a
set STEAMLOADER_VERSION=%VERSION%

echo.
echo ► Mevcut Sürüm: %VERSION%
echo ► Installer oluşturuluyor...
echo.

:: Inno Setup ile installer oluştur
set ISCC="C:\Program Files (x86)\Inno Setup 6\ISCC.exe"
if not exist %ISCC% set ISCC="C:\Program Files\Inno Setup 6\ISCC.exe"

if exist %ISCC% (
    %ISCC% installer.iss
    if errorlevel 1 (
        echo ✗ Inno Setup hatası!
        pause
        exit /b 1
    )
    echo ✓ Installer başarıyla oluşturuldu!
    echo.
    echo 📦 Çıktı: installer_output\SteamLoader_Setup_v%VERSION%.exe
) else (
    echo ✗ Inno Setup bulunamadı!
)

echo.
pause
