#!/bin/bash
#
# battery_charge - force charging the battery, before going on commute.
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
NUMSETTINGS=1;
let NUMREQUIRED=${NUMSETTINGS};

# I/O-check and help text
if [ $# -lt ${NUMREQUIRED} ]; then
  echo "USAGE: $0 <charge> ";
  echo "";
  echo " OPTIONS:";
  echo "  charge - Charge battery until <charge> percent; 2-99 are";
  echo "           eligable values here.";
  echo "";
  echo " EXAMPLES:";
  echo "  # Charge full battery; do this when on extended commute.";
  echo "  $0 99";
  echo "";
  echo "battery_charge  Copyright (C) 2017  Robert Pilstål;"
  echo "This program comes with ABSOLUTELY NO WARRANTY.";
  echo "This is free software, and you are welcome to redistribute it";
  echo "under certain conditions; see supplied General Public License.";
  exit 0;
fi;

# Parse settings
percent=$1;

if [ ${percent} -gt 99 ]; then
  echo "${percent}% is over maximum of 99%";
  exit 1;
fi;

if [ ${percent} -lt 2 ]; then
  echo "${percent}% is less than minimum of 2%";
  exit 1;
fi;

let start=$percent-1;
let stop=$percent;

echo "tpacpi-bat -v -s ST 0 $start";
tpacpi-bat -v -s ST 0 $start;
echo "tpacpi-bat -v -s SP 0 $stop";
tpacpi-bat -v -s SP 0 $stop;
