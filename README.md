# macos-battery-notifier

Send macOS notifications when the battery is low or charged.

## Usage

    Usage:
        ./battery.sh <min_cpu_usage> <max_cpu_usage>            # send alert if cpu usage is below min or above max
        ./battery.sh --install <min_cpu_usage> <max_cpu_usage>  # create Launchd config (.plist) file and reload daemon
        ./battery.sh --help                                     # print this help message

## References

- <https://developer.apple.com/library/archive/documentation/MacOSX/Conceptual/BPSystemStartup/Chapters/CreatingLaunchdJobs.html#//apple_ref/doc/uid/TP40001762-104142>
- <https://rakhesh.com/mac/macos-launchctl-commands/>
