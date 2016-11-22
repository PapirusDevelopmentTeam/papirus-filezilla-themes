#!/usr/bin/env bash
echo "Papirus Filezilla themes"
sleep 5
echo "Delete old Papirus Filezilla themes ..."
sudo rm -rf /usr/share/filezilla/resources/{papirus,papirus-dark}
echo "Download new version from GitHub ..."
wget -c https://github.com/PapirusDevelopmentTeam/papirus-filezilla-themes/archive/master.zip -O /tmp/papirus-filezilla-themes.zip
echo "Unpack archive ..."
unzip -oq /tmp/papirus-filezilla-themes.zip -d /tmp/
echo "Installing ..."
sudo cp -R /tmp/papirus-filezilla-themes-master/{papirus,papirus-dark} /usr/share/filezilla/resources/
sudo chmod -R 755 /usr/share/filezilla/resources/{papirus,papirus-dark}
echo "Done!"
