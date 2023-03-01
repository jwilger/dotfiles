launch-dc() {
  local flag_help

  local -A opts=(
    "-n" `basename $PWD`
    "-w" $PWD
    "-u" "vscode"
    "-c" "app"
    "-p" "/workspace"
    "-e" "zsh"
    "-d" "jwilger/dotfiles"
  )

  local usage=(
    "launch-dc [-h|--help]"
    "launch-dc [-u|--user=CONTAINER_USER] [-n|--name=DOCKER_COMPOSE_PROJECT_NAME] [-c|--container=CONTAINER_TO_ATTACH] [-p|--path=CONTAINER_PATH_TO_START_IN] [-e|--exec=COMMAND_TO_EXEC_IN_CONTAINER] [-w|--workspace-folder=DEVCONTAINER_HOST_PATH] [-d|--dotfiles-repository=DOTFILES_REPO_URL]"
  )

  zparseopts -A opts -K -M -- \
    h=flag_help \
    -help=h \
    n:=arg_name \
    -name=n \
    c:=arg_container \
    -container=c \
    p:=arg_container_path \
    -path=p \
    e:=arg_container_cmd \
    -exec=e \
    w:=arg_workspace_folder \
    -workspace-folder=w \
    d:=arg_dotfiles_repository \
    -dotfiles-repository=d \
    u:=arg_container_user \
    -user=u

  if [[ -z "$flag_help" ]];then
    export COMPOSE_PROJECT_NAME=$opts[-n]
    asdf shell nodejs 18.14.2
    devcontainer up --workspace-folder $opts[-w] --dotfiles-repository $opts[-d]
    docker compose -p $opts[-n] exec -it -u $opts[-u] -w $opts[-p] $opts[-c] $opts[-e]
  else
    { print -l $usage && return }
  fi
}
