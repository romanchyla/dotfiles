#!/bin/bash

echo "Performance analysis: http://techblog.netflix.com/2015/11/linux-performance-analysis-in-60s.html"

declare -a arr=("uptime" "dmesg -T | tail" "vmstat 1 10" "mpstat -P ALL 1" "pidstat 1" "iostat -xz 5" "free -m" "sar -n DEV 1" "sar -n TCP,ETCP 1" "top")
declare -a desc=(
 "1. Look for first number being much higher than the next (1, 5, 15 min) load averages"
 "2. last 10 system messages, if there are any. Look for errors that can cause performance issues (OOM, TCP drops)"
 "3. Columns to check:\nr: Number of processes running on CPU and waiting for a turn. It does not include I/O. 'r' value greater than the CPU count is saturation.\nfree: Free memory in kilobytes. If too many digits to count, you have enough free memory.\nsi, so: Swap-ins and swap-outs. If these are non-zero, you’re out of memory.\nus, sy, id, wa, st: breakdowns of CPU time, on average across all CPUs. > user time, system time (kernel), idle, wait I/O, and stolen time (by other guests, or with Xen, the guest's own isolated driver domain)."
 "4. CPU time breakdowns per CPU, which can be used to check for an imbalance. A single hot CPU can be evidence of a single-threaded application"
 "5. This represents a rolling summary of what CPU each task consumes"
 "6. tool for understanding block devices (disks), both the workload applied and the resulting performance. Look for: \nr/s, w/s, rkB/s, wkB/s: These are the delivered reads, writes, read Kbytes, and write Kbytes per second to the device. Use these for workload characterization. A performance problem may simply be due to an excessive load applied.\nawait: The average time for the I/O in milliseconds. This is the time that the application suffers, as it includes both time queued and time being serviced. Larger than expected average times can be an indicator of device saturation, or device problems\uinvgqu-sz: The average number of requests issued to the device. Values greater than 1 can be evidence of saturation (although devices can typically operate on requests in parallel, especially virtual devices which front multiple back-end disks.)\n%util: Device utilization. This is really a busy percent, showing the time each second that the device was doing work. Values greater than 60% typically lead to poor performance (which should be seen in await), although it depends on the device. Values close to 100% usually indicate saturation."
 "7. check that these aren’t near-zero in size, which can lead to higher disk I/O (confirm using iostat), and worse performance."
 "8. check network interface throughput: rxkB/s and txkB/s, as a measure of workload, and also to check if any limit has been reached"
 "9. summarized view of some key TCP metrics. These include:\nactive/s: Number of locally-initiated TCP connections per second (e.g., via connect()).\npassive/s: Number of remotely-initiated TCP connections per second (e.g., via accept()).\nretrans/s: Number of TCP retransmits per second.\nThe active and passive counts are often useful as a rough measure of server load: number of new accepted connections (passive), and number of downstream connections (active). It might help to think of active as outbound, and passive as inbound, but this isn’t strictly true (e.g., consider a localhost to localhost connection).\nRetransmits are a sign of a network or server issue; it may be an unreliable network (e.g., the public Internet), or it may be due a server being overloaded and dropping packets."
 "10. well, look around :)"
)
for (( i = 0; i < ${#arr[@]} ; i++ )); do
    printf "\n**** Running: ${arr[$i]} *****\n\n"
    
    # Run each command in array 
    eval "${arr[$i]}"
    
    printf "\n${desc[$i]}\n\n"
    read -p "Continue? [Y/n]" answer
    printf "\n"
    case ${answer:0:1} in
      n|N )
        break
      ;;
    esac

done
