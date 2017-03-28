mkdir "%PROGRAMFILES%\cygwinx86"

REM Powershell 2
powershell -Command "(New-Object Net.WebClient).DownloadFile('https://cygwin.com/setup-x86.exe', '%PROGRAMFILES%\cygwinx86\setup-x86.exe')"

REM Powershell 3
REM powershell -Command "Invoke-WebRequest https://cygwin.com/setup-x86.exe -OutFile setup-x86.exe"

"%PROGRAMFILES%\cygwinx86\setup-x86.exe" ^
--site http://cygwin.mirror.constant.com ^
--no-shortcuts ^
--no-desktop ^
--quiet-mode ^
--root "%PROGRAMFILES%\cygwinx86\cygwin" ^
--arch x86 ^
--local-package-dir "%PROGRAMFILES%\cygwinx86\cygwin-packages" ^
--verbose ^
--prune-install ^
--packages openssh,git,vim,zsh,tmux,curl
