with open(r"C:\Users\nikhi\OneDrive\Desktop\FT\Projects\Test\logs.log","r") as file:
    data = file.readlines()
    print(data)

for line in data:
    print(line)