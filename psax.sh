#!/bin/bash

echo -e "PID\tTTY\tSTATUS\tCPU SEC TOTAL\tCMD"

pids=$(find /proc -maxdepth 1 -type d | cut -f3 -d '/' | grep -E [0-9]+ | grep -v $$)

for pid in $pids
do
	if [[ -f  /proc/${pid}/status ]]; then
		ppid=$(cat /proc/${pid}/status | grep PPid | awk '{print $2}')
		tty=$(readlink /proc/${pid}/fd/0)
		status=$(cat /proc/${pid}/status | grep State)
		command=$(cat /proc/${pid}/comm)
		PROCESS_STAT=($(sed -E 's/\([^)]+\)/X/' "/proc/$pid/stat"))
		PROCESS_UTIME=${PROCESS_STAT[13]}
		PROCESS_STIME=${PROCESS_STAT[14]}
		CLK_TCK=$(getconf CLK_TCK)
		cpu_total_time=$(($PROCESS_UTIME/$CLK_TCK + $PROCESS_STIME/$CLK_TCK))
		echo -e "${pid}\t${tty}\t${status}\t${cpu_total_time}\t${command} ${cmdline}"
	fi
done

