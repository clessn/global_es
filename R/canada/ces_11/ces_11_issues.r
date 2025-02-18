


# Issues ------------------------------------------------------------------



## Feel towards US ------------------------------------------------------

table(DataRaw_11$PES11_12)
DataClean_11$iss_feelUs <- NA
valid_indices <- DataRaw_11$PES11_12 <= 100  # Logical vector for filtering
DataClean_11$iss_feelUs <- ifelse(valid_indices, DataRaw_11$PES11_12, NA)
table(DataClean_11$iss_feelUs)



## US-Can ties -------------------------------------------------------------

table(DataRaw_11$PES11_45)
DataClean_11$iss_usTies <- NA
DataClean_11$iss_usTies[DataRaw_11$PES11_45 == 5] <- 0
DataClean_11$iss_usTies[DataRaw_11$PES11_45 == 4] <- 0.25
DataClean_11$iss_usTies[DataRaw_11$PES11_45 == 3] <- 0.5
DataClean_11$iss_usTies[DataRaw_11$PES11_45 == 2] <- 0.75
DataClean_11$iss_usTies[DataRaw_11$PES11_45 == 1] <- 1
table(DataClean_11$iss_usTies)
