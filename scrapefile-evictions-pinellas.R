# Scraper for the Pinellas Court online records database
# Based on a scraper built by Riin Aljas (aljasriin@gmail.com)
# Created by Roxanne Ready (rready@roxanneready.com)

## Useage notes:
# 1. Must have Java Development Environment installed. May require overriding Mac security settings at runtime via System Preferences::Security & Privacy::General::Run Anyway
# 2. Requires a list of case numbers.

## Libaries Used ----
library(tidyverse) # Tidy functions
library(RSelenium) # Headless browser
#library(rvest)
#library(tidytext)
#library(tidyr)
#library(stringr)


## Define Case Numbers ----

cases <- readRDS("data/final_homeless.rds")

case_nrs <- final_homeless$case_number %>% unique() 

## Run Headless Browser Scrape ----

# Create driver and locate the right page 
rD1 <- rsDriver(browser = c("chrome"), 
                port = 4960L, 
                # To find Chrome ver. num., use binman::list_versions("chromedriver"); try multiple
                chromever = "83.0.4103.39")

remote_driver <- rD1[["client"]] 
myurl <- remote_driver$navigate(
  "https://ccmspa.pinellascounty.org/PublicAccess/default.aspx")


temp <- remote_driver$findElement(using = "xpath", 
                                  value = "/html/body/table/tbody/tr[2]/td/table/tbody/tr[1]/td[2]/a[1]")
temp$clickElement()

temp <- remote_driver$findElement(using = "id", 
                                  value = "Case")
temp$clickElement()



temp$clickElement()
pinellasdata<- data.frame(case_number= as.character(), 
                          to_pay = as.character(), 
                          paid = as.character(), 
                          balance = as.character())


i=0
for (casenr in case_nrs) {
  print(casenr)
  
  temp <- remote_driver$findElement(using = "id", 
                                    value = "CaseSearchValue")
  temp$clickElement()
  
  temp$sendKeysToElement(list(casenr))
  temp <- remote_driver$findElement(using = "id",value = "SearchSubmit")
  
  temp$clickElement()
  temp <- remote_driver$findElement(using = "xpath", 
                                    value = "/html/body/table[4]/tbody/tr[3]/td[1]/a")
  temp$clickElement()
  Sys.sleep(1)
  
  
  
  ##SCRAPE INFORMATION----
  #don't close selenium chrome window 
  
  
  
  
  
  pagesource <- remote_driver$getPageSource()
  mynodes <- read_html(pagesource[[1]])
  
  if (str_detect(pagesource, "Financial Information") == TRUE)
  {
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
      mutate(case_number = casenr)
    print(c(casenr, fins$balance)) 
    print(Sys.time())
    
    
    pinellasdata <- bind_rows(pinellasdata, fins) 
    Sys.sleep(1)
    temp <- remote_driver$findElement(using = "xpath",
                                      value = "/html/body/table[2]/tbody/tr/td/table/tbody/tr/td[1]/font/a[6]")
    
    temp$clickElement()
    
    
    Sys.sleep(1)
    
    temp <- remote_driver$findElement(using = "id", 
                                      value = "Case")
    temp$clickElement()
    
    temp <- remote_driver$findElement(using = "id", 
                                      value = "CaseNumberOption")
    temp$clickElement()
    
    temp <- remote_driver$findElement(using = "id", 
                                      value = "CaseSearchValue")
    
    next
    
  }
  
  Sys.sleep(1)
  temp <- remote_driver$findElement(using = "xpath",
                                    value = "/html/body/table[2]/tbody/tr/td/table/tbody/tr/td[1]/font/a[6]")
  
  temp$clickElement()
  
  
  Sys.sleep(1)
  
  temp <- remote_driver$findElement(using = "id", 
                                    value = "Case")
  temp$clickElement()
  
  temp <- remote_driver$findElement(using = "id", 
                                    value = "CaseNumberOption")
  temp$clickElement()
  
  temp <- remote_driver$findElement(using = "id", 
                                    value = "CaseSearchValue")
  print(c(casenr, " no fines"))
  print(Sys.time())

}

rD1$server$stop()
