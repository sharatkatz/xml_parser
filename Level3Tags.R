#######################################################################################################
# HANDLE CASES OF 'duplicate subscripts for columns' 
# OCURRING DUE TO LEVEL3 TAGS INSIDE LEVEL2 TAGS
# exclusive way of reading for Disk, Battery, System_Crash_Info, Cables, Power_Plan and level1 tags
#######################################################################################################

SelectFromCablesTag <- function (doc, TagString_, extractTag) {
	dfSelect <- do.call(rbind, xpathApply(doc, TagString_, function(node) {
					for (nTags_ in unname(unlist(defineCols[extractTag]))) {
						assign(nTags_, xmlValue(node[[nTags_]]))
					 }
					 data.frame(HardwareInfoGUID,
								Index,
								Name,
								Status
								, stringsAsFactors=FALSE)
												}))
			return (dfSelect)
}



SelectFromDiskTag <- function (doc, TagString_, extractTag) {
	dfSelect <- do.call(rbind, xpathApply(doc, TagString_, function(node) {
					for (nTags_ in unname(unlist(defineCols[extractTag]))) {
						assign(nTags_, xmlValue(node[[nTags_]]))
					 }
					 data.frame(HardwareInfoGUID,
								Index,
								Name,
								Make_Model,
								Size_MB,
								ePPID,
								DiskGUID,
								Read_Time_Pct,
								Write_Time_Pct,
								Idle_Time_Pct,
								Bytes_Read_MB,
								Bytes_Write_MB
								, stringsAsFactors=FALSE)
												}))
			return (dfSelect)
}

SelectFromSystem_Crash_InfoTag <- function (doc, TagString_, extractTag) {
	dfSelect <- do.call(rbind, xpathApply(doc, TagString_, function(node) {
					for (nTags_ in unname(unlist(defineCols[extractTag]))) {
						assign(nTags_, xmlValue(node[[nTags_]]))
					 }
					 data.frame(HardwareInfoGUID,
								Index,
								BugCheck_Time,
								BugCheck_String,
								Minidump_FileName,
								BugCheck_Stack1,
								BugCheck_Stack2,
								BugCheck_Stack3,
								BugCheck_Stack4,
								BugCheck_Stack5
								, stringsAsFactors=FALSE)
												}))
			return (dfSelect)
}

SelectFromBatteryTag <- function (doc, TagString_, extractTag) {
	dfSelect <- do.call(rbind, xpathApply(doc, TagString_, function(node) {
					for (nTags_ in unname(unlist(defineCols[extractTag]))) {
						assign(nTags_, xmlValue(node[[nTags_]]))
					 }
					 data.frame(HardwareInfoGUID,
								Index,
								Manufacture_Date,
								Serial_Number,
								Chemistry,
								Design_Capacity_mAH,
								Name,
								Mfg_Name,
								FullChargeCapacity,
								Cycle_Count,
								ePPID,
								Discharge_Time_mins,
								Discharge_Depth_0_5_Pct,
								Discharge_Depth_5_10_Pct,
								Discharge_Depth_10_20_Pct,
								Discharge_Depth_20_40_Pct,
								Discharge_Depth_40_60_Pct,
								Discharge_Depth_60_80_Pct,
								Discharge_Depth_80_100_Pct,
								Discharge_Start_Point_100_94_Pct,
								Discharge_Start_Point_94_70_Pct,
								Discharge_Start_Point_70_50_Pct,
								Discharge_Start_Point_50_30_Pct,
								Discharge_Start_Point_30_10_Pct,
								Discharge_Start_Point_0_10_Pct,
								Discharge_Sessions_With_End_10_15,
								Discharge_Sessions_With_End_5_10,
								Discharge_Sessions_With_End_LT_5,
								Discharge_Temp_Avg,
								Discharge_Temp_Std_Dev,
								Discharge_Temp_Max,
								Discharge_Temp_Min,
								Discharge_mA_Avg,
								Discharge_mA_Std_Dev,
								Discharge_mA_Max,
								Discharge_mA_Min,
								Discharge_mV_Avg,
								Discharge_mV_Std_Dev,
								Discharge_mV_Max,
								Discharge_mV_Min,
								Discharge_Power_W_Avg,
								Discharge_Power_W_Std_Dev,
								Discharge_Power_W_Max,
								Discharge_Power_W_Min,
								Discharge_Power_0_5W_Pct,
								Discharge_Power_5_10W_Pct,
								Discharge_Power_10_15W_Pct,
								Discharge_Power_15_20W_Pct,
								Discharge_Power_20_25W_Pct,
								Discharge_Power_25_30W_Pct,
								Discharge_Power_30_40W_Pct,
								Discharge_Power_40_50W_Pct,
								Discharge_Power_50_60W_Pct,
								Discharge_Power_GT60W_Pct,
								Charge_Time_mins,
								Charge_Number_Full_Charge_Sessions,
								Charge_Number_Partial_Charge_Sessions,
								Charge_Temp_Avg,
								Charge_Temp_Std_Dev,
								Charge_Temp_Max,
								Charge_Temp_Min,
								Charge_mA_Avg,
								Charge_mA_Std_Dev,
								Charge_mA_Max,
								Charge_mA_Min,
								Charge_mV_Avg,
								Charge_mV_Std_Dev,
								Charge_mV_Max,
								Charge_mV_Min,
								Charge_Power_W_RSOC_LE_60_Avg,
								Charge_Power_W_RSOC_LE_60_Std_Dev,
								Charge_Power_W_RSOC_LE_60_Max,
								Charge_Power_W_RSOC_LE_60_Min,
								Charge_Power_W_RSOC_LGT_60_Avg,
								Charge_Power_W_RSOC_LGT_60_Std_Dev,
								Charge_Power_W_RSOC_LGT_60_Max,
								Charge_Power_W_RSOC_LGT_60_Min,
								Dwell_Time_mins,
								Dwell_Avg_RSOC_Level,
								Dwell_Temp_Avg,
								Dwell_Temp_Std_Dev,
								Dwell_Temp_Max,
								Dwell_Temp_Min
								, stringsAsFactors=FALSE)
												}))
			return (dfSelect)
}


SelectFromPower_PlanTag <- function (doc, TagString_, extractTag) {
	dfSelect <- do.call(rbind, xpathApply(doc, TagString_, function(node) {
					for (nTags_ in unname(unlist(defineCols[extractTag]))) {
						assign(nTags_, xmlValue(node[[nTags_]]))
					 }
					 data.frame(HardwareInfoGUID,
								Index,
								Name,
								Active
								, stringsAsFactors=FALSE)
												}))
			return (dfSelect)
}

	
# this exception reads hierarchy level1 in the xml files
SelectFromLevel1ColumnsTag <- function (doc, TagString_="//Hardware_Info", extractTag) { # notice this change as there will no tag as \\Level1Columns
	dfSelect <- do.call(rbind, xpathApply(doc, "//Hardware_Info", function(node) {

						   for (nTags_ in unname(unlist(defineCols[extractTag]))) {
												assign(nTags_, xmlValue(node[[nTags_]]))
											 }

							data.frame(AC_Adapter_Type_W,
										AvailMem_0_256MB_Pct,
										AvailMem_1024_1280MB_Pct,
										AvailMem_1280_1536MB_Pct,
										AvailMem_1536_1792MB_Pct,
										AvailMem_1792_2048MB_Pct,
										AvailMem_2048_2304MB_Pct,
										AvailMem_2304_2560MB_Pct,
										AvailMem_256_512MB_Pct,
										AvailMem_2560_2816MB_Pct,
										AvailMem_2816_3072MB_Pct,
										AvailMem_512_768MB_Pct,
										AvailMem_768_1024MB_Pct,
										AvailMem_GT3072MB_Pct,
										Average_PQL,
										Average_ThreadCount,
										Avg_CPU_Consumption,
										Avg_CPU_Throttle,
										avg_pgs_per_sec,
										Battery_Sessions_0_30mins,
										Battery_Sessions_1_2hr,
										Battery_Sessions_2_3hr,
										Battery_Sessions_3_4hr,
										Battery_Sessions_30min_1hr,
										Battery_Sessions_4_6hr,
										Battery_Sessions_6_8hr,
										Battery_Sessions_8_12hr,
										Battery_Sessions_GT12hr,
										BIOS_Version,
										C0_State_Pct,
										C1_State_Pct,
										C2_State_Pct,
										C3_State_Pct,
										CPU_0_Pct,
										CPU_1_20_Pct,
										CPU_20_40_Pct,
										CPU_40_60_Pct,
										CPU_60_80_Pct,
										CPU_80_100_Pct,
										Customer_Defined_1,
										Customer_Defined_2,
										Customer_Defined_3,
										Customer_Name_1,
										Customer_Name_2,
										Customer_Name_3,
										Data_Begining_Date,
										Data_Ending_Date,
										DDV_Revision,
										DefaultTimerMode,
										File_Creation_Datetime,
										FreeMem_0_256MB_Pct,
										FreeMem_1024_1280MB_Pct,
										FreeMem_1280_1536MB_Pct,
										FreeMem_1536_1792MB_Pct,
										FreeMem_1792_2048MB_Pct,
										FreeMem_2048_2304MB_Pct,
										FreeMem_2304_2560MB_Pct,
										FreeMem_256_512MB_Pct,
										FreeMem_2560_2816MB_Pct,
										FreeMem_2816_3072MB_Pct,
										FreeMem_512_768MB_Pct,
										FreeMem_768_1024MB_Pct,
										FreeMem_GT3072MB_Pct,
										HardwareInfoGUID,
										Hostname,
										Hours_On,
										Hours_On_AC,
										Hours_On_Batt,
										Last_Restart_Time,
										Last_Shutdown_Time,
										Last_Start_Time,
										LCD_Avg_Brightness_AC_Pct,
										LCD_Avg_Brightness_DC_Pct,
										Lid_Hours_Closed,
										Lid_Hours_Open,
										Lid_Transitions,
										max_pgs_per_sec,
										Max_PQL,
										Max_ThreadCount,
										min_pgs_per_sec,
										Min_PQL,
										Min_ThreadCount,
										Motherboard_ePPID,
										No_Of_AC_Insertions,
										Number_Dock_Events,
										Number_Of_Battery_Insertions,
										Number_Of_Battery_Sessions,
										Number_of_Displays,
										Operating_System,
										pgs_per_sec_pct,
										PQL_0_Pct,
										PQL_1_Pct,
										PQL_10_20_Pct,
										PQL_2_Pct,
										PQL_3_Pct,
										PQL_4_Pct,
										PQL_5_10_Pct,
										PQL_5_Pct,
										PQL_GT20_Pct,
										Processor_Information,
										Processor_Serial_Number,
										Processor_Speed,
										S3_Event_Bin_0_30_mins,
										S3_Event_Bin_120_240_mins,
										S3_Event_Bin_240_480_mins,
										S3_Event_Bin_30_60_mins,
										S3_Event_Bin_480_960_mins,
										S3_Event_Bin_60_120_mins,
										S3_Event_Bin_GT_960_mins,
										S3_mins,
										S3_Requests,
										S4_Event_Bin_0_30_mins,
										S4_Event_Bin_120_240_mins,
										S4_Event_Bin_240_480_mins,
										S4_Event_Bin_30_60_mins,
										S4_Event_Bin_480_960_mins,
										S4_Event_Bin_60_120_mins,
										S4_Event_Bin_GT_960_mins,
										S4_mins,
										S4_Requests,
										S5_Requests,
										Std_Dev_ThreadCount,
										Summary_Type,
										System_Model,
										System_RAM_Bytes,
										System_RAM_GB,
										System_Service_Tag,
										System_Type,
										Throttle_0_Pct,
										Throttle_1_25_Pct,
										Throttle_25_50_Pct,
										Throttle_50_75_Pct,
										Throttle_75_100_Pct,
										Video_Controller,
										Video_RAM_Bytes,
										stringsAsFactors = FALSE)
										}))

			return (dfSelect)
}

SelectFromAC_ModeTag <- function (doc, TagString_, extractTag) {
	dfSelect <- do.call(rbind, xpathApply(doc, TagString_, function(node) {
					for (nTags_ in unname(unlist(defineCols[extractTag]))) {
						assign(nTags_, xmlValue(node[[nTags_]]))
					 }
					 data.frame(Turn_Off_Display_After_Seconds,
								Sleep_After_Seconds,
								Display_Brightness_Percentage
								, stringsAsFactors=FALSE)
												}))
			return (dfSelect)
}

SelectFromDC_ModeTag <- function (doc, TagString_, extractTag) {
	dfSelect <- do.call(rbind, xpathApply(doc, TagString_, function(node) {
					for (nTags_ in unname(unlist(defineCols[extractTag]))) {
						assign(nTags_, xmlValue(node[[nTags_]]))
					 }
					 data.frame(Turn_Off_Display_After_Seconds,
								Sleep_After_Seconds,
								Display_Brightness_Percentage
								, stringsAsFactors=FALSE)
												}))
			return (dfSelect)
}


