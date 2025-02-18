
# Issues ------------------------------------------------------------------



## Feel towards US ------------------------------------------------------

table(DataRaw_04$pes_c3b)
DataClean_04$iss_feelUs <- NA
valid_indices <- DataRaw_04$pes_c3b <= 100  # Logical vector for filtering
DataClean_04$iss_feelUs <- ifelse(valid_indices, DataRaw_04$pes_c3b, NA)
table(DataClean_04$iss_feelUs)



## US-Can ties -------------------------------------------------------------
  ### Aussi la possibilité de répondre : r volunteers: haven't thought much about this ######

table(DataRaw_04$cps_f10)
DataClean_04$iss_usTies <- NA
DataClean_04$iss_usTies[DataRaw_04$cps_f10 == 5] <- 0
DataClean_04$iss_usTies[DataRaw_04$cps_f10 == 4] <- 0.25
DataClean_04$iss_usTies[DataRaw_04$cps_f10 == 3] <- 0.5
DataClean_04$iss_usTies[DataRaw_04$cps_f10 == 2] <- 0.75
DataClean_04$iss_usTies[DataRaw_04$cps_f10 == 1] <- 1
table(DataClean_04$iss_usTies)

