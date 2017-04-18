mkdir "%SYSTEMDRIVE%\cygwinx86_64"

REM Powershell 2
powershell -Command "(New-Object Net.WebClient).DownloadFile('https://cygwin.com/setup-x86_64.exe', '%SYSTEMDRIVE%\cygwinx86_64\setup-x86_64.exe')"

REM Powershell 3
REM powershell -Command "Invoke-WebRequest https://cygwin.com/setup-x86_64.exe -OutFile setup-x86_64.exe"

"%SYSTEMDRIVE%\cygwinx86_64\setup-x86_64.exe" ^
--site ftp://ftp-stud.hs-esslingen.de/pub/Mirrors/sources.redhat.com/cygwin/ ^
--no-shortcuts ^
--no-desktop ^
--quiet-mode ^
--root "%SYSTEMDRIVE%\cygwinx86_64\cygwin" ^
--arch x86_64 ^
--local-package-dir "%SYSTEMDRIVE%\cygwinx86_64\cygwin-packages" ^
--verbose ^
--prune-install ^
--packages openssh,git,vim,zsh,tmux,curl
