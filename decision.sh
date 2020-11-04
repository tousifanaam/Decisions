#!/bin/bash

# Usage:  A simple script for making random choices.
# Author: Tousif Anaam

echo
clear
echo
# User Manual                       
if [[ "$1" = "-help" || "$1" = "-h" ]] 2>/dev/null;then  
	echo -e "\nDEFAULT is set to Custom (two options)"                                    
	echo -e "\n \e[92m-n\e[0m  \e[94mfor\e[0m\tyes or no"                                        
	echo -e "\n \e[92m-c\e[0m  \e[94mfor\e[0m\tcoin flip"                                         
	echo -e "\n \e[92m-d\e[0m  \e[94mfor\e[0m\tsingle dice roll"                                         
	echo -e "\n \e[92m-dd\e[0m \e[94mfor\e[0m\tdouble dice roll"                                         
	echo -e "\n \e[92m-m\e[0m  \e[94mfor\e[0m\tCustom (multiple option)"      
 exit
fi 


# 1. normal ( yes/no )
if [ "$1" = "-n" ] 2>/dev/null;then
a='yes'
b='no'
n=0
op1=0
op2=0
while [ $n -ne 7 ]; do
    x=$(($RANDOM % 2))
    if [ $x -eq 0 ];then
        op1=$(($op1+1))
    elif [ $x -eq 1 ];then
        op2=$(($op2+1))
    fi
    n=$((n+1))
done
#echo "$a=$op1 and $b=$op2"
echo -e "\nin 3"
sleep 1s
echo -e "\nin 2"
sleep 1s
echo -e "\nin 1"        
if [ $op1 -gt $op2 ];then
        echo -e "\n>>> $a <<<"
elif [ $op1 -lt $op2 ];then
        echo -e "\n>>> $b <<<"
fi
echo && exit
fi
                
# 2. coin flip ( heads/tails )
spinner() {
    local i sp n
    sp='/-\|'
    n=${#sp}
    printf ' '
    while sleep 0.1; do
        printf "%s\b" "${sp:i++%n:1}"
    done
}

animation () {                                                        
echo                                                            
printf "Flipping... "
spinner &                                                                                                                                                                                   
sleep $((3 + $RANDOM % 3))s                                                        
kill "$!" # kill the spinner
printf '\n'                                                        
}
                
if [ "$1" = "-c" ] 2>/dev/null;then
				animation
   toss=$(($RANDOM % 2))     
   if [ $toss -eq 0 ];then    
        echo -e "\n>>>>>HEADS<<<<<"
   elif [ $toss -eq 1 ];then    
        echo -e "\n>>>>>TAILS<<<<<"            
   fi  
   exit             
fi     
            
# 3. Single Dice Roll (1/2/3/4/5/6)
if [ "$1" = "-d" ] 2>/dev/null;then            
roll=$((1 + $RANDOM % 6))
roll_animation () {
echo "Rolling..." ;n=1
while [ $n -ne 7 ];do
    echo -e "\n$n" && sleep 0.2s && n=$(($n+1)) 
done && clear 
}
roll_animation; roll_animation; echo "Rolling..."; check=1
while [ $check -ne $roll ];do
    echo -e "\n$check" && sleep 0.2s && check=$(($check+1))
done
echo -e "\n\e[92m$roll\e[0m" && sleep 0.2s && check=$(($roll+1))
while [ $check -ne 7 ];do
    echo -e "\n$check" && sleep 0.2s && check=$(($check+1))
                done && echo -e "\nYou rolled a \e[92m[\e[0m $roll \e[92m]\e[0m" && exit
fi            

# 4. Double Dice Roll ((1/2/3/4/5/6) && (1/2/3/4/5/6))
if [ "$1" = "-dd" ] 2>/dev/null;then
roll1=$((1 + $RANDOM % 6)); roll2=$((1 + $RANDOM % 6))
roll_animation () {
echo "Rolling..." ; n=0; x=1; y=6
while [ $n -ne 6 ];do
    echo -e "\n$x\t$y" && sleep 0.2s && x=$(($x+1)) && y=$(($y-1)) && n=$(($n+1)) 
done && clear 
}
roll_animation; roll_animation; echo "Rolling..."; n=0; x=1; y=6
while [ $n -ne 6 ];do
    if [[ $x -eq $roll1 && $y -eq $roll2 ]];then
        echo -e "\n\e[92m$x\t$y\e[0m" && sleep 0.2s && x=$(($x+1)) && y=$(($y-1)) && n=$(($n+1))
    elif [ $x -eq $roll1 ];then
        echo -e "\n\e[92m$x\e[0m\t$y" && sleep 0.2s && x=$(($x+1)) && y=$(($y-1)) && n=$(($n+1))
    elif [ $y -eq $roll2 ];then  
        echo -e "\n$x\t\e[92m$y\e[0m" && sleep 0.2s && x=$(($x+1)) && y=$(($y-1)) && n=$(($n+1))
    else
        echo -e "\n$x\t$y" && sleep 0.2s && x=$(($x+1)) && y=$(($y-1)) && n=$(($n+1))  
    fi               
done && echo -e "\nYou rolled \e[92m[\e[0m $roll1 \e[92m]\e[0m and \e[92m[\e[0m $roll2 \e[92m]\e[0m" && exit
fi    
                        
# 5. Custom (out of multiple)                        
if [ "$1" = "-m" ] 2>/dev/null;then 
clear; echo
decision_file=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 40 | head -n 1)
n=0; number=1
while [ $n -eq 0 ];do
    read -p "${number}. " decision 
    if [ "$decision" = ".d" ];then
        echo -e "\e[94m∆\e[0m Total no. of options noted: $(($number-1))"
    					count=`wc -l $decision_file | cut -d " " -f 1`
    					check=$((1 + $RANDOM % $count))
    					answer=`cat $decision_file | head -$check | tail -1`
        rm -rf $decision_file
    					n=1
    else
    echo -e "\e[92m✓ Noted.\e[0m Type \e[93m.d\e[0m to \e[91mend\e[0m\n" && number=$(($number+1))
    echo $decision >> $decision_file
    fi
done    
echo -e "\nin \e[91m3\e[0m" && sleep 1s
echo -e "\nin \e[93m2\e[0m" && sleep 1s
echo -e "\nin \e[92m1\e[0m" && sleep 1s
echo -e "\n\e[94m>>>\e[0m $answer \e[94m<<<\e[0m" && exit                     
fi
                            
# 6. Custom (out of 2) [default]       
echo 'If you have two options at hand...but not enough brainpower to choose yourself. Let me decide for ya!'
echo
read -p "Decision 1: " a
read -p "Decision 2: " b
if [ $a = $b ] 2>/dev/null; then
        echo
        echo -e "Both cannot be the samething..duh 乁(\e[91m ⁰͡ \e[0mĹ̯ \e[91m⁰͡ \e[0m) ㄏ"
        exit
fi
echo -e "\nin 3"
sleep 1s
echo -e "\nin 2"
sleep 1s
echo -e "\nin 1"

n=0
op1=0
op2=0
while [ $n -ne 7 ]; do
    x=$(($RANDOM % 2))
    if [ $x -eq 0 ];then
        op1=$(($op1+1))
    elif [ $x -eq 1 ];then
        op2=$(($op2+1))
    fi
    n=$((n+1))
done
#echo "$a=$op1 and $b=$op2"
if [ $op1 -gt $op2 ];then
        echo -e "\n>>> $a <<<"
elif [ $op1 -lt $op2 ];then
        echo -e "\n>>> $b <<<"
fi
echo
