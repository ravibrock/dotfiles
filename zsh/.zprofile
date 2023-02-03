# Setting PATH for Python 3.9
PATH="/Library/Frameworks/Python.framework/Versions/3.9/bin:${PATH}"
export PATH

# Setting PATH for Python 3.10
PATH="/Library/Frameworks/Python.framework/Versions/3.10/bin:${PATH}"
export PATH

# MacPorts Installer addition on 2022-09-05_at_14:37:34: adding an appropriate PATH variable for use with MacPorts.
export PATH="/opt/local/bin:/opt/local/sbin:$PATH"

# Set PATH, MANPATH, etc., for Homebrew.
eval "$(/opt/homebrew/bin/brew shellenv)"
