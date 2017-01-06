#
# Makefile for BOOST libraries.
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

# $Revision: 5490 $ $Date:: 2017-01-05 #$ $Author: serge $


###################################################################

ifndef LIB_BOOST_LIB_NAMES
    ifndef APP_BOOST_LIB_NAMES
        $(error neither LIB_BOOST_LIB_NAMES nor APP_BOOST_LIB_NAMES is not set)
    endif
endif

###################################################################
# for LIB
###################################################################

ifdef LIB_BOOST_LIB_NAMES

LIB_BOOST_PATH := $(shell echo $$BOOST_PATH)

ifeq (,$(LIB_BOOST_PATH))
    $(error 'please define path to boost $$BOOST_PATH')
endif


###################################################################

LIB_BOOST_INCL_PATH=$(LIB_BOOST_PATH)

###################################################################
# update 3rd party path

LIB_THIRDPARTY_INCL_PATH += $(LIB_BOOST_INCL_PATH)

endif # LIB_BOOST_LIB_NAMES
###################################################################
# for APP
###################################################################

ifdef APP_BOOST_LIB_NAMES

APP_BOOST_PATH := $(shell echo $$BOOST_PATH)

ifeq (,$(APP_BOOST_PATH))
    $(error 'please define path to boost $$BOOST_PATH')
endif

###################################################################
APP_BOOST_INCL_PATH=-I$(APP_BOOST_PATH)
APP_BOOST_LIBS_PATH=-L$(APP_BOOST_PATH)/stage/lib

APP_BOOST_LIBS = $(patsubst %,-l:libboost_%.a,$(APP_BOOST_LIB_NAMES))

###################################################################
# update 3rd party path

APP_THIRDPARTY_INCL_PATH += $(APP_BOOST_INCL_PATH)

APP_THIRDPARTY_LIBS      += $(APP_BOOST_LIBS)
APP_THIRDPARTY_LIBS_PATH += $(APP_BOOST_LIBS_PATH)

###################################################################

endif
