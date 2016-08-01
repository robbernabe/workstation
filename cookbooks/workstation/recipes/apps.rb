user = Mixlib::ShellOut.new("id -un ${SUDO_USER}").run_command.stdout.to_s.strip

###############################################################################
# MarkedPub
###############################################################################

# TODO: maybe change this to check for the application directory/symlink? I should
# check in /Applications (for a dir) and ~/Applications (for a symlink).
if node[:workstation][:markedpub]
  # If the LSUIElement exists, it will exit with return code 1
  execute 'MarkedPub: Remove from app switcher 0' do
    command '/usr/libexec/PlistBuddy /Applications/MarkedPub.app/Contents/Info.plist -c "Add LSUIElement String"'
    user    user
    returns [0, 1]
  end

  execute 'MarkedPub: Remove from app switcher 1' do
    command '/usr/libexec/PlistBuddy /Applications/MarkedPub.app/Contents/Info.plist -c "Set LSUIElement 1"'
    user    user
  end
end

if node[:workstation][:hermes]
  # If the LSUIElement exists, it will exit with return code 1
  execute 'Hermes: Remove from app switcher 0' do
    command '/usr/libexec/PlistBuddy /Applications/Hermes.app/Contents/Info.plist -c "Add LSUIElement String"'
    user    user
    returns [0, 1]
  end

  execute 'Hermes: Remove from app switcher 1' do
    command '/usr/libexec/PlistBuddy /Applications/Hermes.app/Contents/Info.plist -c "Set LSUIElement 1"'
    user    user
  end
end
