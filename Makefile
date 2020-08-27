PROFILE := gruvbox

ROOT := $(shell pwd)

BASE_PACKAGES := dotprofile git nvim sh tmux user-dirs zsh
DEV_PACKAGES := maven npm R texlive
CLI_PACKAGES := bat beets cursedtag elinks hangups mpd mutt ncmpcpp neofetch newsboat ranger \
	rtv task urlview
GUI_PACKAGES := alacritty battery-notify dunst fscreenshot gtk i3 lock-screen mpdnotify mpv \
	networkmanager-dmenu picom polybar qutebrowser rofi set-brightness termite wallpaper X11 zathura

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

.PHONY : all $(ALL_PACKAGES)

default :

all : $(ALL_PACKAGES)
base : $(BASE_PACKAGES)
dev : $(DEV_PACKAGES)
cli : $(CLI_PACKAGES)
gui : $(GUI_PACKAGES)

###
### -- Base Packages
###

dotprofile :
	@echo "-- Linking $@..."
	@$(call link_files,$@,.config)

git :
	@echo "-- Linking $@..."
	@$(call link_files,$@,.config)

nvim : dotprofile
	@echo "-- Linking $@..."
	@$(call link_files,$@,.config)
	@echo "-- Processing neovim"
	@$(PROFILE_ACTIVATE) neovim > /dev/null 2>&1

sh :
	@echo "-- Linking $@..."
	@$(call link_files,$@,.config)

tmux : dotprofile
	@echo "-- Linking $@..."
	@$(call link_files_rel,$@/config,.config/$@,$@/config)
	-@rm -rf ${HOME}/.local/share/tmux/plugins/tpm
	@$(call link,$@/tpm,.local/share/tmux/plugins)
	@echo "-- Processing $@..."
	@$(PROFILE_ACTIVATE) $@ > /dev/null 2>&1

user-dirs :
	@echo "-- Linking $@..."
	@$(call link_files_rel,$@,.config,$@)

zsh : sh tmux
	@echo "-- Linking $@..."
	@$(call link,$@/.zshrc,.zshrc)
	@$(call link,$@/.zprofile,.zprofile)
	@$(call link_files_rel,$@/config,.config/$@,$@/config)

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
	@$(PROFILE_ACTIVATE) $@ > /dev/null 2>&1

beets : base dotprofile
	@echo "-- Linking $@..."
	@$(call link_files,$@,.config)
	@echo "-- Processing $@..."
	@$(PROFILE_ACTIVATE) $@ > /dev/null 2>&1

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
	@$(PROFILE_ACTIVATE) $@ > /dev/null 2>&1

mpd : base
	@echo "-- Linking $@..."
	@$(call link_files,$@,.config)

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
	@$(PROFILE_ACTIVATE) xinitrc.variables > /dev/null 2>&1
	@echo "-- Processing xresources-theme..."
	@$(PROFILE_ACTIVATE) xresources-theme > /dev/null 2>&1

alacritty : base dotprofile
	@echo "-- Linking $@..."
	@$(call link_files,$@,.config)
	@echo "-- Processing $@..."
	@$(PROFILE_ACTIVATE) $@ > /dev/null 2>&1

battery-notify : base
	@echo "-- Linking $@..."
	@$(call link_files_rel,$@/systemd,.config/systemd/user,$@/systemd)
	@$(call link_files_rel,$@/bin,.local/bin,$@/bin)

dunst : base dotprofile
	@echo "-- Linking $@..."
	@$(call link_files,$@,.config)
	@echo "-- Processing $@..."
	@$(PROFILE_ACTIVATE) $@ > /dev/null 2>&1

fscreenshot : base
	@echo "-- Linking $@..."
	@$(call link,$@/fscreenshot,.local/bin/)

gtk : base
	@echo "-- Linking $@..."
	@$(call link_files_rel,$@/gtk-2.0,.config/gtk-2.0,$@/gtk-2.0)
	@$(call link_files_rel,$@/gtk-3.0,.config/gtk-3.0,$@/gtk-3.0)
	-@rm $(foreach f,$(wildcard $@/themes/*),"${HOME}/.local/share/themes/$(shell realpath --relative-to $@/themes $(f))")
	@$(call link_files_shallow_rel,$@/themes,.local/share/themes,$@/themes)

i3 : base dotprofile polybar wallpaper fscreenshot
	@echo "-- Linking $@..."
	@$(call link_files,$@,.config)
	@echo "-- Processing $@..."
	@$(PROFILE_ACTIVATE) $@ > /dev/null 2>&1

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
	@$(PROFILE_ACTIVATE) polybar-network > /dev/null 2>&1
	@echo "-- Processing $@..."
	@$(PROFILE_ACTIVATE) $@ > /dev/null 2>&1

qutebrowser : base dotprofile
	@echo "-- Linking $@..."
	@$(call link_files,$@,.config)
	@echo "-- Processing $@..."
	@$(PROFILE_ACTIVATE) $@ > /dev/null 2>&1

rofi : base dotprofile
	@echo "-- Linking $@..."
	@$(call link_files,$@,.config)
	@echo "-- Processing $@..."
	@$(PROFILE_ACTIVATE) $@ > /dev/null 2>&1

set-brightness : base
	@echo "-- Linking $@..."
	@$(call link_files_rel,$@,.local/bin,$@)

termite : base dotprofile gtk
	@echo "-- Linking $@..."
	@$(call link_files,$@,.config)
	@echo "-- Processing $@..."
	@$(PROFILE_ACTIVATE) $@ > /dev/null 2>&1

wallpaper : base
	@echo "-- Linking $@..."
	@$(call link,$@/wallpaper-ctl,.local/bin/)

zathura : base
	@echo "-- Linking $@..."
	@$(call link_files,$@,.config)
