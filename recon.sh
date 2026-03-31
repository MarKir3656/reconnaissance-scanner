
#!/bin/bash

OUTPUT_DIR="./output"
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
OUTPUT_FILE="${OUTPUT_DIR}/recon_${TIMESTAMP}.txt"

mkdir -p "$OUTPUT_DIR" 

echo "=== LINUX RECONNAISSANCE ===" | tee -a "$OUTPUT_FILE"
echo "Date time: $(date)" | tee -a "$OUTPUT_FILE"
echo "" | tee -a "$OUTPUT_FILE"

# system info
echo "=== SYSTEM INFO ===" | tee -a "$OUTPUT_FILE"
uname -a | tee -a "$OUTPUT_FILE"
cat /etc/os-release | head -n 3 | tee -a "$OUTPUT_FILE"
echo "" | tee -a "$OUTPUT_FILE"

# users
echo "=== USERS ===" | tee -a "$OUTPUT_FILE"
cut -d ':' -f 1 /etc/passwda | tee -a "$OUTPUT_FILE"
echo "" | tee -a "$OUTPUT_FILE"

# sudo users
echo "=== SUDO USERS ===" | tee -a "$OUTPUT_FILE"
grep -E '^sudo|^root' /etc/group | tee -a "$OUTPUT_FILE"
echo "" | tee -a "$OUTPUT_FILE"

# open ports
echo "=== OPEN PORTS (LISTENING) ===" | tee -a "$OUTPUT_FILE"
ss -tulpn | grep LISTEN | tee -a "$OUTPUT_FILE"
echo "" | tee -a "$OUTPUT_FILE"

# active process
echo "=== TOP PROCESSES BY CPU ===" | tee -a "$OUTPUT_FILE"
ps aux --sort=-%cpu | head -n 10 | tee -a "$OUTPUT_FILE"
echo "" | tee -a "$OUTPUT_FILE"

# cron-jobs
echo "=== CRON JOBS ===" | tee -a "$OUTPUT_FILE"
crontab -l 2>/dev/null | tee -a "$OUTPUT_FILE"
ls -la /etc/cron* 2>/dev/null | tee -a "$OUTPUT_FILE"
echo "" | tee -a "$OUTPUT_FILE"

# suid bin
echo "=== SUID BINARIES ===" | tee -a "$OUTPUT_FILE"
find / -perm -4000 -type f 2>/dev/null | tee -a "$OUTPUT_FILE"
echo "" | tee -a "$OUTPUT_FILE"

echo "=== RECON COMPLETE ===" | tee -a "$OUTPUT_FILE"
echo "Отчет сохранен: $OUTPUT_FILE"