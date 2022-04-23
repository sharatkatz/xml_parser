############################### PARALLEL PROCESSING TEST GROUND START ################################################					
# ProgramFuncs.R
######################################################################################################################					

TagStrings_ <- defineTagStrings[indx]
emptyApplicationDF <- NULL
myDat <- NULL
my.data <- NULL

processXMLChunk <- function(list.of.all.files, EACH.Att, extractTag) {
  
  # add two more column names as data for these will collected using xpathSApply from xml files
  # extractTag <- substr(EACH.Att,3,nchar(EACH.Att))
  ColnamesTagSpecific <- c("Filename", unlist(defineCols[extractTag]), "System_Service_Tag", "File_Creation_Datetime")
  emptyApplicationDF <- data.frame(matrix(ncol = length(ColnamesTagSpecific), nrow = 0))
  colnames(emptyApplicationDF) <- ColnamesTagSpecific
  
  cores <- detectCores(logical = TRUE) - 1
  cl <- makeCluster(cores, type = "PSOCK")
  clusterExport(cl, varlist=c("file_path", 
                              "robustParsing",
                              "emptyApplicationDF",
                              "rbind.all.columns",
                              "robustxpathSApply",
                              "xpathApply", # NOTE: this 'xpathApply' function is different from 'xpathSApply'
                              "defineCols",
                              "xmlToDataFrame",
                              "robustxmlToDataFrame",
                              "xpathSApply",
                              "xmlValue",
                              "xmlParse",
                              "processXMLChunk",
                              "EACH.Att",
                              "indx",
                              "SelectFromBatteryTag",
                              "SelectFromDiskTag",
                              "SelectFromSystem_Crash_InfoTag",
                              "SelectFromCablesTag",
                              "SelectFromPower_PlanTag",
                              "SelectFromLevel1ColumnsTag",
                              "SelectFromAC_ModeTag",
							  "SelectFromConfig",
							  "SelectFromMemory",
							  "SelectFromCPU",
							  "SelectFromBattery_SessEvents",
							  "SelectFromFileData",
							  "SelectFromEvents"))
  
  Nfiles <- length(list.of.all.files)
  myDat <- parLapply(cl, list.of.all.files, FUN <- function(one.file) {
    
	print (paste0("Processing file... ", one.file))
    doc <- robustParsing(one.file, encoding='utf-8')
    ll <- unlist(strsplit(one.file, "\\\\"))
    AppendedApplication <- xmlDF <- emptyApplicationDF
    
		if ( typeof(doc)=="externalptr" ) {
			# Check for level2 tags
			
			if ( extractTag == "Config" ) { xmlDF <- SelectFromConfig (doc, EACH.Att, extractTag)  
			 }  else if ( extractTag == "Memory" ) { xmlDF <- SelectFromMemory (doc, EACH.Att, extractTag)  
			  }  else if ( extractTag == "CPU" )    { xmlDF <- SelectFromCPU (doc, EACH.Att, extractTag)  
			   }  else if ( extractTag == "Battery_SessEvents" )    { xmlDF <- SelectFromBattery_SessEvents (doc, EACH.Att, extractTag)  
				}  else if ( extractTag == "FileData" )    { xmlDF <- SelectFromFileData (doc, EACH.Att, extractTag)  
				 }  else if ( extractTag == "Events" )    { xmlDF <- SelectFromEvents (doc, EACH.Att, extractTag)  
				  }
										  
			listL <- robustxpathSApply(doc, EACH.Att) 
			# specific tags - Disk, Battery, System_Crash_Info, Cables, Power_Plan have level3 tags also
			# therefore, require exclusive way of reading from Level3Tags.R code
			if (length(listL) > 0) {
			  if ( extractTag=="Disk" ) {
				xmlDF <- SelectFromDiskTag (doc, EACH.Att, extractTag)
				} else if ( extractTag == "Battery" ) { xmlDF <- SelectFromBatteryTag (doc, EACH.Att, extractTag)  
					} else if (extractTag == "System_Crash_Info") { xmlDF <- SelectFromSystem_Crash_InfoTag (doc, EACH.Att, extractTag) 
						} else if (extractTag == "Cables") { xmlDF <- SelectFromCablesTag (doc, EACH.Att, extractTag) 
							} else if (extractTag == "Power_Plan") { xmlDF <- SelectFromPower_PlanTag (doc, EACH.Att, extractTag) 
								} else if (extractTag == "AC_Mode" | extractTag == "DC_Mode") { xmlDF <- SelectFromAC_ModeTag (doc, EACH.Att, extractTag) 
									} else { xmlDF <- robustxmlToDataFrame(listL, stringsAsFactors=FALSE)  } 
				}
				
			  if (is.data.frame(xmlDF)) { 
				  xmlDF[, "System_Service_Tag"] <- robustxpathSApply(doc, "//System_Service_Tag", xmlValue)
				  xmlDF[, "File_Creation_Datetime"] <- robustxpathSApply(doc, "//File_Creation_Datetime", xmlValue)
				  xmlDF[, "Filename"] <- tail(ll, 1)
				  # if there are less columns read in the current columns, remaining column need to be added in character mode
				  xmlDF.diff <- setdiff(names(AppendedApplication), names(xmlDF))
				  xmlDF[, c(as.character(xmlDF.diff))] <- ""
				  # remove new line characters in the file
				  xmlDF <- as.data.frame(lapply(xmlDF, function(x) gsub("[\r\n]", "", x)),stringsAsFactors = FALSE)
				  # re-order columns to original
				  # if meta is a part of defineCols[extractTag] then first take it out and the re-arrange
				  allCols <- names(xmlDF)
				  Meta <- c("Filename", "System_Service_Tag", "File_Creation_Datetime")
				  excludeMeta <- allCols [! allCols %in% Meta]
				  xmlDF <- xmlDF[c("Filename", excludeMeta, "System_Service_Tag", "File_Creation_Datetime")]

			  } else { xmlDF <- emptyApplicationDF }
			   
			  # re-order columns to original
			  # xmlDF <- xmlDF[c("Filename", unlist(defineCols[extractTag]), "System_Service_Tag", "File_Creation_Datetime")]
		
		} 
    
    # dfApplication <- rbind(AppendedApplication, xmlDF)
    # return ( dfApplication )
      return (xmlDF)
	  
  })  # you get a list myDat having list of dataframes
  
  # bind all the dataframes in list by row
  my.data <- do.call("rbind", myDat)
  # my.data <- plyr::ldply(myDat, data.frame)   
  
  # stop and exit cluster after reading
  stopCluster(cl)
  
  # throw dataframe out as lapply
  return (my.data)
  
} # end of function processXMLChunk




readxmlExportDF <- function(EACH.Att) { 
  # # start reading in chunks
  extractTag <- substr(EACH.Att, 3, nchar(EACH.Att))
  ldfilesAppended <- lapply(lst, function(EACH.lst) processXMLChunk(EACH.lst, EACH.Att, extractTag=extractTag))		
  # # bind to a dataframe
  ldfilesAppended.2 <- do.call("rbind", ldfilesAppended)
  # ldfilesAppended.2 <- plyr::ldply(ldfilesAppended, data.frame)  
  print (str(ldfilesAppended.2))
  # print (propZero(ldfilesAppended.2)); print (propmiss(ldfilesAppended.2))
  # # export the bound dataframe
  outdlmFile <- paste0(multfolders, '_', extractTag, ".txt")
  outCSVPathfile <- paste(outCSVFolder, outdlmFile, sep="\\")
  write.table(ldfilesAppended.2, file = outCSVPathfile, sep = "|", row.names=TRUE)
  return (paste(extractTag, "... completed"))
} 
