#
# Cookbook:: workstation
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.

package ['vim','tree','htop', 'tmux'] do
  action :install
end

execute 'update' do
  command 'apt-get update && apt-get upgrade'
 end

user 'tomjones' do
  home '/home/tomjones'
  shell '/bin/bash'
end

template '.vimrc' do
  source 'vimrc.erb'
  owner 'tomjones'
  group 'tomjones'
  mode '0755'
  action :create
  not_if { ::File.exist?('/home/tomjones/.vimrc') }
end

directory '/home/tomjones/.vim' do
  owner 'tomjones'
  group 'tomjones'
  mode '0755'
  action :create
end

execute 'vundle' do
  command 'git clone https://github.com/VundleVim/Vundle.vim.git /home/tomjones/.vim/bundle/Vundle.vim'
  not_if { ::File.directory?('/home/tomjones/.vim/bundle/Vundle.vim') }
end

execute 'vim-install-plugins' do
  command 'vim +PluginInstall +qall'
end
