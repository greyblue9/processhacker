@echo off
if exist iscc.exe (
    pushd .\trunk\build\Installer\
    del *.exe
    iscc.exe Process_Hacker2_installer_full.iss
    popd
)

call release.cmd %1