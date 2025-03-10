#!/bin/sh
#
# Overleaf Git Tools
# This file is based on the equivalent in SolidWorks Git Tools
#
# Copyright (C) 2021 Ellie Clifford
# Copyright (C) 2021 Ellie Clifford, Henry Franks
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as
# published by the Free Software Foundation, either version 3 of the
# License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Affero General Public License for more details.
#
# You should have received a copy of the GNU Affero General Public License
# along with this program.  If not, see <https://www.gnu.org/licenses/>.

# Remove existing sld config if it exists and replace it with the latest config
header_start="\
### ---------------- BEGIN AUTO ADDED OVERLEAF TOOLS ---------------------- ###\
"
header_end="\
### ----------------- END AUTO ADDED OVERLEAF TOOLS ----------------------- ###\
"

setup_config() { # args (header_start, header_end, file to add, file to add to)

	if ! [ -f $4 ]; then
		# Thanks, I hate it
		echo "\
$1
$(cat "$3")
$2" >> $4

	elif cat $4 | grep -q "$1"; then
		echo "Found existing overleaf config in $4, replacing..."
		# This is cursed, but at least it's not vba...
		f="\
$(grep -B9999 "$1" $4 | grep -v "$1")
$1
$(cat "$3")
$2
$(grep -A9999 "$2" $4 | grep -v "$2")"
		# Can't oneline this because of order of operations
		echo "$f" > $4
	else
		# Thanks, I hate it
		echo "\
$1
$(cat "$3")
$2" >> $4
	fi
}

setup_config \
	"$header_start" "$header_end" \
	"ols-git-tools/gitconfig" \
	".git/config"
