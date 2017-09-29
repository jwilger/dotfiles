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
  task update: destination
end

def link_homedir_files(files = [])
  files.each do |destination|
    source = destination.sub(/^\./, '')
    link_file this(source), home(destination)
  end
end

link_homedir_files %w(
  .dev_box
  .emacs.d
  .fonts
  .gemrc
  .gitconfig
  .gitignore
  .spacemacs
  .ssh
  .tmux.conf
  .zprofile
  .zshenv
  .zshrc
  bin
)

task :update_submodules do
  `git submodule init`
  `git submodule update`
end

task default: [:update_submodules, :update]
