let Stew = ./lib/stew/Prelude/Prelude

let profile = ../../loaded.dhall

let themeFile =
      Stew.File::{
      , src = "tree/.config/tmux/themes/${profile.tmux.theme}.conf"
      , dest = ".config/tmux/theme.conf"
      }

let reloadHook
    : Stew.Hook
    = { string = "hooks/reload-tmux.sh", name = "Reload tmux" }

let dependencies = [ "../sh" ]

let package =
      Stew.Package::{
      , name = "tmux"
      , dependencies
      , files = [ themeFile ]
      , afterLink = [ reloadHook ]
      }

in  { package }