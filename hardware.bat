@echo off
setlocal

echo Checking system information...

REM Checking the operating system
echo.
echo Operating System:
wmic os get caption, version, osarchitecture

REM Checking RAM
echo.
echo RAM:
wmic memorychip get capacity

REM Checking storage space on each drive partition
echo.
echo Storage space on drive partitions:
for /f "skip=1 tokens=1,3" %%a in ('wmic logicaldisk get DeviceID^, Size^, FreeSpace /format:csv') do (
    set "drive=%%a"
    set "size=%%b"
    set "freespace=%%c"
    set /a usedspace=%size% - %freespace%
    if not "%%a"=="Node" (
        echo Drive %%a:
        echo Total space: %size% bytes
        echo Used space: %usedspace% bytes
        echo Free space: %freespace% bytes
        echo.
    )
)

REM Checking the type of drive (HDD/SSD)
echo.
echo Drive type:
for /f "skip=1 tokens=1,2 delims=," %%a in ('wmic diskdrive get Model^, MediaType /format:csv') do (
    if not "%%a"=="Model" (
        echo Model: %%a - Drive type: %%b
    )
)

REM Checking CPU information
echo.
echo CPU:
wmic cpu get name, maxclockspeed, numberofcores, numberoflogicalprocessors

echo.
echo Information displayed.

endlocal
pause