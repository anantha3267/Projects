import shutil

# Configuration
threshold = 80  # Percentage threshold for alert
disk = "/"  # Disk to monitor, e.g., '/' for root

def get_disk_usage(disk):
    print(shutil.disk_usage(disk))
    usage_percentage = (used / total) * 100
    return usage_percentage

def monitor_disk_usage():
    usage_percentage = get_disk_usage(disk)
    print(f"Disk usage on {disk}: {usage_percentage:.2f}%")
    
    if usage_percentage > threshold:
        print(f"Warning: Disk usage exceeded {threshold}% threshold!")

# Run the script
if __name__ == "__main__":
    monitor_disk_usage()
