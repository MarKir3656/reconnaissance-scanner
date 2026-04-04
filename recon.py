#!/usr/bin/env python3
import os
import subprocess
from datetime import datetime

output_dir = './output'

# create output directory if dosen't exist
def create_dir():
    os.makedirs(output_dir, exist_ok=True)

# create file of result with current data
def create_file():
    output_file = os.path.join(output_dir, f'recon_{datetime.now():%Y%m%d_%H%M%S}.txt')
    return output_file

# temple for module name
def module_name(file, title):
    file.write(f"\n=== {title} ===\n")

# temple for indent
def module_indent(file):
    file.write("\n")

# running command in Linuxx
def run_command(cmd):
    result = subprocess.run(cmd, shell=True, capture_output=True, text=True)
    return result

def main():
    create_dir()
    with open(create_file(), 'w') as result_file:

        module_name(result_file, 'LINUX RECONNAISSANCE')
        result_file.write(f'Date time: {datetime.now():%Y-%m/%d %H:%M:%S}')
        module_indent(result_file)

        # system info
        module_name(result_file, 'SYSTEM INFO')
        result_file.write(f'{run_command("uname -a")}\n')
        result_file.write(f'{run_command("cat /etc/os-release | head -n 3")}\n')
        module_indent(result_file)

        # users
        module_name(result_file, 'USERS')
        result_file.write(f'{run_command("cut -d: -f1 /etc/passwd")}\n')
        module_indent(result_file)

        # sudo users
        module_name(result_file, 'SUDO USERS')
        result_file.write(f'{run_command("grep -E '^(sudo|wheel|root)' /etc/group")}\n')
        module_indent(result_file)

        # open ports
        module_name(result_file, 'OPEN PORTS (LISTENING)')
        result_file.write(f'{run_command("ss -tulpn | grep LISTEN")}\n')
        module_indent(result_file)

        # active process
        module_name(result_file, 'TOP PROCESSES BY CPU')
        result_file.write(f'{run_command("ps aux --sort=-%cpu | head -n 10")}\n')
        module_indent(result_file)

        # cron-jobs
        module_name(result_file, 'CRON JOBS')
        result_file.write(f'{run_command("crontab -l 2>/dev/null")}\n')
        result_file.write(f'{run_command("ls -la /etc/cron* 2>/dev/null")}\n')
        module_indent(result_file)

        # suid bin
        module_name(result_file, 'SUID BINARIES')
        result_file.write(f'{run_command("find / -perm -4000 -type f 2>/dev/null")}\n')
        module_indent(result_file)

        print("RECON COMPLETE")

if __name__ == "__main__":
    main()
