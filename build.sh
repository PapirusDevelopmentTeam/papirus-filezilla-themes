#!/usr/bin/env bash

set -e

SCRIPT_DIR="$(dirname "${BASH_SOURCE[0]}")"

declare -a THEMES=(
	epapirus
	papirus
	papirus-dark
	papirus-adapta
	papirus-adapta-nokto
)

declare -a SIZES=(
	16
	32
	64
)

: "${DEST_DIR:=$SCRIPT_DIR}"
: "${SRC_DIR:=$SCRIPT_DIR/src}"
: "${BUILD_DIR:=$SCRIPT_DIR/build}"

for theme in "${THEMES[@]}"; do
	printf '=> Generate "%s" ...\n' "$theme" >&2

	dest_theme_dir="$DEST_DIR/$theme"
	build_theme_dir="$BUILD_DIR/$theme"

	rm -rf "$build_theme_dir" "$dest_theme_dir"
	mkdir -p "$build_theme_dir" "$dest_theme_dir"

	cp -R "$SRC_DIR"/* "$build_theme_dir"

	case "$theme" in
		papirus)
			theme_name="Papirus"
			find "$build_theme_dir" -type f -name '*.svg' -exec sed -i \
				-e 's/#5c616c/#5c616c/gI' \
				-e 's/#5294e2/#5294e2/gI' '{}' \;
			;;
		papirus-dark)
			theme_name="Papirus Dark"
			find "$build_theme_dir" -type f -name '*.svg' -exec sed -i \
				-e 's/#5c616c/#d3dae3/gI' \
				-e 's/#5294e2/#5294e2/gI' '{}' \;
			;;
		epapirus)
			theme_name="ePapirus"
			find "$build_theme_dir" -type f -name '*.svg' -exec sed -i \
				-e 's/#5c616c/#6e6e6e/gI' \
				-e 's/#5294e2/#5294e2/gI' '{}' \;
			;;
		papirus-adapta)
			theme_name="Papirus Adapta"
			find "$build_theme_dir" -type f -name '*.svg' -exec sed -i \
				-e 's/#5c616c/#414c52/gI' \
				-e 's/#5294e2/#e74c3c/gI' '{}' \;
			;;
		papirus-adapta-nokto)
			theme_name="Papirus Adapta Nokto"
			find "$build_theme_dir" -type f -name '*.svg' -exec sed -i \
				-e 's/#5c616c/#cfd8dc/gI' \
				-e 's/#5294e2/#e74c3c/gI' '{}' \;
			;;
	esac

	# Create theme.xml
	cat > "$dest_theme_dir/theme.xml" <<-EOF
	<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
	<FileZilla3>
	<Theme>
	<Name>${theme_name}</Name>
	<Source>${theme}</Source>
	<Author>Alexey Varfolomeev</Author>
	<Mail>varlesh@gmail.com</Mail>
	$(for size in "${SIZES[@]}"; do \
		printf '<size primary="1">%sx%s</size>\n' "${size}" "$size"; \
	done)
	</Theme>
	</FileZilla3>
	EOF

	# Copy AUTHORS and LICENSE to each theme
	cp -f "$SCRIPT_DIR/AUTHORS" "$SCRIPT_DIR/LICENSE" "$dest_theme_dir"

	# Convert to bitmap images
	for size in "${SIZES[@]}"; do
		bitmap_dir="$DEST_DIR/$theme/${size}x${size}"
		mkdir -p "$bitmap_dir"
		find "$build_theme_dir" -name '*.svg' | while read -r file; do
			bitmap_file="${bitmap_dir}/$(basename -s .svg "$file").png"
			printf 'Converting "%s" -> "%s"\n' "$file" "$bitmap_file" >&2
			rsvg-convert -w "$size" -h "$size" -f png "$file" -o "$bitmap_file"
		done
	done
done
