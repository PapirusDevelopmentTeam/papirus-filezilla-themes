all: install

install:
	mkdir -p $(DESTDIR)/usr/share/filezilla/resources
	cp --no-preserve=mode,ownership -r \
		papirus \
		papirus-dark \
		$(DESTDIR)/usr/share/filezilla/resources

uninstall:
	-rm -rf $(DESTDIR)/usr/share/filezilla/resources/papirus
	-rm -rf $(DESTDIR)/usr/share/filezilla/resources/papirus-dark

_get_version:
	$(eval DATE := $(shell git log -1 --format=%cd --date=format:%Y.%m.%d))
	$(eval COUNT := $(shell git rev-list --all --count))
	$(eval VERSION := $(DATE)-r$(COUNT))

push:
	git push origin

release: _get_version push
	git tag -f $(VERSION)
	git push origin --tags

undo_release: _get_version
	-git tag -d $(VERSION)
	-git push --delete origin $(VERSION)


.PHONY: all install uninstall _get_version push release undo_release
