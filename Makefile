STEW ?= stew

LIB := lib
VENDOR := vendor
PROFILES := profiles
LOADED := loaded.lua

.PHONY: gruvbox-dark

gruvbox-dark:
	ln -sf $(PROFILES)/$@.lua $(LOADED)
	$(STEW) -vvv $(wildcard packages/*)

gruvbox-light:
	ln -sf $(PROFILES)/$@.lua $(LOADED)
	$(STEW) -vvv $(wildcard packages/*)
