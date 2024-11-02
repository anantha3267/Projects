import os
import re

py_files = []
directory = '.' 
pattern = r'\.py$'
regex = re.compile(pattern)
unapproved_libraries = ['pandas','numpy']
unapproved_libraries_present = []

for dir,dirnames,files in os.walk(directory):
    for file in files:
        file_path = os.path.join(dir,file)
        if regex.search(file):
            with open(file_path,'r') as f:
                contents = f.read()
                for library in unapproved_libraries:
                    if f'import {library}' in contents:
                        unapproved_libraries_present.append(file_path)


if unapproved_libraries_present:
    print('unapproved libraries present')
    exit(1)
else:
    print('All imports are good')

            



