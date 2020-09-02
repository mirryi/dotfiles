let Stew = ../lib/stew/stew.dhall

let profile = ../loaded.dhall

let local = ./local.dhall

let configTemplate =
      Stew.TemplateFile::{
      , src = "tree/.config/alacritty/alacritty.yml.tmpl"
      , dest = ".config/alacritty/alacritty.yml"
      }

let dependencies = [ "../qt" ]

let package =
      Stew.Package::{
      , name = "alacritty"
      , dependencies
      , templateFiles = [ configTemplate ]
      }

let variables = profile.alacritty ∧ local

in  { package, variables }
