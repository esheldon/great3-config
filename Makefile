prefix=~/exports/great3-config-local

default:

install:
	@echo "rsyncing to $(prefix)"
	@if [ ! -e $(prefix) ]; then \
		echo Creating directory $(prefix); \
		mkdir -p $(prefix); \
	fi
	rsync -av \
		--exclude "Makefile" \
		--exclude "*git*" \
		--exclude "*swp" \
		--exclude "*~" \
		. $(prefix)/
