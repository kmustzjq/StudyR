rm(list = ls())
gc()
setwd("D:/data_Engineer/Angela/BMWW")

library(readxl)
library(dplyr,warn.conflicts = F)
library(lubridate, warn.conflicts = FALSE)
library(tidyr)

MG08_Modeling_study_by_block_data_old <- read_excel("MG08 Modeling study by block data.xlsx", 
                                                    col_types = c("text", "text", "numeric", 
                                                                  "skip", "text", "numeric", "numeric", 
                                                                  "numeric", "numeric", "numeric", 
                                                                  "numeric", "numeric", "numeric", 
                                                                  "numeric", "numeric", "numeric", 
                                                                  "numeric", "numeric", "numeric", 
                                                                  "numeric", "numeric", "numeric", 
                                                                  "numeric", "numeric", "numeric", 
                                                                  "numeric", "numeric", "numeric", 
                                                                  "numeric", "numeric", "skip", "numeric", 
                                                                  "text", "text"), skip = 1)


MG08_Modeling_study_by_block_data <-  MG08_Modeling_study_by_block_data_old %>% drop_na(SS1_Y_DATE_TIME) %>% 
  mutate(SS1_Y_DATE_TIME = gsub("T", " ",SS1_Y_DATE_TIME),
         SS1_Y_DATE_TIME = as_datetime(SS1_Y_DATE_TIME,format='%Y-%m-%d %H:%M'),
         SS1_Date_numeric = as.numeric(as.POSIXct(strptime(SS1_Y_DATE_TIME, "%Y-%m-%d %H:%M"))),
         # delta_SS1_Date = SS1_Date_numeric - median(SS1_Date_numeric),
         Week_day = wday(SS1_Y_DATE_TIME,label = T),
         # year = year(SS1_Y_DATE_TIME),
         # month = month(SS1_Y_DATE_TIME),
         # day = day(SS1_Y_DATE_TIME),
         Block = as.factor(substr(`WAFER&Blk`,7,7)),
         TL_BMWW_Machine = as.factor(substr(`TL_BMWW_M/C`,1,6))
  ) %>% filter(TL_MWW_DP_RO_MEAN>=5 & TL_MWW_DP_RO_MEAN<=25) %>% 
  # mutate(TL_MWW_DP_RO_MEAN = (TL_MWW_DP_RO_MEAN-5)/20) %>% 
  na.omit()
train_tbl <- MG08_Modeling_study_by_block_data %>% select(SS1_Y_DATE_TIME, TL_MWW_DP_RO_MEAN) %>%
  rename(date  = SS1_Y_DATE_TIME,
         value = TL_MWW_DP_RO_MEAN)

library(ggplot2)
train_tbl %>%
  ggplot(aes(x = date, y = value)) +
  geom_point(col="blue")



library(recipes)
library(timetk)
recipe_spec_timeseries <- recipe(value ~ ., data = train_tbl) %>%
  step_timeseries_signature(date)

train_tbl1 <- bake(prep(recipe_spec_timeseries), new_data = train_tbl)
train_tbl1 %>%
  ggplot(aes(x = date, y = value,col=date_half)) +
  geom_point()


write.csv(train_tbl1,file = "csv/train_tbl1.csv",row.names = F,na="")
