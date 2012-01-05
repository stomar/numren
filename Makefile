# Makefile for numren
#
# targets: man, install, uninstall
#
# M. Stollsteimer, Dec 2012

#### Start of system configuration section. ####

srcdir = .

bindir = /usr/local/bin
mandir = /usr/local/man/man1

INSTALL = install
INSTALL_DIR = $(srcdir)/mkinstalldirs
INSTALL_DATA = $(INSTALL) -m 644

HELP2MAN = help2man
SED = sed

#### End of system configuration section. ####

# files to install in bindir (distinguish between hosts)

binfiles = numren
manfiles = numren.1

### Targets. ####

.PHONY : usage
usage :
	@echo "usage: make <target>"
	@echo "targets are \`install', \`uninstall', and \`man'"


.PHONY : man
man: numren.1


numren.1: numren numren.h2m
	@$(HELP2MAN) --no-info --name='rename files with numbered filenames' \
	          --include=numren.h2m -o numren.1 ./numren
	@$(SED) -i '/\.PP/{N;s/\.PP\nOptions/.SH OPTIONS/};s/^License GPL/.br\nLicense GPL/' numren.1


.PHONY : installdirs
installdirs: mkinstalldirs
	$(INSTALL_DIR) $(DESTDIR)$(bindir)
	$(INSTALL_DIR) $(DESTDIR)$(mandir)


.PHONY : install
install: $(INSTFILES) installdirs
	$(INSTALL) $(binfiles) $(bindir)
	$(INSTALL_DATA) $(manfiles) $(mandir)


.PHONY : uninstall
uninstall:
	cd $(bindir) && rm -f $(binfiles) && \
	cd $(mandir) && rm -f $(manfiles)
