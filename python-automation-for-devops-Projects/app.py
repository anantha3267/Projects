# prepositions = ["in", "on", "at", "by", "with", "about", "for", "as", "from", "to", "into", "onto", "through", "during"]

# input_text = "The book is on the table and the pen is near it"

# words = input_text.split()
# for word in words:
#     if word not in prepositions:
#         print(word)

import re

# Sample Apache log entry
log_entry = '127.0.0.1 - - [05/Feb/2025:10:30:52 +0000] "GET /index.html HTTP/1.1" 200 2326'

# Regular expression pattern to match the log format
log_pattern = r'(?P<ip>[\d\.]+) - - \[(?P<datetime>[^\]]+)\] "(?P<method>[A-Z]+) (?P<url>[^ ]+) HTTP/1\.[01]" (?P<status>\d+) (?P<bytes>\d+)'

# Parse log entry using regex
match = re.match(log_pattern, log_entry)

if match:
    log_data = match.groupdict()
    print(log_data)


import re

# Regular expression pattern to match the log format
log_pattern = r'(?P<ip>[\d\.]+) - - \[(?P<datetime>[^\]]+)\] "(?P<method>[A-Z]+) (?P<url>[^ ]+) HTTP/1\.[01]" (?P<status>\d+) (?P<bytes>\d+)'

# Path to your Apache log file
log_file_path = '/path/to/apache/access.log'

# Open the log file and parse line by line
with open(log_file_path, 'r') as log_file:
    for log_entry in log_file:
        match = re.match(log_pattern, log_entry)
        if match:
            log_data = match.groupdict()
            print(log_data)

import apachelogs

# Path to your Apache log file
log_file_path = '/path/to/apache/access.log'

# Open and parse the log file
with open(log_file_path, 'r') as log_file:
    for entry in apachelogs.parse(log_file):
        # Print each parsed log entry
        print(f"IP: {entry.remote_host}, Method: {entry.request_method}, URL: {entry.request_url}, Status: {entry.status_code}, Date: {entry.date_time}")

from logparser import LogParser

# Path to your Nginx log file
log_file_path = '/path/to/nginx/access.log'

# Create a LogParser instance
parser = LogParser(log_file_path)

# Parse the log file and print each log entry
for log_entry in parser:
    print(log_entry)
