#
# http://www.gnu.org/software/make/manual/make.html
#
# creat time: 2013-1-12
# author: Sam
# mail: txgcwm@163.com
# function: compile sdl tutorial every lesson example
#

CC = g++

CFLAGS = -Wall -O2 -ggdb
CFLAGS += $(shell sdl-config --cflags)
LDFLAGS = $(shell sdl-config --libs)
LDLIBS = -lSDL_image -lSDL_ttf -lSDL_mixer -lglut -lGL -lGLU

export CC CFLAGS LDFLAGS LDLIBS

# add exclude dir to exclude_dirs
exclude_dirs := 

# get the dir which we want to compile
dirs := $(shell find . -maxdepth 1 -type d)
dirs := $(basename $(patsubst ./%,%,$(dirs)))
dirs := $(filter-out $(exclude_dirs),$(dirs))

SUBDIRS = $(dirs)
	 	

all:
	@for i in $(SUBDIRS); \
	do \
		cp Makefile.subdir $$i/Makefile; \
		make -C $$i ; \
	done

clean:
	@for i in $(SUBDIRS); \
	do \
		make -C $$i clean; \
		rm -f $$i/Makefile; \
	done

help:
	@echo "Makefile for SDL tutorial version 1.0"
	@echo "Usage: make [TARGET]"
	@echo "TARGETS:"
	@echo "  all	compile and link."
	@echo "  clean	clean objects, the executable file and Makefile in suddir." 
	@echo "  show	show CFLAGS and LDLIBS."
	@echo "  help	print help message."

show:  
	@echo "CFLAGS: " $(CFLAGS)
	@echo "LDLIBS: " $(LDLIBS)

.PHONY: all clean show help
