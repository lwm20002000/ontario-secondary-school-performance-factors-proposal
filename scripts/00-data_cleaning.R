#### Preamble ####
# Purpose: Get and clean data on school info and student demographics from Ontario's Data Catalogue
# Author: Najma Osman
# Date: 2 February 2021
# Contact: naj.osman@mail.utoronto.ca / najmamosman@gmail.com
# License: MIT
# Pre-requisites: None



#### setup ####
library(here)
library(janitor)
library(tidyverse)
library(readxl)
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

# reduced data; #
  # removing rows associated with:
    # * containing elementary schools,
    # * containing schools where the language is French, as they have different tests which are covered in a separate dataset,
    # * having codes NA, NR, or ND in columns to do with Grade 9 EQAO and/or the Grade 10 literacy test (OSSLT),
    # * containing code SP in columns to do with household income and/or percentage of students whose parents have some university education.

filter_data <-
  cleaned_data %>%
  filter(school_level == "Secondary", school_language == "English") %>%
  filter(percentage_of_students_whose_parents_have_some_university_education != "SP", 
         percentage_of_school_aged_children_who_live_in_low_income_households != "SP") %>%
  filter(change_in_grade_9_academic_mathematics_achievement_over_three_years != "NA", 
         change_in_grade_9_academic_mathematics_achievement_over_three_years != "N/R", 
         change_in_grade_9_academic_mathematics_achievement_over_three_years != "N/D") %>%
  filter(change_in_grade_10_osslt_literacy_achievement_over_three_years != "NA", 
         change_in_grade_10_osslt_literacy_achievement_over_three_years != "N/R", 
         change_in_grade_10_osslt_literacy_achievement_over_three_years != "N/D")
  

  # remove the following columns/select all the others (probably easier): 
      #  * location information: board number, board name, board type, school number, building suite, P.O. Box, Street, postal code, province, latitude, longitude,
      # * school info: school type, school special condition code (e.g., Alternative, Adult, NA), grade range, enrolment, school language,
      # * contact information: phone number, fax number, school website, board website
      # * testing information: grade 3 and 6 results (EQAO, achievement of provincial standard (percentage of student and change over 3 years))

=

#### save cleaned/reduced data set ####