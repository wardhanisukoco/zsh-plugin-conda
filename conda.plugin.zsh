[[ -n "$CONDA_AUTO_ACTIVATE_BASE" ]] || CONDA_AUTO_ACTIVATE_BASE=false

if [[ -n $INIT_CONDA ]]; then
    # init conda, the following command write scripts into your shell init file automatically
    eval "$(conda init zsh)"
    # disable init of env "base"
    eval "$(conda config --set auto_activate_base $CONDA_AUTO_ACTIVATE_BASE)"
fi
