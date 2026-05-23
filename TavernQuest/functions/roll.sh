#!/bin/bash

function roll() {
   dice_value=(1 2 3 4 5 6)
   random_value=$(printf "%s\n" "${dice_value[@]}" | shuf -n 1)
   echo "Rolling..."
   sleep 3
   echo "You rolled:" $random_value
}
