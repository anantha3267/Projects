# Using raw string for the text (although not necessary in this case)
text = r"My phone number is 123-456-7890."

# Regex pattern (use raw string)
pattern = r'\d'  # \d means any digit

# Replace digits with '#'
import re
result = re.sub(pattern, '#', text)

print(result)  # Output: My phone number is ###-###-####.
