import os
import shutil
import subprocess
import json

def get_disk_usage():
    total, used, free = shutil.disk_usage("/")
    return {
        "total_gb": total / (1024**3),
        "used_gb": used / (1024**3),
        "free_gb": free / (1024**3),
        "percent": (used / total) * 100
    }

def get_cpu_load():
    try:
        # For macOS (darwin)
        output = subprocess.check_output(["sysctl", "-n", "vm.loadavg"]).decode().strip()
        load = float(output.split()[1]) # 1-min load average
        # Heuristic for % (assuming 8 cores if not found)
        # Better to use 'top -l 1 | grep "CPU usage"'
        cpu_info = subprocess.check_output(["top", "-l", "1", "-n", "0"]).decode()
        # Find "CPU usage: X% user, Y% sys, Z% idle"
        for line in cpu_info.split('\n'):
            if "CPU usage" in line:
                idle = float(line.split("idle")[0].split(",")[-1].strip().replace('%', ''))
                return 100 - idle
    except:
        return 0.0

def check_resources():
    disk = get_disk_usage()
    cpu = get_cpu_load()
    return {
        "disk": disk,
        "cpu_percent": cpu,
        "safe_to_work": disk["percent"] < 95 and cpu < 90
    }

if __name__ == "__main__":
    status = check_resources()
    print(json.dumps(status, indent=4))
    with open(".tmp/system_status.json", "w") as f:
        json.dump(status, f)
