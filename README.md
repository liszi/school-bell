# school-bell
Cron based command line school-bell alarm system for linux, playing custom audio files as alarm ringtones. 

## Dependencies
- linux OS (ubuntu tested)
- root permission for install and uninstall
- `mplayer` installed `sudo apt install mplayer`
- network connection to keep system time in sync
- correctly configured system timezone
- user who installed *school-bell* must be logged in to keep scheduled alarms active
- crontab shouldn't be used for other purposes for the specific user

## Installation
Execute next command in a linux terminal:
1. clone repository: `git clone https://github.com/liszi/school-bell.git`
2. enter downloaded folder: `cd school-bell`
3. start install script: `./install.sh`
4. enter a password for root permission when script asks for it

## Quickstart
After the successful installation, you can test the school-bell alarm with enabling the sample per-minute schedule
with executing the next command in terminal:

`crontab ~/school-bell/schedules/sample-schedule-every-minute.cron`

It should play default school-bell ringtone every minute.

To disable the alarm, run `crontab -r`

Check the sample school-bell schedule at `~/school-bell/schedules/sample-school-bell-schedule.cron`, edit as expected,
and activate it with the next command:

`crontab ~/school-bell/schedules/sample-school-bell-schedule.cron`

## Installed files

### ~/school-bell folder
After installation, in the home directory of the installer user the `school-bell` folder will appear. 
This folder contains all the data and logs for the *school-bell* application.

#### ~/school-bell/ringtones folder
This folder contains all the ringtones for *school-bell* application. 
Any audio file can be copied here which can be played by `mplayer`. (e.g. mp3, wav, ogg...)

[ring command](#ring-command) will find any audio file in this folder based on filename (without full path).

#### ~/school-bell/schedules folder

This folder contains all the school-bell schedules. These schedules must be valid linux crontab files with `cron` extension. 
These crontab files should utilize `ring` command with optional ringtones to form a complete school-bell schedule. 

For more details see [Schedule](#schedule) section.

### ring command
Installation process creates a `ring` command (`/usr/bin/ring`). 
This command without arguments plays the default bell ringtone (`~/school-bell/ringtones/.default-ringtone.mp3`).
It accepts one optional parameter, which can be either the full path of a ringtone, or the filename of a ringtone 
found in `~/school-bell/ringtones/` folder. 

Ringtone can be any audio file which can be played with `mplayer` command.


### Logs
`ring` command generates logs to `~/school-bell/log.txt` for each run.


## Schedule
Application uses [cron](https://en.wikipedia.org/wiki/Cron) for school-bell schedules.
Crontab files (`*.cron`) stores cronjobs, which are periodically running commands.

For *school-bell* application `ring` command runs with predefined periods. 
Each daily school-bell ring event should be a standalone cronjob (line in the crontab file). 

To generate linux crontab lines use one of the online crontab generator applications. e.g.:
- https://crontab-generator.org/
- http://www.crontabgenerator.com/
- https://corntab.com/

Let's check part of the `~/school-bell/schedules/sample-school-bell-schedule.cron` sample crontab file content:

```
0 8 * * * ring school-bell-3-seconds.mp3 # Period 1 start ring at 8:00 every day
40 8 * * 1-5 ring school-bell-1-seconds.mp3 # Period 1 alarm ring at 8:40 every weekday
45 8 * * 1-5 ring school-bell-3-seconds.mp3
```

Each line is representing a cronjob of a daily alarm. First part of the cronjob is defining the timing, with 5 sections (`40 12 * * 1-5`): minute hours day-of-month month day-of-week. 
After that `ring school-bell-1-seconds.mp3` is the command with the ringtone argument, which plays the ringtone audio with the given timing. After`#` sign comments can be added to each line.

From more details check [cron](https://en.wikipedia.org/wiki/Cron).

### Activate schedule
To activate a specific *school-bell* schedule, a specific crontab file should be selected with `crontab <filepath>` command:

With the next command you can activate the sample school-bell schedule: 

`crontab ~/school-bell/schedules/sample-school-bell-schedule.cron`

This will overwrite the previous active crontab. 

To see the active schedule, type `crontab -l` into terminal. 

### Disable schedule
To stop all the school-bell alarms run `crontab -r`.


## Uninstall
To uninstall an installed *school-bell* application run `~/school-bell/.uninstall.sh` command.

This command will deactivate all the active crontabs, and remove the installed commands from `/usr/bin` folder. 

Uninstall will not remove the school-bell working directory since it can contain important crontabs and ringtones.
To remove all the crontabs and ringtones execute `rm -r ~/school-bell/` command in terminal manually.


## Troubleshooting

### Can't hear school-bell ring sound
1. Test your audio with playing some sound if it is working properly.
2. Check your crontab and it's timing if it is configured as expected with executing `crontab -l` in terminal.
You should see the same content as the schedule file `*.cron`, what you've activated last time. If it is not there, activate it again.
3. `mplayer` must be installed and available from terminal.
4. User must be logged in to hear the sound.
5. Check `~/school-bell/log.txt` file for detailed info.

### School-bell ring played instead of my custom audio
When `ring` command can't find the defined custom audio file, it'll play the default ringtone. Possible reasons:
1. No custom ringtone is not provided after ring command in the active schedule.
2. Provided custom ringtone path is invalid. Provide full path of the ringtone, or copy it to `~/school-bell/ringtones` folder and provide only filename.  
3. Check `~/school-bell/log.txt` file for detailed info.

### Incorrect schedule timing
1. Check if the system time is in sync. You need internet connection, and enabled time syncronization to network time (with NTP)
2. Check your system timezone.
3. Check your active schedule with `crontab -l` command if it is the expected.


