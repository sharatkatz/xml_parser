######################################################################################################################					
# declareTags.R
######################################################################################################################	

defineTags <- c("BIOS_Internal_Logs",
				"Cables",
				"WWAN",
)


defineTagStrings <- paste0("//", defineTags)

defineCols <- list( BIOS_Internal_Logs = c("HardwareInfoGUID",
					   "Name",
					   "Time",
					   "LogType",
					   "EventCode",
					   "Descr"),

					Cables  = c("HardwareInfoGUID",
								"Index",
								"Name",
								"Status"
								),

						WWAN = c("HardwareInfoGUID",
								 "Device_Name",
							     "IMEI"),

					Battery = c("HardwareInfoGUID",
								"Index",
								"Manufacture_Date",
								"Serial_Number",
								"Chemistry",
								"Design_Capacity_mAH",
								"Name",
								"Mfg_Name",
								"FullChargeCapacity",
								"Cycle_Count",
								"Charge_Temp_Std_Dev",
								"Discharge_Time_mins",
								"Discharge_Depth_0_5_Pct",
								),
								
					Application = c("HardwareInfoGUID", 
									"Index", 
									"Name", 
									"Publisher", 
									"Version", 
									"InstallDate", 
									"LastUsed"),	
									
					Driver = c("HardwareInfoGUID",
								"Index",
								"Name",
								"Publisher",
								"Version",
								"InstallDate"),
								
					Update = c("HardwareInfoGUID",
								"Index",
								"Name",
								"Publisher",
								"InstallDate"),
								
					Thermistor = c("HardwareInfoGUID",
									"Index",
									"Location",
									"Temp",
									"Peak_Temp",
									"Avg_Temp",
									"Min_Temp",
									"Std_Dev_Temp",
								),
									
					Smart = c("HardwareInfoGUID",
								"Index",
								"Name",
								"ePPID",
								"Model",
								"Temp_Avg",
								"Temp_Std_Dev",
								"Temp_Max",
							),
					
						
					Level1Columns =  c("AC_Adapter_Type_W",
										"AvailMem_0_256MB_Pct",
										"AvailMem_1024_1280MB_Pct",
										"AvailMem_1280_1536MB_Pct",
										"AvailMem_1536_1792MB_Pct",
										"AvailMem_1792_2048MB_Pct",
										"AvailMem_2048_2304MB_Pct",
										"AvailMem_2304_2560MB_Pct",
										"AvailMem_256_512MB_Pct",
										"AvailMem_2560_2816MB_Pct",
										"AvailMem_2816_3072MB_Pct",
										"AvailMem_512_768MB_Pct",
										"AvailMem_768_1024MB_Pct",
										"AvailMem_GT3072MB_Pct",
									)

				) # end of list defineCols
