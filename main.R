###############################################################################					
# main.R
###############################################################################					
rm (list=ls()); gc()
memory.limit()

######### USER INPUT - START ################################################
# set the working directory
setwd("")

# folder inside which month_year folders are kept
parentFolder <- ""
multfolders = c("")  

# export to below location as pipe delimited text flat files
outCSVFolder <- ""
######### USER INPUT - END   ################################################

# Initial calling - libs, user defined functions, input files
source (".\\CallLibFunc.R", echo=FALSE)

## Sequence No. for indx
# No.	Tag
# 1 BIOS_Internal_Logs
# 2 Cables
# ....
# 32 Level1Columns

# sample usage:
# indx = c(1:4) or c(1,2,3,4) to read 1 through 4 tags
indx = c(30)

# read in a bunch of files
n = 100000 

# Prepare list of files to read
source (".\\ReadFiles.R", echo=FALSE)

# declare columns to be read for each schema 
source (".\\declareTags_v02.R", echo=FALSE)

# declare functions for reading level1 and level3 attrs
source (".\\Level3Tags_v02.R", echo=FALSE)
 
# declare functions to parse xml files in parallel
source (".\\ProgramFuncs_v04.R", echo=FALSE) 

start_time <- Sys.time()
source (".\\ApplyParallelRead v04.R", echo=TRUE)
end_time <- Sys.time()
(end_time - start_time)
