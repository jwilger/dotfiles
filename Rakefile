def home(*args)
  File.join(File.expand_path('~'), *args)
end

def this(*args)
  File.join(File.expand_path(File.dirname(__FILE__)), *args)
end

def link_file(source, destination)
  file destination do
    ln_s source, destination
  end
  task :update => destination
end

def link_homedir_files(files = [])
  files.each do |destination|
    source = destination.sub(/^\./, '')
    link_file this(source), home(destination)
  end
end

link_homedir_files %w(
  .gemrc
  .gitconfig
  .gitignore
  .tmux.conf
  .vim
  .vimrc
  .zshrc
  bin
)

dropbox_ssh_path = File.expand_path(File.join('~', 'Dropbox', 'Personal', '.ssh'))
if File.exists?(dropbox_ssh_path)
  link_file(dropbox_ssh_path, home('.ssh'))
end

task :default do
  puts "You probably wanted `rake update`. There is no default task."
end
