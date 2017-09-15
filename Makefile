PREFIX ?= /usr

all:

install:
	mkdir -p $(DESTDIR)$(PREFIX)/share/filezilla/resources
	cp -R \
		papirus \
		epapirus \
		papirus-dark \
		$(DESTDIR)$(PREFIX)/share/filezilla/resources

uninstall:
	-rm -rf $(DESTDIR)$(PREFIX)/share/filezilla/resources/papirus
	-rm -rf $(DESTDIR)$(PREFIX)/share/filezilla/resources/epapirus
	-rm -rf $(DESTDIR)$(PREFIX)/share/filezilla/resources/papirus-dark

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
