with open(r"C:\Users\nikhi\OneDrive\Desktop\FT\Projects\Test\logs.log","r") as file:
    data = file.read()
    data=data.replace( 'ERROR','CRITICAL')

with open(r"C:\Users\nikhi\OneDrive\Desktop\FT\Projects\Test\logs.log","w") as file:
    file.write(data)

