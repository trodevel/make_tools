#
# Generic makefile for library projects.
#
# Copyright (C) 2016 Sergey Kolevatov
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program. If not, see <http://www.gnu.org/licenses/>.
#
#

# $Revision: 5419 $ $Date:: 2016-12-30 #$ $Author: serge $

###################################################################

ifndef MAKETOOLS_PATH
    $(error MAKETOOLS_PATH is not set)
endif

###################################################################

include Makefile.config

###################################################################

ifndef PROJECT
    $(error PROJECT is not set)
endif

#ifndef BINDIR
#    $(error BINDIR is not set)
#endif

#ifndef OBJDIR
#    $(error OBJDIR is not set)
#endif

ifndef SRCC
    $(error SRCC is not set)
endif

###################################################################

MODE ?= debug

ifeq "$(MODE)" "debug"
    OBJDIR=./DBG
    BINDIR=./DBG

    CFLAGS := -Wall -std=c++0x -ggdb -g3
    LFLAGS := -Wall -lstdc++ -lrt -ldl -lm -pthread -g
else
    OBJDIR=./OPT
    BINDIR=./OPT

    CFLAGS := -Wall -std=c++0x
    LFLAGS := -Wall -lstdc++ -lrt -ldl -lm -pthread
endif

###################################################################


ifdef EXT_LIB_NAMES
include $(MAKETOOLS_PATH)/Makefile.extlibs.mak
endif

###################################################################

TARGET=lib$(PROJECT).a

INCL      += $(INCL_PATH) $(THIRDPARTY_INCL_PATH) -I.
LIBS      += $(THIRDPARTY_LIBS)
LIBS_PATH += $(THIRDPARTY_LIBS_PATH)

###################################################################

include $(MAKETOOLS_PATH)/Makefile.inc

###################################################################

OBJS = $(patsubst %.c, $(OBJDIR)/%.o, $(SRCC))
OBJS:= $(patsubst %.cpp, $(OBJDIR)/%.o, $(OBJS))

static: $(TARGET)

$(TARGET): $(BINDIR) $(BINDIR)/$(TARGET)
	@echo "$@ uptodate - ${MODE}"

$(BINDIR)/$(TARGET): $(OBJS)
	$(AR) $@ $(OBJS)
	-@ ($(RANLIB) $@ || true) >/dev/null 2>&1

$(OBJDIR)/%.o: %.cpp
	@echo compiling $<
	$(CC) $(CFLAGS) -DPIC -c -o $@ $< $(INCL)

$(OBJDIR)/%.o: %.c
	@echo compiling $<
	$(CC) $(CFLAGS) -DPIC -c -o $@ $< $(INCL)

#$(BINDIR)/$(TARGET): $(OBJDIR)/$(TARGET).o $(OBJS) $(BINDIR)/$(STATICLIB) $(EXT_LIB_NAMES)
#	$(CC) $(CFLAGS) -o $@ $(OBJDIR)/$(TARGET).o $(BINDIR)/$(LIBNAME).a $(LIBS) $(LFLAGS_TEST)

#$(EXT_LIB_NAMES):
#	make -C ../$@
#	#ln -sf ../../$@/$(BINDIR)/lib$@.a $(BINDIR)

$(BINDIR):
	@ mkdir -p $(OBJDIR)
	@ mkdir -p $(BINDIR)

clean:
	rm $(OBJDIR)/*.o $(BINDIR)/$(TARGET)

cleanall: clean

.PHONY: all $(MY_LIB_NAMES)
