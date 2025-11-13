@echo off
setlocal enabledelayedexpansion
title Select applications to install

:: Change font color
color 1F

:: ------------------------ Configuration ------------------------

:update
cls
echo ================================
echo        Check Updates ...
echo ================================
echo.
set "url=https://raw.githubusercontent.com/xenix13/Downloadmanager/refs/heads/dev/Downloadmanager(DEV).bat"
set "versionURL=https://raw.githubusercontent.com/xenix13/Downloadmanager/refs/heads/dev/Version.txt?t=%random%"
set "local=%~f0"
set "newlocal=%temp%\Downloadmanager.tmp"
set "tmpVersion=%temp%\version.tmp"
set "remoteVersion="

:: Set localVersion and Version.txt to 
set "localVersion=25.11.23b"

:: Downloads Files 
powershell -Command "Invoke-WebRequest -Uri '%url%' -OutFile '%newlocal%'"
powershell -NoProfile -Command "Invoke-WebRequest -Uri '%versionUrl%' -OutFile '%tmpVersion%' -UseBasicParsing"

::
::

:: Set Remote version for Version Checker
set /p remoteVersion=<"%tmpVersion%"
del "%tmpVersion%"


:: ------------------------ Version Checker ------------------------

echo Check Version...

:: If TEMP File exist try to update
if exist "%newlocal%" (
	if not "!localVersion!"=="!remoteVersion!" (
		echo Your Version : !localVersion!
		set /p choice="A new update !remoteVersion! is available. Do you want to upgrade ? (Y/N) : "
		if /I "!choice!"=="O" goto upgrade
		if /I "!choice!"=="Y" (
			:upgrade
			move /Y "%newlocal%" "%local%"
			echo Upgrade Succesfull !
			echo Reload Script...
			timeout /t 4 >nul
			start "" "%local%"
			exit /b
		) else (
			del "%newlocal%"
			echo Update ignored, Loading...
			pause
		)
	) else (
		echo None update is available.
		del "%newlocal%"
		pause
	)
) else (
    echo Update failure. Loading script...
	pause
)

:: ------------------ Init Apps ------------------
:: To add New apps just copy and past and adjust the name,id and cat on whatever you want

set "total=1"

:: --- Browsers ---
set /a total+=1 & set "app[%total%]=[ ] Chrome"       & set "id[%total%]=Google.Chrome"                & set "cat[%total%]=Browsers"
set /a total+=1 & set "app[%total%]=[ ] Firefox"      & set "id[%total%]=Mozilla.Firefox"              & set "cat[%total%]=Browsers"
set /a total+=1 & set "app[%total%]=[ ] Opera"        & set "id[%total%]=Opera.Opera"                  & set "cat[%total%]=Browsers"
set /a total+=1 & set "app[%total%]=[ ] OperaGX"      & set "id[%total%]=Opera.OperaGX"                & set "cat[%total%]=Browsers"
set /a total+=1 & set "app[%total%]=[ ] Edge"         & set "id[%total%]=Microsoft.Edge"               & set "cat[%total%]=Browsers"
set /a total+=1 & set "app[%total%]=[ ] Vivaldi"      & set "id[%total%]=Vivaldi.Vivaldi"              & set "cat[%total%]=Browsers"
set /a total+=1 & set "app[%total%]=[ ] Yandex"      & set "id[%total%]=Yandex.Browser"              & set "cat[%total%]=Browsers"

:: --- Communications ---
set /a total+=1 & set "app[%total%]=[ ] Teams"        & set "id[%total%]=Microsoft.Teams"              & set "cat[%total%]=Communications"
set /a total+=1 & set "app[%total%]=[ ] Discord"      & set "id[%total%]=Discord.Discord"              & set "cat[%total%]=Communications"
set /a total+=1 & set "app[%total%]=[ ] TeamSpeak"    & set "id[%total%]=TeamSpeakSystems.TeamSpeakClient" & set "cat[%total%]=Communications"
set /a total+=1 & set "app[%total%]=[ ] Nextcloud Talk" & set "id[%total%]=Nextcloud.Talk"              & set "cat[%total%]=Communications"
set /a total+=1 & set "app[%total%]=[ ] Whatsapp" & set "id[%total%]=9NKSQGP7F2NH"              & set "cat[%total%]=Communications"

:: --- Mail ---
set /a total+=1 & set "app[%total%]=[ ] Outlook"      & set "id[%total%]=Microsoft.Outlook"            & set "cat[%total%]=Mail"
set /a total+=1 & set "app[%total%]=[ ] Thunderbird"  & set "id[%total%]=Mozilla.Thunderbird"          & set "cat[%total%]=Mail"
set /a total+=1 & set "app[%total%]=[ ] Betterbird"   & set "id[%total%]=Mozilla.Thunderbird"          & set "cat[%total%]=Mail"

:: --- Media ---
set /a total+=1 & set "app[%total%]=[ ] Plex"         & set "id[%total%]=Plex.Plex"                    & set "cat[%total%]=Media"
set /a total+=1 & set "app[%total%]=[ ] VLC"          & set "id[%total%]=VideoLAN.VLC"                 & set "cat[%total%]=Media"
set /a total+=1 & set "app[%total%]=[ ] Spotify"      & set "id[%total%]=Spotify.Spotify"              & set "cat[%total%]=Media"
set /a total+=1 & set "app[%total%]=[ ] Deezer"       & set "id[%total%]=Deezer.Deezer"                & set "cat[%total%]=Media"
set /a total+=1 & set "app[%total%]=[ ] OBSStudio"    & set "id[%total%]=OBSProject.OBSStudio"         & set "cat[%total%]=Media"
set /a total+=1 & set "app[%total%]=[ ] Elgato StreamDeck"    & set "id[%total%]=Elgato.StreamDeck"         & set "cat[%total%]=Media"


:: --- Documents ---
set /a total+=1 & set "app[%total%]=[ ] LibreOffice"  & set "id[%total%]=TheDocumentFoundation.LibreOffice" & set "cat[%total%]=Documents"
set /a total+=1 & set "app[%total%]=[ ] OnlyOffice"   & set "id[%total%]=ONLYOFFICE.DesktopEditors"    & set "cat[%total%]=Documents"
set /a total+=1 & set "app[%total%]=[ ] Microsoft 365"   & set "id[%total%]=Microsoft.Office"    & set "cat[%total%]=Documents"
set /a total+=1 & set "app[%total%]=[ ] Okular"   & set "id[%total%]=KDE.Okular"    & set "cat[%total%]=Documents"
set /a total+=1 & set "app[%total%]=[ ] Adobe Creative Cloud"   & set "id[%total%]=Adobe.CreativeCloud"    & set "cat[%total%]=Documents"
set /a total+=1 & set "app[%total%]=[ ] Adobe Reader"   & set "id[%total%]=Adobe.Acrobat.Reader.64-bit"    & set "cat[%total%]=Documents"
set /a total+=1 & set "app[%total%]=[ ] HP Smart"   & set "id[%total%]=9WZDNCRFHWLH"    & set "cat[%total%]=Documents"
set /a total+=1 & set "app[%total%]=[ ] Scanner Windows"   & set "id[%total%]=9WZDNCRFJ3PV"    & set "cat[%total%]=Documents"

:: --- Games ---
set /a total+=1 & set "app[%total%]=[ ] Steam"        & set "id[%total%]=Valve.Steam"                  & set "cat[%total%]=Games"
set /a total+=1 & set "app[%total%]=[ ] Epic Games"   & set "id[%total%]=EpicGames.EpicGamesLauncher"  & set "cat[%total%]=Games"
set /a total+=1 & set "app[%total%]=[ ] GOG Galaxy"   & set "id[%total%]=GOG.Galaxy"                   & set "cat[%total%]=Games"
set /a total+=1 & set "app[%total%]=[ ] Ubisoft Connect" & set "id[%total%]=Ubisoft.Connect"           & set "cat[%total%]=Games"
set /a total+=1 & set "app[%total%]=[ ] EA App"       & set "id[%total%]=ElectronicArts.EADesktop"     & set "cat[%total%]=Games"
set /a total+=1 & set "app[%total%]=[ ] NVIDIA GEFORCE NOW" & set "id[%total%]=Nvidia.GeForceNow"       & set "cat[%total%]=Games"
set /a total+=1 & set "app[%total%]=[ ] FACEIT Client" & set "id[%total%]=FACEITLTD.FACEITClient"      & set "cat[%total%]=Games"
set /a total+=1 & set "app[%total%]=[ ] Bluestacks" & set "id[%total%]=Bluestack.Bluestacks"      & set "cat[%total%]=Games"
set /a total+=1 & set "app[%total%]=[ ] Minecraft Launcher" & set "id[%total%]=Mojang.MinecraftLauncher"      & set "cat[%total%]=Games"
set /a total+=1 & set "app[%total%]=[ ] CurseForge" & set "id[%total%]=Overwolf.CurseForge"      & set "cat[%total%]=Games"

:: --- Compression ---
set /a total+=1 & set "app[%total%]=[ ] 7-Zip"        & set "id[%total%]=7zip.7zip"                    & set "cat[%total%]=Compression"
set /a total+=1 & set "app[%total%]=[ ] WinRAR"       & set "id[%total%]=RARLab.WinRAR"                & set "cat[%total%]=Compression"

:: --- Tools ---
set /a total+=1 & set "app[%total%]=[ ] OpenVPN Connect" & set "id[%total%]=OpenVPNTechnologies.OpenVPNConnect" & set "cat[%total%]=Tools"
set /a total+=1 & set "app[%total%]=[ ] Tailscale" & set "id[%total%]=Tailscale.Tailscale"      & set "cat[%total%]=Tools"
set /a total+=1 & set "app[%total%]=[ ] Quickshare"   & set "id[%total%]=Quickshare"                   & set "cat[%total%]=Tools"
set /a total+=1 & set "app[%total%]=[ ] Nextcloud Client" & set "id[%total%]=Nextcloud.NextcloudDesktop" & set "cat[%total%]=Tools"
set /a total+=1 & set "app[%total%]=[ ] KeePassXC"    & set "id[%total%]=KeePassXCTeam.KeePassXC"      & set "cat[%total%]=Tools"
set /a total+=1 & set "app[%total%]=[ ] Bitwarden"    & set "id[%total%]=Bitwarden.Bitwarden"          & set "cat[%total%]=Tools" 
set /a total+=1 & set "app[%total%]=[ ] Nextcloud Password"    & set "id[%total%]=9NXVZ0ZP6D5Z"          & set "cat[%total%]=Tools"
set /a total+=1 & set "app[%total%]=[ ] Itunes"    & set "id[%total%]=Apple.iTunes"          & set "cat[%total%]=Tools"
:: powershell -Command "Invoke-WebRequest -Uri 'https://drivers.amd.com/drivers/installer/25.10/whql/amd-software-adrenalin-edition-25.9.1-minimalsetup-250901_web.exe' -OutFile \"$env:USERPROFILE\Desktop\amd-software-adrenalin-edition-25.9.1-minimalsetup-250901_web.exe\""
::
set /a total+=1 & set "app[%total%]=[ ] DDU"    & set "id[%total%]=Wagnardsoft.DisplayDriverUninstaller"          & set "cat[%total%]=Tools"
set /a total+=1 & set "app[%total%]=[ ] Onedrive" & set "id[%total%]=Microsoft.OneDrive"      & set "cat[%total%]=Tools"
set /a total+=1 & set "app[%total%]=[ ] VirtualBox" & set "id[%total%]=Oracle.VirtualBox"      & set "cat[%total%]=Tools"
set /a total+=1 & set "app[%total%]=[ ] Sweet Home 3D" & set "id[%total%]=eTeks.SweetHome3D"     & set "cat[%total%]=Tools"
set /a total+=1 & set "app[%total%]=[ ] Copilot" & set "id[%total%]=9NHT9RB2F4HD"     & set "cat[%total%]=Tools"

:: --- Admin & Dev---
set /a total+=1 & set "app[%total%]=[ ] Visual Studio Code" & set "id[%total%]=Microsoft.VisualStudioCode" & set "cat[%total%]=Admin & Dev"
set /a total+=1 & set "app[%total%]=[ ] WinSCP"       & set "id[%total%]=WinSCP.WinSCP"                & set "cat[%total%]=Admin & Dev"
set /a total+=1 & set "app[%total%]=[ ] Notepad++"    & set "id[%total%]=Notepad++.Notepad++"          & set "cat[%total%]=Admin & Dev"
set /a total+=1 & set "app[%total%]=[ ] Git"          & set "id[%total%]=Git.Git"                      & set "cat[%total%]=Admin & Dev"
set /a total+=1 & set "app[%total%]=[ ] Tera Term"          & set "id[%total%]=TeraTermProject.teraterm5"             & set "cat[%total%]=Admin & Dev"
set /a total+=1 & set "app[%total%]=[ ] Ventoy" & set "id[%total%]=Ventoy.Ventoy"      & set "cat[%total%]=Admin & Dev"
set /a total+=1 & set "app[%total%]=[ ] Advanced IP Scanner"    & set "id[%total%]=Famatech.AdvancedIPScanner"          & set "cat[%total%]=Admin & Dev"
set /a total+=1 & set "app[%total%]=[ ] Putty"    & set "id[%total%]=PuTTY.PuTTY"          & set "cat[%total%]=Admin & Dev"
set /a total+=1 & set "app[%total%]=[ ] Treesize Free"    & set "id[%total%]=JAMSoftware.TreeSize.Free"          & set "cat[%total%]=Admin & Dev"
set /a total+=1 & set "app[%total%]=[ ] Rufus"    & set "id[%total%]=Rufus.Rufus"          & set "cat[%total%]=Admin & Dev"
set /a total+=1 & set "app[%total%]=[ ] Termius"      & set "id[%total%]=Termius.Termius"              & set "cat[%total%]=Admin & Dev"
set /a total+=1 & set "app[%total%]=[ ] Yealink USB Connect"      & set "id[%total%]=Yealink.YealinkUSBConnect"              & set "cat[%total%]=Admin & Dev"
set /a total+=1 & set "app[%total%]=[ ] TeamViewer"   & set "id[%total%]=TeamViewer.TeamViewer"        & set "cat[%total%]=Admin & Dev"
set /a total+=1 & set "app[%total%]=[ ] AnyDesk"      & set "id[%total%]=AnyDesk.AnyDesk"              & set "cat[%total%]=Admin & Dev" 
set /a total+=1 & set "app[%total%]=[ ] 3CX"      & set "id[%total%]=3CX.Softphone"              & set "cat[%total%]=Admin & Dev"
set /a total+=1 & set "app[%total%]=[ ] Greenshot"      & set "id[%total%]=Greenshot.Greenshot"              & set "cat[%total%]=Admin & Dev"
set /a total+=1 & set "app[%total%]=[ ] Zywall SecuExtender"      & set "idweb[%total%]=powershell -Command "Invoke-WebRequest -Uri 'https://www.zyxel.com/library/assets/products/secuextender/software/SecuExtender_Windows.zip' -OutFile $env:USERPROFILE\Desktop\SecuExtender.zip""              & set "cat[%total%]=Admin & Dev"

:: --- Personnalization ---
set /a total+=1 & set "app[%total%]=[ ] Lively Wallpaper"          & set "id[%total%]=rocksdanister.LivelyWallpaper"             & set "cat[%total%]=Personnalization"
set /a total+=1 & set "app[%total%]=[ ] Sucrose Wallpaper"          & set "id[%total%]=Taiizor.SucroseWallpaperEngine"             & set "cat[%total%]=Personnalization"
set /a total+=1 & set "app[%total%]=[ ] OpenRGB"       & set "id[%total%]=OpenRGB.OpenRGB"                & set "cat[%total%]=Personnalization"
set /a total+=1 & set "app[%total%]=[ ] SignalRgb"          & set "id[%total%]=WhirlwindFX.SignalRgb"             & set "cat[%total%]=Personnalization"
set /a total+=1 & set "app[%total%]=[ ] ICUE"          & set "id[%total%]=Corsair.iCUE.5"             & set "cat[%total%]=Personnalization"
set /a total+=1 & set "app[%total%]=[ ] Logitech GHUB"          & set "id[%total%]=Logitech.GHUB"             & set "cat[%total%]=Personnalization"
set /a total+=1 & set "app[%total%]=[ ] Steelseries Engine"          & set "id[%total%]=SteelSeries.SteelSeriesEngine"             & set "cat[%total%]=Personnalization"
set /a total+=1 & set "app[%total%]=[ ] Razer Synapse"          & set "id[%total%]=RazerInc.RazerInstaller.Synapse4"             & set "cat[%total%]=Personnalization"

:: ------------------ Menu ------------------
goto menu

:menu
color 1F
cls
echo ================================
echo           Select Apps
echo ================================
echo.

:: Columns
set /a cols=4
set "colWidth=30"

:: Display category and apps
set "lastCat="
set /a colCounter=0
set "line="
for /L %%i in (1,1,%total%) do (
    if defined app[%%i] (
        if not "!cat[%%i]!"=="!lastCat!" (
            if defined line echo.!line!
            echo.
            echo --- !cat[%%i]! ---
            echo.
            set "line="
            set /a colCounter=0
            set "lastCat=!cat[%%i]!"
        )

        call :formatApp %%i formatted
        set "line=!line!!formatted!"
        set /a colCounter+=1

        if !colCounter! geq !cols! (
            echo.!line!
            set "line="
            set /a colCounter=0
        ) else (
            set "line=!line! "  :: espace entre colonnes
        )
    )
)
if defined line echo.!line!

echo.
echo Type the number to check/uncheck.
echo Step I to install the selected applications.
echo Step U to uninstall the selected applications.
echo Step C to check update
echo Step Q to quit.
echo.
set /p choix=Choice : 

if /I "%choix%"=="Q" exit /b
if /I "%choix%"=="I" goto install
if /I "%choix%"=="U" goto uninstall
if /I "%choix%"=="C" goto update

:: Toggle
for /L %%i in (1,1,%total%) do (
    if "%choix%"=="%%i" (
        echo !app[%%i]! | find "[X]" >nul
        if errorlevel 1 (
            set "app[%%i]=[X] !app[%%i]:~4!"
        ) else (
            set "app[%%i]=[ ] !app[%%i]:~4!"
        )
    )
)
goto menu

:formatApp
setlocal EnableDelayedExpansion
set "num=  %1"
set "num=!num:~-3!"
set "out=!num!. !app[%1%]!"
set "pad=                                        "
set "out=!out!!pad!"
set "out=!out:~0,%colWidth%!"
endlocal & set "%2=%out%"
exit /b

:install
cls
echo ================================
echo   	 Install in progress...
echo ================================
echo.
for /L %%i in (1,1,%total%) do (
    if defined id[%%i] (
        echo !app[%%i]! | find "[X]" >nul
        if not errorlevel 1 (
            echo Installation de !id[%%i]!...
            winget install --id=!id[%%i]! -e --accept-package-agreements --accept-source-agreements
            echo.
        )
    )

    rem --- Apps Web (téléchargement via PowerShell) ---
    if defined idweb[%%i] (
        echo !app[%%i]! | find "[X]" >nul
        if not errorlevel 1 (
            echo Téléchargement de !app[%%i]!...
            call !idweb[%%i]!
            echo.
        )
    )
)
echo All installations are complete.
echo Press any key to return to the menu...
pause >nul
goto menu

:uninstall
cls
echo ================================
echo   	Uninstall in progress...
echo ================================
echo.
for /L %%i in (1,1,%total%) do (
    if defined app[%%i] (
        echo !app[%%i]! | find "[X]" >nul
        if not errorlevel 1 (
            echo Desinstallation de !id[%%i]!...
            winget uninstall --id=!id[%%i]! -e --disable-interactivity --silent
            echo.
        )
    )
)
echo All uninstallations are complete.
echo Press any key to return to the menu...
pause >nul
goto menu






