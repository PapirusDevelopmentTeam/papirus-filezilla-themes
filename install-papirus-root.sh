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

temp_dir="$(mktemp -d)"

echo "=> Getting the latest version from GitHub ..."
wget -O "/tmp/$gh_repo.tar.gz" \
  https://github.com/PapirusDevelopmentTeam/$gh_repo/archive/master.tar.gz
echo "=> Unpacking archive ..."
tar -xzf "/tmp/$gh_repo.tar.gz" -C "$temp_dir"
echo "=> Deleting old $gh_desc ..."
sudo rm -rf /usr/share/filezilla/resources/papirus \
  /usr/share/filezilla/resources/epapirus \
  /usr/share/filezilla/resources/papirus-dark
echo "=> Installing ..."
sudo cp -R \
  "$temp_dir/$gh_repo-master/papirus" \
  "$temp_dir/$gh_repo-master/epapirus" \
  "$temp_dir/$gh_repo-master/papirus-dark" \
  "/usr/share/filezilla/resources/"
echo "=> Clearing cache ..."
rm -rf "/tmp/$gh_repo.tar.gz" "$temp_dir"
echo "=> Done!"
