#!/bin/bash

# name of the template file
i3_config_template="i3.config.tmpl"

# name of the configuration file
i3_config_name="config"
# path of the configuration directory
i3_config_dir="$XDG_CONFIG_HOME/i3"
# path of the configuration file
i3_config_yaml="$i3_config_dir/$i3_config_name"
# path of the generated directory
i3_activated_dir="$activated_dir/i3"
# path of the generated configuration file
i3_config_activated="$i3_activated_dir/$i3_config_name"

restore_file "$i3_config_yaml"
backup_file "$i3_config_yaml"

mkdir -p "$i3_activated_dir"
gotpl_f "$i3_config_template" "$i3_config_activated"
ln -sf "$i3_config_activated" "$i3_config_yaml"

# reload i3
i3-msg restart >/dev/null
