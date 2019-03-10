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

# $Revision: 10631 $ $Date:: 2019-03-10 #$ $Author: serge $

###################################################################

ifndef MAKETOOLS_PATH
    $(error MAKETOOLS_PATH is not set)
endif

###################################################################

include Makefile.lib.config

ifndef LIB_PROJECT
    $(error LIB_PROJECT is not set)
endif

ifndef LIB_SRCC
    $(error LIB_SRCC is not set)
endif

###################################################################

ifdef LIB_EXT_LIB_NAMES
include $(MAKETOOLS_PATH)/Makefile.extlibs.mak
endif

###################################################################

LIB_TARGET=lib$(LIB_PROJECT).a

LIB_INCL      += $(LIB_INCL_PATH) $(LIB_THIRDPARTY_INCL_PATH) -I.
LIB_LIBS      += $(LIB_THIRDPARTY_LIBS)
LIB_LIBS_PATH += $(LIB_THIRDPARTY_LIBS_PATH)

###################################################################

OBJS = $(patsubst %.c, $(OBJDIR)/%.o, $(LIB_SRCC))
OBJS:= $(patsubst %.cpp, $(OBJDIR)/%.o, $(OBJS))

lib: $(LIB_TARGET)

$(LIB_TARGET): lib_mkdir $(BINDIR)/$(LIB_TARGET)
	@echo "$@ uptodate - ${MODE}"

$(BINDIR)/$(LIB_TARGET): $(OBJS)
	$(AR) $@ $(OBJS)
	-@ ($(RANLIB) $@ || true) >/dev/null 2>&1

$(OBJDIR)/%.o: %.cpp
	@echo compiling $<
	$(CC) $(CFLAGS) -DPIC -c -o $@ $< $(LIB_INCL)

$(OBJDIR)/%.o: %.c
	@echo compiling $<
	$(CC) $(CFLAGS) -DPIC -c -o $@ $< $(LIB_INCL)

lib_mkdir:
	@ mkdir -p $(OBJDIR)
	@ mkdir -p $(BINDIR)

lib_clean:
	-@ if test -n "`find $(OBJDIR) -maxdepth 1 -name '*.o' -print -quit)`"; then echo "LIB: $(LIB_PROJECT): cleaning obj"; rm $(OBJDIR)/*.o; else echo "LIB: $(LIB_PROJECT): obj already cleaned"; fi
ifneq ("$(wildcard "$(BINDIR)/$(LIB_TARGET)")","")
	-@rm $(BINDIR)/$(LIB_TARGET)
endif

lib_cleanall: lib_clean

#.PHONY: all $(MY_LIB_NAMES)
