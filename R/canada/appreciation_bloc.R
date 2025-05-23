df <- data.frame(
  year = c(1993, 1997, 2000, 2004, 2006, 2008, 2011, 2015, 2019, 2021),
  feel = c(
    # For each dataset, filter values between 0 and 100 before calculating mean
    mean(subset(readRDS("_SharedFolder_global_es/data/canada/raw/data_ces_1993_raw.rds")$REFH10, 
                readRDS("_SharedFolder_global_es/data/canada/raw/data_ces_1993_raw.rds")$REFH10 >= 0 & 
                readRDS("_SharedFolder_global_es/data/canada/raw/data_ces_1993_raw.rds")$REFH10 <= 100), na.rm = TRUE),
    
    mean(subset(readRDS("_SharedFolder_global_es/data/canada/raw/data_ces_1997_raw.rds")$cpsd1e,
                readRDS("_SharedFolder_global_es/data/canada/raw/data_ces_1997_raw.rds")$cpsd1e >= 0 & 
                readRDS("_SharedFolder_global_es/data/canada/raw/data_ces_1997_raw.rds")$cpsd1e <= 100), na.rm = TRUE),
    
    mean(subset(readRDS("_SharedFolder_global_es/data/canada/raw/data_ces_2000_raw.rds")$cpsducep,
                readRDS("_SharedFolder_global_es/data/canada/raw/data_ces_2000_raw.rds")$cpsducep >= 0 & 
                readRDS("_SharedFolder_global_es/data/canada/raw/data_ces_2000_raw.rds")$cpsducep <= 100), na.rm = TRUE),
    
    mean(subset(readRDS("_SharedFolder_global_es/data/canada/raw/data_ces_2004_raw.rds")$cps_g4,
                readRDS("_SharedFolder_global_es/data/canada/raw/data_ces_2004_raw.rds")$cps_g4 >= 0 & 
                readRDS("_SharedFolder_global_es/data/canada/raw/data_ces_2004_raw.rds")$cps_g4 <= 100), na.rm = TRUE),
    
    mean(subset(readRDS("_SharedFolder_global_es/data/canada/raw/data_ces_2006_raw.rds")$cps_g4,
                readRDS("_SharedFolder_global_es/data/canada/raw/data_ces_2006_raw.rds")$cps_g4 >= 0 & 
                readRDS("_SharedFolder_global_es/data/canada/raw/data_ces_2006_raw.rds")$cps_g4 <= 100), na.rm = TRUE),
    
    mean(subset(readRDS("_SharedFolder_global_es/data/canada/raw/data_ces_2008_raw.rds")$ces08_CPS_G4,
                readRDS("_SharedFolder_global_es/data/canada/raw/data_ces_2008_raw.rds")$ces08_CPS_G4 >= 0 & 
                readRDS("_SharedFolder_global_es/data/canada/raw/data_ces_2008_raw.rds")$ces08_CPS_G4 <= 100), na.rm = TRUE),
    
    mean(subset(readRDS("_SharedFolder_global_es/data/canada/raw/data_ces_2011_raw.rds")$CPS11_26,
                readRDS("_SharedFolder_global_es/data/canada/raw/data_ces_2011_raw.rds")$CPS11_26 >= 0 & 
                readRDS("_SharedFolder_global_es/data/canada/raw/data_ces_2011_raw.rds")$CPS11_26 <= 100), na.rm = TRUE),
    
    mean(subset(readRDS("_SharedFolder_global_es/data/canada/raw/data_ces_2015_raw.rds")$ldrfeel_ducp,
                readRDS("_SharedFolder_global_es/data/canada/raw/data_ces_2015_raw.rds")$ldrfeel_ducp >= 0 & 
                readRDS("_SharedFolder_global_es/data/canada/raw/data_ces_2015_raw.rds")$ldrfeel_ducp <= 100), na.rm = TRUE),
    
    # Special operation for 2019 - combining two variables
    {
      # First variable - normal 0-100 range
      data_2019 <- readRDS("_SharedFolder_global_es/data/canada/raw/data_ces_2019_raw.rds")
      var1 <- subset(data_2019$cps19_lead_rating_26, 
                   data_2019$cps19_lead_rating_26 >= 0 & 
                   data_2019$cps19_lead_rating_26 <= 100)
      
      # Second variable - scale from 0-10 to 0-100
      var2 <- subset(data_2019$pes19_lead_rate_11 * 10,
                   data_2019$pes19_lead_rate_11 >= 0 & 
                   data_2019$pes19_lead_rate_11 <= 10)
      
      # Combine both and calculate mean
      mean(c(var1, var2), na.rm = TRUE)
    },
    
    mean(subset(readRDS("_SharedFolder_global_es/data/canada/raw/data_ces_2021_raw.rds")$cps21_lead_rating_26,
                readRDS("_SharedFolder_global_es/data/canada/raw/data_ces_2021_raw.rds")$cps21_lead_rating_26 >= 0 & 
                readRDS("_SharedFolder_global_es/data/canada/raw/data_ces_2021_raw.rds")$cps21_lead_rating_26 <= 100), na.rm = TRUE)
  )
)

saveRDS(df, "~/Projects/datagotchi_2025_rapports/data/bloc.rds")
