PROFILE := gruvbox

ROOT := $(shell pwd)
ENVFILE := sh/env

BASE_PACKAGES := dotprofile git sh tmux user-dirs zsh less
DEV_PACKAGES := maven npm R texlive
CLI_PACKAGES := bat beets cursedtag elinks hangups mpd mutt ncmpcpp neofetch newsboat nvim \
	ranger rtv task urlview
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
	$(foreach f,$(shell find $1 -type f),$(call link,$(f),$2/$(f)))
endef

define link_files_shallow
	$(foreach f,$(wildcard $1/*),$(call link,$(f),$2/$(f)))
endef

define link_files_shallow_rel
	$(foreach f,$(wildcard $1/*),$(call link,$(f),$2/$(shell realpath --relative-to $3 $(f))))
endef

define link_files_rel
	$(foreach f,$(shell find $1 -type f),$(call link,$(f),$2/$(shell realpath --relative-to $3 $(f))))
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
	@$(call link_files,$@,.config)

git :
	@echo "-- Linking $@..."
	@$(call link_files,$@,.config)

dotprofile : sh
	@echo "-- Linking $@..."
	@$(call link_files,$@,.config)

tmux : sh dotprofile
	@echo "-- Linking $@..."
	@$(call link_files_rel,$@/config,.config/$@,$@/config)
	-@. $(ENVFILE) && \
		rm -rf ${XDG_DATA_HOME}/tmux/plugins/tpm
	@$(call link,$@/tpm,.local/share/tmux/plugins)
	@echo "-- Processing $@..."
	@. $(ENVFILE) && \
		$(PROFILE_ACTIVATE) $@ > /dev/null 2>&1

user-dirs : sh
	@echo "-- Linking $@..."
	@$(call link_files_rel,$@,.config,$@)

zsh : sh tmux
	@echo "-- Linking $@..."
	@$(call link,$@/.zshrc,.zshrc)
	@$(call link,$@/.zprofile,.zprofile)
	@$(call link_files_rel,$@/config,.config/$@,$@/config)

less : sh
	@echo "-- Bootstrapping less"
	@. $(ENVFILE) && \
		mkdir -p ${XDG_CACHE_HOME}/$@

###
### -- Dev Packages
###

maven : base
	@echo "-- Linking $@..."
	@$(call link_files,$@,.config)

npm : base
	@echo "-- Linking $@..."
	@$(call link_files,$@,.config)

R : base
	@echo "-- Linking $@..."
	@$(call link_files,$@,.config)

texlive : base
	@echo "-- Linking $@..."
	@$(call link_files,$@,.config)

###
### -- CLI Packages
###

bat : base dotprofile
	@echo "-- Linking $@..."
	@$(call link_files,$@,.config)
	@echo "-- Processing $@..."
	@. $(ENVFILE) && \
		$(PROFILE_ACTIVATE) $@ > /dev/null 2>&1

beets : base dotprofile
	@echo "-- Linking $@..."
	@$(call link_files,$@,.config)
	@echo "-- Processing $@..."
	@. $(ENVFILE) && \
		$(PROFILE_ACTIVATE) $@ > /dev/null 2>&1
	@. $(ENVFILE) && \
		mkdir -p ${XDG_DATA_HOME}/$@

cursedtag : base
	@echo "-- Linking $@..."
	@$(call link_files,$@,.config)

elinks : base urlview
	@echo "-- Linking $@..."
	@$(call link_files,$@,.config)

hangups : base dotprofile
	@echo "-- Linking $@..."
	@$(call link_files,$@,.config)
	@echo "-- Processing $@..."
	@. $(ENVFILE) && \
		$(PROFILE_ACTIVATE) $@ > /dev/null 2>&1

mpd : base
	@echo "-- Linking $@..."
	@$(call link_files,$@,.config)
	@. $(ENVFILE) && \
		mkdir -p ${XDG_DATA_HOME}/$@

mutt : base
	@echo "-- Linking $@..."
	@$(call link_files,$@,.config)

ncmpcpp : base
	@echo "-- Linking $@..."
	@$(call link_files,$@,.config)

neofetch : base
	@echo "-- Linking $@..."
	@$(call link_files,$@,.config)

newsboat : base
	@echo "-- Linking $@..."
	@$(call link_files,$@,.config)

nvim : base dotprofile
	@echo "-- Linking $@..."
	@$(call link_files,$@,.config)
	@echo "-- Processing neovim"
	@. $(ENVFILE) && \
		$(PROFILE_ACTIVATE) neovim > /dev/null 2>&1
	@echo "-- Bootstrapping neovim"
	@. $(ENVFILE) && \
		$@/scripts/bootstrap

ranger : base
	@echo "-- Linking $@..."
	@$(call link_files,$@,.config)

rtv : base
	@echo "-- Linking $@..."
	@$(call link_files,$@,.config)

task: base
	@echo "-- Linking $@..."
	@$(call link_files,$@,.config)

urlview : base
	@echo "-- Linking $@..."
	@$(call link,$@/.urlview,.urlview)

###
### -- GUI Packages
###

X11 : base dotprofile
	@echo "-- Linking $@..."
	@$(call link_files,$@,.config)
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
	@$(call link_files,$@,.config)
	@echo "-- Processing $@..."
	@. $(ENVFILE) && \
		$(PROFILE_ACTIVATE) $@ > /dev/null 2>&1

battery-notify : base
	@echo "-- Linking $@..."
	@$(call link_files_rel,$@/systemd,.config/systemd/user,$@/systemd)
	@$(call link_files_rel,$@/bin,.local/bin,$@/bin)

dunst : base dotprofile
	@echo "-- Linking $@..."
	@$(call link_files,$@,.config)
	@echo "-- Processing $@..."
	@. $(ENVFILE) && \
		$(PROFILE_ACTIVATE) $@ > /dev/null 2>&1

fscreenshot : base
	@echo "-- Linking $@..."
	@$(call link,$@/fscreenshot,.local/bin/)

gtk : base
	@echo "-- Linking $@..."
	@$(call link_files_rel,$@/gtk-2.0,.config/gtk-2.0,$@/gtk-2.0)
	@$(call link_files_rel,$@/gtk-3.0,.config/gtk-3.0,$@/gtk-3.0)
	-@. $(ENVFILE) && \
		rm $(foreach f,$(wildcard $@/themes/*),"${XDG_DATA_HOME}/themes/$(shell realpath --relative-to $@/themes $(f))")
	@$(call link_files_shallow_rel,$@/themes,.local/share/themes,$@/themes)

i3 : base dotprofile polybar wallpaper fscreenshot
	@echo "-- Linking $@..."
	@$(call link_files,$@,.config)
	@echo "-- Processing $@..."
	@. $(ENVFILE) && \
		$(PROFILE_ACTIVATE) $@ > /dev/null 2>&1

lock-screen : base
	@echo "-- Linking $@..."
	@$(call link_files_rel,$@,.local/bin,$@)

mpdnotify : base mpd
	@echo "-- Linking $@..."
	@$(call link_files_rel,$@/config,.config/$@,$@/config)
	@$(call link_files_rel,$@/systemd,.config/systemd/user,$@/systemd)

mpv : base
	@echo "-- Linking $@..."
	@$(call link_files,$@,.config)

networkmanager-dmenu : base rofi
	@echo "-- Linking $@..."
	@$(call link_files,$@,.config)

picom : base
	@echo "-- Linking $@..."
	@$(call link_files,$@,.config)

polybar : base dotprofile
	@echo "-- Linking $@..."
	@$(call link_files_rel,$@/config,.config/$@,$@/config)
	@$(call link_files_rel,$@/bin,.local/bin,$@/bin)
	@echo "-- Processing polybar-network..."
	@. $(ENVFILE) && \
		$(PROFILE_ACTIVATE) polybar-network > /dev/null 2>&1
	@echo "-- Processing $@..."
	@. $(ENVFILE) && \
		$(PROFILE_ACTIVATE) $@ > /dev/null 2>&1

qutebrowser : base dotprofile
	@echo "-- Linking $@..."
	@$(call link_files,$@,.config)
	@echo "-- Processing $@..."
	@. $(ENVFILE) && \
		$(PROFILE_ACTIVATE) $@ > /dev/null 2>&1

rofi : base dotprofile
	@echo "-- Linking $@..."
	@$(call link_files,$@,.config)
	@echo "-- Processing $@..."
	@. $(ENVFILE) && \
		$(PROFILE_ACTIVATE) $@ > /dev/null 2>&1

set-brightness : base
	@echo "-- Linking $@..."
	@$(call link_files_rel,$@,.local/bin,$@)

steam : SKINS_DIR = ${XDG_DATA_HOME}/Steam/skins
steam : SKINS_DIR_METRO = $(SKINS_DIR)/metro-for-steam-4.4
steam : METRO_ZIP = $(SKINS_DIR)/metro-for-steam-4.4.zip
steam : METRO_PATCH = $(SKINS_DIR)/metro-for-steam-4.4-patch
steam : base
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
	@$(call link_files,$@,.config)
	@echo "-- Processing $@..."
	@. $(ENVFILE) && \
		$(PROFILE_ACTIVATE) $@ > /dev/null 2>&1

wallpaper : base
	@echo "-- Linking $@..."
	@$(call link,$@/wallpaper-ctl,.local/bin/)

zathura : base
	@echo "-- Linking $@..."
	@$(call link_files,$@,.config)
