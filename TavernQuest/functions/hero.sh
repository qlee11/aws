#!/bin/bash


function hero() {
   cat images/hero.txt

   echo -e "Health: $current_hero_health"
   echo -e "Strength: $current_hero_str"
   echo -e "Armor: $current_hero_armor"

}
