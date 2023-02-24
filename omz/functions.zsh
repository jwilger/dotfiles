launch-dc() {
  default_name=`basename $PWD`
  name=${1-${default_name}}
  container=${2-app}
  container_path=${3-/workspace}
  export COMPOSE_PROJECT_NAME=$name
  asdf shell nodejs lts
  devcontainer up --workspace-folder . --dotfiles-repository https://github.com/jwilger/dotfiles.git
  docker compose -p $name exec -it -u vscode -w $container_path $container zsh
}
