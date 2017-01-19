#!/bin/bash
echo "clear directories"
rm {epapirus,papirus,papirus-dark}/*.png

echo "convert to 16x16"
for file in epapirus/*.svg; do rsvg-convert -w 16 -h 16 -f png $file > $file.png; done
for file in papirus/*.svg; do rsvg-convert -w 16 -h 16 -f png $file > $file.png; done
for file in papirus-dark/*.svg; do rsvg-convert -w 16 -h 16 -f png $file > $file.png; done
rename 's/\.svg\.png/\.png/g' papirus/*.png
rename 's/\.svg\.png/\.png/g' epapirus/*.png
rename 's/\.svg\.png/\.png/g' papirus-dark/*.png

echo "copy 16x16 to theme"
cp epapirus/*.png ../epapirus/16x16/
cp papirus/*.png ../papirus/16x16/
cp papirus-dark/*.png ../papirus-dark/16x16/

echo "clear directories"
rm {epapirus,papirus,papirus-dark}/*.png

echo "convert to 32x32"
for file in epapirus/*.svg; do rsvg-convert -w 32 -h 32 -f png $file > $file.png; done
for file in papirus/*.svg; do rsvg-convert -w 32 -h 32 -f png $file > $file.png; done
for file in papirus-dark/*.svg; do rsvg-convert -w 32 -h 32 -f png $file > $file.png; done
rename 's/\.svg\.png/\.png/g' papirus/*.png
rename 's/\.svg\.png/\.png/g' epapirus/*.png
rename 's/\.svg\.png/\.png/g' papirus-dark/*.png

echo "copy 32x32 to theme"
cp epapirus/*.png ../epapirus/32x32/
cp papirus/*.png ../papirus/32x32/
cp papirus-dark/*.png ../papirus-dark/32x32/

echo "clear directories"
rm {epapirus,papirus,papirus-dark}/*.png

echo "convert to 64x64"
for file in epapirus/*.svg; do rsvg-convert -w 64 -h 64 -f png $file > $file.png; done
for file in papirus/*.svg; do rsvg-convert -w 64 -h 64 -f png $file > $file.png; done
for file in papirus-dark/*.svg; do rsvg-convert -w 64 -h 64 -f png $file > $file.png; done
rename 's/\.svg\.png/\.png/g' papirus/*.png
rename 's/\.svg\.png/\.png/g' epapirus/*.png
rename 's/\.svg\.png/\.png/g' papirus-dark/*.png

echo "copy 64x64 to theme"
cp epapirus/*.png ../epapirus/64x64/
cp papirus/*.png ../papirus/64x64/
cp papirus-dark/*.png ../papirus-dark/64x64/

echo "clear directories"
rm {epapirus,papirus,papirus-dark}/*.png

echo "all done"
