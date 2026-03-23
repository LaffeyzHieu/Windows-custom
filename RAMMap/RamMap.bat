@echo off
chcp 65001 > nul
title Dọn dẹp RAM tự động
color B

REM path
set RAMMAP=%~dp0RAMMap64.exe

:menu
cls
echo.
echo ========================================
echo         RAM MANAGER MENU
echo ========================================
echo.
echo  1. Dọn RAM bằng RAMMap
echo  2. Đóng tất cả cửa sổ
echo  3. Đóng tất cả cửa sổ + RAMMap
echo  0. Thoát
echo.
echo ========================================
choice /c 1230 /n /m "Chọn số (0-3): "

if errorlevel 4 goto end
if errorlevel 3 goto doboth
if errorlevel 2 goto closeapps
if errorlevel 1 goto rammap
echo.
echo [ERROR] Lựa chọn không hợp lệ!
timeout /t 2 >nul
goto menu

:rammap
cls
echo.
echo ========================================
echo    Đang dọn dẹp RAM bằng RAMMap...
echo ========================================
echo.

REM Kiểm tra file
echo [File] Đang tìm RAMMap64.exe...
timeout /t 1 /nobreak >nul

if not exist %RAMMAP% (
    echo.
    echo [ERROR] không tìm thấy RAMMap64.exe!
    echo [File] kiểm tra lại đường dẫn.
    pause
    goto menu
)

echo [File] đã tìm thấy...
timeout /t 1 /nobreak >nul
echo.

REM 1
echo [1/4] Empty Working Sets
<nul set /p "=Progress: ["
for /L %%i in (1,1,20) do (
    <nul set /p "=█"
    timeout /t 0 >nul
)
echo ]
%RAMMAP% -Ew
timeout /t 1 /nobreak >nul
echo [Empty Working Sets] hoàn thành!
echo.

REM 2
echo [2/4] Empty Modified Page List
<nul set /p "=Progress: ["
for /L %%i in (1,1,20) do (
    <nul set /p "=█"
    timeout /t 0 >nul
)
echo ]
%RAMMAP% -Em
timeout /t 1 /nobreak >nul
echo [Empty Modified Page List] hoàn thành!
echo.

REM 3
echo [3/4] Empty System Working Set
<nul set /p "=Progress: ["
for /L %%i in (1,2,20) do (
    <nul set /p "=█"
    timeout /t 0 >nul
)
echo ]
%RAMMAP% -Et
timeout /t 1 /nobreak >nul
echo [Empty System Working Set] hoàn thành!
echo.

REM 4
echo [4/4] Empty Standby List
<nul set /p "=Progress: ["
for /L %%i in (1,2,20) do (
    <nul set /p "=█"
    timeout /t 0 >nul
)
echo ]
%RAMMAP% -Es
timeout /t 1 /nobreak >nul
echo [Empty Standby List] hoàn thành!
echo.

echo ========================================
echo    Dọn dẹp RAM thành công!
echo ========================================
echo.
echo Nhấn phím bất kỳ để quay lại menu...
pause >nul
goto menu

:closeapps
cls
echo.
echo ========================================
echo      Đang đóng tất cả ứng dụng...
echo ========================================
echo.

echo [Process] Đang tìm các ứng dụng đang chạy...
<nul set /p "=Progress: ["
for /L %%i in (1,1,20) do (
    <nul set /p "=█"
    timeout /t 0 >nul
)
echo ]

timeout /t 1 /nobreak >nul

powershell -Command "Get-Process | Where-Object {$_.MainWindowTitle -ne '' -and $_.ProcessName -notin @('explorer', 'taskmgr', 'cmd')} | Stop-Process -Force"

echo.
echo [Process] Đã đóng tất cả ứng dụng!
echo.
echo ========================================
echo.
echo Nhấn phím bất kỳ để quay lại menu...
pause >nul
goto menu

:doboth
cls
echo.
echo ========================================
echo   Đang thực hiện cả 2 tác vụ...
echo ========================================
echo.

REM Đóng app trước
echo [1/4] Đóng tất cả ứng dụng...
timeout /t 1 /nobreak >nul
powershell -Command "Get-Process | Where-Object {$_.MainWindowTitle -ne '' -and $_.ProcessName -notin @('explorer', 'taskmgr', 'cmd')} | Stop-Process -Force"
echo [1/4] Hoàn thành!
echo.

REM Kiểm tra RAMMap
echo [2/4] Kiểm tra RAMMap...
timeout /t 1 /nobreak >nul
if not exist %RAMMAP% (
    echo [ERROR] không tìm thấy RAMMap64.exe!
    pause
    goto menu
)
echo [2/4] Hoàn thành!
echo.

REM Empty Working Sets
echo [3/4] Empty Working Sets
<nul set /p "=Progress: ["
for /L %%i in (1,1,20) do (
    <nul set /p "=█"
    timeout /t 0 >nul
)
echo ]
%RAMMAP% -Ew
timeout /t 1 /nobreak >nul
echo [3/4] Hoàn thành!
echo.

REM Empty Modified Page List
echo [4/4] Empty Modified Page List
<nul set /p "=Progress: ["
for /L %%i in (1,1,20) do (
    <nul set /p "=█"
    timeout /t 0 >nul
)
echo ]
%RAMMAP% -Em
timeout /t 1 /nobreak >nul
echo [4/4] Hoàn thành!
echo.

echo ========================================
echo   RAM giờ thoáng như gió bay!
echo ========================================
echo.
echo Nhấn phím bất kỳ để quay lại menu...
pause >nul
goto menu

:end
cls
echo.
echo ========================================
echo      Tạm biệt! RAM khoẻ nhé!
echo ========================================
echo.
timeout /t 2 >nul
exit