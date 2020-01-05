PREFIX ?= /usr
ICON_THEMES ?= $(patsubst %/theme.xml,%,$(wildcard ./*/theme.xml))

all:

build: clean
	bash build.sh

clean:
	-rm -rf build/

install:
	mkdir -p $(DESTDIR)$(PREFIX)/share/filezilla/resources
	cp -R $(ICON_THEMES) $(DESTDIR)$(PREFIX)/share/filezilla/resources

uninstall:
	-rm -rf $(foreach icon_theme,$(ICON_THEMES),$(DESTDIR)$(PREFIX)/share/filezilla/resources/$(icon_theme))

dist: _get_version
	git archive --format=tar.gz -o $(notdir $(CURDIR))-$(VERSION).tar.gz master -- $(ICON_THEMES)

_get_version:
	$(eval VERSION := $(shell git show -s --format=%cd --date=format:%Y%m%d HEAD))
	@echo $(VERSION)

release: _get_version
	git tag -f $(VERSION)
	git push origin --tags
	git push origin

undo_release: _get_version
	-git tag -d $(VERSION)
	-git push --delete origin $(VERSION)


.PHONY: all build clean dist install uninstall _get_version release undo_release
