PREFIX ?= /usr

all:

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

push:
	git push origin

release: _get_version push
	git tag -f $(VERSION)
	git push origin --tags

undo_release: _get_version
	-git tag -d $(VERSION)
	-git push --delete origin $(VERSION)


.PHONY: all install uninstall _get_version push release undo_release
