#!/bin/bash

# name of the template file
dunst_config_template="dunstrc.tmpl"

# name of the configuration file
dunst_config_name="dunstrc"
# path of the configuration directory
dunst_config_dir="$XDG_CONFIG_HOME/dunst"
# path of the configuration file
dunst_config_path="$dunst_config_dir/$dunst_config_name"
# path of the generated directory
dunst_activated_dir="$activated_dir/dunst"
# path of the generated configuration file
dunst_config_activated="$dunst_activated_dir/$dunst_config_name"

restore_file "$dunst_config_path"
backup_file "$dunst_config_path"

mkdir -p "$dunst_activated_dir"
gotpl_f "$dunst_config_template" "$dunst_config_activated"
ln -sf "$dunst_config_activated" "$dunst_config_path"

# restart dunst
echo "Restarting dunst..."
pkill dunst
dunst &
