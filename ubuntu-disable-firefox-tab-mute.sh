pkill firefox; sleep 2

for FF_ROOT in ~/snap/firefox/common/.mozilla/firefox ~/.mozilla/firefox; do
  [ -d "$FF_ROOT" ] || continue
  for PROFILE in "$FF_ROOT"/*/; do
    [ -f "$PROFILE/prefs.js" ] || continue

    mkdir -p "$PROFILE/chrome"

    grep -q 'legacyUserProfileCustomizations.stylesheets' "$PROFILE/user.js" 2>/dev/null || \
      echo 'user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true);' >> "$PROFILE/user.js"

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

    echo "Wrote to: $PROFILE"
  done
done
