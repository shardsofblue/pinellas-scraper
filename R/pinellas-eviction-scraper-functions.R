## Setup

#### Load Libraries ####

library(tidyverse) # Tidy functions
library(RSelenium) # Headless browser
library(XML) # For extracting info from HTML
library(seleniumPipes) # For additional Selenium features
library(rvest) # For extracting info from HTML
library(RCurl) # For extracting URL
library(janitor) # For cleaning up scraped data
library(reticulate) # For injecting Python

## Functions

#### Reset sink() ####
sink.reset <- function(){
  for(i in seq_len(sink.number())){
    sink(NULL)
  }
}

#### Check for text on page ####

check_for_text <- function(text, xpath) {
  if(exists("remote_driver")){
    # Get page HTML source code (stores as list)
    pagehtml <- remote_driver$getPageSource()
    # Read in html as nodes
    nodes <- read_html(pagehtml[[1]])
    
    # Try to collect an element into a list
    temp <- remote_driver$findElements(using = "xpath",
                                       value = xpath)
    # If the list length is greater than 0, the element exists
    if(length(temp) > 0) {
      # print("Found the element.")
      if (as.character(temp[[1]]$getElementText()) == text) {
        return(TRUE)
      } else {
        # print("Element text doesn't match search.")
        return(FALSE)
      }
    } else {
      # print("Element not found.")
      return(FALSE)
    }
  } else {
    # print("No remote driver detected.")
    return(FALSE)
  }
}
# Test
# check_for_text(text = "Registered User Login",
#                xpath = "/html/body/table/tbody/tr[2]/td/table/tbody/tr[1]/td[2]/a[8]")

### Check for an element on a page ####

check_for_element <- function(element_to_check, by = "xpath") {
  if(exists("remote_driver")){
    # Get page HTML source code (stores as list)
    pagehtml <- remote_driver$getPageSource()
    # Read in html as nodes
    nodes <- read_html(pagehtml[[1]])
    # Try to collect an element into a list
    temp <- remote_driver$findElements(using = by,
                                       value = element_to_check)
    # If the list length is greater than 0, the element exists
    if(length(temp) > 0) {
      # print("Found the element.")
      return(TRUE)
    } else {
      # print("Element not found.")
      return(FALSE)
    }
  } else {
    # print("No remote driver detected.")
    return(FALSE)
  }
}

#### Check what page ####

# Function to check if at login screen
check_if_login_screen <- function(){
  if(check_for_element("SignOn", by = "name")){
    return(TRUE)
  } else {
    return(FALSE)
  }
}

check_if_case_details_page <- function() {
  if(check_for_element("ssCaseDetailROA", by = "class")){
    return(TRUE)
  } else {
    return(FALSE)
  }
}

### Send to webpage ####

# Function to navigate to the Pinellas court system homepage
navigate_to_pinellas_courts_home <- function() {
  myurl <- remote_driver$navigate(
    "https://ccmspa.pinellascounty.org/PublicAccess/default.aspx")
}

#### Get case number ####
# Function to get case number if on case details page
get_case_num <- function(){
  if(check_if_case_details_page()){
    temp <- remote_driver$findElements(using="class name",
                                       value="ssCaseDetailCaseNbr")
    return(as.character(temp[[1]]$getElementText())) %>%
      str_remove_all("(Case\\sNo\\.\\s)")
  } else { 
    print("get_case_num: Couldn't find case number")
    return("NA")
    }
}

### Log in functions ####

# Function to log in to the Pinellas court system
login_action <- function() {
  # Locate and click the Registered User log-in
  temp <- remote_driver$findElement(using = "xpath",
                                    value ="/html/body/table/tbody/tr[2]/td/table/tbody/tr[1]/td[2]/a[8]")
  temp$clickElement()
  
  Sys.sleep(1)
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
  
  Sys.sleep(1)
  # Click submit
  temp <- remote_driver$findElement(using = "xpath",
                                    value = "/html/body/form/table/tbody/tr[2]/td/table/tbody/tr[1]/td[2]/table/tbody/tr[6]/td/input")
  temp$clickElement()
  Sys.sleep(3)
}

login_to_pinellas_courts <- function() {
  # Check we're on the home page with the login link
  if(check_for_text(text = "Registered User Login", xpath = "/html/body/table/tbody/tr[2]/td/table/tbody/tr[1]/td[2]/a[8]") == TRUE) {
    print("login_to_pinellas_courts: Element found; able to log in.")
    login_action()
    } else {
      print("login_to_pinellas_courts: Element not found; returning to start.")
      # Go to the home page
      navigate_to_pinellas_courts_home()
      Sys.sleep(2)
      # Look for login link
      if(check_for_text(text = "Registered User Login", xpath = "/html/body/table/tbody/tr[2]/td/table/tbody/tr[1]/td[2]/a[8]") == TRUE) {
        login_action()
      } else {
        print("login_to_pinellas_courts: Already logged in.")
      }
    }
}

### Enter court case search functions ####

# Function to enter All Case Records Search
enter_all_case_search_action <- function() {
  temp <- remote_driver$findElement(using = "xpath",
                                  value = "/html/body/table/tbody/tr[2]/td/table/tbody/tr[1]/td[2]/a[1]")
  temp$clickElement()
}

enter_all_case_search <- function() {
  # Check we're on the page with the All Case Records Search link
  if(check_for_text(text = "All Case Records Search", xpath = "/html/body/table/tbody/tr[2]/td/table/tbody/tr[1]/td[2]/a[1]") == TRUE) {
    print("enter_all_case_search: Element found; able to enter all case search.")
    enter_all_case_search_action()
    } else {
      print("enter_all_case_search: Element not found; returning to start.")
      # Go to the home page and log back in
      login_to_pinellas_courts()
      Sys.sleep(3)
      # Look for All Case Records Search link
      if(check_for_text(text = "All Case Records Search", xpath = "/html/body/table/tbody/tr[2]/td/table/tbody/tr[1]/td[2]/a[1]") == TRUE) {
        print("enter_all_case_search: Element found; able to enter all case search.")
        enter_all_case_search_action()
      } else {
        print("enter_all_case_search: Error. Could not find records search link.")
      }
    }
}

### Search within a date range ####

# Function to set the date range
enter_date_range_action <- function(counter) {

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
    
    Sys.sleep(12)
}

# Function to implement date range entry
enter_date_range <- function(x){
  # Check we're on the page with the All Case Records Search title
  if(check_for_text(text = "All Case Records Search", xpath = "/html/body/form/table[3]/tbody/tr/td[2]/font") == TRUE) {
    print("enter_date_range: Element found; able to enter a date range.")
    enter_date_range_action(x)
    
    } else {
      # Go back a step (this function will regress back to the start if necessary)
      enter_all_case_search()
      Sys.sleep(2)
      # Look for All Case Records Search title
      if(check_for_text(text = "All Case Records Search", xpath = "/html/body/form/table[3]/tbody/tr/td[2]/font") == TRUE) {
        enter_date_range_action(x)
      } else {
        print("enter_date_range: Error. Unable to search date range.")
      }
    }
}

### Store basic case info ####
# Function to store basic case info
store_basic_info_action <- function(counter) {
  # Get page HTML source code (stores as list)
  pagehtml <- remote_driver$getPageSource()
  
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
  #write.csv(cases_df_clean, paste0('data/by-month/basic-info/eviction_cases_', counter_ch, '.csv'))
  return(cases_df_clean)
}

# Function to implement basic info storing
# Checks for "Refine Search" to validate location
store_basic_info <- function(x) {
  if(check_for_text(text = "Refine Search", xpath = "/html/body/table[2]/tbody/tr/td/table/tbody/tr/td[1]/font/a[6]") == TRUE) {
    print("store_basic_info: Element found; able to store info.")
    return(store_basic_info_action(x))
    } else {
      print("store_basic_info: Element not found; returning to start.")
      # Go back a step (this function will regress back to the start if necessary)
      enter_all_case_search()
      Sys.sleep(1)
      # Look for All Case Records Search link
      if(check_for_text(text = "Refine Search", xpath = "/html/body/table[2]/tbody/tr/td/table/tbody/tr/td[1]/font/a[6]") == TRUE) {
        store_basic_info_action(x)
      } else {
        print("store_basic_info: Error. Could not find requested text.")
      }
    }
}

### Function to return to All Case Records Search page ####
return_to_search <- function() {
  if(check_for_text(text = "Refine Search", xpath = "/html/body/table[2]/tbody/tr/td/table/tbody/tr/td[1]/font/a[6]") == TRUE) {
    
    temp <- remote_driver$findElement(using = "xpath",
                                      value = "/html/body/table[2]/tbody/tr/td/table/tbody/tr/td[1]/font/a[6]")
    temp$clickElement()
    Sys.sleep(1)
  } else {
    # Go back a step (this function will regress back to the start if necessary)
    enter_all_case_search()
    Sys.sleep(1)
  }
}

### View details about a case ####
# Function to view case details
view_case_action <- function(x){
  if(check_for_element(paste0("/html/body/table[4]/tbody/tr[", x+2, "]/td[1]/a"))) {
    temp <- remote_driver$findElement(using = "xpath",
                                      value = paste0("/html/body/table[4]/tbody/tr[", x+2, "]/td[1]/a"))
    temp$clickElement()
  } else {
    print("view_case_action: ")
  }
  
}

# Function to implement case detail viewing
view_case <- function(x_case_pos, y_date_pos){
  if(check_for_element(paste0("/html/body/table[4]/tbody/tr[", x_case_pos+2, "]/td[1]/a"))) {
    print("view_case: Element found; able to enter an individual case record.")
    view_case_action(x_case_pos)
    if(check_if_login_screen() == TRUE){
      # Go back a step (this function will regress back to the start if necessary)
      enter_date_range(y_date_pos) 
      view_case_action(x_case_pos)
    }
  } else {
    print("view_case: Element not found; returning to start.")
    # Go back a step (this function will regress back to the start if necessary)
    enter_date_range(y_date_pos) 
    if(check_for_element(paste0("/html/body/table[4]/tbody/tr[", x_case_pos+2, "]/td[1]/a"))) {
      view_case_action(x_case_pos)
    } else {
      print("view_case: Unable to find case to click. Going next.")
    }
    
  }
}

### Return to the month's list of cases ####
# Function to return to results of search by date range
return_to_results_action <- function(){
  # Return to the search results page to click a new case
  temp <- remote_driver$findElement(using = "xpath",
                                    value = "/html/body/table[2]/tbody/tr/td/table/tbody/tr/td[1]/font/a[7]")
  temp$clickElement()
  Sys.sleep(2)
}

# Function to implement return to month's list of cases
return_to_results <- function(x_date_pos){
  if(check_for_element("/html/body/table[2]/tbody/tr/td/table/tbody/tr/td[1]/font/a[7]")){
    print("return_to_results: Element found; able to return to list of month's cases.")
    return_to_results_action()
  } else {
    print("return_to_results: Element not found; returning to start.")
    # Go back a step (this function will regress back to the start if necessary)
    enter_date_range(x_date_pos)
  }
}

#### Check how many cases exist ####
how_many_cases <- function() {
  # Get page HTML source code (stores as list)
  pagehtml <- remote_driver$getPageSource()
  
  # Get table
  cases_df <- readHTMLTable(
    pagehtml[[1]], # Pull the html from the list
    which = 6) %>% # Get the right table (the 6th one holds the info we need)
    as_tibble() %>%
    drop_na() %>%
    row_to_names(1) %>%
    mutate_if(is.factor, as.character)
  
  return(nrow(cases_df))
}

#### Get financials ####
# Function to get financials
get_financials_action <- function(){
  pagesource <- remote_driver$getPageSource()
  mynodes <- read_html(pagesource[[1]])
  
  # Get case number
  casenr <- tolower(get_case_num())
  
  if (str_detect(pagesource, "Financial Information") == TRUE) {
    print("get_financials_action: Element found; financial data present.")
    
    #get financial information 
    fins <- mynodes %>% 
      html_nodes('#RCDFRPC1+ td , #RCDFRBD1+ td b , tr:nth-child(8) td:nth-child(7) , #RCDFRBFA1+ td') %>% 
      html_text() %>% 
      as.data.frame() %>% 
      rename(values = 1)
    
    fins$values <- as.character(fins$values)
    fins <- fins %>% 
      rownames_to_column() %>% 
      pivot_wider(names_from = rowname, 
                  values_from = values) %>% 
      select("to_pay" = 1, 
             "paid" = 2, 
             "balance" = 3) %>% 
      mutate(case_number = casenr) %>%
      mutate_all(~tolower(.))
    
    # print(c(casenr, fins$balance)) 
    # print(Sys.time())
    # fin_data <- bind_rows(fin_data, fins) 
    # return(data.frame(fin_data))
    
    Sys.sleep(1)
    return(data.frame(fins))
  } else {
    print("get_financials_action: Element not found; no financial data present.")
    fins <- data.frame(case_number = casenr,
                       to_pay = "",
                       paid = "",
                       balance = "")
    return(data.frame(fins))
  }
}

# Function to implement getting financials
get_financials <- function(date_counter, case_counter) {
  if(check_for_element("/html/body/table[2]/tbody/tr/td/table/tbody/tr/td[1]/font/a[7]")){
    print("get_financials: Element found; I'm viewing a single case.")
    return(get_financials_action())
  } else {
    print("get_financials: Element not found; returning to login.")
    # Go back a step (this function will regress back to the start if necessary)
    view_case(case_counter, date_counter)
    return(get_financials_action())
  }
}

#### Get addresses ####

# Get addresses action
get_addresses_action <- function() {
  
  address_data_this <- data.frame(case_number = as.character(),
                             def_address = as.character(),
                             plaint_address = as.character())
  
  pagehtml <- remote_driver$getPageSource()
  mynodes <- read_html(pagehtml[[1]])
  
  # Get case number
  case_num_this <- tolower(get_case_num())
  
  # Check for "Party Information" at expected location on page
  if(check_for_text("Party Information", "/html/body/table[4]/caption/div")){
    print("get_addresses_action: Element found; retrieving party information.")
    
    # Find the address data
    
    # This is the table we want
    temp <- remote_driver$findElements(using = "xpath",
                                       value = "/html/body/table[4]")
    # Get defendant address
    if(check_for_element("//*[contains(text(), 'DEFENDANT')]/ancestor::tr/following-sibling::tr")) {
      print("get_addresses_action: Defendant address found.")
      temp <- remote_driver$findElements(using = "xpath",
                                         value = "//*[contains(text(), 'DEFENDANT')]/ancestor::tr/following-sibling::tr")
      
      def_address_this <- as.character(temp[[1]]$getElementText()) %>%
        trimws("both") %>%
        str_remove_all("\\n") %>%
        str_replace_all("  ", " ") %>%
        tolower()
    } else { 
      print("get_address_action: Defendant address not found.") 
      def_address_this <- ""
      }
    
    
    # Get plaintiff address
    if(check_for_element("//*[contains(text(), 'PLAINTIFF')]/ancestor::tr/following-sibling::tr")){
      print("get_addresses_action: Plaintiff address found.")
      temp <- remote_driver$findElements(using = "xpath",
                                         value = "//*[contains(text(), 'PLAINTIFF')]/ancestor::tr/following-sibling::tr")
      
      plaint_address_this <- as.character(temp[[1]]$getElementText()) %>%
        trimws("both") %>%
        str_remove_all("\\n") %>%
        str_replace_all("  ", " ") %>%
        tolower()
    } else { 
      print("get_address action: Plaintiff address not found.") 
      plaint_address_this <- ""
      }
    
   # Add case info to dataframe 
   address_data_this <- address_data_this %>% add_row(case_number = case_num_this, 
                             def_address = def_address_this,
                             plaint_address = plaint_address_this)
  
  } else {
    print("get_addresses_action: No Party Information data found for this case.")
    address_data_this <- address_data_this %>% add_row(case_number = case_num_this, 
                                                       def_address = "",
                                                       plaint_address = "")
  } 
  return(address_data_this)
}

# Get addresses
get_addresses <- function(date_counter, case_counter) {
  # Check that it's viewing a single case
  if(check_if_case_details_page()){
    print("get_addresses: Element found; I'm viewing a single case.")
    return(get_addresses_action())
  } else {
    print("get_addresses: Element not found; returning to login.")
    # Go back a step (this function will regress back to the start if necessary)
    view_case(case_counter, date_counter)
    # Check again that it's viewing a single case. If not, note the error and move on.
    if(check_if_case_details_page()){
      print("get_addresses: Element found; Viewing a single case.")
      return(get_addresses_action())
    } else {
      print("get_addresses: Case details page not found.")
      return(get_addresses_action())
    }
  }
}

#### Next ####

