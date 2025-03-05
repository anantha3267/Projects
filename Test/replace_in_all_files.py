import os
dir = os.getcwd()

for i in os.listdir(dir):
    if i.endswith(".log"):
        path_name = os.path.join(dir,i)
        with open(path_name,"r") as file:
            data = file.read()
            data=data.replace( 'CRITICAL','ERROR')
        with open(path_name,"w") as file:
            file.write(data)