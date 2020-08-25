#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Wed Aug 12 11:26:41 2020

@author: shardsofblue
"""

# Built and tested in Spyder via Anaconda

# This file is for dumping old or reference code, because I am a code hoarder.

#%%
from bs4 import BeautifulSoup
import csv

defendant_name_list = list()
defendant_address_list = list()

# Store defendant name (list)
defendant_name_soup = soup.find_all(string = 'defendant')[i].next_element
defendant_name_list.append(clean(defendant_name_soup.getText()))
print(defendant_name_list[i])

# Store defendant address (list)
defendant_address_soup = soup.find_all(string = 'defendant')[i].next_element.parent.next_sibling
defendant_address_list.append(clean(defendant_address_soup.getText()))
print(defendant_address_list[i])

html = """
  <table class="details" border="0" cellpadding="5" cellspacing="2" width="95%">
    <tr valign="top">
      <th>Tests</th>
      <th>Failures</th>
      <th>Success Rate</th>
      <th>Average Time</th>
      <th>Min Time</th>
      <th>Max Time</th>
   </tr>
   <tr valign="top" class="Failure">
     <td>103</td>
     <td>24</td>
     <td>76.70%</td>
     <td>71 ms</td>
     <td>0 ms</td>
     <td>829 ms</td>
  </tr>
  <tr valign="top" class="Failure">
     <td>109</td>
     <td>35</td>
     <td>82.01%</td>
     <td>12 ms</td>
     <td>2 ms</td>
     <td>923 ms</td>
  </tr>
</table>"""



soup = BeautifulSoup(html)
table = soup.find("table", attrs={"class":"details"})

# The first tr contains the field names.
headings = [th.get_text() for th in table.find("tr").find_all("th")]



datasets = []
for row in table.find_all("tr")[1:]:
    dataset = zip(headings, (td.get_text() for td in row.find_all("td")))
    datasets.append(tuple(dataset))

print(datasets)


headers_row = [hdr for hdr, data in datasets[0]]

with open('data.csv', 'w', newline='') as csvfile:
    writer = csv.DictWriter(csvfile, fieldnames= headers_row)

    writer.writeheader()

    for row in datasets: # your original data
        writer.writerow(dict(row))
#%%

#%%
# OLD Collect basic info from the search results page
def OLDpull_basic_case_data():
    # int Row_count = driver.findElements(By.xpath("//*[@id='post-body-6522850981930750493']/div[1]/table/tbody/tr")).size();
    WebDriverWait(driver, short_timeout).until(EC.presence_of_element_located((By.XPATH, '/html/body/table[4]')))
    case_table = driver.find_elements_by_xpath('/html/body/table[4]/tbody/tr')
    
    all_rows = list()
    
    for i in case_table:
        all_rows.append(i.get_attribute('innerHTML'))
    
    # Delete the header row and 
    #all_cases = all_rows[2:]
        
        return(all_rows)
    
# return(dict(datasets[2]))

#%%

#%%

# Pull the case table as a BeautifulSoup object
case_table_soup = BeautifulSoup(source, 'html.parser').select_one('body > table:nth-child(5)')

# BeautifulSoup structure
tr_list = case_table_soup('tr')
one_row = tr_list[0]
one_value = tr_list[0]('th')[0].string


#%%

#%%

# Collect basic info from the search results page and saves to a .csv
# Accepts html source code; designed to be used with the utils.py function: pull_html_source()
# Requires utils.py function: clean()
def save_basic_case_data(source):
    
    # Pull the case table as a BeautifulSoup object
    case_table_soup = BeautifulSoup(source, 'html.parser').select_one('body > table:nth-child(5)')
    
    # Process the first tr as field names.
    headers_row = [th.get_text() for th in case_table_soup.find("tr").find_all("th")]
    
    # Process remaining rows as data pairs
    datasets = []
    for row in case_table_soup.find_all("tr")[1:]:
        dataset = zip(headers_row, (clean(td.get_text()) for td in row.find_all("td")))
        datasets.append(tuple(dataset))
        
    # Process and save the extracted data as a .csv
    with open('data.csv', 'w', newline='') as csvfile:
        writer = csv.DictWriter(csvfile, fieldnames= headers_row)
    
        writer.writeheader()
    
        for row in datasets: 
            writer.writerow(dict(row))
                
#%%

#%%

# Save any dataframe to a csv
def save_to_csv(data, filename = 'data.csv'):
    data.to_csv(filename)
    
#%%

