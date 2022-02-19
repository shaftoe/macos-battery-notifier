set -euo pipefail

readonly LAUNCHD_CONFIG_FILE="$HOME/Library/LaunchAgents/in.l3x.battery.plist"

if [ $1 == "--help" -o $1 == "-h" ]; then
    printf "Usage:
    $0 <min_cpu_usage> <max_cpu_usage>            # send alert if cpu usage is below min or above max
    $0 --install <min_cpu_usage> <max_cpu_usage>  # create Launchd config file (${LAUNCHD_CONFIG_FILE}) and reload daemon
    $0 --help                                     # print this help message
"
    exit 0
fi

if [ $1 == "--install" ]; then
    min_cpu=$2
    max_cpu=$3
    printf "Creating new config file: $LAUNCHD_CONFIG_FILE\n"
    printf "<?xml version=\"1.0\" encoding=\"UTF-8\"?>
<!DOCTYPE plist PUBLIC \"-//Apple//DTD PLIST 1.0//EN\" \"http://www.apple.com/DTDs/PropertyList-1.0.dtd\">
<plist version=\"1.0\">
<dict>
    <key>Label</key>
    <string>in.l3x.battery</string>

    <key>ProgramArguments</key>
    <array>
        <string>$(pwd)/$0</string>
        <string>${min_cpu}</string>
        <string>${max_cpu}</string>
    </array>

    <key>StartInterval</key>
    <integer>60</integer>
</dict>
</plist>
" > $LAUNCHD_CONFIG_FILE
    printf "Reloading Launchd... "
    launchctl unload $LAUNCHD_CONFIG_FILE
    launchctl load $LAUNCHD_CONFIG_FILE
    printf "done\n"
    exit 0
fi

readonly MIN_CPU=$1
readonly MAX_CPU=$2

CPU=$(pmset -g batt | grep -Eo "\d+%" | tr -d '%')
STATE=$(pmset -g batt | grep -Eo "discharging|charging")

if [ "$STATE" = "discharging" -a "$CPU" -le "$MIN_CPU" ]; then
    osascript -e "display notification \"$CPU\" with title \"Low battery\""
elif [ "$STATE" = "charging" -a "$CPU" -ge "$MAX_CPU" ]; then
    osascript -e "display notification \"$CPU%\" with title \"Battery charged\""
fi

exit 0
