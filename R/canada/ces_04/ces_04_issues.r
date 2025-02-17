
# Issues ------------------------------------------------------------------



## Feel towards US ------------------------------------------------------

table(DataRaw_04$ces04_pes_c3b)
DataClean_04$iss_feelUs <- NA
valid_indices <- DataRaw_04$ces04_pes_c3b <= 100  # Logical vector for filtering
DataClean_04$iss_feelUs <- ifelse(valid_indices, DataRaw_04$ces04_pes_c3b, NA)
table(DataClean_04$iss_feelUs)



## US-Can ties -------------------------------------------------------------
  ### Aussi la possibilité de répondre : r volunteers: haven't thought much about this ######

table(DataRaw_04$ces04_cps_f10)
DataClean_04$iss_usTies <- NA
DataClean_04$iss_usTies[DataRaw_04$ces04_cps_f10 == "much more distant"] <- 0
DataClean_04$iss_usTies[DataRaw_04$ces04_cps_f10 == "more distant"] <- 0.25
DataClean_04$iss_usTies[DataRaw_04$ces04_cps_f10 == "about the same as now"] <- 0.5
DataClean_04$iss_usTies[DataRaw_04$ces04_cps_f10 == "somewhat closer"] <- 0.75
DataClean_04$iss_usTies[DataRaw_04$ces04_cps_f10 == "much closer"] <- 1
table(DataClean_04$iss_usTies)

