# Note that for the 'NSGlobalDomain' we will only set for our own user, which
# is the GlobalPreferences file located at:
#
#       ~/Library/Preferences/.GlobalPreferences.plist
#
# Resources:
#   - http://jtimberman.housepub.org/blog/2014/12/29/chef-12-homebrew-user-mixin/

Chef::Resource::Execute.send(:include, Chef::Mixin::HomebrewUser)

# directory "/Library/Application\ Support/GarageBand" do
#   action :delete
#   recursive true
# end
# 
# directory "/Applications/GarageBand.app" do
#   action :delete
#   recursive true
# end

# Before getting started, make sure perms are correct on our preference file!
execute 'Set ownership properly on GlobalPreferences file' do
  command "chown #{find_homebrew_uid}:staff ~/Library/Preferences/.GlobalPreferences.plist"
end

###############################################################################
# Safari                                                                      #
###############################################################################

execute 'Safari: Re-enable backspace/delete to go back in Safari' do
  command 'defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2BackspaceKeyNavigationEnabled -bool YES'
  user    find_homebrew_uid
end

###############################################################################
# Mail                                                                        #
###############################################################################

execute 'Apple Mail: Disable inline attachments (just show the icons)' do
  command 'defaults write com.apple.mail DisableInlineAttachmentViewing -bool true'
  user    find_homebrew_uid
end

###############################################################################
# Chrome                                                                      #
###############################################################################

execute 'Chrome: Disable swipe to to navigate' do
  command 'defaults write com.google.Chrome.plist AppleEnableSwipeNavigateWithScrolls -bool FALSE'
  user    find_homebrew_uid
end

###############################################################################
# Finder                                                                      #
###############################################################################

execute 'Finder: Use list view in all Finder windows by default' do
  command 'defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"'
  user    find_homebrew_uid
end

execute 'Finder: Show icons for external hard drives on the desktop' do
  command 'defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true'
  user    find_homebrew_uid
end

execute 'Finder: Show icons for hard drives on the desktop' do
  command 'defaults write com.apple.finder ShowHardDrivesOnDesktop -bool true'
  user    find_homebrew_uid
end
execute 'Finder: Show icons for servers on the desktop' do
  command 'defaults write com.apple.finder ShowMountedServersOnDesktop -bool true'
  user    find_homebrew_uid
end
execute 'Finder: Show icons for removable media on the desktop' do
  command 'defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true'
  user    find_homebrew_uid
end

execute 'Finder: Show path in Title Bar' do
  command 'defaults write com.apple.finder _FXShowPosixPathInTitle -bool YES'
  user    find_homebrew_uid
end

execute 'Finder: New Finder window shows $HOME' do
  command 'defaults write com.apple.finder NewWindowTarget -string "PfHm"'
  user    find_homebrew_uid
end

execute 'Finder: Show the ~/Library folder' do
  command 'chflags nohidden ~/Library'
  user    find_homebrew_uid
end

execute 'Finder: Show the path bar' do
  command 'defaults write com.apple.finder ShowPathBar -boolean true'
  user    find_homebrew_uid
end

execute 'Finder: Set sidebar icon size to small' do
  command 'defaults write NSGlobalDomain NSTableViewDefaultSizeMode -int 1'
  user    find_homebrew_uid
end

execute 'Finder: Scrollbar fix for finder and Terminal' do
  command 'defaults write -g AppleShowScrollBars -string WhenScrolling'
  user    find_homebrew_uid
end

execute 'Finder: Expand save panel by default' do
  command 'defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true'
  user    find_homebrew_uid
end

execute 'Finder: Expand print panel by default' do
  command 'defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true'
  user    find_homebrew_uid
end

###############################################################################
# Networking                                                                  #
###############################################################################

execute 'Enable AirDrop over Ethernet' do
  command 'defaults write com.apple.NetworkBrowser BrowseAllInterfaces 1'
  user    find_homebrew_uid
end

###############################################################################
# iTerm2 Tweaks                                                               #
###############################################################################

# Fix the scroll to top bug (where it jumps immediately back to bottom of screen)
# Be sure to restart iTerm2 after running this.
execute 'iTerm2: Fix scroll to top bug' do
  command 'defaults write com.googlecode.iterm2 NSScrollAnimationEnabled -bool NO'
  user    find_homebrew_uid
end

###############################################################################
# Power                                                                       #
###############################################################################

execute 'Power: Disable Mac from sleeping entirely' do
  command '/usr/bin/sudo /usr/bin/pmset -a sleep 0'
  user    find_homebrew_uid
end

execute 'Power: Never put the hard disks to sleep' do
  command '/usr/bin/sudo /usr/bin/pmset -a disksleep 0'
  user    find_homebrew_uid
end

execute 'Power: Put display to sleep after 10 minutes' do
  command '/usr/bin/sudo /usr/bin/pmset -a displaysleep 10'
  user    find_homebrew_uid
end

###############################################################################
# Mouse/Trackpad
###############################################################################

execute 'Mouse/Trackpad: Disable “natural” scrolling' do
  command 'defaults write ~/Library/Preferences/.GlobalPreferences.plist com.apple.swipescrolldirection -boolean NO'
  user    find_homebrew_uid
end

execute 'Mouse/Trackpad: Disable mouse pointer "shake to locate"' do
  command 'defaults write ~/Library/Preferences/.GlobalPreferences CGDisableCursorLocationMagnification -bool YES'
  user   find_homebrew_uid
end

###############################################################################
# Dock, Dashboard, and hot corners                                            #
###############################################################################

execute 'Restart Dock' do
  command 'killall Dock'
  user    find_homebrew_uid
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

# Note: Be sure to run `killall Dock` for these settings to take effect

execute 'Hot Corners: Bottom left screen corner → Start screen saver' do
  command 'defaults write com.apple.dock wvous-bl-corner -int 5 && defaults write com.apple.dock wvous-bl-modifier -int 0'
  user    find_homebrew_uid
  notifies :run, 'execute[Restart Dock]'
end
