


# Issues ------------------------------------------------------------------



## Feel towards US ------------------------------------------------------

table(DataRaw_06$pes_c8)
DataClean_06$iss_feelUs <- NA
valid_indices <- DataRaw_06$pes_c8 <= 100  # Logical vector for filtering
DataClean_06$iss_feelUs <- ifelse(valid_indices, DataRaw_06$pes_c8, NA)
table(DataClean_06$iss_feelUs)

attributes(DataRaw_06)
## US-Can ties -------------------------------------------------------------

table(DataRaw_06$cps_f806)
DataClean_06$iss_usTies <- NA
DataClean_06$iss_usTies[DataRaw_06$cps_f806 == "much more distant"] <- 0
DataClean_06$iss_usTies[DataRaw_06$cps_f806 == "more distant"] <- 0.25
DataClean_06$iss_usTies[DataRaw_06$cps_f806 == "about the same as now"] <- 0.5
DataClean_06$iss_usTies[DataRaw_06$cps_f806 == "somewhat closer"] <- 0.75
DataClean_06$iss_usTies[DataRaw_06$cps_f806 == "much closer"] <- 1
table(DataClean_06$iss_usTies)
