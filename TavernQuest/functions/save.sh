#!/bin/bash


function save() {

   echo -e "hero_health: $hero_health"'\n' \
           "hero_str: $hero_str"'\n' \
           "hero_armor: $current_hero_armor"'\n' \
           "act: $act" > functions/save.txt

}