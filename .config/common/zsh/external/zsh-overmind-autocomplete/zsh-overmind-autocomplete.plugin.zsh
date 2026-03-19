_overmind_generic() {
  # Parse subcommands from 'overmind -h'
  local -a subcommands
  subcommands=("${(@f)$(overmind -h | awk '/COMMANDS:/{flag=1; next} /GLOBAL OPTIONS:/{flag=0} flag {gsub(",", ""); print $1}')}")

  # Map full command names to their single-letter alternatives
  typeset -A subcmd_map
  subcmd_map=(
    'start' 's'
    'restart' 'r'
    'stop' 'i'
    'connect' 'c'
    'quit' 'q'
    'kill' 'k'
    'run' 'e'
    'status' 'ps'
  )

  if (( CURRENT == 2 )); then
    _describe 'subcommand' subcommands
    return
  fi

  local cmd=${subcmd_map[$words[2]]}
  [[ -z "$cmd" ]] && cmd=$words[2]

case $cmd in
  'restart'|'r'|'connect'|'c'|'stop'|'i')
    local -a procs
    local output=$(overmind status | awk 'NR>1 {print $1}')
    procs=("${(@f)output}")
    _describe 'process name' procs
    ;;
esac

}

compdef '_overmind_generic' overmind
