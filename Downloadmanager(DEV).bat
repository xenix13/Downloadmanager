@echo off
setlocal enabledelayedexpansion
title Selection d applications a installer
color 1F

:: ------------------ Auto-élévation ------------------
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo Demande de droits administrateur...
    powershell -Command "Start-Process '%~f0' -Verb runAs"
    exit /b
)

:: ------------------------ Configuration ------------------------
set "url=https://raw.githubusercontent.com/xenix13/Downloadmanager/refs/heads/dev/Downloadmanager(DEV).bat"
set "local=%~f0"
set "localVersion=25.10.2b"
powershell -Command "Invoke-WebRequest -Uri '%url%' -OutFile '%local%.tmp'"
set "versionURL=https://raw.githubusercontent.com/xenix13/Downloadmanager/refs/heads/dev/Version.txt?t=%random%"
set "tmpVersion=%temp%\version.tmp"
powershell -NoProfile -Command "Invoke-WebRequest -Uri '%versionUrl%' -OutFile '%tmpVersion%' -UseBasicParsing"
set "remoteVersion="
set /p remoteVersion=<"%tmpVersion%"
del "%tmpVersion%"


:: ------------------------ Téléchargement ------------------------
echo Check Updates...

:: Si téléchargement réussi, demande validation
if exist "%local%.tmp" (
	if not "!localVersion!"=="!remoteVersion!" (
		echo Votre version : !localVersion!
		set /p choice="Une mise a jour est disponible. La nouvelle version !remoteVersion! est disponible. Voulez-vous l installer ? (O/N) : "
		if /I "!choice!"=="O" (
			move /Y "%local%.tmp" "%local%"
			echo Script mis a jour avec succes !
			echo Relance du script...
			start "" "%local%"
			exit /b
		) else (
			del "%local%.tmp"
			echo Mise à jour ignoree, lancement du script...
			pause
		)
	) else (
		echo Aucune mise a jour disponible.
		del "%local%.tmp"
		pause
	)
) else (
    echo Echec de la mise à jour, lancement du script...
	pause
)

:: ------------------ Initialisation des applications ------------------
set "total=0"

:: --- Navigateur ---
set /a total+=1 & set "app[%total%]=[ ] Chrome"       & set "id[%total%]=Google.Chrome"                & set "cat[%total%]=Navigateur"
set /a total+=1 & set "app[%total%]=[ ] Firefox"      & set "id[%total%]=Mozilla.Firefox"              & set "cat[%total%]=Navigateur"
set /a total+=1 & set "app[%total%]=[ ] Opera"        & set "id[%total%]=Opera.Opera"                  & set "cat[%total%]=Navigateur"
set /a total+=1 & set "app[%total%]=[ ] OperaGX"      & set "id[%total%]=Opera.OperaGX"                & set "cat[%total%]=Navigateur"
set /a total+=1 & set "app[%total%]=[ ] Edge"         & set "id[%total%]=Microsoft.Edge"               & set "cat[%total%]=Navigateur"
set /a total+=1 & set "app[%total%]=[ ] Vivaldi"      & set "id[%total%]=Vivaldi.Vivaldi"              & set "cat[%total%]=Navigateur"
set /a total+=1 & set "app[%total%]=[ ] Yandex"      & set "id[%total%]=Yandex.Browser"              & set "cat[%total%]=Navigateur"

:: --- Communications ---
set /a total+=1 & set "app[%total%]=[ ] Teams"        & set "id[%total%]=Microsoft.Teams"              & set "cat[%total%]=Communications"
set /a total+=1 & set "app[%total%]=[ ] Discord"      & set "id[%total%]=Discord.Discord"              & set "cat[%total%]=Communications"
set /a total+=1 & set "app[%total%]=[ ] TeamSpeak"    & set "id[%total%]=TeamSpeakSystems.TeamSpeakClient" & set "cat[%total%]=Communications"
set /a total+=1 & set "app[%total%]=[ ] Nextcloud Talk" & set "id[%total%]=Nextcloud.Talk"              & set "cat[%total%]=Communications"

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
set /a total+=1 & set "app[%total%]=[ ] Okular"   & set "id[%total%]=KDE.Okular"    & set "cat[%total%]=Documents"
set /a total+=1 & set "app[%total%]=[ ] Adobe Creative Cloud"   & set "id[%total%]=Adobe.CreativeCloud"    & set "cat[%total%]=Documents"

:: --- Jeux ---
set /a total+=1 & set "app[%total%]=[ ] Steam"        & set "id[%total%]=Valve.Steam"                  & set "cat[%total%]=Jeux"
set /a total+=1 & set "app[%total%]=[ ] Epic Games"   & set "id[%total%]=EpicGames.EpicGamesLauncher"  & set "cat[%total%]=Jeux"
set /a total+=1 & set "app[%total%]=[ ] GOG Galaxy"   & set "id[%total%]=GOG.Galaxy"                   & set "cat[%total%]=Jeux"
set /a total+=1 & set "app[%total%]=[ ] Ubisoft Connect" & set "id[%total%]=Ubisoft.Connect"           & set "cat[%total%]=Jeux"
set /a total+=1 & set "app[%total%]=[ ] EA App"       & set "id[%total%]=ElectronicArts.EADesktop"     & set "cat[%total%]=Jeux"
set /a total+=1 & set "app[%total%]=[ ] NVIDIA GEFORCE NOW" & set "id[%total%]=Nvidia.GeForceNow"       & set "cat[%total%]=Jeux"
set /a total+=1 & set "app[%total%]=[ ] FACEIT Client" & set "id[%total%]=FACEITLTD.FACEITClient"      & set "cat[%total%]=Jeux"
set /a total+=1 & set "app[%total%]=[ ] Bluestacks" & set "id[%total%]=Bluestack.Bluestacks"      & set "cat[%total%]=Jeux"

:: --- Compression ---
set /a total+=1 & set "app[%total%]=[ ] 7-Zip"        & set "id[%total%]=7zip.7zip"                    & set "cat[%total%]=Compression"
set /a total+=1 & set "app[%total%]=[ ] WinRAR"       & set "id[%total%]=RARLab.WinRAR"                & set "cat[%total%]=Compression"

:: --- Outils ---
set /a total+=1 & set "app[%total%]=[ ] TeamViewer"   & set "id[%total%]=TeamViewer.TeamViewer"        & set "cat[%total%]=Outils"
set /a total+=1 & set "app[%total%]=[ ] AnyDesk"      & set "id[%total%]=AnyDesk.AnyDesk"              & set "cat[%total%]=Outils"
set /a total+=1 & set "app[%total%]=[ ] Termius"      & set "id[%total%]=Termius.Termius"              & set "cat[%total%]=Outils"
set /a total+=1 & set "app[%total%]=[ ] OpenVPN Connect" & set "id[%total%]=OpenVPNTechnologies.OpenVPNConnect" & set "cat[%total%]=Outils"
set /a total+=1 & set "app[%total%]=[ ] Quickshare"   & set "id[%total%]=Quickshare"                   & set "cat[%total%]=Outils"
set /a total+=1 & set "app[%total%]=[ ] Nextcloud Client" & set "id[%total%]=Nextcloud.NextcloudDesktop" & set "cat[%total%]=Outils"
set /a total+=1 & set "app[%total%]=[ ] KeePassXC"    & set "id[%total%]=KeePassXCTeam.KeePassXC"      & set "cat[%total%]=Outils"
set /a total+=1 & set "app[%total%]=[ ] Bitwarden"    & set "id[%total%]=Bitwarden.Bitwarden"          & set "cat[%total%]=Outils" 
set /a total+=1 & set "app[%total%]=[ ] Nextcloud Password"    & set "id[%total%]=9NXVZ0ZP6D5Z"          & set "cat[%total%]=Outils"
set /a total+=1 & set "app[%total%]=[ ] Rufus"    & set "id[%total%]=Rufus.Rufus"          & set "cat[%total%]=Outils"
set /a total+=1 & set "app[%total%]=[ ] Itunes"    & set "id[%total%]=Apple.iTunes"          & set "cat[%total%]=Outils"
set /a total+=1 & set "app[%total%]=[ ] Driver Store"    & set "id[%total%]=lostindark.DriverStoreExplorer"          & set "cat[%total%]=Outils"

:: --- Developpement ---
set /a total+=1 & set "app[%total%]=[ ] Visual Studio Code" & set "id[%total%]=Microsoft.VisualStudioCode" & set "cat[%total%]=Developpement"
set /a total+=1 & set "app[%total%]=[ ] WinSCP"       & set "id[%total%]=WinSCP.WinSCP"                & set "cat[%total%]=Developpement"
set /a total+=1 & set "app[%total%]=[ ] Notepad++"    & set "id[%total%]=Notepad++.Notepad++"          & set "cat[%total%]=Developpement"
set /a total+=1 & set "app[%total%]=[ ] Git"          & set "id[%total%]=Git.Git"                      & set "cat[%total%]=Developpement"

:: --- Personnalisation ---
set /a total+=1 & set "app[%total%]=[ ] Lively Wallpaper"          & set "id[%total%]=rocksdanister.LivelyWallpaper"             & set "cat[%total%]=Personnalisation"

:: ------------------ Menu ------------------
goto menu

:menu
color 1F
cls
echo ================================
echo   Selectionne les applications
echo ================================
echo.

:: Colonnes fixes
set /a cols=3
set "colWidth=30"

:: Affichage avec catégories et pas de fantômes
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
echo Tape le numero pour cocher/decocher.
echo Tape I pour installer les applications selectionnees.
echo Tape U pour desinstaller la selection.
echo Tape Q pour quitter.
echo.
set /p choix=Ton choix : 

if /I "%choix%"=="Q" exit /b
if /I "%choix%"=="I" goto install
if /I "%choix%"=="U" goto uninstall

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
echo   Installation en cours...
echo ================================
echo.
for /L %%i in (1,1,%total%) do (
    if defined app[%%i] (
        echo !app[%%i]! | find "[X]" >nul
        if not errorlevel 1 (
            echo Installation de !id[%%i]!...
            winget install --id=!id[%%i]! -e --accept-package-agreements --accept-source-agreements
            echo.
        )
    )
)
echo Toutes les installations sont terminees.
echo Appuyez sur une touche pour revenir au menu...
pause >nul
goto menu

:uninstall
cls
echo ================================
echo   Desinstallation en cours...
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
echo Toutes les desinstallations sont terminees.
echo Appuyez sur une touche pour revenir au menu...
pause >nul
goto menu

