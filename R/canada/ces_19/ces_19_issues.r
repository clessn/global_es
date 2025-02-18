


# Issues ------------------------------------------------------------------



## Feel towards US ------------------------------------------------------

table(DataRaw_19$pes19_country_2)
DataClean_19$iss_feelUs <- NA
valid_indices <- DataRaw_19$pes19_country_2 <= 100  # Logical vector for filtering
DataClean_19$iss_feelUs <- ifelse(valid_indices, DataRaw_19$pes19_country_2, NA)
table(DataClean_19$iss_feelUs)


## US-Can ties -------------------------------------------------------------

table(DataRaw_19$pes19_tieus)
DataClean_19$iss_usTies <- NA
DataClean_19$iss_usTies[DataRaw_19$pes19_tieus == 5] <- 0
DataClean_19$iss_usTies[DataRaw_19$pes19_tieus == 4] <- 0.25
DataClean_19$iss_usTies[DataRaw_19$pes19_tieus == 3] <- 0.5
DataClean_19$iss_usTies[DataRaw_19$pes19_tieus == 2] <- 0.75
DataClean_19$iss_usTies[DataRaw_19$pes19_tieus == 1] <- 1
table(DataClean_19$iss_usTies)

