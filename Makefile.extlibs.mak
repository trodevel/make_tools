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

# $Revision: 5418 $ $Date:: 2016-12-30 #$ $Author: serge $


###################################################################

ifndef EXT_LIB_NAMES
    $(error EXT_LIB_NAMES is not set)
endif

ifndef BINDIR
    $(error BINDIR is not set)
endif

###################################################################

EXT_INCL_PATH=-I..
EXT_LIBS_PATH=$(patsubst %,-L../%/$(BINDIR),$(EXT_LIB_NAMES))
EXT_LIBS = $(patsubst %,-l%,$(EXT_LIB_NAMES))

###################################################################
# update paths

INCL_PATH += $(EXT_INCL_PATH)

LIBS      += $(EXT_LIBS)
LIBS_PATH += $(EXT_LIBS_PATH)

###################################################################
