


# Issues ------------------------------------------------------------------



## Feel towards US ------------------------------------------------------

table(DataRaw_08$ces08_PES_C8)
DataClean_08$iss_feelUs <- NA
valid_indices <- DataRaw_08$ces08_PES_C8 <= 100  # Logical vector for filtering
DataClean_08$iss_feelUs <- ifelse(valid_indices, DataRaw_08$ces08_PES_C8, NA)
table(DataClean_08$iss_feelUs)



## US-Can ties -------------------------------------------------------------

table(DataRaw_08$ces08_PES_F8)
DataClean_08$iss_usTies <- NA
DataClean_08$iss_usTies[DataRaw_08$ces08_PES_F8 == 5] <- 0
DataClean_08$iss_usTies[DataRaw_08$ces08_PES_F8 == 4] <- 0.25
DataClean_08$iss_usTies[DataRaw_08$ces08_PES_F8 == 3] <- 0.5
DataClean_08$iss_usTies[DataRaw_08$ces08_PES_F8 == 2] <- 0.75
DataClean_08$iss_usTies[DataRaw_08$ces08_PES_F8 == 1] <- 1
table(DataClean_08$iss_usTies)
