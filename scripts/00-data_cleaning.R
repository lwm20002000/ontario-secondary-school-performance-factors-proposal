#### Preamble ####
# Purpose: Get and clean data on school info and student demographics from Ontario's Data Catalogue
# Author: Najma Osman
# Date: 26 January 2021
# Contact: naj.osman@mail.utoronto.ca / najmamosman@gmail.com
# License: MIT
# Pre-requisites: None



#### setup ####
library(here)
library(janitor)
library(tidyverse)
library(curl)

#### get and read in raw data #### 
  # Data from Ontario Data Catalogue (https://data.ontario.ca/dataset/school-information-and-student-demographics) #

url <- 
  "https://data.ontario.ca/dataset/d85f68c5-fcb0-4b4d-aec5-3047db47dcd5/resource/602a5186-67f5-4faf-94f3-7c61ffc4719a/download/new_sif_data_table_2018_2019prelim_en_december.xlsx"
destfile <- 
  "inputs/data/new_sif_data_table_2018_2019prelim_en_december.xlsx"
curl::curl_download(url, destfile)
# read into R
raw_data <- 
  read_excel(destfile)

#### data cleaning ####

# clean row names #

cleaned_data <- 
  janitor::clean_names(raw_data)

# save cleaned data set #


#### reduced data; #### 
# removing rows associated with


# remove the following columns: 
  # - school number, building suite, P.O. Box, Street, postal code
  # - phone number, fax number, school website, board website
  # - extract date


#### save reduced data set ####

