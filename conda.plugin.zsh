[[ -n "$CONDA_AUTO_ACTIVATE_BASE" ]] || CONDA_AUTO_ACTIVATE_BASE=false
# Look for conda in $PATH and verify that it's not a part of conda-win in WSL
if ! command -v conda &>/dev/null; then
  FOUND_CONDA=0
# elif [[ "${commands[conda]}" = */conda-win/* && "$(uname -r)" = *icrosoft* ]]; then
#   FOUND_CONDA=0
else
  FOUND_CONDA=1
fi

# Look for conda and try to load it (will only work on interactive shells)
if [[ $FOUND_CONDA -ne 1 ]]; then
  condadirs=("$HOME/.anaconda3" "/usr/local/anaconda3" "/opt/anaconda3" "/usr/local/opt/anaconda3")
  for dir in $condadirs; do
    if [[ -d "$dir/bin" ]]; then
      FOUND_CONDA=1
      break
    fi
  done

  if [[ $FOUND_CONDA -ne 1 ]]; then
    if (( $+commands[brew] )) && dir=$(brew --prefix conda 2>/dev/null); then
      if [[ -d "$dir/bin" ]]; then
        FOUND_CONDA=1
      fi
    fi
  fi

  # If we found conda, load it but show a caveat about non-interactive shells
  if [[ $FOUND_CONDA -eq 1 ]]; then
    # Configuring in .zshrc only makes conda available for interactive shells
    export CONDA_ROOT="$dir"
    export PATH="$CONDA_ROOT/bin:$PATH"

    if [[ -n $INIT_CONDA ]]; then
        # init conda, the following command write scripts into your shell init file automatically
        eval "$(conda init zsh)"
        # disable init of env "base"
        eval "$(conda config --set auto_activate_base $CONDA_AUTO_ACTIVATE_BASE)"
    fi
  fi
fi

# the prompt
function conda_prompt_info() {
  echo "${ZSH_THEME_CONDA_PROMPT_PREFIX}$(conda_env)${ZSH_THEME_CONDA_PROMPT_SEPARATOR}$(conda_py_ver)${ZSH_THEME_CONDA_PROMPT_SUFFIX}"
}

# a simpler prompt (this is the more tradtional version)
function conda_env_prompt_info() {
  echo "${ZSH_THEME_CONDA_PROMPT_PREFIX}$(conda_env)${ZSH_THEME_CONDA_PROMPT_SUFFIX}"
}

# Conda evniornment
function conda_env() {
  if [[ -n ${CONDA_DEFAULT_ENV} ]]; then
    echo ${CONDA_DEFAULT_ENV}
  fi
}

# Python version
function conda_py_ver() {
  if [[ -n ${CONDA_DEFAULT_ENV} ]]; then
    echo "py:$(python -V | cut -d ' ' -f 2)"
  fi
}

# Default values for the appearance of the prompt. Customize in your theme if you like.
ZSH_THEME_CONDA_PROMPT_PREFIX="%{$FG[028]%}("
ZSH_THEME_CONDA_PROMPT_SUFFIX=")%{$reset_color%}"
ZSH_THEME_CONDA_PROMPT_SEPARATOR="|"

unset FOUND_CONDA condadirs dir