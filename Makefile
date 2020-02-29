prefix=/usr/local
datarootdir=$(prefix)/share
datadir=$(datarootdir)
exec_prefix=$(prefix)
bindir=$(exec_prefix)/bin
mandir=$(datarootdir)/man
man1dir=$(mandir)/man1

all:
	@echo  "Targets: install, uninstall, man"

install: conf conf.1
	cp conf $(bindir)/
	cp conf.1 $(man1dir)/

uninstall:
	rm $(bindir)/conf
	rm $(man1dir)/conf.1

man: conf conf.1
	pod2man conf conf.1
