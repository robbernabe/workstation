#
# Cookbook Name:: workstation
# Recipe:: mac_os_x

include_recipe 'homebrew'

homebrew_tap 'caskroom/cask'
homebrew_tap 'caskroom/versions'
homebrew_tap 'caskroom/fonts'
homebrew_tap 'homebrew/games'

node[:workstation][:tools].each do |pkg|
  homebrew_package pkg
end

node[:workstation][:languages].each do |pkg|
  homebrew_package pkg
end

node[:workstation][:gems].each do |pkg|
  gem_package pkg
end

node[:workstation][:devops].each do |pkg|
  homebrew_package pkg
end

node[:workstation][:infosec].each do |pkg|
  homebrew_package pkg
end

node[:workstation][:misc].each do |pkg|
  homebrew_package pkg
end

node[:workstation][:games].each do |pkg|
  homebrew_package pkg
end

if node[:workstation][:install_casks]
  node[:workstation][:casks].each do |cask|
    homebrew_cask cask
  end

  node[:workstation][:fonts].each do |cask|
    homebrew_cask cask
  end
end
