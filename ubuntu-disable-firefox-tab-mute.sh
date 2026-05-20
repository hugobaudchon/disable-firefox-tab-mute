pkill firefox; sleep 2
PROFILE=$(find ~/snap/firefox/common/.mozilla/firefox ~/.mozilla/firefox -maxdepth 1 -type d \( -name '*.default-release' -o -name '*.default' \) 2>/dev/null | head -n1)
cat > "$PROFILE/chrome/userChrome.css" << 'CSS'
.tab-icon-overlay,
.tab-audio-button,
.tab-icon-sound,
.tabbrowser-tab [soundplaying],
.tabbrowser-tab [muted],
.tabbrowser-tab [activemedia-blocked] {
  pointer-events: none !important;
}
CSS
