#!/bin/zsh

# comments in interactive code
setopt INTERACTIVE_COMMENTS
# expand parameters, commands, etc.
setopt PROMPT_SUBST
# no c-s/c-q output freezing
setopt NO_FLOW_CONTROL
# completion within words
setopt COMPLETE_IN_WORD
# autocontinue suspended process on disown
setopt AUTO_CONTINUE
# match hidden files without specify dot
setopt GLOBDOTS

# enable colors
autoload -Uz colors
colors

# enable url magic
autoload -Uz url-quote-magic
zle -N self-insert url-quote-magic

# enable version control info
autoload -Uz vcs_info
