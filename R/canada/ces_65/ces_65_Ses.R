
# SES ---------------------------------------------------------------------


## language ----------------------------------------------------------------




table(Df_raw_65$v314)
Df_clean_65$ses_language <- NA
Df_clean_65$ses_language[Df_raw_65$v314 == "english"] <- 1
Df_clean_65$ses_language[Df_raw_65$v314 == "french"] <- 2
Df_clean_65$ses_language[ !(Df_raw_65$v314 %in% c("english","french"))] <- 3
table(Df_clean_65$ses_language)


## gender -------------------------------------------------------------------------


table(Df_raw_65$v337)
Df_clean_65$ses_gender <- NA
Df_clean_65$ses_gender[Df_raw_65$v337 == "male"] <- 1
Df_clean_65$ses_gender[Df_raw_65$v337 == "female"] <- 0
table(Df_clean_65$ses_gender)



## income ------------------------------------------------------------------


### income low --------------------------------------------------------------


table(Df_raw_65$v336)
Df_clean_65$ses_incomeLow <- NA
Df_clean_65$ses_incomeLow[Df_raw_65$v336 == "under $1,000" | Df_raw_65$v336 == "$1,000 to $1,999" | Df_raw_65$v336 == "$2,000 to $2,999" | Df_raw_65$v336=="$3,000 to $3,999"] <- 1
Df_clean_65$ses_incomeLow[Df_raw_65$v336 != "under $1,000" & Df_raw_65$v336 != "$1,000 to $1,999" & Df_raw_65$v336 != "$2,000 to $2,999" & Df_raw_65$v336!="$3,000 to $3,999"] <- 0
Df_clean_65$ses_incomeLow[Df_raw_65$v336 == "dk, refused"] <- NA
table(Df_clean_65$ses_incomeLow)


### income mid --------------------------------------------------------------


Df_clean_65$ses_incomeMid <- NA
Df_clean_65$ses_incomeMid[Df_raw_65$v336 == "$4,000 to $4,999" | Df_raw_65$v336 == "$5,000 to $5,999" | Df_raw_65$v336 == "$6,000 to $6,999" | Df_raw_65$v336 == "$7,000 to $7,999" | Df_raw_65$v336 == "$8,000 to $9,999"] <- 1
Df_clean_65$ses_incomeMid[Df_raw_65$v336 != "$4,000 to $4,999" & Df_raw_65$v336 != "$5,000 to $5,999" & Df_raw_65$v336 != "$6,000 to $6,999" & Df_raw_65$v336 != "$7,000 to $7,999" & Df_raw_65$v336 != "$8,000 to $9,999"] <- 0
Df_clean_65$ses_incomeMid[Df_raw_65$v336 == "dk, refused"] <- NA
table(Df_clean_65$ses_incomeMid)


### income high -------------------------------------------------------------


Df_clean_65$ses_incomeHigh <- NA
Df_clean_65$ses_incomeHigh[Df_raw_65$v336 == "$10,000 to $14,999" | Df_raw_65$v336 == "$15,000 or over"] <- 1
Df_clean_65$ses_incomeHigh[Df_raw_65$v336 != "$10,000 to $14,999" & Df_raw_65$v336 != "$15,000 or over"] <- 0
Df_clean_65$ses_incomeHigh[Df_raw_65$v336 == "dk, refused"] <- NA
table(Df_clean_65$ses_incomeHigh)


## marital status ----------------------------------------------------------


table(Df_raw_65$v304)
Df_clean_65$ses_matStatus <- NA
Df_clean_65$ses_matStatus[Df_raw_65$v304 == "single"] <- 1
Df_clean_65$ses_matStatus[Df_raw_65$v304 == "separated"] <- 2
Df_clean_65$ses_matStatus[Df_raw_65$v304 == "married"] <- 3
Df_clean_65$ses_matStatus[Df_raw_65$v304 == "divorced"] <- 4
Df_clean_65$ses_matStatus[Df_raw_65$v304 == "widowed"] <- 5
Df_clean_65$ses_matStatus[Df_raw_65$v304 == "not applicable"] <- NA
table(Df_clean_65$ses_matStatus)



## education ---------------------------------------------------------------


table(Df_raw_65$v307)


### education below hs ------------------------------------------------------


Df_clean_65$ses_educBHS <- NA
Df_clean_65$ses_educBHS[Df_raw_65$v307 < 12] <- 1
Df_clean_65$ses_educBHS[Df_raw_65$v307 > 12] <- 0
table(Df_clean_65$ses_educBHS)


### education hs ---------------------------------------------------


Df_clean_65$ses_educHS <- NA
Df_clean_65$ses_educHS[Df_raw_65$v307==12 | Df_raw_65$v307==13] <- 1
Df_clean_65$ses_educHS[Df_raw_65$v307!=12 & Df_raw_65$v307!=13] <- 0
table(Df_clean_65$ses_educHS)


# education more hs -------------------------------------------------------


Df_clean_65$ses_educUniv <- NA
Df_clean_65$ses_educUniv[Df_raw_65$v307>13] <- 1
Df_clean_65$ses_educUniv[Df_raw_65$v307<13] <- 0
table(Df_clean_65$ses_educUniv)

## age ---------------------------------------------------------------------


table(Df_raw_65$v335)
Df_clean_65$ses_age <- Df_raw_65$v335
Df_clean_65$ses_age[Df_clean_65$ses_age==99] <- NA


### age 34 & lower ----------------------------------------------------------


Df_clean_65$ses_age34m <- NA
Df_clean_65$ses_age34m[Df_clean_65$ses_age<35] <- 1
Df_clean_65$ses_age34m[Df_clean_65$ses_age>=35] <- 0
table(Df_clean_65$ses_age34m)


### age 35 to 55 ---------------------------------------------------------------


Df_clean_65$ses_age35p54 <- NA
Df_clean_65$ses_age35p54[Df_clean_65$ses_age>=35 & Df_clean_65$ses_age<55] <- 1
Df_clean_65$ses_age35p54[Df_clean_65$ses_age<35 | Df_clean_65$ses_age>=55] <- 0
table(Df_clean_65$ses_age35p54)



### age 55 & higher ---------------------------------------------------------


Df_clean_65$ses_age55p <- NA
Df_clean_65$ses_age55p[Df_clean_65$ses_age>=55] <- 1
Df_clean_65$ses_age55p[Df_clean_65$ses_age<55] <- 0
table(Df_clean_65$ses_age55p)

