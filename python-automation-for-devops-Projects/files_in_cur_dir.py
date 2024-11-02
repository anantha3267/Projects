import os 

for f in os.listdir('.'):
    if os.path.isfile(f):
        print(f"This is a file {f}")
    elif os.path.isdir(f):
        print(f"This is a directory {f}")


import os

data = [
    (f, 'file') if os.path.isfile(f) else (f, 'directory') if os.path.isdir(f) else (f, 'unknown type')
    for f in os.listdir('.')
]

# Print the categorized entries
for item, category in data:
    print(f"This is a {category}: {item}")

