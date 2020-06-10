# Scraper for the Pinellas Court online records database
# Based on a scraper built by Riin Aljas (aljasriin@gmail.com)
# Created by Roxanne Ready (rready@roxanneready.com)

## Useage notes:
# 1. Must have Java Development Environment installed. May require overriding Mac security settings at runtime via System Preferences::Security & Privacy::General::Run Anyway
# 2. Requires a list of case numbers.

#### Libaries Used ----
library(tidyverse) # Tidy functions
library(RSelenium) # Headless browser
#library(rvest)
#library(tidytext)
#library(tidyr)
#library(stringr)


#### Initialize dataframes ----

evictions_cases_df <- tibble(
  case_num = numeric(), 
  case_type = character()
)

#### Set up Headless Browser ----

### Initialize at court webpage and log in

## Activate Headless Driver
# Create and initialize driver
rD1 <- rsDriver(browser = c("chrome"), 
                port = 4960L, 
                # To find Chrome ver. num., use binman::list_versions("chromedriver"); try multiple
                chromever = "83.0.4103.39")

remote_driver <- rD1[["client"]] 

# Send to webpage
myurl <- remote_driver$navigate(
  "https://ccmspa.pinellascounty.org/PublicAccess/default.aspx")

## Log in
# Locate and click the Registered User log-in
temp <- remote_driver$findElement(using = "xpath",
                                  value ="/html/body/table/tbody/tr[2]/td/table/tbody/tr[1]/td[2]/a[8]")
temp$clickElement()

# Enter username
temp <- remote_driver$findElement(using = "xpath",
                                  value = "/html/body/form/table/tbody/tr[2]/td/table/tbody/tr[1]/td[2]/table/tbody/tr[1]/td/input")
temp$clickElement()
temp$sendKeysToElement(list("REG01506"))

# Enter password
temp <- remote_driver$findElement(using = "xpath",
                                  value = "/html/body/form/table/tbody/tr[2]/td/table/tbody/tr[1]/td[2]/table/tbody/tr[3]/td/input")
temp$clickElement
temp$sendKeysToElement(list("9ZbdYbpxPt8"))

# Click submit
temp <- remote_driver$findElement(using = "xpath",
                                  value = "/html/body/form/table/tbody/tr[2]/td/table/tbody/tr[1]/td[2]/table/tbody/tr[6]/td/input")
temp$clickElement()

## Enter court case search
# Enter "All Case Records" search
temp <- remote_driver$findElement(using = "xpath",
                                  value = "/html/body/table/tbody/tr[2]/td/table/tbody/tr[1]/td[2]/a[1]")
temp$clickElement()

#### Begin Scrape ----

# Store series of date ranges in 7-day intervals 
dates_ls <- list(list("01/01/2020", "01/07/2020"), list("01/08/2020", "01/14/2020"))
#dates_ls[[1]][[1]]

# Set search use "Date Filed" 
temp <- remote_driver$findElement(using = "id",
                                  value = "DateFiled")
temp$clickElement()

### Enter search criteria

## Dates
# Select Starting Date field
temp <- remote_driver$findElement(using = "xpath",
                                  value = "/html/body/form/table[4]/tbody/tr/td/table/tbody/tr[6]/td[2]/table/tbody/tr/td/div/table/tbody/tr/td/table/tbody/tr[6]/td[2]/table/tbody/tr/td[1]/input")
temp$clickElement()

# Clear text field
temp$clearElement()

# Input starting date
temp$sendKeysToElement(list(dates_ls[[1]][[1]]))

# Select Ending Date field
temp <- remote_driver$findElement(using = "xpath",
                                  value = "/html/body/form/table[4]/tbody/tr/td/table/tbody/tr[6]/td[2]/table/tbody/tr/td/div/table/tbody/tr/td/table/tbody/tr[6]/td[2]/table/tbody/tr/td[3]/input")
temp$clickElement()

# Clear text field
temp$clearElement()

# Input ending date
temp$sendKeysToElement(list(dates_ls[[1]][[2]]))

## Case Types
# Choose "County Civil" cases
temp <- remote_driver$findElement(using = "xpath",
                                  value = "/html/body/form/table[4]/tbody/tr/td/table/tbody/tr[11]/td[2]/table/tbody/tr/td/div/table/tbody/tr/td/table/tbody/tr/td[2]/select/option[6]")
temp$clickElement()

## Submit
temp <- remote_driver$findElement(using = "xpath",
                                  value = "/html/body/form/table[4]/tbody/tr/td/table/tbody/tr[14]/td[2]/input[1]")
temp$clickElement()

### View Cases of Interest

## Store case numbers pulled

# Find how many cases on the page
temp <- remote_driver$findElements(using = "xpath",
                                       value = "/html/body/table[4]/tbody/tr")
templen <- length(temp) - 2 # Records start at row 3
print(paste0(as.character(templen), " records found."))

# For each row in table on page
# Store contents of td[1] in evictions_cases_df$case_num
# Store contencts of td[?] in evictions_cases_df$case_type

#### Cleanup ----
rD1$server$stop()
