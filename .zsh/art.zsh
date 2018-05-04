#!/bin/bash
# Get the command line options

opt_nocolor=f
opt_force_color=f

# System Variables
user=$(whoami)
hostname=$(hostname | sed 's/.local//g')
#ip=$(ipconfig | grep 192 -m 1)
#ip=$(echo "${ip}" | awk '$1=$1' | sed 's/([A-Z]\{1,2\})//g' | sed -e 's/^.*: *//')
distro=$(echo "Windows 7")
ip=$(wget -qO- http://ipecho.net/plain ; echo)
kernel=$(uname)
uptime=$(uptime | sed 's/.*up \([^,]*\), .*/\1/')
shell="$SHELL"
terminal="$TERM ${TERM_PROGRAM//_/ }"
packages=$(($(cygcheck -cd | wc -l) - 2))
cpu=$(cat /proc/cpuinfo | grep 'model name' -m 1 | sed -e 's/^.*: *//')
# removes (R) and (TM) from the CPU name so it fits in a standard 80 window
cpu=$(echo "${cpu}" | awk '$1=$1' | sed 's/([A-Z]\{1,2\})//g')

memorykb=$(cat /proc/meminfo | grep MemTotal: | sed -e 's/MemTotal: *//' -e 's/kB//')
memorymb=$((memorykb/1024))
disk=$(df | head -2 | tail -1 | awk '{print $5}')


# Set up colors if:
# * stdout is a tty
# * the user hasn't turned it off
# * or if we're forcing color
if [[ ( -t 1  && "${opt_nocolor}" = f) || "${opt_force_color}" = t ]]
then
  RED=$(tput       setaf 1 2>/dev/null)
  GREEN=$(tput     setaf 2 2>/dev/null)
  YELLOW=$(tput    setaf 3 2>/dev/null)
  BLUE=$(tput      setaf 4 2>/dev/null)
  PURPLE=$(tput    setaf 5 2>/dev/null)
  textColor=$(tput setaf 6 2>/dev/null)
  normal=$(tput    sgr0 2>/dev/null)
fi

userText="${textColor}User:${normal}"
hostnameText="${textColor}Hostname:${normal}"
distroText="${textColor}Distro:${normal}"
kernelText="${textColor}Kernel:${normal}"
uptimeText="${textColor}Uptime:${normal}"
ipText="${textColor}IP Address:${normal}"
shellText="${textColor}Shell:${normal}"
terminalText="${textColor}Terminal:${normal}"
packagehandlerText="${textColor}Packages:${normal}"
cpuText="${textColor}CPU:${normal}"
memoryText="${textColor}Memory:${normal}"
diskText="${textColor}Disk:${normal}"

# The ${foo#  } is a cheat so that it lines up here as well
# as when run.
echo -e "
${GREEN#  }                 ###
${GREEN#  }               ####                   $userText $user
${GREEN#  }               ###                    $hostnameText $hostname
${GREEN#  }       #######    #######             $distroText $distro
${YELLOW# }     ######################           $kernelText $kernel
${YELLOW# }    #####################             $uptimeText $uptime
${RED#    }    ####################              $shellText $shell
${RED#    }    ####################              $terminalText $terminal
${RED#    }    #####################             $packagehandlerText ${packages}
${PURPLE# }     ######################           $cpuText $cpu
${PURPLE# }      ####################            $memoryText $memorymb
${BLUE#   }        ################              $diskText $disk
${BLUE#   }         ####     #####               $ipText $ip${normal}
"
