# ZSH completion file
# Move to a folder that's in your $fpath and rename to _conf
# If you're installing with Homebrew on Mac, this is already done for you

#compdef conf
local state line

# Function for subcommand completion
function _cmds {
  local commands
  commands=(
    'link[link an entry]'
    'unlink[unlink an entry]'
    'check[check an entry]'
    'list[list entries]'
    'edit[edit the map file]'
  )
  _values 'commands' $commands
}

# The (- 1) means don't complete argument 1 or options after completing what's on the line
# The 1 is the first argument, should be completed using the _cmds function
local arguments
arguments=(
  '(- 1)-man[show manual]'
  '(- 1)--manual[show manual]'
  '(- 1)-h[show help]'
  '(- 1)--help[show help]'
  '(- 1)1:: :_cmds'
)

# -A "-*" means don't complete any options after the first normal argument
_arguments -A "-*" $arguments

