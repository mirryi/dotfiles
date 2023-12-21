STEW ?= stew

LIB := lib
VENDOR := vendor
PROFILES := profiles
LOADED := loaded.lua

.PHONY : gruvbox-dark gruvbox-light

gruvbox-dark	:
	ln -sf $(PROFILES)/gruvbox-dark.lua $(LOADED)
	$(STEW) -vvv $(wildcard packages/*)

gruvbox-light	:
	ln -sf $(PROFILES)/gruvbox-light.lua $(LOADED)
	$(STEW) -vvv $(wildcard packages/*)
