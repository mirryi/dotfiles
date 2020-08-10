#!/bin/bash

# name of the template file
bat_config_template="bat.config.tmpl"

# name of the configuration file
bat_config_name="config"
# path of the configuration directory
bat_config_dir="$XDG_CONFIG_HOME/bat"
# path of the configuration file
bat_config_path="$bat_config_dir/$bat_config_name"
# path of the generated directory
bat_activated_dir="$activated_dir/bat"
# path of the generated configuration file
bat_config_activated="$bat_activated_dir/$bat_config_name"

restore_file "$bat_config_path"
backup_file "$bat_config_path"

mkdir -p "$bat_activated_dir"
gotpl_f "$bat_config_template" "$bat_config_activated"
ln -sf "$bat_config_activated" "$bat_config_path"
