#!/bin/bash

# These are the minimum requirements
os="Ubuntu"
# Need the exact same version, because in the Task this is the minimum requirement and later versions are not supported.
version="20.04"
cpu_number=8
# Set to 1 if AVX support is needed
avx_support_needed=1
memory_GB=16
free_disk_space_GB=32

color_off='\033[0m'
color_green='\033[32m'
color_red='\033[31m'

final_decision="${color_green}PASSED${color_off}"

function main(){
    checkOsAndVersion
    checkCpu
    checkMemory
    checkFreeDiskSpace

    printFinalDecision
}

function checkOsAndVersion(){
    # There are some systems which not have lsb_release command by default, that's why I use other method.
    # lsb_release -sd|grep $os|grep -q $version

    echo "DISTRIBUTION CHECK"

    text_for_matching="DISTRIB_DESCRIPTION"
    current_distribution=$(cat /etc/*-release|grep $text_for_matching|sed "s|^$text_for_matching=\"\(.*\)\"$|\1|")
    printCurrent "$current_distribution"
    printRequired "$os $version"

    text_in_message="OS and version"
    if echo $current_distribution|grep $os|grep -q $version
    then
        printOK "$text_in_message"
    else
        printNOK "$text_in_message"
    fi
    printNewLine
}

function checkCpu(){
    echo "CPU CHECK"

    current_cpu_nuber=$(nproc)
    printCurrent $current_cpu_nuber
    printRequired $cpu_number

    text_in_message="CPU number"
    if [ $current_cpu_nuber -ge $cpu_number ]
    then
        printOK "$text_in_message"
    else
        printNOK "$text_in_message"
    fi

    if [ $avx_support_needed -eq 1 ]
    then
        checkCpuAvxSupport
    fi

    printNewLine
}

function checkCpuAvxSupport(){
    text_in_message="CPU AVX support"
    if grep -q avx /proc/cpuinfo
    then
        printOK "$text_in_message"
    else
        printNOK "$text_in_message"
    fi
}

function checkMemory(){
    echo "MEMORY CHECK"

    total_memory_kB=$(grep MemTotal /proc/meminfo|sed "s|^[^0-9]*\([0-9]*\)[^0-9]*$|\1|")
    # I divided with 1000 rather than 1024, because in the Task was GB not GiB.
    total_memory_GB=$(($((total_memory_kB)) / 1000 / 1000))
    # Bash only support integers out of the box, that's why I check the last decimal for rounding.
    last_decimal=$(echo $total_memory_kB|sed "s|^[0-9]*\([0-9]\)[0-9]\{5\}$|\1|")

    printCurrent "$total_memory_GB.${last_decimal}GB"
    printRequired "${memory_GB}GB"

    text_in_message="Memory"
    if [ $total_memory_GB -ge $memory_GB ]
    then
        printOK $text_in_message
    elif [ $total_memory_GB -eq $(($memory_GB - 1)) ]
    then
        if [ $last_decimal -ge 5 ]
        then
            printOK $text_in_message
        else
            printNOK $text_in_message
        fi
    else
        printNOK $text_in_message
    fi
    printNewLine

    # Other option to check RAM:
    # free --giga -h -t
}

function checkFreeDiskSpace(){
    echo "FREE DISK SPACE CHECK"

    current_free_disk_space_GB=$(df -h -BG --total --output=avail|tail -n 1|sed "s|^[^0-9]*\([0-9]*\)G$|\1|")
    printCurrent "${current_free_disk_space_GB}GB"
    printRequired "${free_disk_space_GB}GB"

    text_in_message="Free disk space"
    if [ $current_free_disk_space_GB -ge $free_disk_space_GB ]
    then
        printOK "$text_in_message"
    else
        printNOK "$text_in_message"
    fi
    printNewLine
}

function setFailed(){
    final_decision="${color_red}FAILED${color_off}"
}

function printCurrent(){
    echo "Current: $1"
}

function printRequired(){
    echo "Required: $1"
}

function printOK(){
    echo -e "$1 is ${color_green}OK${color_off}."
}

function printNOK(){
    echo -e "$1 is ${color_red}NOK${color_off}."
    setFailed
}

function printNewLine(){
    echo ""
}

function printFinalDecision(){
    echo "FINAL VERDICT"
    echo -e $final_decision
}

main
