#!/bin/bash

# name of the template file
hangups_config_template="hangups.conf.tmpl"

# name of the configuration file
hangups_config_name="hangups.conf"
# path of the configuration directory
hangups_config_dir="$XDG_CONFIG_HOME/hangups"
# path of the configuration file
hangups_config_yaml="$hangups_config_dir/$hangups_config_name"
# path of the generated directory
hangups_activated_dir="$activated_dir/hangups"
# path of the generated configuration file
hangups_config_activated="$hangups_activated_dir/$hangups_config_name"

restore_file "$hangups_config_yaml"
backup_file "$hangups_config_yaml"

mkdir -p "$hangups_activated_dir"
gotpl_f "$hangups_config_template" "$hangups_config_activated"
ln -sf "$hangups_config_activated" "$hangups_config_yaml"
