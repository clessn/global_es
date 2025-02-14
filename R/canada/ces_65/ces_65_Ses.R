
# SES ---------------------------------------------------------------------


## language ----------------------------------------------------------------




table(DataRaw_65$v314)
DataClean_65$ses_language <- NA
DataClean_65$ses_language[DataRaw_65$v314 == "english"] <- 1
DataClean_65$ses_language[DataRaw_65$v314 == "french"] <- 2
DataClean_65$ses_language[ !(DataRaw_65$v314 %in% c("english","french"))] <- 3
table(DataClean_65$ses_language)


## gender -------------------------------------------------------------------------


table(DataRaw_65$)




## income ------------------------------------------------------------------


table(DataRaw_65$v336)
DataClean_65$ses_income <- NA
DataClean_65$ses_income[DataRaw_65$v336 == "under $1,000"] <- "under_1000"
DataClean_65$ses_income[DataRaw_65$v336 == 2] <- "1_to_30000"
DataClean_65$ses_income[DataRaw_65$v336 == 3] <- "30001_to_60000"
DataClean_65$ses_income[DataRaw_65$v336 == 4] <- "60001_to_90000"
DataClean_65$ses_income[DataRaw_65$v336 == 5] <- "90001_to_110000"
DataClean_65$ses_income[DataRaw_65$v336 == 6] <- "110001_to_150000"
DataClean_65$ses_income[DataRaw_65$v336 == 7] <- "150001_to_200000"
DataClean_65$ses_income[DataRaw_65$v336 == 8] <- "more_than_200000"
DataClean_65$ses_income <- factor(DataClean_65$ses_income, levels = c("no_income",
                                                                  "1_to_30000",
                                                                  "30001_to_60000",
                                                                  "60001_to_90000",
                                                                  "90001_to_110000",
                                                                  "110001_to_150000",
                                                                  "150001_to_200000",
                                                                  "more_than_200000"))


### income low --------------------------------------------------------------


table(DataRaw_65$v336)
DataClean_65$ses_incomeLow <- NA
DataClean_65$ses_incomeLow[DataRaw_65$v336 == "under $1,000" | DataRaw_65$v336 == "$1,000 to $1,999" | DataRaw_65$v336 == "$2,000 to $2,999" | DataRaw_65$v336=="$3,000 to $3,999"] <- 1
DataClean_65$ses_incomeLow[DataRaw_65$v336 != "under $1,000" & DataRaw_65$v336 != "$1,000 to $1,999" & DataRaw_65$v336 != "$2,000 to $2,999" & DataRaw_65$v336!="$3,000 to $3,999"] <- 0
DataClean_65$ses_incomeLow[DataRaw_65$v336 == "dk, refused"] <- NA
table(DataClean_65$ses_incomeLow)


### income mid --------------------------------------------------------------


DataClean_65$ses_incomeMid <- NA
DataClean_65$ses_incomeMid[DataRaw_65$v336 == "$4,000 to $4,999" | DataRaw_65$v336 == "$5,000 to $5,999" | DataRaw_65$v336 == "$6,000 to $6,999" | DataRaw_65$v336 == "$7,000 to $7,999" | DataRaw_65$v336 == "$8,000 to $9,999"] <- 1
DataClean_65$ses_incomeMid[DataRaw_65$v336 != "$4,000 to $4,999" & DataRaw_65$v336 != "$5,000 to $5,999" & DataRaw_65$v336 != "$6,000 to $6,999" & DataRaw_65$v336 != "$7,000 to $7,999" & DataRaw_65$v336 != "$8,000 to $9,999"] <- 0
DataClean_65$ses_incomeMid[DataRaw_65$v336 == "dk, refused"] <- NA
table(DataClean_65$ses_incomeMid)


### income high -------------------------------------------------------------


DataClean_65$ses_incomeHigh <- NA
DataClean_65$ses_incomeHigh[DataRaw_65$v336 == "$10,000 to $14,999" | DataRaw_65$v336 == "$15,000 or over"] <- 1
DataClean_65$ses_incomeHigh[DataRaw_65$v336 != "$10,000 to $14,999" & DataRaw_65$v336 != "$15,000 or over"] <- 0
DataClean_65$ses_incomeHigh[DataRaw_65$v336 == "dk, refused"] <- NA
table(DataClean_65$ses_incomeHigh)


## marital status ----------------------------------------------------------


table(DataRaw_65$v304)
DataClean_65$ses_matStatus <- NA
DataClean_65$ses_matStatus[DataRaw_65$v304 == "single"] <- 1
DataClean_65$ses_matStatus[DataRaw_65$v304 == "separated"] <- 2
DataClean_65$ses_matStatus[DataRaw_65$v304 == "married"] <- 3
DataClean_65$ses_matStatus[DataRaw_65$v304 == "divorced"] <- 4
DataClean_65$ses_matStatus[DataRaw_65$v304 == "widowed"] <- 5
DataClean_65$ses_matStatus[DataRaw_65$v304 == "not applicable"] <- NA
table(DataClean_65$ses_matStatus)



## education ---------------------------------------------------------------


table(DataRaw_65$v307)


### education below hs ------------------------------------------------------


DataClean_65$ses_educBHS <- NA
DataClean_65$ses_educBHS[DataRaw_65$v307 < 12] <- 1
DataClean_65$ses_educBHS[DataRaw_65$v307 > 12] <- 0
table(DataClean_65$ses_educBHS)


### education hs ---------------------------------------------------


DataClean_65$ses_educHS <- NA
DataClean_65$ses_educHS[DataRaw_65$v307==12 | DataRaw_65$v307==13] <- 1
DataClean_65$ses_educHS[DataRaw_65$v307!=12 & DataRaw_65$v307!=13] <- 0
table(DataClean_65$ses_educHS)


# education more hs -------------------------------------------------------


DataClean_65$ses_educUniv <- NA
DataClean_65$ses_educUniv[DataRaw_65$v307>13] <- 1
DataClean_65$ses_educUniv[DataRaw_65$v307<13] <- 0
table(DataClean_65$ses_educUniv)

## age ---------------------------------------------------------------------


table(DataRaw_65$v335)
DataClean_65$ses_age <- DataRaw_65$v335
DataClean_65$ses_age[DataClean_65$ses_age==99] <- NA


### age 34 & lower ----------------------------------------------------------


DataClean_65$ses_age34m <- NA
DataClean_65$ses_age34m[DataClean_65$ses_age<35] <- 1
DataClean_65$ses_age34m[DataClean_65$ses_age>=35] <- 0
table(DataClean_65$ses_age34m)


### age 35 to 55 ---------------------------------------------------------------


DataClean_65$ses_age35p54 <- NA
DataClean_65$ses_age35p54[DataClean_65$ses_age>=35 & DataClean_65$ses_age<55] <- 1
DataClean_65$ses_age35p54[DataClean_65$ses_age<35 | DataClean_65$ses_age>=55] <- 0
table(DataClean_65$ses_age35p54)



### age 55 & higher ---------------------------------------------------------


DataClean_65$ses_age55p <- NA
DataClean_65$ses_age55p[DataClean_65$ses_age>=55] <- 1
DataClean_65$ses_age55p[DataClean_65$ses_age<55] <- 0
table(DataClean_65$ses_age55p)



## religiosity -------------------------------------------------------------

table(DataRaw_65$v310)
Data_clean_65$ses_religosity <- NA

