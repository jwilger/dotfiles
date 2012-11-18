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
  .autotest
  .gemrc
  .gitconfig
  .gitignore
  .irbrc
  .offlineimap.py
  .offlineimaprc
  .screenrc
  .tmux.conf
  .urlview
  .vim
  .vimrc
  .zshrc
  bin
)
