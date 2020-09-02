let Stew = ../../lib/stew/stew.dhall

let home = (../../lib/stew/env.dhall).home

let serviceTemplate =
      Stew.TemplateFile::{
      , src = "tree/.config/systemd/user/battery-monitor.service.tmpl"
      , dest = ".config/systemd/user/battery-monitor.service"
      }

let dependencies = [ ".." ]

let package =
      Stew.Package::{
      , name = "battery-notify/systemd-service"
      , dependencies
      , templateFiles = [ serviceTemplate ]
      }

let variables = { home }

in  { package, variables }