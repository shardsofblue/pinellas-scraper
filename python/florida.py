#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Wed Aug 12 11:26:41 2020

@author: shardsofblue
"""

# Built and tested in Python 3 using Spyder via Anaconda
# Search 'FLAG' for development-mode code and unfinished code

#%%
# Import necessary libraries
from selenium import webdriver
from selenium.webdriver.chrome.options import Options
# from selenium.webdriver.common.keys import Keys
from selenium.webdriver.support import expected_conditions as EC
# from selenium.common.exceptions import JavascriptException, NoSuchElementException, StaleElementReferenceException
# from selenium.common.exceptions import ElementNotInteractableException, ElementNotSelectableException
from selenium.webdriver import ActionChains
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.common.exceptions import TimeoutException, ElementClickInterceptedException
# from IPython.display import clear_output
# from selenium.common.exceptions import ElementNotInteractableException, ElementNotSelectableException
# from datetime import datetime
import time
# import pickle
# import csv
# import unicodedata
import os
from os import path # OS functionality
from pathlib import Path # To find home dir
from bs4 import BeautifulSoup # HTML parsing
import pandas as pd
#%%

#%%

# FLAG Set system path MUST BE REPLACED WITH RELATIVE PATHING
# path = os.getcwd() + "/pinellas-python"
# os.chdir(path)
# home_path = str(Path.home())
os.chdir("/Volumes/Passport/github/evictions/scrapers_data/fl_pinellas/pinellas-python")

# Import project libraries
from user import *
from utils import *
from date_range import *

#%%

#%%
# Define global variables
brief_timeout = 1
short_timeout = 5
med_timeout = 20
long_timeout = 60
#time.sleep(short_timeout)
downloads_folder = 'downloads/'

#%%

#%%
# Create Florida class and functions

#this class of functions will work for every Florida county that uses the same back-end as Pinellas website
#as of Aug. 11, 2020, only Pinellas is in production
class florida:
    
    # Go to home start page
    def go_home(driver):
        start_page = 'https://ccmspa.pinellascounty.org/PublicAccess/default.aspx'
        driver.get(start_page)
  
   # Load a new driver for Florida counties (function)
    def load_new_driver(county, headless=''):
        
        # Implement global variables
        global driver
        global start_page
        
        # Check that a driver window isn't already open
        try:
            driver.close()
        except:
            pass
            
        # Navigate to Pinellas home
        if clean(county) == 'pinellas':
            start_page = 'https://ccmspa.pinellascounty.org/PublicAccess/default.aspx'
        # elif clean(county) == 'chatham':
        #     start_page = 'https://cmsportal.chathamcounty.org/Portal/Home/Dashboard/29'
        else:
          # quit and output error saying which counties are implemented
          print('Only Pinellas is implemented. Please specify \'pinellas\' for the county variable.')
          pass
        
        # Define Chrome options
        chrome_options = Options()
        
        # Define headless (running without visible browser window)
        if str(headless) == 'headless':
            chrome_options.add_argument("--headless")
        else:
            pass
        
        # Set Chrome options
        chrome_options.add_argument("--window-size=1920x700")
        chrome_options.add_argument("--disable-notifications")
        chrome_options.add_argument('--no-sandbox')
        chrome_options.add_argument('--verbose')
        chrome_options.add_experimental_option("prefs", {
                "download.default_directory": download_path,
                "download.prompt_for_download": False,
                "download.directory_upgrade": True,
                "safebrowsing_for_trusted_sources_enabled": False,
                "safebrowsing.enabled": False
                })
        # Launch driver (including executable path)
        driver = webdriver.Chrome(options=chrome_options, executable_path=executable_path)
        florida.go_home(driver = driver)
        
        # Set implicit wait time 
        driver.implicitly_wait(short_timeout) # seconds 
        
    # Log the user in (function)
    def login(username, password):
        
        # Set implicit wait time 
        driver.implicitly_wait(short_timeout) # seconds
        
        # Enter login screen if needed
        if is_home_screen(driver):
            # Click login button
            login_link = driver.find_elements_by_xpath("/html/body/table/tbody/tr[2]/td/table/tbody/tr[1]/td[2]/a[8]")
            
            try:
                ActionChains(driver).move_to_element(login_link[0]).click(login_link[0]).perform()
            except:
                print("Unable to find login link")
        elif is_login_screen(driver):
            pass
        else:
            print('Unable to find login screen. Returning home.')
            florida.go_home(driver)           
            
        # Input user and password
        try:
            login_user_field = WebDriverWait(driver, short_timeout).until(EC.element_to_be_clickable((By.ID, 'UserName')))
            login_pw_field = WebDriverWait(driver, short_timeout).until(EC.element_to_be_clickable((By.ID, 'Password')))
            submit_button = WebDriverWait(driver, short_timeout).until(EC.element_to_be_clickable((By.XPATH, '//*[@id="Login"]/table/tbody/tr[2]/td/table/tbody/tr[1]/td[2]/table/tbody/tr[6]/td/input')))
            
            login_user_field.click()
            login_user_field.clear()
            login_user_field.send_keys(username)
            
            login_pw_field.click()
            login_pw_field.clear()
            login_pw_field.send_keys(password)
            
            submit_button.click()
            
        except:
            print("Unable to find login fields")
            
            
    # Enter All Case Records Search
    def enter_records_search():
        
        # Set implicit wait time 
        driver.implicitly_wait(short_timeout) # seconds
        
        try: 
            enter_search_link = WebDriverWait(driver, short_timeout).until(EC.element_to_be_clickable((By.XPATH, '/html/body/table/tbody/tr[2]/td/table/tbody/tr[1]/td[2]/a[1]')))
        
            enter_search_link.click()
        except:
            print("Unable to find All Records Search")
    
    # Enter date range
    def enter_date_range(dates, case_types = ["all"]):
        
        # Set implicit wait time 
        driver.implicitly_wait(short_timeout) # seconds
        
        # Define dates
        start_date = dates[0][0]
        end_date = dates[0][1]
        
        # Select date range as search method
        try:
            date_filed_radio = WebDriverWait(driver, short_timeout).until(EC.element_to_be_clickable((By.ID, 'DateFiled')))
            
            date_filed_radio.click()
            
        except:
            print("Unable to find Date Range radio button")
            
        # Input date range
        try:
            date_start_input = WebDriverWait(driver, short_timeout).until(EC.element_to_be_clickable((By.ID, 'DateFiledOnAfter')))
            date_end_input = WebDriverWait(driver, short_timeout).until(EC.element_to_be_clickable((By.ID, 'DateFiledOnBefore')))
            
            date_start_input.click()
            date_start_input.clear()
            date_start_input.send_keys(start_date)
            
            date_end_input.click()
            date_end_input.clear()
            date_end_input.send_keys(end_date)
            
        except:
            print("Unable to set date range")
            
        try:
            WebDriverWait(driver, short_timeout).until(EC.presence_of_element_located((By.ID, 'selCaseTypeGroups')))
        except:
            print("Unable to find Case Types selection list.")
        
        # Choose case types
        # Only "all" and "eviction" are in development (Aug. 12)
        
        # Set options to options as shown in page HTML
        if case_types == ["all"]:
            case_types_as_labels = []
        elif case_types == ["evictions"]:
            case_types_as_labels = ["DELINQUENT TENANT/EVICTION/UNLAWFUL DETAINER"]
        else:
            case_types_as_labels = []
        
        try:
            fast_multiselect(driver, 'selCaseTypeGroups', case_types_as_labels)
        except:
            print('Error when setting case type')
            
        # Submit the search query
        try:
            submit_button = WebDriverWait(driver, short_timeout).until(EC.element_to_be_clickable((By.ID, 'SearchSubmit')))
            submit_button.click()
            
        except:
            print("Unable to submit search")
                
    # Collect basic info from the search results page and output it as a dataset
    # Can be used during a live scrape or by passing pre-saved html
    # Requires utils.py function: clean()
    def pull_basic_case_data(source):
        
        # Pull the case table as a BeautifulSoup object
        case_table_soup = BeautifulSoup(source, 'html.parser').select_one('body > table:nth-child(5)')
        
        tr_list = case_table_soup('tr')
        
        # Process the first tr as field names.
        headers_row = [th.get_text() for th in case_table_soup.find("tr").find_all("th")]
        
        # Process remaining rows as data pairs (skip header row and blank row)
        datasets = []
        for row in case_table_soup.find_all("tr")[2:]:
            dataset = zip(headers_row, (clean(td.get_text()) for td in row.find_all("td")))
            datasets.append(tuple(dataset))
            
        processed_rows = [
          [data for hdr, data in row]
          for row in datasets
        ]
        
        # Combine header and data into a dataframe
        df = pd.DataFrame(processed_rows,
                          columns = headers_row)
        
        return(df)
    
    
    
    
    ### THE FOLLOWING FUNCTIONS ARE IN DEVELOPMENT ###
    
    # View a single case on the page
    def view_case(x):
        
        # Make sure the relevent table has had time to load 
        # (FLAG change to long_timeout after testing)
        # /html/body/table[4]/tbody
        try:
            WebDriverWait(driver, short_timeout).until(EC.presence_of_element_located((By.XPATH, '/html/body/table[4]/tbody')))
        except TimeoutException:
            print('Table of cases not found before system timeout.')
        except:
            print('Table of cases not located')
        
        # FLAG Remember to account for nonclickable case numbers (aka locked cases)
        # /html/body/table[4]/tbody/tr[8]/td[1]/a 
        try:
            path_to_element = '/html/body/table[4]/tbody/tr[' + str(x) + ']/td[1]'
            case = WebDriverWait(driver, short_timeout).until(EC.presence_of_element_located((By.XPATH, path_to_element)))
            
            try:
                case = WebDriverWait(driver, short_timeout).until(EC.presence_of_element_located((By.XPATH, (path_to_element + '/a'))))
                case.click()
            except:
                print('Unable to view ' + case.text + '. Case probably locked.')
                # FLAG should add a log of the unclickable text
            
        except:
            print('Case not found.')
                
    # Scrape data from a single case 
    # Returns a csv-ready data frame
    # Generates multiple rows for multiple defendants/plaintiffs
    # Can be passed pre-saved html
    # FLAG incomplete
    # This function scrapes:
        # [x] case number
        # [x] defendant/plaintiff name(s)
        # [x] defendant/plaintiff address(s)
        # [] defendant/plaintiff attorney(s)
        # [] case type
        # [] date filed
        # [] which documents are available
        # [] financial information
    def pull_detailed_case_data(source):
        
        # Load the html as a BeautifulSoup object
        soup = BeautifulSoup(source, 'html.parser')
        
        # Get case number
        try:
            case_num = soup.select_one('body > div.sscasedetailcasenbr > span').getText()
        except:
            case_num = soup.select_one('body > div.sscasedetailcasenbr > span')
        print('Processing case number ' + case_num)
        
        ### Get DEFENDANT info
        
        # How many defendants are there?
        num_defendants = len(soup.find_all('table')[7].find_all(string = 'defendant'))
        
        # Init a Pandas data frame
        defendants_df = pd.DataFrame()
        
        # Store each defendant in the data frame
        for i in range(num_defendants):
            
            # Store defendant info (dataframe)
            defendant_name_soup = soup.find_all('table')[7].find_all(string = 'defendant')[i].next_element
            try:
                defendant_name = clean(defendant_name_soup.getText())
            except:
                defendant_name = defendant_name_soup
            
            defendant_address_soup = soup.find_all('table')[7].find_all(string = 'defendant')[i].next_element.parent.next_sibling
            try:
                defendant_address = clean(defendant_address_soup.getText())
            except:
                defendant_address = defendant_address_soup

            temp_df = pd.DataFrame({
                'defendant_name': defendant_name,
                'defendant_address': defendant_address,
                'defendant_attorney': ''
                }, index=[case_num])
            
            defendants_df = defendants_df.append(temp_df)
        
        ### Get PLAINTIFF info
        
        # How many plaintiffs are there?
        num_plaintiffs = len(soup.find_all('table')[7].find_all(string = 'plaintiff'))
        
        # Init a Pandas data frame
        plaintiffs_df = pd.DataFrame()
        
        # Store each plaintiff in the data frame
        for i in range(num_plaintiffs):
            
            # Store plaintiff name (dataframe)
            plaintiff_name_soup = soup.find_all('table')[7].find_all(string = 'plaintiff')[i].next_element
            try:
                plaintiff_name = clean(plaintiff_name_soup.getText())
            except:
                plaintiff_name = plaintiff_name_soup
                
            plaintiff_address_soup = soup.find_all('table')[7].find_all(string = 'plaintiff')[i].next_element.parent.next_sibling
            try:
                plaintiff_address = clean(plaintiff_address_soup.getText())
            except:
                plaintiff_address = plaintiff_address_soup
                
            temp_df = pd.DataFrame({
                'plaintiff_name': plaintiff_name,
                'plaintiff_address': plaintiff_address,
                'plaintiff_attorney': ''
                }, index=[case_num])
            
            plaintiffs_df = plaintiffs_df.append(temp_df)
            
        case_data_df = defendants_df.join(plaintiffs_df)
        
        return(case_data_df)
    
    # Loop through all cases and scrape data
    # Use 'dev' to loop through limited number of cases
    # Utilizes florida.pull_detailed_case_data()
    # FLAG incomplete
    # This function:
        # [x] Saves html from each case to a local file
        # [x] Returns a csv-ready dataframe of data for all cases
        # [] Handles auto-logouts
    def loop_cases(cases_count = 'all'):
        
        # Define how many cases to loop through
        if cases_count == 'dev':
            cases_count = range(5)
        # FLAG development mode: need to define from how many rows are on page (minus 2 to account for two non-case rows)
        elif cases_count == 'all':
            # Count cases on page
            # cases_count = range(x) # x = count of all cases on page
            print('All cases mode not yet implemented. Using dev mode.')
            cases_count = range(5)
        else:
            print('Error. cases_count must be either \'all\' or \'dev\'. Using dev mode.')
            cases_count = range(5)
        
        # Initialize a dataframe to hold case data
        case_df = pd.DataFrame()
        
        # Begin looping
        for i in cases_count:
            row_num = i + 3
            try:
                this_case = clean(WebDriverWait(driver, short_timeout).until(EC.presence_of_element_located((By.XPATH, '/html/body/table[4]/tbody/tr[' + str(row_num) + ']/td[1]/a'))).text)
                        
            except:
                this_case = 'NO CASE FOUND'
            finally:
                print('Viewing ' + this_case + ' at index ' + str(i) + ' which is row ' + str(row_num))
                
            if this_case != 'NO CASE FOUND':
                
                florida.view_case(row_num)
                
                time.sleep(brief_timeout)
                
                # Save the html locally
                save_all_html(driver, (downloads_folder + this_case + '.html'))
                
                time.sleep(brief_timeout)
                
                # Load in html that was just locally saved
                with open(downloads_folder + this_case + '.html') as file:
                    page_source = file.read()
                
                # Scrape the data and save it to a temp dataframe
                this_case_df = florida.pull_detailed_case_data(page_source)
                
                # Add new case data to master dataframe
                case_df = case_df.append(this_case_df)
                
                # Return to the search results
                try:
                    back_button = WebDriverWait(driver, short_timeout).until(EC.element_to_be_clickable((By.LINK_TEXT, 'Back')))
                    print('Back button found at index ' + str(i) + '. Returning to search results.')
                    time.sleep(2)
                    back_button.click()
                except:
                    print('Back button not found at index  ' + str(i))
                    
        return(case_df)
        

#%%

#%%
### Test scripts

# with open(downloads_folder + "20-003794-CO.html") as file:
#     page_source = file.read()
    
# a = florida.pull_detailed_case_data(page_source)
# b = florida.loop_cases()

#%%





#%%

#%%
### RUN THE SCRAPER ###
#%%

#%%
## LOAD UP THE DRIVER ##
## ----------------------------------- ##

# Load the driver
# Creates "driver" object
florida.load_new_driver('pinellas')

# Brief pause to prevent throttling
time.sleep(short_timeout)

# Go to home page (if not already done via load_new_driver)
if is_home_screen(driver):
    print('On home page, not logged in.')
else:
    print('Going to home page.')
    florida.go_home(driver)

## ----------------------------------- ##
#%%

#%%
## LOG IN AND ENTER SEARCH START PAGE ##
## ----------------------------------- ##

# Log in
# FLAG ? ADD FUNCTIONALITY FOR IF NO LOGIN FIELDS IN THIS FUNC IN CASE OF ALREADY LOGGED IN ?
florida.login(username, password) 
# Brief pause to prevent throttling
time.sleep(short_timeout)

# Check for success
if sign_on_error():
    # Log in
    florida.login(username, password)

# Brief pause to prevent throttling
time.sleep(brief_timeout)

# Enter search
florida.enter_records_search()

## ----------------------------------- ##
#%%

#%%
## SEARCH BY DATE RANGE ##
## ----------------------------------- ##

# Search by date range ('all' or 'evictions')
florida.enter_date_range(scrape_dates, case_types = ["evictions"])
#%%

#%%
## SAVE SEARCH RESULTS HTML
# Save the search result html source code
# This HTML includes basic case info & can act as a list of case numbers
save_all_html(driver, 'page_source.html')

## ----------------------------------- ##
#%%

#%%
## TWO OPTIONS FOR LOADING THE HTML FOR PROCESSING ##
## ----------------------------------- ##

# OPT 1: Assign page source as a string to a variable from active driver
page_source = pull_all_html(driver)

# OPT 2: Assign page source as a string to a variable from saved source code
with open("page_source.html") as file:
    page_source = file.read()
    
## ----------------------------------- ##
#%%

#%%
## SAVE BASIC CASE INFO TO CSV ###
## ----------------------------------- ##

# Pull case data and save to a CSV
all_cases = florida.pull_basic_case_data(page_source)
all_cases.to_csv('data.csv')

## ----------------------------------- ##
#%%

#%%

## SAVE DETAILED CASE INFO TO CSV
## ----------------------------------- ##

# Loop through cases and scrape case info
all_cases_detailed_df = florida.loop_cases()

# Save case info
all_cases_detailed_df.to_csv('')

## ----------------------------------- ##
#%%

#%%
## CLEAN UP DRIVER
## ----------------------------------- ##

try:
    driver.close()
    print("Driver window closed.")
except:
    print("No driver window to close.")
    pass

try:
    driver.quit()
    print("Driver exited.")
except:
    print("No driver to exit.")
    pass

## ----------------------------------- ##
#%%


