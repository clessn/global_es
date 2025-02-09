# gender
table(Df_raw$cpsgend)
Df_clean$ses_gender <- NA
Df_clean$ses_gender[Df_raw$cpsgend == 1] <- 1
Df_clean$ses_gender[Df_raw$cpsgend == 2] <- 0
table(Df_clean$ses_gender)

