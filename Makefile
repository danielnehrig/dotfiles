#
# Makefile
# dnehrig, 2020-02-20 20:17
#

help:
	@echo "help"
	./install.py --help

node:
	@echo "Upgrade Dependencies"
	./install.py --upgrade=node

sym:
	@echo "Upgrade Dependencies"
	./install.py --upgrade=sym

build:
	@echo "Install"
	./install.py


# vim:ft=make
#
