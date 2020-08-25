#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Wed Aug 12 11:26:41 2020

@author: shardsofblue
"""

# Built and tested in Spyder via Anaconda

from os import path
import csv
from selenium import webdriver
from selenium.webdriver.support.ui import Select
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from bs4 import BeautifulSoup # HTML parsing

# Lower the case, strip blanks, strip multiple spaces, and remove linebreaks
def clean(str):
    str = str.lower()
    str = str.strip()
    str = " ".join(str.split())
    str = str.replace('\n', ' ')
    return str

# Pull and return all html as a string from the current page of an active driver
# Requires the clean() function
def pull_all_html(driver):
    html = BeautifulSoup(driver.page_source, 'lxml')
    return(clean(str(html)))
        
# Save all html from the current page of an active driver
# Requires the pull_all_html() function
def save_all_html(driver, file_name = 'source.html'):
    with open(file_name, 'w') as f:
        f.write(pull_all_html(driver))
        
# Select options from a listbox
# Takes a driver, the id of the containing listbox, and a list of desired option display texts
def fast_multiselect(driver, element_id, labels):
    try:
        select = Select(driver.find_element_by_id(element_id))
        select.deselect_all()
        for label in labels:
            select.select_by_visible_text(label)
    except:
        print("Error.")
  
# Check for sign on error
def sign_on_error():
    try:
        error_message = WebDriverWait(driver, short_timeout).until(EC.element_to_be_clickable((By.XPATH, '//*[@id="Login"]/table/tbody/tr[2]/td/table/tbody/tr[1]/td[2]/table/tbody/tr[7]/td/p')))
        if error_message == "Sign on failed. Please submit an email to publicview@mypinellasclerk.org for assistance.":
            return(True)
        else:
            return(False)
    except:
        return(False)
    
# Check whether at login screen (returns boolean)
# Useful to check for auto-logout (system inconsistently returns users to login or home screens)
def is_login_screen(driver):
    try:
        WebDriverWait(driver, 3).until(EC.presence_of_element_located((By.NAME, 'SignOn')))
        return(True)
    except:
        return(False)
    
# Check whether at home screen and logged out (returns boolean)
# Useful to check for auto-logout (system inconsistently returns users to login or home screens)
# FLAG not locating element
def is_home_screen(driver):
    try:
        WebDriverWait(driver, 3).until(EC.element_to_be_clickable((By.LINK_TEXT, 'Registered User Login')))
        return(True) 
    except:
        return(False)