import psutil
import time

def get_cpu_memory_usage():
    # CPU usage in percent
    cpu_usage = psutil.cpu_percent(interval=1)

    # Memory usage
    memory = psutil.virtual_memory()
    memory_used = memory.used / (1024 ** 3)  # Convert to GB
    memory_total = memory.total / (1024 ** 3)  # Convert to GB
    memory_percent = memory.percent

    print(f"CPU Usage: {cpu_usage}%")
    print(f"Memory Usage: {memory_used:.2f} GB / {memory_total:.2f} GB ({memory_percent}%)")

if __name__ == "__main__":
    while True:
        get_cpu_memory_usage()
        time.sleep(5)  # Update every 5 seconds
