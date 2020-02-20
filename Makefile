#
# Makefile
# dnehrig, 2020-02-20 20:17
#

help:
	@echo "help"
	./install.py --help

upgrade:
	@echo "Upgrade Dependencies"
	./install.py --upgrade

build:
	@echo "Install"
	./install.py

all:
	@echo "Install and Compile"
	./install.py --all


# vim:ft=make
#
