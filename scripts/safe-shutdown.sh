#!/bin/bash

# SETTINGS
# arrow key code:
#    UP arrow -> A
#  DOWN arrow -> B
#  LEFT arrow -> C
# RIGHT arrow -> D
key1="A"
key2="B"
key3="C"
key4="B"

# timeout between keys in seconds
to=3

# CODE
# force root
if [ "$(id -u)" != "0" ]; then
	exec sudo "$0" "$@"
fi

# read key input and check for arrow keys in right order
echo "Please type the arrow key code: "
read -rsn1 -t $to input
case "$input" in
$'\x1b')
	read -rsn1 -t 0.1 tmp
	if [[ "$tmp" == "[" ]]; then
		read -rsn1 -t 0.1 tmp
		case "$tmp" in
		$key1) 
			read -rsn1 -t $to input
			case "$input" in
			$'\x1b')
				read -rsn1 -t 0.1 tmp
				if [[ "$tmp" == "[" ]]; then
					read -rsn1 -t 0.1 tmp
					case "$tmp" in
					$key2)
						read -rsn1 -t $to input
			                        case "$input" in
			                        $'\x1b')
                        			        read -rsn1 -t 0.1 tmp
			                                if [[ "$tmp" == "[" ]]; then
                        			                read -rsn1 -t 0.1 tmp
			                                        case "$tmp" in
                        			                $key3)
                                                			read -rsn1 -t $to input
			                                                case "$input" in
                        			                        $'\x1b')
                                                			        read -rsn1 -t 0.1 tmp
			                                                        if [[ "$tmp" == "[" ]]; then
                        			                                        read -rsn1 -t 0.1 tmp
                                                			                case "$tmp" in
			                                                                $key4)
												echo "Success - System is going to shut down in 5 seconds. . ."
												sleep 5
                        			                                                shutdown -h now
                                                			                ;;
			                                                                esac
                        			                                fi
			                                                ;;
                        			                        esac
                                        			;;
                                        			esac
			                                fi
                        			;;
			                        esac
					;;
					esac
				fi
			;;
			esac
		;;
		esac
	fi
;;
esac

echo "Shutdown canceled!"
sleep 3
