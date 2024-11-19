# required to read JSON files.
library("rjson")
# Passing argument files
myData <- fromJSON(list.files,(path = '_SharedFolder_GlobalES/Dashboard/Canada/json_files'))
# Convert JSON file to dataframe.
json_data_frame <- as.data.frame(myData)
print(json_data_frame)

