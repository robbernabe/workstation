#
# Cookbook: workstation
# Attribute: default
#

default[:workstation][:markedpub] = true
default[:workstation][:hermes]    = true
default[:workstation][:install_casks] = true

default[:workstation][:languages] = %w(go python node)
default[:workstation][:gems]      = %w(tmuxinator)
default[:workstation][:devops]    = %w(ansible packer terraform)
default[:workstation][:infosec]   = %w(chkrootkit nmap siege)
default[:workstation][:fonts]     = %w(font-inconsolata font-ubuntu-mono-powerline)
default[:workstation][:misc]      = %w(ghostscript imagemagick pidof)
default[:workstation][:games]     = %w(vitetris)
default[:workstation][:tools]     = %w(
  awscli curl git mercurial the_silver_searcher wget htop-osx httpie iperf
  mtr openssl siege sl sqlite ssh-copy-id tmux tree watch youtube-dl pyenv
  pass reattach-to-user-namespace httping ctags cmake sysdig vim rbenv rbenv-gemset
  coreutils jq jrnl postgresql postgis redis rabbitmq keybase tmate direnv fzf ranger
)
default[:workstation][:casks]     = %w(
  alfred google-chrome firefox dropbox gpgtools spectacle 1password
  handbrake iterm2-nightly launchrocket licecap macdown macvim slack
  mysqlworkbench screenhero skype xquartz vlc wireshark viscosity
  backblaze istat-menus sequel-pro dockertoolbox virtualbox
  vagrant vmware-fusion evernote appcleaner insomniax hermes
)
