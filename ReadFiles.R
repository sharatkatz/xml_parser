######################################################################################################################
# Prepare list of files to read
######################################################################################################################
# Find all xml or json files in your folder
file_list = list()
for (folderName in multfolders) {
  file_path <- paste(parentFolder, folderName, sep="\\")
  file_listN <- list.files(path = file_path, 
                           pattern = "*.xml|*.json", all.files = FALSE,
                           full.names = FALSE, recursive = FALSE,
                           ignore.case = FALSE, include.dirs = FALSE)
  file_listN <- paste(parentFolder,folderName, file_listN, sep='\\')
  message ("Number of files in directory [", file_path, "] are ", length(file_listN))
  file_list =  c(file_listN, file_list)
  rm (file_listN)
}

rm (folderName)

message ("Total number of files in all directories are: ", length(file_list))
