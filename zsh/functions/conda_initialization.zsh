if [ "$CONDA_INITIALIZED" = 0 ]
then
    # Conda initialization
    __conda_setup="$('/Users/ravibrock/miniforge3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
    if [ $? -eq 0 ]; then
        eval "$__conda_setup"
    else
        if [ -f "/Users/ravibrock/miniforge3/etc/profile.d/conda.sh" ]; then
            . "/Users/ravibrock/miniforge3/etc/profile.d/conda.sh"
        else
            export PATH="/Users/ravibrock/miniforge3/bin:$PATH"
        fi
    fi
    unset __conda_setup
    # Sets environment variable so that Conda setup is not run again
    export CONDA_INITIALIZED=1
fi
