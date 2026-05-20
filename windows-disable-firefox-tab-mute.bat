@echo off
powershell -NoProfile -ExecutionPolicy Bypass -Command ^
  "Get-Process firefox -ErrorAction SilentlyContinue | Stop-Process -Force;" ^
  "Start-Sleep -Seconds 2;" ^
  "$p = (Get-ChildItem \"$env:APPDATA\Mozilla\Firefox\Profiles\" -Directory | Where-Object Name -Match 'default-release$' | Select-Object -First 1).FullName;" ^
  "New-Item -ItemType Directory -Force -Path \"$p\chrome\" | Out-Null;" ^
  "$css = \".tab-icon-overlay, .tab-audio-button, .tab-icon-sound, .tabbrowser-tab [soundplaying], .tabbrowser-tab [muted], .tabbrowser-tab [activemedia-blocked] { pointer-events: none !important; }\";" ^
  "[System.IO.File]::WriteAllText(\"$p\chrome\userChrome.css\", $css, (New-Object System.Text.UTF8Encoding $false));" ^
  "Add-Content \"$p\user.js\" 'user_pref(\"toolkit.legacyUserProfileCustomizations.stylesheets\", true);';" ^
  "Write-Host 'Done. Reopen Firefox.'"
pause
