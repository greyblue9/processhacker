@echo off

rem This script mast be located in ../../ dir, exmple C:\Dev\ProcessHacker\SRC\release.cmd and use with SVN check command like:¦¦¦
rem "svn co https://processhacker.svn.sourceforge.net/svnroot/processhacker/2.x/trunk trunk" for download trunk branch only.
rem parameter %1 is major version number!

if exist ..\bin\processhacker-*-*.* del ..\bin\processhacker-*-*.*

if exist .\release\src (
   if exist ..\release\src del /s/f/q ..\release\src
   if exist ..\release\src rd /S /Q  ..\release\src
   mkdir ..\release\src
   )

rem Source distribution
    if exist ..\bin\ProcessHacker2 rmdir /S /Q ..\bin\ProcessHacker2
    svn.exe export .\trunk ..\bin\ProcessHacker2
    7z.exe a -mx9 ..\bin\processhacker-2.%1-src.zip ..\bin\ProcessHacker2\*

rem SDK distribution

7z.exe a -mx9 ..\bin\processhacker-2.%1-sdk.zip .\trunk\sdk\*

rem Binary distribution

if exist ..\bin rmdir /S /Q ..\bin
mkdir ..\bin

for %%a in (
    CHANGELOG.txt
    COPYRIGHT.txt
    LICENSE.txt
    README.txt
    ) do copy .\trunk\%%a ..\bin\%%a

for %%a in (
    CHANGELOG.txt
    COPYRIGHT.txt
    LICENSE.txt
    README.txt
    ) do copy .\trunk\%%a ..\release\%%a

mkdir ..\bin\x86
copy .\trunk\bin\Release32\ProcessHacker.exe ..\bin\x86\
copy .\trunk\KProcessHacker\bin-signed\i386\kprocesshacker.sys ..\bin\x86\
copy .\trunk\bin\Release32\peview.exe ..\bin\x86\

mkdir ..\bin\x64
copy .\trunk\bin\Release64\ProcessHacker.exe ..\bin\x64\
copy .\trunk\KProcessHacker\bin-signed\amd64\kprocesshacker.sys ..\bin\x64\
copy .\trunk\bin\Release64\peview.exe ..\bin\x64\

mkdir ..\bin\x86\plugins
for %%a in (
    AtomTablePlugin
    AvgCpuPlugin
    DbgViewPlugin
    DiskDrivesPlugin
    DnsCachePlugin
    DotNetTools
    ExtendedNotifications
    ExtendedServices
    ExtendedTools
    HexPidPlugin
    HighlightPlugin
    NetAdapters
    NetworkTools
    NvGpuPlugin
    OnlineChecks
    PerfMonPlugin
    ROTViewerPlugin
    SbieSupport
    SetCriticalPlugin
    ToolStatus
    Updater
    UserNotes
    WaitChainPlugin
    WindowExplorer
    ) do copy .\trunk\bin\Release32\plugins\%%a.dll ..\bin\x86\plugins\%%a.dll

mkdir ..\bin\x64\plugins
for %%a in (
    AtomTablePlugin
    AvgCpuPlugin
    DbgViewPlugin
    DiskDrivesPlugin
    DotNetTools
    DnsCachePlugin
    ExtendedNotifications
    ExtendedServices
    ExtendedTools
    HexPidPlugin
    HighlightPlugin
    NetAdapters
    NetworkTools
    NvGpuPlugin
    OnlineChecks
    PerfMonPlugin
    ROTViewerPlugin
    SbieSupport
    SetCriticalPlugin
    ToolStatus
    Updater
    UserNotes
    WaitChainPlugin
    WindowExplorer
    ) do copy .\trunk\bin\Release64\plugins\%%a.dll ..\bin\x64\plugins\%%a.dll

If exist ..\release\processhacker-2.%1-bin.zip  del /s/f/q  ..\release\processhacker-2.%1-bin.zip
7z.exe a -mx9 ..\release\processhacker-2.%1-bin.zip ..\bin\*
If exist ..\release\processhacker-*-setup.exe  del /s/f/q  ..\release\processhacker-*-setup.exe
if exist .\trunk\build\Installer\processhacker-*-setup.exe del /s/f/q .\trunk\build\Installer\processhacker-*-setup.exe
iscc .\trunk\build\Installer\Process_Hacker2_installer_full.iss
copy .\trunk\build\Installer\processhacker-*-setup.exe ..\release\
if exist .\trunk\build\Installer\processhacker-*-setup.exe del /s/f/q .\trunk\build\Installer\processhacker-*-setup.exe
makesrc.cmd %1
cd /d .\trunk&&makesdk.cmd %1&cd ../&copy /b /y ..\release\*.* /b .\release\&exit