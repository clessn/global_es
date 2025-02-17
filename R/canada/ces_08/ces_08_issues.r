


# Issues ------------------------------------------------------------------



## Feel towards US ------------------------------------------------------

table(DataRaw_08$pes_c8)
DataClean_08$iss_feelUs <- NA
valid_indices <- DataRaw_08$pes_c8 <= 100  # Logical vector for filtering
DataClean_08$iss_feelUs <- ifelse(valid_indices, DataRaw_08$pes_c8, NA)
table(DataClean_08$iss_feelUs)



## US-Can ties -------------------------------------------------------------

table(DataRaw_08$pes_f8)
DataClean_08$iss_usTies <- NA
DataClean_08$iss_usTies[DataRaw_08$pes_f8 == "much more distant"] <- 0
DataClean_08$iss_usTies[DataRaw_08$pes_f8 == "more distant"] <- 0.25
DataClean_08$iss_usTies[DataRaw_08$pes_f8 == "about the same as now"] <- 0.5
DataClean_08$iss_usTies[DataRaw_08$pes_f8 == "somewhat closer"] <- 0.75
DataClean_08$iss_usTies[DataRaw_08$pes_f8 == "much closer"] <- 1
table(DataClean_08$iss_usTies)
