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

# $Revision: 5489 $ $Date:: 2017-01-05 #$ $Author: serge $

###################################################################

ifndef MAKETOOLS_PATH
    $(error MAKETOOLS_PATH is not set)
endif

###################################################################

MODE ?= debug

ifeq "$(MODE)" "debug"
    OBJDIR=./DBG
    BINDIR=./DBG

    CFLAGS += -Wall -std=c++0x -ggdb -g3
    LFLAGS += -Wall -lstdc++ -lrt -ldl -lm -pthread -g
else
    OBJDIR=./OPT
    BINDIR=./OPT

    CFLAGS += -Wall -std=c++0x
    LFLAGS += -Wall -lstdc++ -lrt -ldl -lm -pthread
endif

###################################################################

include $(MAKETOOLS_PATH)/Makefile.inc

###################################################################


ifneq ("$(wildcard Makefile.lib.config)","")
    ifneq ("$(wildcard Makefile.app.config)","")

all: lib app
clean: lib_clean app_clean
cleanall: lib_cleanall app_cleanall

    else

all: lib
clean: lib_clean
cleanall: lib_cleanall

    endif
else
    ifneq ("$(wildcard Makefile.app.config)","")

all: app
clean: app_clean
cleanall: app_cleanall

    else
        $(error cannot define target)
    endif
endif

###################################################################


ifneq ("$(wildcard Makefile.lib.config)","")
    include Makefile.lib.config
    include $(MAKETOOLS_PATH)/Makefile.lib.mak
endif

###################################################################

ifneq ("$(wildcard Makefile.app.config)","")
    include Makefile.app.config
    include $(MAKETOOLS_PATH)/Makefile.app.mak
endif

###################################################################

ifdef LIB_BOOST_LIB_NAMES
    include $(MAKETOOLS_PATH)/Makefile.boost.mak
endif

ifdef APP_BOOST_LIB_NAMES
    include $(MAKETOOLS_PATH)/Makefile.boost.mak
endif

###################################################################

