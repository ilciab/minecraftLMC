@echo off
setlocal enabledelayedexpansion

rem === Config ===
set REPO=git@github.com:ilciab/minecraftLMC.git

rem === Sync from GitHub ===
if exist .git (
    git fetch origin
    git reset --hard origin/main
) else (
    git clone %REPO% .
)

rem === Start the Minecraft server ===
call start.bat

rem === Auto commit and push after exit ===
git add -A
for /f %%i in ('powershell -NoLogo -Command "Get-Date -Format yyyy-MM-dd_HH-mm-ss_UTC"') do set TS=%%i
git commit -m "auto save %TS%" || echo No changes to commit.
git pull --rebase origin main || echo Pull failed.
git push origin main || echo Push failed.

endlocal
pause

