@ECHO OFF
ECHO "# This will build your new home!"

SET DIR=%~dp0
::SET DIR=%DIR:~0,-5%

WHERE git
IF %ERRORLEVEL% EQU 0 (
    SET GIT=true
) else (
    SET GIT=
)

:::::::::::::::::::::::::
::  updating dotfiles  ::
:::::::::::::::::::::::::
if defined GIT (
    echo "-> updating dotfiles"
    cd /D %DIR%
    git pull
)

::::::::::::::::::::::::::::::::::::::::::
::  create and populate .vim directory  ::
::::::::::::::::::::::::::::::::::::::::::
if not exist %UserProfile%\vimfiles (
    echo "-> creating ~\vimfiles"
    mkdir %UserProfile%\vimfiles
)
if not exist %UserProfile%\vimfiles\bundle (
    echo "-> creating ~\vimfiles\bundle"
    mkdir %UserProfile%\vimfiles\bundle
)
:: clone or update Vundle.vim
if defined GIT (
    if not exist %UserProfile%\vimfiles\bundle\Vundle.vim (
        echo "-> cloning https://github.com/VundleVim/Vundle.vim.git"
        git clone https://github.com/VundleVim/Vundle.vim.git %UserProfile%\vimfiles\bundle\Vundle.vim
    ) else (
        echo "-> updating Vundle.vim"
        cd /D %UserProfile%\vimfiles\bundle\Vundle.vim
        git pull
    )
)
SET MYSNIPPETS=%DIR%\.vim\mysnippets
    SET TARGET="nix"
if exist %UserProfile%\vimfiles\mysnippets (
    for /f "tokens=2 delims=[]" %%i in ('dir %UserProfile%\vimfiles\mysnippets* ^| FIND " mysnippets " ^| FIND "<SYMLINK"') do (
       SET TARGET=%%i
    )
       echo %MYSNIPPETS%
       echo %TARGET%
    if %TARGET% NEQ %MYSNIPPETS% (
        echo "-> move ~\vimfiles\mysnippets to ~\vimfiles\mysnippets_bak"
::        move %UserProfile%\vimfiles\mysnippets %UserProfile%\vimfiles\mysnippets_bak 
        echo "-> link %MYSNIPPETS% to ~\vimfiles\mysnippets"
    )
) else (
    echo "-> link %MYSNIPPETS% to ~\vimfiles\mysnippets"
)
