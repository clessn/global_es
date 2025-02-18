


# Issues ------------------------------------------------------------------



## Feel towards US ------------------------------------------------------

table(DataRaw_21$)
DataClean_21$iss_feelUs <- NA
valid_indices <- DataRaw_21$pes19_country_2 <= 100  # Logical vector for filtering
DataClean_21$iss_feelUs <- ifelse(valid_indices, DataRaw_21$pes19_country_2, NA)
table(DataClean_21$iss_feelUs)


## US-Can ties -------------------------------------------------------------

table(DataRaw_21$pes21_tieus)
DataClean_21$iss_usTies <- NA
DataClean_21$iss_usTies[DataRaw_21$pes21_tieus == 5] <- 0
DataClean_21$iss_usTies[DataRaw_21$pes21_tieus == 4] <- 0.25
DataClean_21$iss_usTies[DataRaw_21$pes21_tieus == 3] <- 0.5
DataClean_21$iss_usTies[DataRaw_21$pes21_tieus == 2] <- 0.75
DataClean_21$iss_usTies[DataRaw_21$pes21_tieus == 1] <- 1
table(DataClean_21$iss_usTies)
