@echo off

call csvn
devenv .\trunk\ProcessHacker.sln /build "Release|Win32"
setenv /x64
devenv .\trunk\ProcessHacker.sln /build "Release|x64"
setenv /x86
call .\trunk\build\internal\wait.cmd 2
call .\trunk\build\sdk\makesdk.cmd
devenv .\trunk\plugins\Plugins.sln /build "Release|Win32"
setenv /x64
devenv .\trunk\plugins\Plugins.sln /build "Release|x64"
setenv /x86
call .\trunk\build\internal\wait.cmd 2

if exist iscc.exe (
    pushd .\trunk\build\Installer\
    del *.exe
    iscc.exe" Process_Hacker2_installer_full.iss
    popd
)

call release.cmd %1
