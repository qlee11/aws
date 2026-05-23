#!/bin/bash


function heal() {
   current_hero_health=$hero_health
   current_hero_armor=$hero_armor

   if [ $hp_potion -gt 0 ]; then
      ((hp_potion--))
   fi

   echo -e "${LIGHT_BLUE}GAME:${ENDCOLOR}Your health has been restored!"
   echo -e "${LIGHT_CYAN}Health: $current_hero_health ${ENDCOLOR}"
   echo -e "${LIGHT_CYAN}Armor: $current_hero_armor ${ENDCOLOR}"
   echo -e "${LIGHT_CYAN}Remaining healing potions: $hp_potion ${ENDCOLOR}"
}
