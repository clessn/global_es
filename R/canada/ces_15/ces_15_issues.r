


# Issues ------------------------------------------------------------------



## Feel towards US ------------------------------------------------------

table(DataRaw_15$p_like_us)
DataClean_15$iss_feelUs <- NA
valid_indices <- DataRaw_15$p_like_us <= 100  # Logical vector for filtering
DataClean_15$iss_feelUs <- ifelse(valid_indices, DataRaw_15$p_like_us, NA)
table(DataClean_15$iss_feelUs)



## US-Can ties -------------------------------------------------------------

table(DataRaw_15$p_usties)
DataClean_15$iss_usTies <- NA
DataClean_15$iss_usTies[DataRaw_15$p_usties == 5] <- 0
DataClean_15$iss_usTies[DataRaw_15$p_usties == 4] <- 0.25
DataClean_15$iss_usTies[DataRaw_15$p_usties == 3] <- 0.5
DataClean_15$iss_usTies[DataRaw_15$p_usties == 2] <- 0.75
DataClean_15$iss_usTies[DataRaw_15$p_usties == 1] <- 1
table(DataClean_15$iss_usTies)
