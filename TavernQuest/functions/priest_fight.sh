#!/bin/bash


function priest_fight() {

   priest
   while [[ $current_priest_health -ne 0 || $current_hero_health -ne 0 ]]; do
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
            echo -e "${LIGHT_CYAN}You hit the priest guy with $attack_dmg damage!${ENDCOLOR}"
            if [ $attack_dmg -gt $current_priest_armor ]; then
               current_priest_armor=0
               remaining_dmg=$(expr $attack_dmg - $current_priest_armor)
               current_priest_health=$(expr $current_priest_health - $remaining_dmg)
               echo -e "${LIGHT_CYAN}Enemy armor is broken!${ENDCOLOR}"
            elif [ $current_priest_armor -eq 0 ]; then
               current_priest_health=$(expr $current_priest_health - $attack_dmg)
            elif [ $attack_dmg -gt $current_priest_health ]; then
                  current_priest_health=0
            else
               current_priest_armor=$(expr $current_priest_armor - $attack_dmg)
            fi

            priest
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
         
         if [ $current_priest_health -le 0 ]; then
            echo -e "${GREEN}You won the fight!${ENDCOLOR}"
            break
         fi
         
         sleep 3
         echo -e "${RED}Enemy turn!${ENDCOLOR}"
         sleep 2
         dice
         enemy_roll
         priest_dmg=$(expr $random_value \* $priest_str)
         echo -e "${RED}Enemy hit you with $priest_dmg damage!${ENDCOLOR}"
         if [ $priest_dmg -gt $current_hero_armor ]; then
            remaining_dmg=$(expr $priest_dmg - $current_hero_armor)
            current_hero_armor=0
            current_hero_health=$(expr $current_hero_health - $remaining_dmg)
            echo -e "${RED}Your armor is broken!${ENDCOLOR}"
         elif [ $current_hero_armor -eq 0 ]; then
            current_hero_health=$(expr $current_hero_health - $priest_dmg)
         else
            current_hero_armor=$(expr $current_hero_armor - $priest_dmg)
         fi
         hero
   done
   
}