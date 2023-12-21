# dotfiles

The dotfiles for my Linux machines, managed by
[`stew`](https://github.com/mirryi/stew).

Each subdirectory is a package. Each package has its own set of configuration
files. Some packages require the specification of other local variables in local
configuration files. Some packages list other packages as prerequisites.

Most of the package documentation is outdated.

-   [Installation](#installation)
-   [Profiles](#profiles)
-   [To-Do](#to-do)

## Hosts

[hosts/](./hosts) contains system configurations and files for specific machines.

-   `segv` - Gentoo system on Lenovo Flex 6 laptop
-   `origin` - Arch home PC


## Installation

1.  Install `stew`:
    `cargo install --git https://github.com/mirryi/stew --features "luajit unsafe"`
2.  Clone this repo somewhere (e.g. `~/.dotfiles`).
3.  Link the desired packages: `stew <package>`.
