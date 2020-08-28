PROFILE := gruvbox

ROOT := $(shell pwd)
ENVFILE := sh/.config/sh/env

BASE_PACKAGES := dotprofile git sh tmux user-dirs zsh less
DEV_PACKAGES := maven npm R texlive
CLI_PACKAGES := bat beets cursedtag elinks hangups mpd mutt ncmpcpp neofetch newsboat nvim \
	ranger rtv task urlview wget
GUI_PACKAGES := alacritty battery-notify dunst fscreenshot gtk i3 lock-screen mpdnotify mpv \
	networkmanager-dmenu picom polybar qutebrowser rofi set-brightness steam termite wallpaper \
	X11 zathura

ALL_PACKAGES = $(BASE_PACKAGES) $(DEV_PACKAGES) $(CLI_PACKAGES) $(GUI_PACKAGES)

DOTPROFILE := dotprofile
PROFILE_ACTIVATE := $(DOTPROFILE) -vvv activate $(PROFILE)

define link
	mkdir -p ${HOME}/$(dir $2);
	ln -sf "$(ROOT)/$1" "${HOME}/$2";
endef

define link_files
	$(foreach f,$(shell find $1 -type f),$(call link,$(f),$(shell realpath --relative-to $1 $(f))))
endef

define link_files_rel
	$(foreach f,$(shell find $1 -type f),$(call link,$(f),$2/$(shell realpath --relative-to $3 $(f))))
endef

define link_files_shallow
	$(foreach f,$(wildcard $1/*),$(call link,$(f),$2/$(f)))
endef

define link_files_shallow_rel
	$(foreach f,$(wildcard $1/*),$(call link,$(f),$2/$(shell realpath --relative-to $3 $(f))))
endef


.PHONY : all base dev cli gui bootstrap update-submodules $(ALL_PACKAGES)

default :

all : $(ALL_PACKAGES)
base : $(BASE_PACKAGES)
dev : $(DEV_PACKAGES)
cli : $(CLI_PACKAGES)
gui : $(GUI_PACKAGES)

bootstrap : update-submodules base

update-submodules :
	@echo "-- Updating submodules..."
	@git submodule update --recursive --init

###
### -- Base Packages
###

sh :
	@echo "-- Linking $@..."
	@$(call link_files,$@)

git :
	@echo "-- Linking $@..."
	@$(call link_files,$@)

dotprofile : sh
	@echo "-- Linking $@..."
	@$(call link_files,$@)

tmux : sh dotprofile
	@echo "-- Linking $@..."
	-@. $(ENVFILE) && \
		rm -rf ${XDG_DATA_HOME}/tmux/plugins/tpm
	@$(call link_files,$@)
	@echo "-- Processing $@..."
	@. $(ENVFILE) && \
		$(PROFILE_ACTIVATE) $@ > /dev/null 2>&1

user-dirs : sh
	@echo "-- Linking $@..."
	@$(call link_files,$@)

zsh : sh tmux
	@echo "-- Linking $@..."
	@$(call link_files,$@)

less : sh
	@echo "-- Bootstrapping less"
	@. $(ENVFILE) && \
		mkdir -p ${XDG_CACHE_HOME}/$@

###
### -- Dev Packages
###

maven : base
	@echo "-- Linking $@..."
	@$(call link_files,$@)

npm : base
	@echo "-- Linking $@..."
	@$(call link_files,$@)

R : base
	@echo "-- Linking $@..."
	@$(call link_files,$@)

texlive : base
	@echo "-- Linking $@..."
	@$(call link_files,$@)

###
### -- CLI Packages
###

bat : base dotprofile
	@echo "-- Linking $@..."
	@$(call link_files,$@)
	@echo "-- Processing $@..."
	@. $(ENVFILE) && \
		$(PROFILE_ACTIVATE) $@ > /dev/null 2>&1

beets : base dotprofile
	@echo "-- Linking $@..."
	@$(call link_files,$@)
	@echo "-- Processing $@..."
	@. $(ENVFILE) && \
		$(PROFILE_ACTIVATE) $@ > /dev/null 2>&1
	@. $(ENVFILE) && \
		mkdir -p ${XDG_DATA_HOME}/$@

cursedtag : base
	@echo "-- Linking $@..."
	@$(call link_files,$@)

elinks : base urlview
	@echo "-- Linking $@..."
	@$(call link_files,$@)

hangups : base dotprofile
	@echo "-- Linking $@..."
	@$(call link_files,$@)
	@echo "-- Processing $@..."
	@. $(ENVFILE) && \
		$(PROFILE_ACTIVATE) $@ > /dev/null 2>&1

mpd : base
	@echo "-- Linking $@..."
	@$(call link_files,$@)
	@. $(ENVFILE) && \
		mkdir -p ${XDG_DATA_HOME}/$@

mutt : base
	@echo "-- Linking $@..."
	@$(call link_files,$@)

ncmpcpp : base
	@echo "-- Linking $@..."
	@$(call link_files,$@)

neofetch : base
	@echo "-- Linking $@..."
	@$(call link_files,$@)

newsboat : base
	@echo "-- Linking $@..."
	@$(call link_files,$@)

nvim : base dotprofile
	@echo "-- Linking $@..."
	@$(call link_files,$@)
	@echo "-- Processing neovim"
	@. $(ENVFILE) && \
		$(PROFILE_ACTIVATE) neovim > /dev/null 2>&1
	@echo "-- Bootstrapping neovim"
	@. $(ENVFILE) && \
		$@/.config/nvim/scripts/bootstrap

ranger : base
	@echo "-- Linking $@..."
	@$(call link_files,$@)

rtv : base
	@echo "-- Linking $@..."
	@$(call link_files,$@)

task: base
	@echo "-- Linking $@..."
	@$(call link_files,$@)

urlview : base
	@echo "-- Linking $@..."
	@$(call link_files,$@)

wget : base
	@echo "-- Linking $@"
	@$(call link_files,$@)

###
### -- GUI Packages
###

X11 : base dotprofile
	@echo "-- Linking $@..."
	@$(call link_files,$@)
	@echo "-- Processing xinitrc.variables..."
	@. $(ENVFILE) && \
		$(PROFILE_ACTIVATE) xinitrc.variables > /dev/null 2>&1
	@echo "-- Processing xresources-theme..."
	@. $(ENVFILE) && \
		$(PROFILE_ACTIVATE) xresources-theme > /dev/null 2>&1
	@. $(ENVFILE) && \
		mkdir -p "${XDG_LOG_HOME}/$@"

alacritty : base dotprofile
	@echo "-- Linking $@..."
	@$(call link_files,$@)
	@echo "-- Processing $@..."
	@. $(ENVFILE) && \
		$(PROFILE_ACTIVATE) $@ > /dev/null 2>&1

battery-notify : base
	@echo "-- Linking $@..."
	@$(call link_files,$@)

dunst : base dotprofile
	@echo "-- Linking $@..."
	@$(call link_files,$@)
	@echo "-- Processing $@..."
	@. $(ENVFILE) && \
		$(PROFILE_ACTIVATE) $@ > /dev/null 2>&1

fscreenshot : base
	@echo "-- Linking $@..."
	@$(call link_files,$@)

gtk :
	@echo "-- Linking $@..."
	@$(call link_files_rel,$@/.config,.config,$@/.config)
	-@. $(ENVFILE) && \
		rm -f $(foreach f,$(wildcard $@/.local/share/themes/*),"${XDG_DATA_HOME}/themes/$(shell realpath --relative-to $@/themes $(f))")
	@$(call link_files_shallow_rel,$@/.local/share/themes,.local/share/themes,$@/.local/share/themes)
	@. $(ENVFILE) && \
		$(PROFILE_ACTIVATE) $@ > /dev/null 2>&1

i3 : base dotprofile polybar wallpaper fscreenshot
	@echo "-- Linking $@..."
	@$(call link_files,$@)
	@echo "-- Processing $@..."
	@. $(ENVFILE) && \
		$(PROFILE_ACTIVATE) $@ > /dev/null 2>&1

lock-screen : base
	@echo "-- Linking $@..."
	@$(call link_files,$@)

mpdnotify : base mpd
	@echo "-- Linking $@..."
	@$(call link_files,$@)

mpv : base
	@echo "-- Linking $@..."
	@$(call link_files,$@)

networkmanager-dmenu : base rofi
	@echo "-- Linking $@..."
	@$(call link_files,$@)

picom : base
	@echo "-- Linking $@..."
	@$(call link_files,$@)

polybar : base dotprofile
	@echo "-- Linking $@..."
	@$(call link_files,$@)
	@echo "-- Processing polybar-network..."
	@. $(ENVFILE) && \
		$(PROFILE_ACTIVATE) polybar-network > /dev/null 2>&1
	@echo "-- Processing $@..."
	@. $(ENVFILE) && \
		$(PROFILE_ACTIVATE) $@ > /dev/null 2>&1

qutebrowser : base dotprofile
	@echo "-- Linking $@..."
	@$(call link_files,$@)
	@echo "-- Processing $@..."
	@. $(ENVFILE) && \
		$(PROFILE_ACTIVATE) $@ > /dev/null 2>&1

rofi : base dotprofile
	@echo "-- Linking $@..."
	@$(call link_files,$@)
	@echo "-- Processing $@..."
	@. $(ENVFILE) && \
		$(PROFILE_ACTIVATE) $@ > /dev/null 2>&1

set-brightness : base
	@echo "-- Linking $@..."
	@$(call link_files,$@)

steam : SKINS_DIR = ${XDG_DATA_HOME}/Steam/skins
steam : SKINS_DIR_METRO = $(SKINS_DIR)/metro-for-steam-4.4
steam : METRO_ZIP = $(SKINS_DIR)/metro-for-steam-4.4.zip
steam : METRO_PATCH = $(SKINS_DIR)/metro-for-steam-4.4-patch
steam : base wget
	@echo "-- Installing Steam skin..."
	@. $(ENVFILE) && \
		mkdir -p $(SKINS_DIR) && \
		wget -O $(METRO_ZIP) "https://github.com/minischetti/metro-for-steam/archive/v4.4.zip" > /dev/null 2>&1 && \
		unzip -o $(METRO_ZIP) -d $(SKINS_DIR) > /dev/null 2>&1 && \
		rm $(METRO_ZIP)
	@echo "-- Installing metro-for-steam patch..."
	@. $(ENVFILE) && \
		git clone "https://github.com/redsigma/UPMetroSkin.git" $(METRO_PATCH) > /dev/null 2>&1 && \
		cp -r "$(METRO_PATCH)/Unofficial 4.x Patch/Main Files [Install First]"/* $(SKINS_DIR_METRO) && \
		rm -rf $(METRO_PATCH)

termite : base dotprofile gtk
	@echo "-- Linking $@..."
	@$(call link_files,$@)
	@echo "-- Processing $@..."
	@. $(ENVFILE) && \
		$(PROFILE_ACTIVATE) $@ > /dev/null 2>&1

wallpaper : base
	@echo "-- Linking $@..."
	@$(call link_files,$@)

zathura : base
	@echo "-- Linking $@..."
	@$(call link_files,$@)
