all:

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
