#
# Generic makefile for application projects.
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

# $Revision: 5526 $ $Date:: 2017-01-10 #$ $Author: serge $

###################################################################

ifndef MAKETOOLS_PATH
    $(error MAKETOOLS_PATH is not set)
endif

###################################################################

include Makefile.app.config

ifndef APP_PROJECT
    $(error APP_PROJECT is not set)
endif

ifndef APP_SRCC
    $(error APP_SRCC is not set)
endif

###################################################################

ifdef APP_EXT_LIB_NAMES
include $(MAKETOOLS_PATH)/Makefile.extlibs.mak
endif

###################################################################

TARGET=$(APP_PROJECT)

APP_INCL      = $(APP_INCL_PATH) $(APP_THIRDPARTY_INCL_PATH) -I.
#LIBS      +=
#LIBS_PATH +=

ifdef LIB_PROJECT
MY_LIB          = -l$(LIB_PROJECT)
MY_LIB_PATH     = -L$(BINDIR)
endif

###################################################################

APP_OBJS = $(patsubst %.c, $(OBJDIR)/%.o, $(APP_SRCC))
APP_OBJS:= $(patsubst %.cpp, $(OBJDIR)/%.o, $(APP_OBJS))

app: $(TARGET)

$(TARGET): $(BINDIR) $(BINDIR)/$(TARGET)
	ln -sf $(BINDIR)/$(TARGET) $(TARGET)
	@echo "$@ uptodate - ${MODE}"

$(OBJDIR)/%.o: %.cpp
	@echo compiling $<
	$(CC) $(CFLAGS) -DPIC -c -o $@ $< $(APP_INCL)

$(OBJDIR)/%.o: %.c
	@echo compiling $<
	$(CC) $(CFLAGS) -DPIC -c -o $@ $< $(APP_INCL)

$(BINDIR)/$(TARGET): $(OBJDIR)/$(TARGET).o $(APP_OBJS) $(APP_EXT_LIB_NAMES)
	$(CC) $(CFLAGS) -o $@ $(OBJDIR)/$(TARGET).o $(LFLAGS) $(APP_INCL) $(MY_LIB) $(APP_LIBS) $(APP_THIRDPARTY_LIBS) $(MY_LIB_PATH) $(APP_LIBS_PATH) $(APP_THIRDPARTY_LIBS_PATH)

$(APP_EXT_LIB_NAMES):
	make -C ../$@

$(BINDIR):
	@ mkdir -p $(OBJDIR)
	@ mkdir -p $(BINDIR)

app_clean:
	-rm $(OBJDIR)/*.o $(BINDIR)/$(TARGET)

app_cleanall: app_clean $(APP_CLEAN_EXT_LIBS)

$(APP_CLEAN_EXT_LIBS):
	@echo dir_clean ../$@ = $(subst _clean,,$@)
	-make -C ../$(subst _clean,,$@) clean

.PHONY: all $(MY_LIB_NAMES)
