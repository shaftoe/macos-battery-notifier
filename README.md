# macos-battery-notifier

Show a notification in macOS Notification Center when the MacBook battery is low or full.

## Why?

Although there's no consensus abut it, it appears that keeping a modern battery charged between 20% and 80% might help extending its life.

This simple shell script helps creating a cronjob-like task that checks the battery level (default to once per minute) and shows a notification in macOS Notification Center when the battery is low or full.

Personally I use 20-80 as a range but it's configurable and you can set your own preferred values (see __Usage__ below).

## How?

- `launchctl` to manage the _cronjob_
- `pmset -g batt` to get the battery level
- `osascript` to send the notification

## Usage

    ./battery-notifier.sh <min_cpu_usage> <max_cpu_usage>            # send alert if cpu usage is below min or above max
    ./battery-notifier.sh --install <min_cpu_usage> <max_cpu_usage>  # create Launchd config (.plist) file and reload daemon
    ./battery-notifier.sh --uninstall                                # uninstall Launchd user-agent
    ./battery-notifier.sh --help                                     # print this help message

### Examples

#### Install as a Launchd timed (a.k.a. `cronjob` or _recurring_) job

    ./battery-notifier.sh --install 20 80

#### One-time

    ./battery-notifier.sh 10 90

shows the following notification if the CPU usage has reached 10%:

![image](screenshot.png)

## References

- <https://developer.apple.com/library/archive/documentation/MacOSX/Conceptual/BPSystemStartup/Chapters/CreatingLaunchdJobs.html#//apple_ref/doc/uid/TP40001762-104142>
- <https://rakhesh.com/mac/macos-launchctl-commands/>
