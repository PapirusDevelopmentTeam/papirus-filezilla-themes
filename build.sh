#!/usr/bin/env bash

set -e

SCRIPT_DIR="$(dirname "${BASH_SOURCE[0]}")"

declare -a THEMES=(
	epapirus
	papirus
	papirus-dark
)

declare -A SIZES_MAP=(
	[16]="-density 96"
	[20]="-density 96 -extent 20x20"
	[24]="-density 96 -extent 24x24"
	[28]="-density 96 -extent 28x28"
	[32]="-density 192 -resize 32x32"
	[36]="-density 192 -resize 32x32 -extent 36x36"
	[40]="-density 192 -resize 32x32 -extent 40x40"
	[44]="-density 192 -resize 32x32 -extent 44x44"
	[48]="-density 288 -resize 48x48"
	[52]="-density 288 -resize 48x48 -extent 52x52"
	[56]="-density 288 -resize 48x48 -extent 56x56"
	[60]="-density 288 -resize 48x48 -extent 60x60"
	[64]="-density 384 -extent 64x64"
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
			;;
		papirus-dark)
			theme_name="Papirus Dark"
			find "$build_theme_dir" -type f -name '*.svg' -exec sed -i \
				-e 's/#444444/#d3dae3/gI' \
				-e 's/#4285f4/#4285f4/gI' '{}' \;
			;;
		epapirus)
			theme_name="ePapirus"
			find "$build_theme_dir" -type f -name '*.svg' -exec sed -i \
				-e 's/#444444/#6e6e6e/gI' \
				-e 's/#4285f4/#4285f4/gI' '{}' \;
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
	$(for size in "${!SIZES_MAP[@]}"; do \
		printf '<size primary="1">%sx%s</size>\n' "$size" "$size"; \
	done)
	</Theme>
	</FileZilla3>
	EOF

	# Copy AUTHORS and LICENSE to each theme
	cp -f "$SCRIPT_DIR/AUTHORS" "$SCRIPT_DIR/LICENSE" "$dest_theme_dir"

	# Convert to bitmap images
	for size in "${!SIZES_MAP[@]}"; do
		bitmap_dir="$DEST_DIR/$theme/${size}x${size}"
		mkdir -p "$bitmap_dir"
		read -ra opts <<< "${SIZES_MAP[$size]}"
		for file in "$build_theme_dir"/*; do
			[ -f "$file" ] || continue
			bitmap_file="$bitmap_dir/$(basename "$file" .svg).png"
			printf 'Converting "%s" -> "%s"\n' "$file" "$bitmap_file" >&2
			convert -background none -gravity center "${opts[@]}" "$file" "$bitmap_file"
		done
	done
done
