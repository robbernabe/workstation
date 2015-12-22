# Note that for the 'NSGlobalDomain' we will only set for our own user, which
# is the GlobalPreferences file located at:
#
#       ~/Library/Preferences/.GlobalPreferences.plist
#
# Resources:
#   - http://jtimberman.housepub.org/blog/2014/12/29/chef-12-homebrew-user-mixin/

user = Mixlib::ShellOut.new("id -un ${SUDO_USER}").run_command.stdout.to_s.strip

# Before getting started, make sure perms are correct on our preference file!
file "/Users/#{user}/Library/Preferences/.GlobalPreferences.plist" do
  mode  '0600'
  owner user
  group 'staff'
end

# execute 'Set ownership properly on GlobalPreferences file' do
#   command "chown #{user}:staff ~/Library/Preferences/.GlobalPreferences.plist"
# end

###############################################################################
# Safari                                                                      #
###############################################################################

execute 'Safari: Re-enable backspace/delete to go back in Safari' do
  command 'defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2BackspaceKeyNavigationEnabled -bool YES'
  user    user
end

###############################################################################
# TextEdit
###############################################################################

execute 'TextEdit: Use plain text mode for new TextEdit documents' do
  command 'defaults write com.apple.TextEdit RichText -int 0'
  user    user
end

execute 'TextEdit: Disable smart quotes' do
  command 'defaults write com.apple.TextEdit SmartQuotes -bool false'
  user    user
end

execute 'TextEdit: Disable smart dashes' do
  command 'defaults write com.apple.TextEdit SmartDashes -bool false'
  user    user
end

###############################################################################
# Mail                                                                        #
###############################################################################

execute 'Apple Mail: Disable inline attachments (just show the icons)' do
  command 'defaults write com.apple.mail DisableInlineAttachmentViewing -bool true'
  user    user
end

###############################################################################
# Chrome                                                                      #
###############################################################################

execute 'Chrome: Disable swipe to to navigate' do
  command 'defaults write com.google.Chrome.plist AppleEnableSwipeNavigateWithScrolls -bool FALSE'
  user    user
end

###############################################################################
# Finder                                                                      #
###############################################################################

execute 'Finder: Show status bar' do
  command 'defaults write com.apple.finder ShowStatusBar -bool true'
  user    user
end

execute 'Finder: Use list view in all Finder windows by default' do
  command 'defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"'
  user    user
end

execute 'Finder: Show icons for external hard drives on the desktop' do
  command 'defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true'
  user    user
end

execute 'Finder: Show icons for hard drives on the desktop' do
  command 'defaults write com.apple.finder ShowHardDrivesOnDesktop -bool true'
  user    user
end
execute 'Finder: Show icons for servers on the desktop' do
  command 'defaults write com.apple.finder ShowMountedServersOnDesktop -bool true'
  user    user
end
execute 'Finder: Show icons for removable media on the desktop' do
  command 'defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true'
  user    user
end

execute 'Finder: Show path in Title Bar' do
  command 'defaults write com.apple.finder _FXShowPosixPathInTitle -bool YES'
  user    user
end

execute 'Finder: New Finder window shows $HOME' do
  command 'defaults write com.apple.finder NewWindowTarget -string "PfHm"'
  user    user
end

execute 'Finder: Show the ~/Library folder' do
  command 'chflags nohidden ~/Library'
  user    user
end

execute 'Finder: Show the path bar' do
  command 'defaults write com.apple.finder ShowPathBar -boolean true'
  user    user
end

execute 'Finder: Set sidebar icon size to small' do
  command 'defaults write NSGlobalDomain NSTableViewDefaultSizeMode -int 1'
  user    user
end

execute 'Finder: Scrollbar fix for finder and Terminal' do
  command 'defaults write -g AppleShowScrollBars -string WhenScrolling'
  user    user
end

execute 'Finder: Expand save panel by default' do
  command 'defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true'
  user    user
end

execute 'Finder: Expand print panel by default' do
  command 'defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true'
  user    user
end

###############################################################################
# Networking                                                                  #
###############################################################################

execute 'Enable AirDrop over Ethernet' do
  command 'defaults write com.apple.NetworkBrowser BrowseAllInterfaces 1'
  user    user
end

###############################################################################
# iTerm2 Tweaks                                                               #
###############################################################################

# Fix the scroll to top bug (where it jumps immediately back to bottom of screen)
# Be sure to restart iTerm2 after running this.
execute 'iTerm2: Fix scroll to top bug' do
  command 'defaults write com.googlecode.iterm2 NSScrollAnimationEnabled -bool NO'
  user    user
end

###############################################################################
# Power                                                                       #
###############################################################################

execute 'Power: Disable Mac from sleeping entirely' do
  command '/usr/bin/sudo /usr/bin/pmset -a sleep 0'
  user    user
end

execute 'Power: Never put the hard disks to sleep' do
  command '/usr/bin/sudo /usr/bin/pmset -a disksleep 0'
  user    user
end

execute 'Power: Put display to sleep after 10 minutes' do
  command '/usr/bin/sudo /usr/bin/pmset -a displaysleep 10'
  user    user
end

###############################################################################
# Mouse/Trackpad
###############################################################################

execute 'Mouse/Trackpad: Disable “natural” scrolling' do
  command 'defaults write ~/Library/Preferences/.GlobalPreferences.plist com.apple.swipescrolldirection -boolean NO'
  user    user
end

execute 'Mouse/Trackpad: Disable mouse pointer "shake to locate"' do
  command 'defaults write ~/Library/Preferences/.GlobalPreferences.plist CGDisableCursorLocationMagnification -bool YES'
  user   user
end

###############################################################################
# Keyboard
###############################################################################

execute 'Keyboard: Enable full keyboard controls' do
  command 'defaults write ~/Library/Preferences/.GlobalPreferences.plist AppleKeyboardUIMode -int 3'
  user    user
end

execute 'Keyboard: Set a shorter delay until key repeat' do
  command 'defaults write ~/Library/Preferences/.GlobalPreferences.plist InitialKeyRepeat -int 12'
  user    user
end

execute 'Keyboard: Set a blazingly fast keyboard repeat rate' do
  command 'defaults write ~/Library/Preferences/.GlobalPreferences.plist KeyRepeat -int 0'
  user    user
end

execute 'Keyboard: Enable character repeat on keydown' do
  command 'defaults write ~/Library/Preferences/.GlobalPreferences.plist ApplePressAndHoldEnabled -bool false'
  user    user
end

###############################################################################
# Dock, Dashboard, and Hot Corners                                            #
###############################################################################

execute 'Restart Dock' do
  command 'killall Dock'
  user    user
  action  :nothing
end

# Hot corners
# Possible values:
#  0: no-op
#  2: Mission Control
#  3: Show application windows
#  4: Desktop
#  5: Start screen saver
#  6: Disable screen saver
#  7: Dashboard
# 10: Put display to sleep
# 11: Launchpad
# 12: Notification Center

execute 'Dock: Set to right' do
  command 'defaults write com.apple.Dock orientation -string "right"'
  user    user
  notifies :run, 'execute[Restart Dock]'
end

execute 'Dock: Set autohide' do
  command 'defaults write com.apple.Dock autohide -bool TRUE'
  user    user
  notifies :run, 'execute[Restart Dock]'
end

execute 'Hot Corners: Bottom left screen corner → Start screen saver' do
  command 'defaults write com.apple.dock wvous-bl-corner -int 5 && defaults write com.apple.dock wvous-bl-modifier -int 0'
  user    user
  notifies :run, 'execute[Restart Dock]'
end

# directory "/Library/Application\ Support/GarageBand" do
#   action :delete
#   recursive true
# end
#
# directory "/Applications/GarageBand.app" do
#   action :delete
#   recursive true
# end
