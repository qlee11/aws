#!/bin/bash


function orc_fight() {

   orc
   while [[ $current_orc_health -ne 0 || $current_hero_health -ne 0 ]]; do
         if [ $current_hero_health -le 0 ]; then
            echo -e "${RED}You've lost the fight!${ENDCOLOR}"
            echo -e "${RED}GAME OVER!${ENDCOLOR}"
            break
         fi
         echo -e "${LIGHT_CYAN}Your turn (roll/heal/inventory):${ENDCOLOR}"
         read action
         if [ $action == "roll" ]; then
            dice
            roll
            attack_dmg=$(expr $random_value \* $hero_str)
            echo -e "${LIGHT_CYAN}You hit the orc with $attack_dmg damage!${ENDCOLOR}"
            if [ $attack_dmg -gt $current_orc_armor ]; then
               current_orc_armor=0
               remaining_dmg=$(expr $attack_dmg - $current_orc_armor)
               current_orc_health=$(expr $current_orc_health - $remaining_dmg)
               echo -e "${LIGHT_CYAN}Enemy armor is broken!${ENDCOLOR}"
            elif [ $current_orc_armor -eq 0 ]; then
               current_orc_health=$(expr $current_orc_health - $attack_dmg)
            elif [ $attack_dmg -gt $current_orc_health ]; then
                  current_orc_health=0
            else
               current_orc_armor=$(expr $current_orc_armor - $attack_dmg)
            fi

            orc
         elif [[ $action == "heal" && $hp_potion -eq 0 ]]; then
               echo "You don't have any healing potion!"
               continue
         elif [[ $action == "heal" && $hp_potion -ne 0 ]]; then
               heal
               continue
         elif [ $action == "inventory" ]; then
               inventory
               continue
         else
            echo -e "${RED}Incorrect command!${ENDCOLOR}"
            continue
         fi
         
         if [ $current_orc_health -le 0 ]; then
            echo -e "${GREEN}You won the fight!${ENDCOLOR}"
            break
         fi
         
         sleep 3
         echo -e "${RED}Enemy turn!${ENDCOLOR}"
         sleep 2
         dice
         enemy_roll
         orc_dmg=$(expr $random_value \* $orc_str)
         echo -e "${RED}Enemy hit you with $orc_dmg damage!${ENDCOLOR}"
         if [ $orc_dmg -gt $current_hero_armor ]; then
            remaining_dmg=$(expr $orc_dmg - $current_hero_armor)
            current_hero_armor=0
            current_hero_health=$(expr $current_hero_health - $remaining_dmg)
            echo -e "${RED}Your armor is broken!${ENDCOLOR}"
         elif [ $current_hero_armor -eq 0 ]; then
            current_hero_health=$(expr $current_hero_health - $orc_dmg)
         else
            current_hero_armor=$(expr $current_hero_armor - $orc_dmg)
         fi
         hero
   done
   
}
