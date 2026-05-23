#!/bin/bash

# Load functions and variables
for file in functions/*; do
   source $file
done

   # ACT 1
   cat images/tavernquest.txt
   sleep 2
   cat images/chapter1.txt


   echo "A lonely traveller wanders aimlessly in a dark forest. He is hungry, thirsty and tired." | $textspeed
   echo "Suddenly he notices a small light source, so he turns into that direction. As he moves closer, he discovers that the light is coming from a small tavern." | $textspeed
   echo "He goes in to rest a bit." | $textspeed
   sleep 2
   echo "The tavern is quite crowded and noisy. He buys a beer and some food, then sits to an empty table." | $textspeed
   echo "After he finished his meal, a strange looking fellow approches him..." | $textspeed
   sleep 2
   skull
   
   echo "What's your name traveller?" | $textspeed
   
   read name

   skull
   
   echo "Hey $name, I have job offer for you. Are you interested?" | $textspeed
   
   read answer
   if [[  $answer = "Yes"  ||  $answer = "yes"  ]]; then
      
      echo -e "Good answer! Let me tell you about the job." | $textspeed
   else
      echo "Then leave me alone!" | $textspeed
      exit
      
   fi

   
   echo -e "There's an abandoned church in the forest, not far from here. They say there's an old dungeon under the church, which hides an ${YELLOW}ancient relic${ENDCOLOR}!" | $textspeed
   echo "If we find that thing, it'll make us rich, brother!" | $textspeed
   echo "So, what do you say? Are you in?" | $textspeed
   
   read answer
   if [[ $answer = "Yes"  ||  $answer = "yes" ]]; then
      
      echo "Good choice! Now, that place is probably dangerous, so first I would need to know, if you can defend yourself." | $textspeed
      echo -e "Let's see if you can beat that loud ${RED}drunk idiot${ENDCOLOR}!" | $textspeed
      
   else
      echo "Then leave me alone!" | $textspeed
      exit
   fi
       
   sleep 3
   drunk_fight

   sleep 3
   skull
   
   echo "Hahaha, well done! You defeated that ugly bastard!" | $textspeed
   echo "Here, use this healing potion, it will patch you up!" | $textspeed
   ((hp_potion++))
   echo -e "${LIGHT_BLUE}GAME:${ENDCOLOR} You've received a healing potion!"
   echo -e "${YELLOW}TIP:${ENDCOLOR} type heal to use healing potion!"
   
   read heal
   while [ $heal != "heal" ]; do
      echo "Type "heal" for healing!"
      read heal
   done
   heal

   
   skull
   echo -e "Also, after every successful fight, you will receive a roll with my ${MAGENTA}magic dice${ENDCOLOR} to improve your stats!" | $textspeed
   echo -e "${YELLOW}TIP:${ENDCOLOR} type roll to use the ${MAGENTA}magic dice${ENDCOLOR}!"
   
   read input
   while [ $input != "roll" ]; do
      echo -e "${ENDCOLOR} Type roll to use the ${MAGENTA}magic dice${ENDCOLOR}!"
      read input
   done
   magic_dice
   magic_roll
   sleep 3

   
   skull
   echo "Now, let's go to the church!" | $textspeed
   
   sleep 5
   clear
   sleep 2


   # ACT 2
   cat images/chapter2.txt

   echo "After some hours of wandering with your new friend, you finally the reached the church." | $textspeed
   cat images/church.txt
   sleep 2
   echo "It was an eerie looking, abandoned, old building." | $textspeed
   echo "The whole place radiated an evil atmosphere, fog started to descend, even the sky had an greenish color..." | $textspeed
   sleep 2
   skull
   echo -e "Hahaha! Are you scared or what? Let's go inside and find that ${YELLOW}treasure!${ENDCOLOR} \n" | $textspeed
   

   
   echo "As you stepped in, a disgusting stench filled your nose." | $textspeed
   echo "The hall was packed with rotten bodies... Looks like the last mass didn't go as planned." | $textspeed
   echo "A strange growling could be heard from the podium and as you turned your head into that direction, you noticed the priest. Well, at least what's left from his body..." | $textspeed
   echo "He stood up and started to mumble some gibberish in a myterious language..." | $textspeed
   sleep 2
   echo "Suddenly, little blue orbs started to come out from his book and each of them flew into a body on the ground." | $textspeed
   echo "In this moment, the rest of bodies started to rise as well..." | $textspeed
   sleep 2

   skull
   echo "Quick! Deal with the priest, while I distract his minions!" | $textspeed

   sleep 3
   priest_fight

   echo "As the priest fell to the ground, the life disappeared from the zombies as well and they collapsed like ragdolls." | $textspeed
   skull
   echo "*heavy panting*..." | $textspeed
   sleep 3
   echo "Nice job, kid! They almost got me..." | $textspeed
   echo -e "Here, roll the ${MAGENTA}dice${ENDCOLOR} while I get my strength back." | $textspeed
   echo -e "${YELLOW}TIP:${ENDCOLOR} type roll to use the ${MAGENTA}magic dice${ENDCOLOR}!"
   read input
   while [ $input != "roll" ]; do
      echo -e "${ENDCOLOR} Type roll to use the ${MAGENTA}magic dice${ENDCOLOR}!"
      read input
   done
   magic_dice
   magic_roll
   sleep 3
   echo "While you were waiting for your friend to rest, you have noticed an old chest at the corner of the room." | $textspeed
   sleep 2
   chest
   sleep 3
   echo -e "You have opened it and found a ${RED}ruby ring${ENDCOLOR}!" | $textspeed
   sleep 2
   echo -e "${LIGHT_BLUE}GAME:${ENDCOLOR} Max HP increased by 100 point!" | $textspeed
   stash+=("Ruby ring \n")
   ((hero_health+=100))
   current_hero_health=$hero_health
   hero
   sleep 3

   skull
   echo "All right, the entrance to the dungeon must be here somewhere...\n" | $textspeed
   echo "You both start to canvass the room." | $textspeed
   sleep 5
   skull
   echo "How about that closet?\n" | $textspeed
   echo "You pushed the closet away and noticed a big hole in the wall." | $textspeed
   skull
   echo "That's our entrance!" | $textspeed
   echo -e "Come on, that ${YELLOW}treasure${ENDCOLOR} is waiting for us!"
   sleep 3
   clear

   # ACT 3
   cat images/chapter3.txt
   echo "Descending on the staircase felt like an enternity." | $textspeed
   echo "The place was really dark, the only light source was given by the flaming torches on the walls." | $textspeed
   echo "You couldn't help thinking about, who the hell lit those torches in the first place." | $textspeed
   skull
   echo "Hey kid!" | $textspeed
   echo "Stop the daydreaming!" | $textspeed
   echo -e "We need to find that ${YELLOW}treasure${ENDCOLOR} and this place is huge." | $textspeed
   echo "Let's pick, which way we should we go!" | $textspeed
   echo "Left or right?" | $textspeed
   read direction
   if [[ $direction = "right" ]]; then
      skull
      echo -e "Ah, great! A freaking ${RED}orc${ENDCOLOR}!" | $textspeed
      orc_fight
      magic_roll
   else
      echo "You found an open cell with a body inside." | $textspeed
      echo -e "Next to it lays a silver greatsword. You pick it up!" | $textspeed
      echo -e "${LIGHT_BLUE}GAME:${ENDCOLOR} You strength increased by 2 points!" | $textspeed
      ((hero_strength+=2))
      hero
   fi