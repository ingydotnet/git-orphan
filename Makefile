# Make sure we have 'git' and it works OK:
ifeq ($(shell which git),)
  $(error 'git' is not installed on this system)
endif

# Set variables:
NAME := git-orphan
LIB  := lib/$(NAME)
DOC  := doc/$(NAME).swim
MAN1 := man/man1
SHARE = share

# Basic targets:
default: help

help:
	@echo 'Makefile rules:'
	@echo ''
	@echo 'test       Run all tests'
	@echo 'install    Install $(NAME)'
	@echo 'uninstall  Uninstall $(NAME)'
	@echo 'env        Show environment variables to set'

.PHONY: test
test:
	prove $(PROVEOPT:%=% )test/

# Doc rules:
.PHONY: doc
update: doc

doc: ReadMe.pod $(MAN1)/$(NAME).1

ReadMe.pod: $(DOC)
	swim --to=pod --wrap --complete $< > $@

Intro.pod: doc/intro-to-subrepo.swim
	swim --to=pod --wrap --complete $< > $@

$(MAN1)/%.1: doc/%.swim Makefile
	swim --to=man --wrap $< > $@

clean purge:
	rm -fr tmp
