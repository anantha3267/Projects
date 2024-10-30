import os
import time

def count_lines(file_path):
    with open(file_path, 'r') as file:
        return sum(1 for _ in file)

def rotate_log(file_path, max_lines=10):
    line_count = count_lines(file_path)
    if line_count > max_lines:
        # Archive and create a new log file
        timestamp = time.strftime("%Y%m%d%H%M%S")  # Get current time as a string
        backup_file = f"{file_path}.{timestamp}.backup"  # Use timestamp for unique backup name
        os.rename(file_path, backup_file)
        with open(file_path, 'w'):  # Create a new empty file
            pass
        print(f"Log rotated: Old log archived as '{backup_file}'.")
    else:
        print("Log rotation not needed.")

rotate_log('application.log')
