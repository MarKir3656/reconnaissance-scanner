# About reconnaissance-scanner

A script for automatically collecting information about a Linux system. Used during reconnaissance.

# Сapabilities

- Information about OS and core;
- Collect information about users and sudo users;
- Scan of listening ports;
- List of active processes;
- Cron jobs;
- Identifying potentially dangerous rights;

# Installation and start

## For Linux

```bash
git clone https://github.com/MarKir3656/reconnaissance-scanner.git
cd reconnaissance-scanner
chmod +x recon.sh
./recon.sh
```
Result are saved in `./output` directory.

### Example of file

```
=== SYSTEM INFO ===
Linux workstation 6.17.0-19-generic ...

=== USERS ===
root
daemon
bin
sys
sync

=== SUDO USERS ===
root:x:0:
sudo:x:27:user

=== OPEN PORTS (LISTENING) ===
tcp   LISTEN 0      4096         0.0.0.0:22         0.0.0.0:*
tcp   LISTEN 0      4096      127.0.0.54:53         0.0.0.0:*
...
=== TOP PROCESSES BY CPU ===
USER         PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
user        1543 14.2  0.1  22292  4684 pts/0    R+   14:26   0:00 ps aux --sort=-%cpu
user        1499  7.1  0.1  20060  4020 pts/0    S+   14:26   0:00 -bash
root           1  1.0  0.3  23376 14676 ?        Ss   14:21   0:03 /sbin/init splash
```
