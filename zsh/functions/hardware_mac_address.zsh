networksetup -listallhardwareports | awk -v RS= '/en0/{print $NF}'
