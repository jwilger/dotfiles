def home(*args)
  File.join(File.expand_path('~'), *args)
end

def this(*args)
  File.join(File.expand_path(File.dirname(__FILE__)), *args)
end

task :install => :update

desc "Creates/updates symlinks in home directory"
task :update => [
  :autotest,
  :gemrc,
  :gitconfig,
  :gitignore,
  :irbrc,
  :screenrc,
  :tmux,
  :ssh,
  :vim,
  :vimrc,
  :zshrc,
  :zlogin,
  :zshenv,
  :rvmrc,
  :bin
]

task :autotest => home('.autotest')
task :gemrc => home('.gemrc')
task :gitconfig => home('.gitconfig')
task :gitignore => home('.gitignore')
task :irbrc => home('.irbrc')
task :screenrc => home('.screenrc')
task :tmux => home('.tmux.conf')
task :ssh => home('.ssh')
task :vim => home('.vim')
task :vimrc => home('.vimrc')
task :zshrc => home('.zshrc')
task :zlogin => home('.zlogin')
task :zshenv => home('.zshenv')
task :rvmrc => home('.rvmrc')
task :bin => home('bin')

file home('.autotest') do
  ln_s this('autotest'), home('.autotest')
end

file home('.gemrc') do
  ln_s this('gemrc'), home('.gemrc')
end

file home('.gitconfig') do
  ln_s this('gitconfig'), home('.gitconfig')
end

file home('.gitignore') do
  ln_s this('gitignore'), home('.gitignore')
end

file home('.irbrc') do
  ln_s this('irbrc'), home('.irbrc')
end

file home('.screenrc') do
  ln_s this('screenrc'), home('.screenrc')
end

file home('.tmux.conf') do
  ln_s this('tmux.conf'), home('.tmux.conf')
end

file home('.ssh') do
  ln_s home('Dropbox/Personal/.ssh'), home('.ssh')
  chmod(0600, File.join(home('.ssh'), 'id_dsa'))
end

file home('.vim') do
  ln_s this('vim'), home('.vim')
end

file home('.vimrc') do
  ln_s this('vimrc'), home('.vimrc')
end

file home('.zshrc') do
  ln_s this('zshrc'), home('.zshrc')
end

file home('.zlogin') do
  ln_s this('zlogin'), home('.zlogin')
end

file home('.zshenv') do
  ln_s this('zlogin'), home('.zshenv')
end

file home('.rvmrc') do
  ln_s this('rvmrc'), home('.rvmrc')
end

file home('bin') do
  ln_s this('bin'), home('bin')
end
