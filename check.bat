@echo off
pushd %temp%
title Scan ^& Repair Windows Image by Abdullah ERTšRK

:: Sistem dilini PowerShell ile al
:: Get system language using PowerShell
for /f %%L in ('powershell -NoProfile -Command "[System.Globalization.CultureInfo]::InstalledUICulture.TwoLetterISOLanguageName"') do set "lang=%%L"

if /I "%lang%"=="tr" (
    set "lang=TR"
) else (
    set "lang=EN"
)

:: Y”netici de§ilse kendini y”netici olarak yeniden baŸlat
:: Relaunch as administrator if not already elevated
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
if %errorlevel% NEQ 0 (
    echo.
    if "%lang%"=="TR" (
        echo Y”netici yetkileriyle yeniden baŸlatlyor...
    ) else (
        echo Restarting with administrative privileges...
    )
    powershell -Command "Start-Process -FilePath '%~f0' -Verb RunAs"
    exit /b
)

setlocal enabledelayedexpansion

:: Eski log dosyalarn sil
:: Delete old log files
del /f /q "%temp%\check.log" >nul 2>&1
del /f /q "%temp%\scan.log" >nul 2>&1

echo.
if "%lang%"=="TR" (
    powershell -Command "Write-Host '      Kontrol ve onarm iŸlemleri uzun srebilir, ltfen sabrla bekleyin...' -ForegroundColor Yellow"
) else (
    powershell -Command "Write-Host '      Scan and repair processes may take a while, please be patient...' -ForegroundColor Yellow"
)

:: CheckHealth ve ScanHealth ‡alŸtr ve ‡kty hem ekrana hem dosyaya yaz
:: Run CheckHealth and ScanHealth, output both to screen and file
powershell -Command "$r=Repair-WindowsImage -Online -CheckHealth | Out-String -Stream; $r | Out-File -Encoding ASCII '%temp%\check.log'; $r"
powershell -Command "$r=Repair-WindowsImage -Online -ScanHealth | Out-String -Stream; $r | Out-File -Encoding ASCII '%temp%\scan.log'; $r"

:: "Repairable" kelimesi ge‡iyor mu kontrol et
:: Check if "Repairable" appears in logs
findstr /I "Repairable" "%temp%\check.log" >nul
set "checkRepairable=%errorlevel%"

findstr /I "Repairable" "%temp%\scan.log" >nul
set "scanRepairable=%errorlevel%"

:: E§er onarlabilir sorun varsa DISM ve SFC ‡alŸtr
:: If a repairable issue is found, run DISM and SFC
if %checkRepairable%==0 (
    echo.
    if "%lang%"=="TR" (
        powershell -Command "Write-Host '      Sistemde onarlabilir bir sorun bulundu. Onarm baŸlatlyor...' -ForegroundColor Red"
    ) else (
        powershell -Command "Write-Host '      A repairable issue has been detected. Starting repair...' -ForegroundColor Red"
    )
    Dism /Online /Cleanup-Image /RestoreHealth
    sfc /scannow
    goto :end
)

if %scanRepairable%==0 (
    echo.
    if "%lang%"=="TR" (
        powershell -Command "Write-Host '      Sistemde onarlabilir bir sorun bulundu. Onarm baŸlatlyor...' -ForegroundColor Red"
    ) else (
        powershell -Command "Write-Host '      A repairable issue has been detected. Starting repair...' -ForegroundColor Red"
    )
    Dism /Online /Cleanup-Image /RestoreHealth
    sfc /scannow
    goto :end
)

:: "Healthy" mesaj varsa kullancy bilgilendir
:: If "Healthy" found, inform the user that system is fine
findstr /I "Healthy" "%temp%\check.log" >nul
set "checkHealthy=%errorlevel%"

findstr /I "Healthy" "%temp%\scan.log" >nul
set "scanHealthy=%errorlevel%"

if %checkHealthy%==0 if %scanHealthy%==0 (
    echo.
    if "%lang%"=="TR" (
        powershell -Command "Write-Host '      Windows sa§l§ normaldir, onarm gerekmiyor...' -ForegroundColor Green"
    ) else (
        powershell -Command "Write-Host '      Windows health is normal, no repair needed...' -ForegroundColor Green"
    )
    goto :end
)

:: Ne onarlabilir ne de sa§lklysa bilinmeyen durum olarak uyar
:: If not repairable and not healthy, show unknown state warning
if "%lang%"=="TR" (
    powershell -Command "Write-Host '      Sistem sa§l§ durumu tespit edilemedi...' -ForegroundColor Yellow"
) else (
    powershell -Command "Write-Host '      System health status could not be determined...' -ForegroundColor Yellow"
)

:end
:: Ge‡ici dosyalar sil
:: Cleanup temporary files
del /f /q "%temp%\check.log" >nul 2>&1
del /f /q "%temp%\scan.log" >nul 2>&1

echo.
if "%lang%"=="TR" (
	echo.
    echo       Tarama ve onarm iŸlemleri tamamland.
    echo.
    echo       €kŸ i‡in herhangi bir tuŸa basn...
) else (
	echo.
    echo       Scan and repair operations completed.
    echo.
    echo       Press any key to exit...
)
pause >nul
timeout 1 >nul
exit