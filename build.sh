#!/usr/bin/env bash

set -e

DESTDIR=".."

THEMES=(
	epapirus
	papirus
	papirus-dark
    papirus-adapta
    papirus-adapta-nokto
)

SIZES=(
	16
	32
	64
)

for theme in "${THEMES[@]}"; do
	echo "=> Generate $theme ..."
	for size in "${SIZES[@]}"; do
		dest_dir="${DESTDIR}/${theme}/${size}x${size}"
		mkdir -p "$dest_dir"
		find "$theme" -type f -name '*.svg' | while read file; do
			dest_file="${dest_dir}/$(basename -s .svg "$file").png"
			echo "Convert $file -> $dest_file"
			rsvg-convert -w "$size" -h "$size" -f png "$file" -o "$dest_file"
		done
	done
done
