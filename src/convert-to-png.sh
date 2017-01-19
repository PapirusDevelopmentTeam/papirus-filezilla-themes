#!/bin/bash
echo "convert ePapirus"
cd epapirus
rm *.png
for file in *.svg; do inkscape $file --without-gui --export-png=$file.png; done
rename 's/\.svg\.png/\.png/g' *.png
cd ..

echo "convert Papirus"
cd papirus
rm *.png
for file in *.svg; do inkscape $file --without-gui --export-png=$file.png; done
rename 's/\.svg\.png/\.png/g' *.png
cd ..

echo "convert PapirusDark"
cd papirus-dark
rm *.png
for file in *.svg; do inkscape $file --without-gui --export-png=$file.png; done
rename 's/\.svg\.png/\.png/g' *.png
cd ..
echo "done"
