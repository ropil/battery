#!/bin/bash
#
# battery_cycle - prolong battery life by cycling between two set thresholds. 
# Copyright (C) 2017  Robert Pilstål
#
#   This program is free software: you can redistribute it and/or modify
#   it under the terms of the GNU General Public License as published by
#   the Free Software Foundation, either version 3 of the License, or
#   (at your option) any later version.
#
#   This program is distributed in the hope that it will be useful,
#   but WITHOUT ANY WARRANTY; without even the implied warranty of
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#   GNU General Public License for more details.
#
#   You should have received a copy of the GNU General Public License
#   along with this program. If not, see <http://www.gnu.org/licenses/>.
set -e;

# Number of settings options
NUMSETTINGS=0;
NUMREQUIRED=${NUMSETTINGS};

# I/O-check and help text
if [ $# -gt ${NUMREQUIRED} ]; then
  echo "USAGE: [BATTERY_START=40] [BATTERY_STOP=80] $0";
  echo "";
  echo " ENVIRONMENT:";
  echo "  BATTERY_START - Start charging when battery charge drops";
  echo "                  below this value, in percent. (Default=40)";
  echo "  BATTERY_STOP  - Stop charging when battery charge climbs";
  echo "                  above this value, in percent. (Default=80)";
  echo "";
  echo " EXAMPLES:";
  echo "  # Run with defaults (based on forum, wiki and blog research)";
  echo "  $0;";
  echo "";
  echo "battery_cycle  Copyright (C) 2017  Robert Pilstål;"
  echo "This program comes with ABSOLUTELY NO WARRANTY.";
  echo "This is free software, and you are welcome to redistribute it";
  echo "under certain conditions; see supplied General Public License.";
  exit 0;
fi;

# Set default values
if [ -z ${BATTERY_START} ]; then
  BATTERY_START=40;
fi

if [ -z ${BATTERY_STOP} ]; then
  BATTERY_STOP=80;
fi

tpacpi-bat -v -s ST 0 ${BATTERY_START};
tpacpi-bat -v -s SP 0 ${BATTERY_STOP};
