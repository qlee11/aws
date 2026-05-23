#!/bin/bash

function priest() {
   cat images/priest.txt

   echo -e "Health: $current_priest_health"
   echo -e "Strength: $current_priest_str"
   echo -e "Armor: $current_priest_armor"
}
