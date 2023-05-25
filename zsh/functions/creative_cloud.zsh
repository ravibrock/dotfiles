if [ $argv = 'disable' ]
then
    launchctl unload -w /Library/LaunchAgents/com.adobe.AdobeCreativeCloud.plist
fi
if [ $argv = 'enable' ]
then
    launchctl load -w /Library/LaunchAgents/com.adobe.AdobeCreativeCloud.plist
fi
