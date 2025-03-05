#awk '$9 == 200 {print $1, $4, $5, $6, $7, $9}' ./apachelogs.log
#awk -F',' '{print $1, $2, $3, $4}' ./yourlogfile.log
#awk -F'[,:]' '{print $1, $2, $3, $4}' ./yourlogfile.log


import re
import json

# Path to the log file
log_file_path = './apachelogs.log'

# Regular expression to match log entries
log_pattern = r'(\S+) - - \[(.*?)\] "(.*?)" (\d{3}) (\d+)'

# List to store parsed logs
parsed_logs = []

# Read log data from file
with open(log_file_path, 'r') as file:
    for line in file:
        match = re.match(log_pattern, line)
        if match:
            ip, datetime, request, status_code, response_size = match.groups()
            # Store the parsed log as a dictionary
            parsed_logs.append({
                "ip": ip,
                "datetime": datetime,
                "request": request,
                "status_code": int(status_code),
                "response_size": int(response_size)
            })

# Convert the parsed logs to JSON
json_output = json.dumps(parsed_logs, indent=2)

# Print the result
print(parsed_logs)
print(json_output)
