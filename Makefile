ROOT := $(shell pwd)

BASE_PACKAGES := pam-env dotprofile git nvim sh tmux user-dirs zsh
DEV_PACKAGES := maven npm R texlive
CLI_PACKAGES := bat beets cursedtag elinks hangups mpd mutt ncmpcpp neofetch newsboat ranger \
	rtv task urlview
GUI_PACKAGES := alacritty battery-notify dunst fscreenshot gtk i3 lock-screen mpdnotify mpv \
	networkmanager-dmenu picom polybar qutebrowser rofi termite wallpaper X11 zathura

ALL_PACKAGES = $(BASE_PACKAGES) $(DEV_PACKAGES) $(CLI_PACKAGES) $(GUI_PACKAGES)

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

pam-env :
	@echo "-- Linking $@..."
	@$(call link,$@/.pam_environment,.pam_environment)

dotprofile :
	@echo "-- Linking $@..."
	@$(call link_files,$@,.config)

git :
	@echo "-- Linking $@..."
	@$(call link_files,$@,.config)

nvim :
	@echo "-- Linking $@..."
	@$(call link_files,$@,.config)

sh :
	@echo "-- Linking $@..."
	@$(call link_files,$@,.config)

tmux :
	@echo "-- Linking $@..."
	@$(call link_files_rel,$@/config,.config/$@,$@/config)
	-@rm -rf ${HOME}/.local/share/tmux/plugins/tpm
	@$(call link,$@/tpm,.local/share/tmux/plugins)

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

beets : base dotprofile
	@echo "-- Linking $@..."
	@$(call link_files,$@,.config)

cursedtag : base
	@echo "-- Linking $@..."
	@$(call link_files,$@,.config)

elinks : base urlview
	@echo "-- Linking $@..."
	@$(call link_files,$@,.config)

hangups : base dotprofile
	@echo "-- Linking $@..."
	@$(call link_files,$@,.config)

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

alacritty : base dotprofile
	@echo "-- Linking $@..."
	@$(call link_files,$@,.config)

battery-notify : base
	@echo "-- Linking $@..."
	@$(call link_files_rel,$@/systemd,.config/systemd/user,$@/systemd)
	@$(call link_files_rel,$@/bin,.local/bin,$@/bin)

dunst : base dotprofile
	@echo "-- Linking $@..."
	@$(call link_files,$@,.config)

fscreenshot : base
	@echo "-- Linking $@..."
	@$(call link,$@/fscreenshot,.local/bin/)

gtk : base
	@echo "-- Linking $@..."
	@$(call link_files_rel,$@/gtk-2.0,.config/gtk-2.0,$@/gtk-2.0)
	@$(call link_files_rel,$@/gtk-3.0,.config/gtk-3.0,$@/gtk-3.0)
	@$(call link_files_shallow_rel,$@/themes,.local/share/themes,$@/themes)

i3 : base dotprofile polybar wallpaper fscreenshot
	@echo "-- Linking $@..."
	@$(call link_files,$@,.config)

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

qutebrowser : base dotprofile
	@echo "-- Linking $@..."
	@$(call link_files,$@,.config)

rofi : base dotprofile
	@echo "-- Linking $@..."
	@$(call link_files,$@,.config)

set-brightness : base
	@echo "-- Linking $@..."
	@$(call link_files_rel,$@,.local/bin,$@)

termite : base dotprofile gtk
	@echo "-- Linking $@..."
	@$(call link_files,$@,.config)

wallpaper : base
	@echo "-- Linking $@..."
	@$(call link,$@/wallpaper-ctl,.local/bin/)

zathura : base
	@echo "-- Linking $@..."
	@$(call link_files,$@,.config)
