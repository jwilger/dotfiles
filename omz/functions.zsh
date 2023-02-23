launch-dc() {
  name=$1
  container=$2
  container_path=${3-/workspaces}
  export COMPOSE_PROJECT_NAME=$name
  asdf shell nodejs lts
  devcontainer up --workspace-folder . --dotfiles-repository https://github.com/jwilger/dotfiles.git
  docker compose -p $name exec -it -u vscode -w $container_path $container zsh
}
