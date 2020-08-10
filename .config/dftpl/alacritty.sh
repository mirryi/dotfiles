#!/bin/bash

# name of the template file
alacritty_config_template="alacritty.yml.tmpl"

# name of the configuration file
alacritty_config_name="alacritty.yml"
# path of the configuration directory
alacritty_config_dir="$XDG_CONFIG_HOME/alacritty"
# path of the configuration file
alacritty_config_yaml="$alacritty_config_dir/$alacritty_config_name"
# path of the generated directory
alacritty_activated_dir="$activated_dir/alacritty"
# path of the generated configuration file
alacritty_config_activated="$alacritty_activated_dir/$alacritty_config_name"

restore_file "$alacritty_config_yaml"
backup_file "$alacritty_config_yaml"

mkdir -p "$alacritty_activated_dir"
gotpl_f "$alacritty_config_template" "$alacritty_config_activated"
ln -sf "$alacritty_config_activated" "$alacritty_config_yaml"
