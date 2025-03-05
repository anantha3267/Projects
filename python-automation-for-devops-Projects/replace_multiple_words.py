def replace_multiple_words(file_path,replace_values):
    with open(file_path,"r") as file:
        data = file.read()
    for key,value in replace_values.items():
        data = data.replace(key,value)

    with open(file_path,"w") as file:
        file.write(data)


replace_values = {'INFO': 'INFO_UPDATED', 'ERROR': 'CRITICAL'}
replace_multiple_words(r"C:\Users\nikhi\OneDrive\Desktop\FT\Projects\Test\logs.log",replace_values)
