Text = "The cat jumped over the fence and ran through the garden"
pre = ["over","through"]
new_text = ""

Text = Text.split()
for i in Text:
    if i not in pre:
        new_text = new_text + " " + i

print(new_text)
