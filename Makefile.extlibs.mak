#
# Makefile for external libraries.
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

# $Revision: 5488 $ $Date:: 2017-01-05 #$ $Author: serge $


###################################################################

ifndef BINDIR
    $(error BINDIR is not set)
endif

###################################################################
ifndef LIB_EXT_LIB_NAMES
    ifndef APP_EXT_LIB_NAMES
	$(error neither LIB_EXT_LIB_NAMES nor APP_EXT_LIB_NAMES is set)
    endif
endif

###################################################################

ifdef LIB_EXT_LIB_NAMES

LIB_EXT_INCL_PATH=-I..
LIB_EXT_LIBS_PATH=$(patsubst %,-L../%/$(BINDIR),$(LIB_EXT_LIB_NAMES))
LIB_EXT_LIBS = $(patsubst %,-l%,$(LIB_EXT_LIB_NAMES))

# update paths

LIB_INCL_PATH += $(LIB_EXT_INCL_PATH)
LIB_LIBS      += $(LIB_EXT_LIBS)
LIB_LIBS_PATH += $(LIB_EXT_LIBS_PATH)

endif

###################################################################

ifdef APP_EXT_LIB_NAMES

APP_EXT_INCL_PATH=-I..
APP_EXT_LIBS_PATH=$(patsubst %,-L../%/$(BINDIR),$(APP_EXT_LIB_NAMES))
APP_EXT_LIBS = $(patsubst %,-l%,$(APP_EXT_LIB_NAMES))

APP_INCL_PATH += $(APP_EXT_INCL_PATH)
APP_LIBS      += $(APP_EXT_LIBS)
APP_LIBS_PATH += $(APP_EXT_LIBS_PATH)

APP_CLEAN_EXT_LIBS=$(addsuffix _clean,$(APP_EXT_LIB_NAMES))

#$(info APP_CLEAN_EXT_LIBS = $(APP_CLEAN_EXT_LIBS))

endif

###################################################################


###################################################################
