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

## Useage notes:
# 1. Must have Java Development Environment installed. May require overriding Mac security settings at runtime via System Preferences::Security & Privacy::General::Run Anyway
# 2. Requires a hard-coded list of dates

#### Libaries Used ----
library(tidyverse) # Tidy functions
library(RSelenium) # Headless browser
library(XML) # For extracting info from HTML
library(rvest) # For extracting info from HTML
library(RCurl) # For extracting URL
library(janitor) # For cleaning up scraped data
library(reticulate) # For injecting Python
# library(httr) # For executing file downloads
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

# rD2 <- rsDriver(browser = c("firefox"))

remote_driver <- rD1[["client"]]
# remote_driver <- rD2[["client"]]

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
    
    
    # If there are "Other events and Hearings"
    if (str_detect(pagehtml, "OTHER EVENTS AND HEARINGS") == TRUE) {
      
      # Store table of all avaliable documents, mainly for number of rows to check
      # KI: Doesn't recognize that some aren't links
      docs_df <- readHTMLTable(
        pagehtml[[1]], # Pull the html from the list
        which = 9) # Get the right table (the 9th one holds the info we need)
      
      # Look for a clickable document link
      for (i in 1:nrow(docs_df)) {
        # Try to collect an element into a list
        temp <- remote_driver$findElements(using = "xpath",
                                           value = paste0("/html/body/table[5]/tbody/tr[", i, "]/td[3]/b/a"))
        # If the list length is greater than 0, it worked
        if(length(temp) > 0) {
          print(paste0("Link found at row ", i))
          # Assign the link to temp to click
          temp <- remote_driver$findElement(using = "xpath",
                                             value = paste0("/html/body/table[5]/tbody/tr[", i, "]/td[3]/b/a"))
          # Break the for loop; we only need to click one doc to see all available
          break
        } else {
          print(paste0("No link found in row ", i))
        }
      }
      # Click through
      temp$clickElement()
      
      ## Click on each image in the case
      
      # Get page URL (we'll need it later)
      pageurl <- remote_driver$getCurrentUrl()
      
      # Get page HTML source code (stores as list)
      pagehtml <- remote_driver$getPageSource()
      # Read in html as nodes
      nodes <- read_html(pagehtml[[1]])
      
      # First, click the "Selected Event" document
      # This will download into the computer's default downloads folder
      # KIs: 
      # Usually clicking the link will open a new window where the file will have to be downloaded from, but sometimes it will just download it immediately without opening that window.
      # Cannot be solved with right-click -> "download linked file" because it's not a direct link; the server uses aspx to find the file.
      temp <- remote_driver$findElement(using = "xpath",
                                        value = "/html/body/table[3]/tbody/tr[2]/td[2]/a")
      temp$clickElement()
      
      # Now move on to "Other Events" (and later, "Other Images")
      # Check for rows with td; empty tables have ths but no tds
      temp <- remote_driver$findElements(using = "xpath",
                                         value = "/html/body/table[4]/tbody/tr[2]/td[1]")
      if (length(temp) > 0 ) {
        print("Files found.")
        
        # Get all rows 
        docs <- nodes %>% 
          html_node('table:nth-child(8)') %>% 
          html_table(fill = T)
        
        # For each row (starting at row 2)...
        for (i in 2:nrow(docs)){
          # Check the item is clickable...
          temp <- remote_driver$findElements(using = "xpath",
                                             value = paste0("/html/body/table[4]/tbody/tr[", i, "]/td[2]/a"))
          if(length(temp) > 0){
            # If it's clickable, choose it...
            temp <- remote_driver$findElement(using = "xpath",
                                              value = paste0("/html/body/table[4]/tbody/tr[", i, "]/td[2]/a"))
            ## Use HTTR
            # httr::GET( # setup cookies & session
            #   url = pageurl[[1]],
            #   httr::user_agent("Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/51.0.2704.103 Safari/537.36"),
            #   httr::accept("text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8"),
            #   verbose() # remove when done monitoring 
            # ) -> res 
            # 
            # pg <- httr::content(res)
            # html_nodes(pg, xpath="/html/body/table[4]/tbody/tr[2]/td[2]/a") %>% 
            #   html_attr("href") -> dl_url
            
            # And save its URL
            
            # And click it
            # temp$clickElement()
            
            # Now check to see if we went to a new page or are on the same page
            # Get URL
            temp_pageurl <- remote_driver$getCurrentUrl()[[1]]
            
            ## Check for timeout
            #If you can find the search button, do the thing
            #Else reload the driver and log back in
            
            if(pageurl != temp_pageurl) {
              # Test
              #print("we're somewhere new!")
              
              # Download the file
              # ??? Might need to use Firefox
              
              # The following is from:
              # https://github.com/ropensci/wdman/issues/19
              # remote_driver$queryRD(
              #   ipAddr = paste0(remote_driver$serverURL, "/session/", remote_driver$sessionInfo[["id"]], "/chromium/send_command"),
              #   method = "POST",
              #   qdata = list(
              #     cmd = "Page.setDownloadBehavior",
              #     params = list(
              #       behavior = "allow",
              #       downloadPath = getwd()
              #     )
              #   )
              # )
              
              # Go Back
              remote_driver$goBack()
            } else {
              #print("we didn't move!")
            }
            
            # KIs: 
            # Usually clicking the link will open a new window where the file will have to be downloaded from, but sometimes it will just download it immediately without opening that window.
            # Cannot be solved with right-click -> "download linked file" because it's not a direct link; the server uses aspx to find the file.
            
            # Ideas:
            # Copy aspx link, navigate there in new tab, save the file, close the tab (IF it's still open), do it again
            # Instead of opening a new window, let it open in the same one, then check the page address (or title). If it includes "ViewDocumentFragment", download and navigate Back. Otherwise, click the next link.
          }
        }
        
      } else {
        print("No files found.")
      }
      
      # Now do the same for "Other Images")
      # Check for rows with td; empty tables have ths but no tds
      temp <- remote_driver$findElements(using = "xpath",
                                         value = "/html/body/table[5]/tbody/tr/td[1]")
      if (length(temp) > 0 ) {
        print("Files found.")
      } else {
        print("No files found.")
      }
    
    
      
    
    # for (rows in docs_df)
    # go to tr nth child(i)
    # if there's a link, click it
    
    ###################
    # Get page HTML source code (stores as list)
    pagehtml <- remote_driver$getPageSource()
    nodes <- read_html(pagehtml[[1]])
    
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
    ##########################
    
    
    
    
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
}

write.csv(all_cases_clean, "data/eviction_cases_jan2019_to_may2020.csv")

#### Cleanup ----
rD1$server$stop()
rD2$server$stop()


#### Sanity checks ----
all_cases_clean <- read_csv("data/eviction_cases_jan2019_to_may2020.csv")

all_cases_clean %>%
  select(-X1) %>%
  group_by(date_filed) %>%
  summarize(count = n()) %>%
  arrange(count)
