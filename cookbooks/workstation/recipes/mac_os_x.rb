#
# Cookbook Name:: workstation
# Recipe:: mac_os_x

include_recipe 'homebrew'

node[:workstation][:tools].each do |pkg|
  homebrew_package pkg
end

node[:workstation][:languages].each do |pkg|
  homebrew_package pkg
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

homebrew_tap 'homebrew/games'
homebrew_tap 'caskroom/versions'
homebrew_tap 'caskroom/fonts'
homebrew_tap 'nviennot/tmate'

homebrew_package 'tmate'

if node[:workstation][:install_casks]
  node[:workstation][:casks].each do |cask|
    homebrew_cask cask
  end

  node[:workstation][:fonts].each do |cask|
    homebrew_cask cask
  end
end
