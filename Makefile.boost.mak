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

# $Revision: 5418 $ $Date:: 2016-12-30 #$ $Author: serge $


###################################################################

ifndef BOOST_LIB_NAMES
    $(error BOOST_LIB_NAMES is not set)
endif

###################################################################

BOOST_PATH := $(shell echo $$BOOST_PATH)

ifeq (,$(BOOST_PATH))
    $(error 'please define path to boost $$BOOST_PATH')
endif

###################################################################

BOOST_INCL_PATH=$(BOOST_PATH)
BOOST_LIBS_PATH=-L$(BOOST_PATH)/stage/lib

BOOST_LIBS = $(patsubst %,-lboost_%,$(BOOST_LIB_NAMES))

###################################################################
# update 3rd party path

THIRDPARTY_INCL_PATH += $(BOOST_INCL_PATH)

THIRDPARTY_LIBS      += $(BOOST_LIBS)
THIRDPARTY_LIBS_PATH += $(BOOST_LIBS_PATH)

###################################################################
