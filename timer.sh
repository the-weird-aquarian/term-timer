#!/usr/bin/env bash

totalSeconds=0

# Show usage
usage() {
cat << EOF

Usage:
timer <duration>

Description:
Set a countdown timer directly from the terminal.

Examples:
timer 10s
timer 1m 30s
timer 2h 30m 10s

EOF
}

# If no arguments provided, show usage
if [ $# -eq 0 ]; then
  usage
  exit 1
fi

# Loop through the arguments
for arg in "$@"
do
  duration=$(echo "$arg" | sed -n 's/\([0-9]\+\).*/\1/p') #Removes s,m,h; keeps digits
  unit=$(echo "$arg" | sed -n 's/[^smh]*\([smh]\).*/\1/p') #Removes digits; keeps s,m,h

  # Convert duration to seconds
  case $unit in

    s)
      totalSeconds=$((totalSeconds + duration))
    ;;

    m)
      totalSeconds=$((totalSeconds + duration * 60))
    ;;

    h)
      totalSeconds=$((totalSeconds + duration * 3600))
    ;;

    *)
      echo "Error: invalid input format."
      echo "Please use any one of the following formats:"
      echo -e "10s\n30m\n1h 30m 10s"
      exit 1
    ;;

  esac

  # Shift the arguments by 1
  shift
done

secondsRemaining=$totalSeconds
echo -e "\nTimer started.\n"

# Count down the duration in seconds
while [ $secondsRemaining -gt 0 ]
do
  # Calculate the hours, minutes, and seconds
  hours=$((secondsRemaining / 3600))
  minutes=$(((secondsRemaining % 3600) / 60))
  totalSeconds=$((secondsRemaining % 60))

  # Format the time as HH:MM:SS
  echo -ne "\r$(printf "%02d:%02d:%02d" $hours $minutes $totalSeconds)"
  # \r moves cursor to front everytime so the output is overwritten
  # %02d ensures its always double digits

  # Sleep for 1 second before continuing the loop
  sleep 1

  ((secondsRemaining--))
done

echo -e "\n\nTimer finished.\n"
/usr/bin/notify-send --urgency=critical --icon=timer "Timer finished." # Notification
