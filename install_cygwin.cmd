mkdir "%USERPROFILE%\cygwin"

REM Powershell 2
powershell -Command "(New-Object Net.WebClient).DownloadFile('https://cygwin.com/setup-x86_64.exe', '%USERPROFILE%\cygwin\setup-x86_64.exe')"

REM Powershell 3
REM powershell -Command "Invoke-WebRequest https://cygwin.com/setup-x86_64.exe -OutFile setup-x86_64.exe"

"%USERPROFILE%\cygwin\setup-x86_64.exe" ^
--no-admin
--site ftp://ftp-stud.hs-esslingen.de/pub/Mirrors/sources.redhat.com/cygwin/ ^
--no-shortcuts ^
--no-desktop ^
--quiet-mode ^
--root "%USERPROFILE%\cygwin\cygwin" ^
--arch x86_64 ^
--local-package-dir "%USERPROFILE%\cygwin\cygwin-packages" ^
--verbose ^
--prune-install ^
--packages openssh,git,vim,zsh,tmux,curl
