#!/bin/sh

set -e

gh_repo="papirus-filezilla-themes"
gh_desc="Papirus Filezilla themes"

cat <<- EOF



      ppppp                         ii
      pp   pp     aaaaa   ppppp          rr  rrr   uu   uu     sssss
      ppppp     aa   aa   pp   pp   ii   rrrr      uu   uu   ssss
      pp        aa   aa   pp   pp   ii   rr        uu   uu      ssss
      pp          aaaaa   ppppp     ii   rr          uuuuu   sssss
                          pp
                          pp


  $gh_desc
  https://github.com/PapirusDevelopmentTeam/$gh_repo


EOF

echo "=> Removing $gh_desc ..."
sudo rm -rf /usr/share/filezilla/resources/papirus \
  /usr/share/filezilla/resources/epapirus \
  /usr/share/filezilla/resources/papirus-dark
echo "=> Done!"
