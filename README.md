# dotfiles

The dotfiles for my Linux machines, managed by a custom Makefile
solution similar to GNU Stow.

Each subdirectory is a configuration 'package'. The Makefile contains
targets to link each package to its proper location. Some packages
depend on others, and those dependencies are specified as target
prerequisites.

A set of base packages are linked for every non-base package. See
[Packages](#packages).

[dotprofile](https://github.com/Dophin2009/dotprofile) is used to
template some configuration files and manage themes.

## Installation

Clone this repo somewhere (e.g. `~/.dotfiles`).

The \[bootstrap script\] will link the [base packages](#packages).

Link the desired packages with `make <package>`.

## Packages

### Base Packages

The following are considered `base` packages. These are linked as
dependencies for every other package.

-   `pam-env`
-   `user-dirs`
-   `dotprofile`
-   `git`
-   `nvim`
-   `tmux`
-   `sh`
-   `zsh`
