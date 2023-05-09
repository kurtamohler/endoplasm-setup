
# Add `~/bin` to path
PATH="$PATH:$HOME/bin"

# Activate main conda env
conda activate main

# nohist command to disable history for a shell session
alias nohist='unset HISTFILE'

# Configure `detach` command to autocomplete first arg as a command name
complete -F _command detach
