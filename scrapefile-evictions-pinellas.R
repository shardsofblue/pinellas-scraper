# Scraper for the Pinellas Court online records database
# Based on a scraper built by Riin Aljas (aljasriin@gmail.com)
# Created by Roxanne Ready (rready@roxanneready.com)

## Use: Downloads basic case info for Eviction-related cases
# Data collected:
# Case Number	
# Citation Number	
# Style/Defendant Info	
# Filed/Location/Judicial Officer	
# Type	
# Charge(s)

## KIs: 
# 1. Only scrapes down one search level; does not click through each case for details.
# 2. No exception catching, making the unsupervised loop risky. (I ran the loop then ran each missed month manually.)
# 3. Requires user to provide a list of dates

## Useage notes:
# 1. Must have Java Development Environment installed. May require overriding Mac security settings at runtime via System Preferences::Security & Privacy::General::Run Anyway

#### Libaries Used ----
library(tidyverse) # Tidy functions
library(RSelenium) # Headless browser
library(XML)
library(rvest) # For extracting info from HTML
library(RCurl) # For extracting URL
library(janitor) # For cleaning up scraped data
#library(seleniumPipes) # For additional Selenium features
#library(tidytext)
#library(tidyr)
#library(stringr)


#### Initialize dataframes ----



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

# Store series of date ranges in one-month intervals 
dates_ls <- list(
                 list("01/01/2019", "01/31/2019"), # 2019
                 list("02/01/2019", "02/28/2019"),
                 list("03/01/2019", "03/31/2019"),
                 list("04/01/2019", "04/30/2019"),
                 list("05/01/2019", "05/31/2019"),
                 list("06/01/2019", "06/30/2019"),
                 list("07/01/2019", "07/31/2019"),
                 list("08/01/2019", "08/31/2019"),
                 list("09/01/2019", "09/30/2019"),
                 list("10/01/2019", "10/31/2019"),
                 list("11/01/2019", "11/30/2019"),
                 list("12/01/2019", "12/31/2019"),
                 list("01/01/2020", "01/31/2020"), # 2020
                 list("02/01/2020", "02/29/2020"),
                 list("03/01/2020", "03/31/2020"),
                 list("04/01/2020", "04/30/2020"),
                 list("05/01/2020", "05/31/2020")
                 )

#### Begin Scrape ----

# OUTER LOOP START ##############################################################################

counter = 1

for(i in dates_ls) {
  
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
  temp$sendKeysToElement(list(dates_ls[[counter]][[1]]))
  
  # Select Ending Date field
  temp <- remote_driver$findElement(using = "xpath",
                                    value = "/html/body/form/table[4]/tbody/tr/td/table/tbody/tr[6]/td[2]/table/tbody/tr/td/div/table/tbody/tr/td/table/tbody/tr[6]/td[2]/table/tbody/tr/td[3]/input")
  temp$clickElement()
  
  # Clear text field
  temp$clearElement()
  
  # Input ending date
  temp$sendKeysToElement(list(dates_ls[[counter]][[2]]))
  
  ## Case Types
  # Choose "Delinquent Tenant/Eviction" cases
  temp <- remote_driver$findElement(using = "xpath",
                                    value = "/html/body/form/table[4]/tbody/tr/td/table/tbody/tr[11]/td[2]/table/tbody/tr/td/div/table/tbody/tr/td/table/tbody/tr/td[2]/select/option[6]")
  
  # Check whether it's already selected (JavaScript)
  selected_status <- remote_driver$executeScript(
    "return document.querySelector('#selCaseTypeGroups > option:nth-child(6)').selected", 
    args = list("dummy")
  )
  
  # If not selected, click it
  if (!selected_status[[1]]){
    temp$clickElement()
  }
  
  ## Submit
  temp <- remote_driver$findElement(using = "xpath",
                                    value = "/html/body/form/table[4]/tbody/tr/td/table/tbody/tr[14]/td[2]/input[1]")
  temp$clickElement()
  
  Sys.sleep(15)
  
  ### LIST OF CASES RETURNED
  # Note: RVEST / XML use starts here
  
  ### View and Store Cases Returned
  # Start by collecting basic info w/o clicking through
  
  ## Store basic case info
  # Get page HTML source code (stores as list)
  pagehtml <- remote_driver$getPageSource()
  #pageurl <- remote_driver$getCurrentUrl()
  
  # Get table
  cases_df <- readHTMLTable(
    pagehtml[[1]], # Pull the html from the list
    which = 6) # Get the right table (the 6th one holds the info we need)
  
  # Clean up table (slightly)
  cases_df_clean <- as_tibble(cases_df) %>%
    drop_na() %>%
    row_to_names(1) %>%
    mutate_if(is.factor, as.character)
  
  if (counter < 10){
    counter_ch <- paste0("00", as.character(counter))
  } else if (counter < 100) {
    counter_ch <- paste0("0", as.character(counter))
  } else {
    counter_ch <- as.character(counter)
  }
  
  # Store the table in a CSV
  write.csv(cases_df_clean, paste0('data/by-month/eviction_cases_', counter_ch, '.csv'))
  
  # Increment the counter
  counter <- counter + 1
  
  ### Itterate over each case number on the web page
  
  ## Find how many rows there are
  case_count <- cases_df_clean %>%
    dplyr::summarise(n = n())
  
  ## Click each case
  c = 1
  while (c <= case_count) {
    
    temp <- remote_driver$findElement(using = "xpath",
                                      value = paste0("/html/body/table[4]/tbody/tr[", c+2, "]/td[1]/a"))
    temp$clickElement()
    
    ## Inside the case, pull useful data:
    # Addresses
    # Financial info (to pay, paid, balance)
    ## Download documents
    
    ## Download Documents
    
    # Get page HTML source code (stores as list)
    pagehtml <- remote_driver$getPageSource()
    
    # Click the first document
    # Goes to a page that includes all case "events"
    
    # Get page HTML source code (stores as list)
    pagehtml <- remote_driver$getPageSource()
    
    # Get all links on page
    all_links <- remote_driver$findElements(using = "tag name",
                                            value = "a") 
    
    getElementAttribute(all_links, 
                        'href')
    
    all_links$getElementAttribute('href')
    
    # for (i in all_links) {
    #   print(getElementAttribute(i, 'href'))
    # }
    
    
    # Store table of all avaliable documents
    # Doesn't recognize that some aren't links
    docs_df <- readHTMLTable(
      pagehtml[[1]], # Pull the html from the list
      which = 9) # Get the right table (the 9th one holds the info we need)
      
    # Clean up info
    docs_df_clean <- docs_df %>% 
      select(-V2, -V3) %>%
      filter(!(V1 == "Party:")) %>%
      rename("date_filed" = V1,
             "events_hearings_orders" = V4) %>%
      slice(-1) %>%
      mutate_if(is.factor, as.character)
    
    docs_df_clean %>% slice(1) %>%
      pull(events_hearings_orders)
    
    
    # Return to the search results page to click a new case
    temp <- remote_driver$findElement(using = "xpath",
                                      value = "/html/body/table[2]/tbody/tr/td/table/tbody/tr/td[1]/font/a[7]")
    temp$clickElement()
    
    # Increment the counter
    c <- c + 1
  }
  
  
  ### Return to the search start page to start again
  temp <- remote_driver$findElement(using = "xpath",
                                    value = "/html/body/table[2]/tbody/tr/td/table/tbody/tr/td[1]/font/a[6]")
  temp$clickElement()
  
  Sys.sleep(5)
}

# OUTER LOOP END ##############################################################################

## Combine CSVs into single file
# Read in all CSVs
all_cases <- list.files("data/by-month", 
           "*.csv",
           full.names=TRUE) %>%
  map_dfr(read_csv) %>%
  select(-'X1')

# Clean up the combined dataframe
all_cases_clean <- all_cases %>% 
  # Drop empty columns
  select(-`Citation Number`, -`Charge(s)`) %>%
  # Break out date/location/officer
  mutate(Date_Filed = str_sub(`Filed/Location/Judicial Officer`,1,10),
         Location = str_sub(`Filed/Location/Judicial Officer`,11,20),
         Judicial_Officer = str_sub(`Filed/Location/Judicial Officer`,21)
  ) %>%
  select(-`Filed/Location/Judicial Officer`) %>%
  # Make everything lowercase
  mutate_all(~tolower(.)) %>%
  rename_all(~tolower(.)) %>%
  # Split out plaintif / defendants
  separate(col = `style/defendant info`,
           into = c("plaintiff", "defendant"),
           sep = "vs\\."
  ) %>%
  # Strip newlines and carriage returns
  mutate_all(~str_replace_all(., "[\r\n]" , ""))

write.csv(all_cases_clean, "data/eviction_cases_jan2019_to_may2020.csv")

#### Cleanup ----
rD1$server$stop()


#### Sanity checks ----
all_cases_clean <- read_csv("data/eviction_cases_jan2019_to_may2020.csv")

all_cases_clean %>%
  select(-X1) %>%
  group_by(date_filed) %>%
  summarize(count = n()) %>%
  arrange(count)
