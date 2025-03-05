# replace_in_lines.py

def replace_word_in_lines(file_path, search_word, old_word, new_word):
    with open(file_path, 'r') as file:
        lines = file.readlines()

    with open(file_path, 'w') as file:
        for line in lines:
            if search_word in line:
                line = line.replace(old_word, new_word)
            file.write(line)

# Replace 'Failed' with 'Unable' only on lines containing 'ERROR'
replace_word_in_lines('logfile.log', 'ERROR', 'Failed', 'Unable')
