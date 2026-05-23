#!/bin/bash

function magic_roll() {
   stats=( "Strength" "Health" "Armor" )
   random_stat=$(printf "%s\n" "${stats[@]}" | shuf -n 1)
   echo "Rolling..."
   sleep 3
   echo "You rolled:" $random_stat
   if [ $random_stat == "Strength" ]; then
    ((hero_str++))
    current_hero_str=$hero_str
    echo -e "${LIGHT_CYAN}Strength increased by 1 point!${ENDCOLOR}"
    hero
   elif [ $random_stat == "Health" ]; then
    ((hero_health+=100))
    current_hero_health=$hero_health
    echo -e "${LIGHT_CYAN}Max health increased by 100 point!${ENDCOLOR}"
    hero
   elif [ $random_stat == "Armor" ]; then
    ((hero_armor+=10))
    current_hero_armor=$hero_armor
    echo -e "${LIGHT_CYAN}Max armor increased by 10 points!${ENDCOLOR}"
    hero
   fi  
}
