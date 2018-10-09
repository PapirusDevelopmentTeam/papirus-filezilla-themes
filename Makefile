PREFIX ?= /usr

all:

build: clean
	bash build.sh

clean:
	-rm -rf build/

install:
	mkdir -p $(DESTDIR)$(PREFIX)/share/filezilla/resources
	cp -R \
		papirus \
		papirus-dark \
		papirus-adapta \
		papirus-adapta-nokto \
		epapirus \
		$(DESTDIR)$(PREFIX)/share/filezilla/resources

uninstall:
	-rm -rf $(DESTDIR)$(PREFIX)/share/filezilla/resources/papirus
	-rm -rf $(DESTDIR)$(PREFIX)/share/filezilla/resources/papirus-dark
	-rm -rf $(DESTDIR)$(PREFIX)/share/filezilla/resources/papirus-adapta
	-rm -rf $(DESTDIR)$(PREFIX)/share/filezilla/resources/papirus-adapta-nokto
	-rm -rf $(DESTDIR)$(PREFIX)/share/filezilla/resources/epapirus

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


.PHONY: all build clean install uninstall _get_version push release undo_release
