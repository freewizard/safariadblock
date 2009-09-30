#!/bin/sh

echo "Uninstalling Safari AdBlock..."
rm -r "/Library/Application Support/SIMBL/Plugins/Safari AdBlock"
rm -rf "$HOME/Library/Application Support/Safari AdBlock"
defaults delete com.apple.Safari ABIsEnabled
defaults delete com.apple.Safari ABCheckForUpdates
defaults delete com.apple.Safari ABLastVersionCheck
defaults delete com.apple.Safari ABSubscriptions
