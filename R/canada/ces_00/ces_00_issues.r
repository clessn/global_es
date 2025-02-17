


# Issues ------------------------------------------------------------------



## Feel towards US ------------------------------------------------------

table(DataRaw_00$pesc2e)
DataClean_00$iss_feelUs <- NA
valid_indices <- DataRaw_00$pesc2e <= 100  # Logical vector for filtering
DataClean_00$iss_feelUs <- ifelse(valid_indices, DataRaw_00$pesc2e, NA)
table(DataClean_00$iss_feelUs)



## US-Can ties -------------------------------------------------------------

table(DataRaw_00$pesd4)
DataClean_00$iss_usTies <- NA
DataClean_00$iss_usTies[DataRaw_00$pesd4 == 5] <- 0
DataClean_00$iss_usTies[DataRaw_00$pesd4 == 4] <- 0.25
DataClean_00$iss_usTies[DataRaw_00$pesd4 == 3] <- 0.5
DataClean_00$iss_usTies[DataRaw_00$pesd4 == 2] <- 0.75
DataClean_00$iss_usTies[DataRaw_00$pesd4 == 1] <- 1
table(DataClean_00$iss_usTies)
