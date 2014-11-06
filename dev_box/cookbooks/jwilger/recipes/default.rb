include_recipe 'dev_box'

ssh_known_hosts_entry 'github.com'

package 'zsh'

bash "Set vagrant shell to ZSH" do
  code <<-EOT
    chsh -s /bin/zsh vagrant 
  EOT
  not_if 'test "/bin/zsh" = "$(grep vagrant /etc/passwd | cut -d: -f7)"'
end

git "/home/vagrant/projects/dotfiles" do
  repository 'git@github.com:jwilger/dotfiles.git'
  revision 'master'
  enable_submodules true
  group 'vagrant'
  user 'vagrant'
  action :checkout
end

bash "link dotfiles" do
  user 'vagrant'
  code <<-EOF
    export HOME=/home/vagrant
    rm -rf ~/.vim*
    rm -rf ~/.tmux*
    cd /home/vagrant/projects/dotfiles
    rake update
  EOF
end

file "/home/vagrant/.zshrc.local" do
  owner 'vagrant'
  group 'vagrant'
  content <<-EOF
    export PATH="$PATH:/opt/rbenv/bin"
    source /etc/profile.d/rbenv.sh
  EOF
end

link '/etc/localtime' do
  to '/usr/share/zoneinfo/PST8PDT'
end
