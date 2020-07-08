Initial Evictions Analysis
================
Roxanne Ready
7/8/2020

  - [Tasks](#tasks)
  - [Setup](#setup)
      - [Load Libraries](#load-libraries)
      - [Load & Prepare Data](#load-prepare-data)
  - [Analysis](#analysis)
      - [All of 2020](#all-of-2020)
      - [Since CARES Act (March 27)](#since-cares-act-march-27)
      - [Since State-Issued Moratoria](#since-state-issued-moratoria)
      - [TEMPLATE for state-by-state](#template-for-state-by-state)

## Tasks

  - All of 2020, by month, number of…
      - √ eviction filings
      - √ writs issued
      - √ writs executed
  - Since CARES Act moratorium on March 27, number of…
      - √ eviction filings
      - √ writs issued
      - √ writs executed
  - Since state moratoriums, number of…
      - eviction filings
      - writs issued
      - writs executed

## Setup

### Load Libraries

``` r
library(tidyverse) # Tidy functions
library(knitr) # For pretty tables
library(kableExtra) # For even prettier tables
```

### Load & Prepare Data

``` r fold-hide
## ALL EVICTIONS DATA (pre-cleaned)

# Import data
evictions_data_raw <- read_csv("sta_evictions_all_2020.csv")

# Filter out all Wisconsin except Milwaukee
evictions_data <- evictions_data_raw %>%
  # Remove all Wisconsin
  filter(!str_detect(location, "_wi")) %>%
  # Re-add Milwaukee
  bind_rows(evictions_data_raw %>%
              filter(location == "milwaukee_wi"))

# Remove redundant data frame
rm(evictions_data_raw)


## PREPARE WRIT DATA

# Split filing dates for grouping by month, and store
writ_data <- evictions_data %>%
  # Split out writ filing dates
  separate(col = writ_date,
           into = c("writ_year", "writ_month", "writ_day"),
           sep = "-",
           remove = F
  ) %>%
  # Split out writ served dates
  separate(col = writ_served_date,
           into = c("writ_served_year", "writ_served_month", "writ_served_day"),
           sep = "-",
           remove = F
  ) %>%
  # Keep only relevant writ info (can be rejoined with other table if more info needed)
  select(location, case_number, file_date, 
         writ_date, writ_month, writ_day, writ_year, 
         writ_served_date, writ_served_month, writ_served_day, writ_served_year)
```

## Analysis

### All of 2020

#### Evictions

``` r
# Number of evictions, total (51,802)
kable(evictions_data %>%
  count() %>%
  arrange(desc(n)))
```

<table>

<thead>

<tr>

<th style="text-align:right;">

n

</th>

</tr>

</thead>

<tbody>

<tr>

<td style="text-align:right;">

51802

</td>

</tr>

</tbody>

</table>

``` r
# Number of evictions, by location, total
kable(evictions_data %>%
  group_by(location) %>%
  count() %>%
  arrange(desc(n))) %>%
  kable_styling(bootstrap_options = c("striped", "hover", "condensed", full_width = FALSE))
```

<table class="table table-striped table-hover table-condensed" style="margin-left: auto; margin-right: auto;">

<thead>

<tr>

<th style="text-align:left;">

location

</th>

<th style="text-align:right;">

n

</th>

</tr>

</thead>

<tbody>

<tr>

<td style="text-align:left;">

fulton\_ga

</td>

<td style="text-align:right;">

10866

</td>

</tr>

<tr>

<td style="text-align:left;">

dekalb\_ga

</td>

<td style="text-align:right;">

9095

</td>

</tr>

<tr>

<td style="text-align:left;">

shelby\_tn

</td>

<td style="text-align:right;">

7785

</td>

</tr>

<tr>

<td style="text-align:left;">

oklahomacity\_ok

</td>

<td style="text-align:right;">

4453

</td>

</tr>

<tr>

<td style="text-align:left;">

milwaukee\_wi

</td>

<td style="text-align:right;">

4384

</td>

</tr>

<tr>

<td style="text-align:left;">

tulsa\_ok

</td>

<td style="text-align:right;">

4113

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:right;">

3460

</td>

</tr>

<tr>

<td style="text-align:left;">

chatham\_ga

</td>

<td style="text-align:right;">

2925

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:right;">

1669

</td>

</tr>

<tr>

<td style="text-align:left;">

toledo\_oh

</td>

<td style="text-align:right;">

1499

</td>

</tr>

<tr>

<td style="text-align:left;">

neworleans\_la

</td>

<td style="text-align:right;">

1117

</td>

</tr>

<tr>

<td style="text-align:left;">

stlouis\_mo

</td>

<td style="text-align:right;">

436

</td>

</tr>

</tbody>

</table>

``` r
# Number of evictions, by month, total
kable(evictions_data %>% 
  group_by(file_month) %>%
  count()) %>%
  kable_styling(bootstrap_options = c("striped", "hover", "condensed", full_width = FALSE))
```

<table class="table table-striped table-hover table-condensed" style="margin-left: auto; margin-right: auto;">

<thead>

<tr>

<th style="text-align:right;">

file\_month

</th>

<th style="text-align:right;">

n

</th>

</tr>

</thead>

<tbody>

<tr>

<td style="text-align:right;">

1

</td>

<td style="text-align:right;">

16321

</td>

</tr>

<tr>

<td style="text-align:right;">

2

</td>

<td style="text-align:right;">

15860

</td>

</tr>

<tr>

<td style="text-align:right;">

3

</td>

<td style="text-align:right;">

10093

</td>

</tr>

<tr>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

1622

</td>

</tr>

<tr>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2848

</td>

</tr>

<tr>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

4865

</td>

</tr>

<tr>

<td style="text-align:right;">

7

</td>

<td style="text-align:right;">

76

</td>

</tr>

<tr>

<td style="text-align:right;">

12

</td>

<td style="text-align:right;">

1

</td>

</tr>

<tr>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

116

</td>

</tr>

</tbody>

</table>

``` r
# Number of evictions, by month and location, total
kable(evictions_data %>% 
  group_by(location, file_month) %>%
  count()) %>%
  kable_styling(bootstrap_options = c("striped", "hover", "condensed", full_width = FALSE)) %>%
  scroll_box(width = "100%", height = "400px") 
```

<div style="border: 1px solid #ddd; padding: 0px; overflow-y: scroll; height:400px; overflow-x: scroll; width:100%; ">

<table class="table table-striped table-hover table-condensed" style="margin-left: auto; margin-right: auto;">

<thead>

<tr>

<th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;">

location

</th>

<th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;">

file\_month

</th>

<th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;">

n

</th>

</tr>

</thead>

<tbody>

<tr>

<td style="text-align:left;">

chatham\_ga

</td>

<td style="text-align:right;">

1

</td>

<td style="text-align:right;">

1042

</td>

</tr>

<tr>

<td style="text-align:left;">

chatham\_ga

</td>

<td style="text-align:right;">

2

</td>

<td style="text-align:right;">

945

</td>

</tr>

<tr>

<td style="text-align:left;">

chatham\_ga

</td>

<td style="text-align:right;">

3

</td>

<td style="text-align:right;">

498

</td>

</tr>

<tr>

<td style="text-align:left;">

chatham\_ga

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

69

</td>

</tr>

<tr>

<td style="text-align:left;">

chatham\_ga

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

122

</td>

</tr>

<tr>

<td style="text-align:left;">

chatham\_ga

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

238

</td>

</tr>

<tr>

<td style="text-align:left;">

chatham\_ga

</td>

<td style="text-align:right;">

7

</td>

<td style="text-align:right;">

11

</td>

</tr>

<tr>

<td style="text-align:left;">

dekalb\_ga

</td>

<td style="text-align:right;">

1

</td>

<td style="text-align:right;">

3194

</td>

</tr>

<tr>

<td style="text-align:left;">

dekalb\_ga

</td>

<td style="text-align:right;">

2

</td>

<td style="text-align:right;">

3006

</td>

</tr>

<tr>

<td style="text-align:left;">

dekalb\_ga

</td>

<td style="text-align:right;">

3

</td>

<td style="text-align:right;">

1913

</td>

</tr>

<tr>

<td style="text-align:left;">

dekalb\_ga

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

321

</td>

</tr>

<tr>

<td style="text-align:left;">

dekalb\_ga

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

312

</td>

</tr>

<tr>

<td style="text-align:left;">

dekalb\_ga

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

333

</td>

</tr>

<tr>

<td style="text-align:left;">

dekalb\_ga

</td>

<td style="text-align:right;">

12

</td>

<td style="text-align:right;">

1

</td>

</tr>

<tr>

<td style="text-align:left;">

dekalb\_ga

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

15

</td>

</tr>

<tr>

<td style="text-align:left;">

fulton\_ga

</td>

<td style="text-align:right;">

1

</td>

<td style="text-align:right;">

3003

</td>

</tr>

<tr>

<td style="text-align:left;">

fulton\_ga

</td>

<td style="text-align:right;">

2

</td>

<td style="text-align:right;">

3960

</td>

</tr>

<tr>

<td style="text-align:left;">

fulton\_ga

</td>

<td style="text-align:right;">

3

</td>

<td style="text-align:right;">

2603

</td>

</tr>

<tr>

<td style="text-align:left;">

fulton\_ga

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

338

</td>

</tr>

<tr>

<td style="text-align:left;">

fulton\_ga

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

321

</td>

</tr>

<tr>

<td style="text-align:left;">

fulton\_ga

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

543

</td>

</tr>

<tr>

<td style="text-align:left;">

fulton\_ga

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

98

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:right;">

1

</td>

<td style="text-align:right;">

1119

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:right;">

2

</td>

<td style="text-align:right;">

939

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:right;">

3

</td>

<td style="text-align:right;">

704

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

190

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

235

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

273

</td>

</tr>

<tr>

<td style="text-align:left;">

milwaukee\_wi

</td>

<td style="text-align:right;">

1

</td>

<td style="text-align:right;">

1275

</td>

</tr>

<tr>

<td style="text-align:left;">

milwaukee\_wi

</td>

<td style="text-align:right;">

2

</td>

<td style="text-align:right;">

1070

</td>

</tr>

<tr>

<td style="text-align:left;">

milwaukee\_wi

</td>

<td style="text-align:right;">

3

</td>

<td style="text-align:right;">

433

</td>

</tr>

<tr>

<td style="text-align:left;">

milwaukee\_wi

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

15

</td>

</tr>

<tr>

<td style="text-align:left;">

milwaukee\_wi

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

68

</td>

</tr>

<tr>

<td style="text-align:left;">

milwaukee\_wi

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

1473

</td>

</tr>

<tr>

<td style="text-align:left;">

milwaukee\_wi

</td>

<td style="text-align:right;">

7

</td>

<td style="text-align:right;">

49

</td>

</tr>

<tr>

<td style="text-align:left;">

milwaukee\_wi

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

1

</td>

</tr>

<tr>

<td style="text-align:left;">

neworleans\_la

</td>

<td style="text-align:right;">

1

</td>

<td style="text-align:right;">

472

</td>

</tr>

<tr>

<td style="text-align:left;">

neworleans\_la

</td>

<td style="text-align:right;">

2

</td>

<td style="text-align:right;">

387

</td>

</tr>

<tr>

<td style="text-align:left;">

neworleans\_la

</td>

<td style="text-align:right;">

3

</td>

<td style="text-align:right;">

130

</td>

</tr>

<tr>

<td style="text-align:left;">

neworleans\_la

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

128

</td>

</tr>

<tr>

<td style="text-align:left;">

oklahomacity\_ok

</td>

<td style="text-align:right;">

1

</td>

<td style="text-align:right;">

1371

</td>

</tr>

<tr>

<td style="text-align:left;">

oklahomacity\_ok

</td>

<td style="text-align:right;">

2

</td>

<td style="text-align:right;">

1274

</td>

</tr>

<tr>

<td style="text-align:left;">

oklahomacity\_ok

</td>

<td style="text-align:right;">

3

</td>

<td style="text-align:right;">

619

</td>

</tr>

<tr>

<td style="text-align:left;">

oklahomacity\_ok

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

49

</td>

</tr>

<tr>

<td style="text-align:left;">

oklahomacity\_ok

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

546

</td>

</tr>

<tr>

<td style="text-align:left;">

oklahomacity\_ok

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

587

</td>

</tr>

<tr>

<td style="text-align:left;">

oklahomacity\_ok

</td>

<td style="text-align:right;">

7

</td>

<td style="text-align:right;">

6

</td>

</tr>

<tr>

<td style="text-align:left;">

oklahomacity\_ok

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

1

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:right;">

1

</td>

<td style="text-align:right;">

575

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:right;">

2

</td>

<td style="text-align:right;">

447

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:right;">

3

</td>

<td style="text-align:right;">

374

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

134

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

139

</td>

</tr>

<tr>

<td style="text-align:left;">

shelby\_tn

</td>

<td style="text-align:right;">

1

</td>

<td style="text-align:right;">

2556

</td>

</tr>

<tr>

<td style="text-align:left;">

shelby\_tn

</td>

<td style="text-align:right;">

2

</td>

<td style="text-align:right;">

2187

</td>

</tr>

<tr>

<td style="text-align:left;">

shelby\_tn

</td>

<td style="text-align:right;">

3

</td>

<td style="text-align:right;">

1269

</td>

</tr>

<tr>

<td style="text-align:left;">

shelby\_tn

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

363

</td>

</tr>

<tr>

<td style="text-align:left;">

shelby\_tn

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

702

</td>

</tr>

<tr>

<td style="text-align:left;">

shelby\_tn

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

708

</td>

</tr>

<tr>

<td style="text-align:left;">

stlouis\_mo

</td>

<td style="text-align:right;">

2

</td>

<td style="text-align:right;">

1

</td>

</tr>

<tr>

<td style="text-align:left;">

stlouis\_mo

</td>

<td style="text-align:right;">

3

</td>

<td style="text-align:right;">

375

</td>

</tr>

<tr>

<td style="text-align:left;">

stlouis\_mo

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

35

</td>

</tr>

<tr>

<td style="text-align:left;">

stlouis\_mo

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

24

</td>

</tr>

<tr>

<td style="text-align:left;">

stlouis\_mo

</td>

<td style="text-align:right;">

NA

</td>

<td style="text-align:right;">

1

</td>

</tr>

<tr>

<td style="text-align:left;">

toledo\_oh

</td>

<td style="text-align:right;">

1

</td>

<td style="text-align:right;">

451

</td>

</tr>

<tr>

<td style="text-align:left;">

toledo\_oh

</td>

<td style="text-align:right;">

2

</td>

<td style="text-align:right;">

440

</td>

</tr>

<tr>

<td style="text-align:left;">

toledo\_oh

</td>

<td style="text-align:right;">

3

</td>

<td style="text-align:right;">

333

</td>

</tr>

<tr>

<td style="text-align:left;">

toledo\_oh

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

65

</td>

</tr>

<tr>

<td style="text-align:left;">

toledo\_oh

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

109

</td>

</tr>

<tr>

<td style="text-align:left;">

toledo\_oh

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

101

</td>

</tr>

<tr>

<td style="text-align:left;">

tulsa\_ok

</td>

<td style="text-align:right;">

1

</td>

<td style="text-align:right;">

1263

</td>

</tr>

<tr>

<td style="text-align:left;">

tulsa\_ok

</td>

<td style="text-align:right;">

2

</td>

<td style="text-align:right;">

1204

</td>

</tr>

<tr>

<td style="text-align:left;">

tulsa\_ok

</td>

<td style="text-align:right;">

3

</td>

<td style="text-align:right;">

842

</td>

</tr>

<tr>

<td style="text-align:left;">

tulsa\_ok

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

43

</td>

</tr>

<tr>

<td style="text-align:left;">

tulsa\_ok

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

270

</td>

</tr>

<tr>

<td style="text-align:left;">

tulsa\_ok

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

481

</td>

</tr>

<tr>

<td style="text-align:left;">

tulsa\_ok

</td>

<td style="text-align:right;">

7

</td>

<td style="text-align:right;">

10

</td>

</tr>

</tbody>

</table>

</div>

``` r
  # arrange(desc(n, location))
```

#### Writs Filed and Served

Notes:

  - If `writ_date` / `writ_served_date` says “no\_information,” there
    was NO data in the county (count unknown). If it’s NA, it means that
    in that county, we do have that data BUT there wasn’t one for that
    case (count zero).

<!-- end list -->

``` r
### 'WRIT FILED' INFO NA OR MISSING

# Cases with no writ filed date attached (26,057)
evictions_data %>%
  filter(is.na(writ_date)) %>%
  group_by(writ_date) %>%
  count()
```

    ## # A tibble: 1 x 2
    ## # Groups:   writ_date [1]
    ##   writ_date     n
    ##   <chr>     <int>
    ## 1 <NA>      26057

``` r
# Cases missing writ file date info (21,125)
kable(evictions_data %>% 
  filter(writ_date == "no_information") %>%
  group_by(location, writ_date) %>%
  count()) %>%
  kable_styling(bootstrap_options = c("striped", "hover", "condensed", full_width = FALSE))
```

<table class="table table-striped table-hover table-condensed" style="margin-left: auto; margin-right: auto;">

<thead>

<tr>

<th style="text-align:left;">

location

</th>

<th style="text-align:left;">

writ\_date

</th>

<th style="text-align:right;">

n

</th>

</tr>

</thead>

<tbody>

<tr>

<td style="text-align:left;">

chatham\_ga

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:right;">

2925

</td>

</tr>

<tr>

<td style="text-align:left;">

dekalb\_ga

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:right;">

9095

</td>

</tr>

<tr>

<td style="text-align:left;">

milwaukee\_wi

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:right;">

4384

</td>

</tr>

<tr>

<td style="text-align:left;">

neworleans\_la

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:right;">

1117

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:right;">

1669

</td>

</tr>

<tr>

<td style="text-align:left;">

stlouis\_mo

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:right;">

436

</td>

</tr>

<tr>

<td style="text-align:left;">

toledo\_oh

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:right;">

1499

</td>

</tr>

</tbody>

</table>

``` r
## 'WRIT SERVED' INFO NA OR MISSING

# Cases with no writ served date attached (25,324)
evictions_data %>% 
  filter(is.na(writ_served_date)) %>%
  group_by(writ_served_date) %>%
  count()
```

    ## # A tibble: 1 x 2
    ## # Groups:   writ_served_date [1]
    ##   writ_served_date     n
    ##   <chr>            <int>
    ## 1 <NA>             25324

``` r
# Cases missing writ served date info (22,896)
kable(evictions_data %>% 
  filter(writ_served_date == "no_information") %>%
  group_by(location, writ_served_date) %>%
  count()) %>%
  kable_styling(bootstrap_options = c("striped", "hover", "condensed", full_width = FALSE))
```

<table class="table table-striped table-hover table-condensed" style="margin-left: auto; margin-right: auto;">

<thead>

<tr>

<th style="text-align:left;">

location

</th>

<th style="text-align:left;">

writ\_served\_date

</th>

<th style="text-align:right;">

n

</th>

</tr>

</thead>

<tbody>

<tr>

<td style="text-align:left;">

chatham\_ga

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:right;">

2925

</td>

</tr>

<tr>

<td style="text-align:left;">

fulton\_ga

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:right;">

10866

</td>

</tr>

<tr>

<td style="text-align:left;">

milwaukee\_wi

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:right;">

4384

</td>

</tr>

<tr>

<td style="text-align:left;">

neworleans\_la

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:right;">

1117

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:right;">

1669

</td>

</tr>

<tr>

<td style="text-align:left;">

stlouis\_mo

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:right;">

436

</td>

</tr>

<tr>

<td style="text-align:left;">

toledo\_oh

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:right;">

1499

</td>

</tr>

</tbody>

</table>

``` r
## WRIT COUNTS

# Number of writs FILED, by location
kable(writ_data %>%
  # Filter for cases with writ filing dates
  filter(!(is.na(writ_date))&(writ_date != "no_information")) %>%
  group_by(location) %>%
  count()) %>%
  kable_styling(bootstrap_options = c("striped", "hover", "condensed", full_width = FALSE))
```

<table class="table table-striped table-hover table-condensed" style="margin-left: auto; margin-right: auto;">

<thead>

<tr>

<th style="text-align:left;">

location

</th>

<th style="text-align:right;">

n

</th>

</tr>

</thead>

<tbody>

<tr>

<td style="text-align:left;">

fulton\_ga

</td>

<td style="text-align:right;">

1249

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:right;">

1082

</td>

</tr>

<tr>

<td style="text-align:left;">

oklahomacity\_ok

</td>

<td style="text-align:right;">

1215

</td>

</tr>

<tr>

<td style="text-align:left;">

shelby\_tn

</td>

<td style="text-align:right;">

1074

</td>

</tr>

</tbody>

</table>

``` r
# Number of writs SERVED, by location
kable(writ_data %>%
  # Filter for cases with writ served dates
  filter(!(is.na(writ_served_date))&(writ_served_date != "no_information")) %>%
  group_by(location) %>%
  count()) %>%
  kable_styling(bootstrap_options = c("striped", "hover", "condensed", full_width = FALSE))
```

<table class="table table-striped table-hover table-condensed" style="margin-left: auto; margin-right: auto;">

<thead>

<tr>

<th style="text-align:left;">

location

</th>

<th style="text-align:right;">

n

</th>

</tr>

</thead>

<tbody>

<tr>

<td style="text-align:left;">

dekalb\_ga

</td>

<td style="text-align:right;">

1480

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:right;">

626

</td>

</tr>

<tr>

<td style="text-align:left;">

oklahomacity\_ok

</td>

<td style="text-align:right;">

1027

</td>

</tr>

<tr>

<td style="text-align:left;">

shelby\_tn

</td>

<td style="text-align:right;">

449

</td>

</tr>

</tbody>

</table>

``` r
# Number of writs FILED, by month
kable(writ_data %>%
  # Filter for cases with writ filing dates
  filter(!(is.na(writ_date))&(writ_date != "no_information")) %>%
  group_by(writ_month) %>%
  count()) %>%
  kable_styling(bootstrap_options = c("striped", "hover", "condensed", full_width = FALSE))
```

<table class="table table-striped table-hover table-condensed" style="margin-left: auto; margin-right: auto;">

<thead>

<tr>

<th style="text-align:left;">

writ\_month

</th>

<th style="text-align:right;">

n

</th>

</tr>

</thead>

<tbody>

<tr>

<td style="text-align:left;">

01

</td>

<td style="text-align:right;">

493

</td>

</tr>

<tr>

<td style="text-align:left;">

02

</td>

<td style="text-align:right;">

2093

</td>

</tr>

<tr>

<td style="text-align:left;">

03

</td>

<td style="text-align:right;">

1488

</td>

</tr>

<tr>

<td style="text-align:left;">

04

</td>

<td style="text-align:right;">

64

</td>

</tr>

<tr>

<td style="text-align:left;">

05

</td>

<td style="text-align:right;">

177

</td>

</tr>

<tr>

<td style="text-align:left;">

06

</td>

<td style="text-align:right;">

302

</td>

</tr>

<tr>

<td style="text-align:left;">

07

</td>

<td style="text-align:right;">

3

</td>

</tr>

</tbody>

</table>

``` r
# Number of writs SERVED, by month
kable(writ_data %>%
  # Filter for cases with writ filing dates
  filter(!(is.na(writ_served_date))&(writ_served_date != "no_information")) %>%
  group_by(writ_served_month) %>%
  count()) %>%
  kable_styling(bootstrap_options = c("striped", "hover", "condensed", full_width = FALSE))
```

<table class="table table-striped table-hover table-condensed" style="margin-left: auto; margin-right: auto;">

<thead>

<tr>

<th style="text-align:left;">

writ\_served\_month

</th>

<th style="text-align:right;">

n

</th>

</tr>

</thead>

<tbody>

<tr>

<td style="text-align:left;">

01

</td>

<td style="text-align:right;">

252

</td>

</tr>

<tr>

<td style="text-align:left;">

02

</td>

<td style="text-align:right;">

1426

</td>

</tr>

<tr>

<td style="text-align:left;">

03

</td>

<td style="text-align:right;">

1158

</td>

</tr>

<tr>

<td style="text-align:left;">

04

</td>

<td style="text-align:right;">

94

</td>

</tr>

<tr>

<td style="text-align:left;">

05

</td>

<td style="text-align:right;">

414

</td>

</tr>

<tr>

<td style="text-align:left;">

06

</td>

<td style="text-align:right;">

238

</td>

</tr>

</tbody>

</table>

``` r
# Number of writs FILED, by location and month
kable(writ_data %>%
  # Filter for cases with writ filing dates
  filter(!(is.na(writ_date))&(writ_date != "no_information")) %>%
  group_by(location, writ_month) %>%
  count()) %>%
  kable_styling(bootstrap_options = c("striped", "hover", "condensed", full_width = FALSE)) %>%
  scroll_box(width = "100%", height = "400px") 
```

<div style="border: 1px solid #ddd; padding: 0px; overflow-y: scroll; height:400px; overflow-x: scroll; width:100%; ">

<table class="table table-striped table-hover table-condensed" style="margin-left: auto; margin-right: auto;">

<thead>

<tr>

<th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;">

location

</th>

<th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;">

writ\_month

</th>

<th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;">

n

</th>

</tr>

</thead>

<tbody>

<tr>

<td style="text-align:left;">

fulton\_ga

</td>

<td style="text-align:left;">

01

</td>

<td style="text-align:right;">

69

</td>

</tr>

<tr>

<td style="text-align:left;">

fulton\_ga

</td>

<td style="text-align:left;">

02

</td>

<td style="text-align:right;">

771

</td>

</tr>

<tr>

<td style="text-align:left;">

fulton\_ga

</td>

<td style="text-align:left;">

03

</td>

<td style="text-align:right;">

408

</td>

</tr>

<tr>

<td style="text-align:left;">

fulton\_ga

</td>

<td style="text-align:left;">

06

</td>

<td style="text-align:right;">

1

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

01

</td>

<td style="text-align:right;">

79

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

02

</td>

<td style="text-align:right;">

510

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

03

</td>

<td style="text-align:right;">

413

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

04

</td>

<td style="text-align:right;">

63

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

05

</td>

<td style="text-align:right;">

14

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

06

</td>

<td style="text-align:right;">

3

</td>

</tr>

<tr>

<td style="text-align:left;">

oklahomacity\_ok

</td>

<td style="text-align:left;">

01

</td>

<td style="text-align:right;">

310

</td>

</tr>

<tr>

<td style="text-align:left;">

oklahomacity\_ok

</td>

<td style="text-align:left;">

02

</td>

<td style="text-align:right;">

373

</td>

</tr>

<tr>

<td style="text-align:left;">

oklahomacity\_ok

</td>

<td style="text-align:left;">

03

</td>

<td style="text-align:right;">

176

</td>

</tr>

<tr>

<td style="text-align:left;">

oklahomacity\_ok

</td>

<td style="text-align:left;">

04

</td>

<td style="text-align:right;">

1

</td>

</tr>

<tr>

<td style="text-align:left;">

oklahomacity\_ok

</td>

<td style="text-align:left;">

05

</td>

<td style="text-align:right;">

163

</td>

</tr>

<tr>

<td style="text-align:left;">

oklahomacity\_ok

</td>

<td style="text-align:left;">

06

</td>

<td style="text-align:right;">

189

</td>

</tr>

<tr>

<td style="text-align:left;">

oklahomacity\_ok

</td>

<td style="text-align:left;">

07

</td>

<td style="text-align:right;">

3

</td>

</tr>

<tr>

<td style="text-align:left;">

shelby\_tn

</td>

<td style="text-align:left;">

01

</td>

<td style="text-align:right;">

35

</td>

</tr>

<tr>

<td style="text-align:left;">

shelby\_tn

</td>

<td style="text-align:left;">

02

</td>

<td style="text-align:right;">

439

</td>

</tr>

<tr>

<td style="text-align:left;">

shelby\_tn

</td>

<td style="text-align:left;">

03

</td>

<td style="text-align:right;">

491

</td>

</tr>

<tr>

<td style="text-align:left;">

shelby\_tn

</td>

<td style="text-align:left;">

06

</td>

<td style="text-align:right;">

109

</td>

</tr>

</tbody>

</table>

</div>

``` r
# Number of writs SERVED, by location and month
kable(writ_data %>%
  # Filter for cases with writ filing dates
  filter(!(is.na(writ_served_date))&(writ_served_date != "no_information")) %>%
  group_by(location, writ_served_month) %>%
  count()) %>%
  kable_styling(bootstrap_options = c("striped", "hover", "condensed", full_width = FALSE)) %>%
  scroll_box(width = "100%", height = "400px") 
```

<div style="border: 1px solid #ddd; padding: 0px; overflow-y: scroll; height:400px; overflow-x: scroll; width:100%; ">

<table class="table table-striped table-hover table-condensed" style="margin-left: auto; margin-right: auto;">

<thead>

<tr>

<th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;">

location

</th>

<th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;">

writ\_served\_month

</th>

<th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;">

n

</th>

</tr>

</thead>

<tbody>

<tr>

<td style="text-align:left;">

dekalb\_ga

</td>

<td style="text-align:left;">

01

</td>

<td style="text-align:right;">

28

</td>

</tr>

<tr>

<td style="text-align:left;">

dekalb\_ga

</td>

<td style="text-align:left;">

02

</td>

<td style="text-align:right;">

743

</td>

</tr>

<tr>

<td style="text-align:left;">

dekalb\_ga

</td>

<td style="text-align:left;">

03

</td>

<td style="text-align:right;">

418

</td>

</tr>

<tr>

<td style="text-align:left;">

dekalb\_ga

</td>

<td style="text-align:left;">

05

</td>

<td style="text-align:right;">

278

</td>

</tr>

<tr>

<td style="text-align:left;">

dekalb\_ga

</td>

<td style="text-align:left;">

06

</td>

<td style="text-align:right;">

13

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

01

</td>

<td style="text-align:right;">

29

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

02

</td>

<td style="text-align:right;">

249

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

03

</td>

<td style="text-align:right;">

328

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

04

</td>

<td style="text-align:right;">

5

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

05

</td>

<td style="text-align:right;">

11

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

06

</td>

<td style="text-align:right;">

4

</td>

</tr>

<tr>

<td style="text-align:left;">

oklahomacity\_ok

</td>

<td style="text-align:left;">

01

</td>

<td style="text-align:right;">

194

</td>

</tr>

<tr>

<td style="text-align:left;">

oklahomacity\_ok

</td>

<td style="text-align:left;">

02

</td>

<td style="text-align:right;">

341

</td>

</tr>

<tr>

<td style="text-align:left;">

oklahomacity\_ok

</td>

<td style="text-align:left;">

03

</td>

<td style="text-align:right;">

231

</td>

</tr>

<tr>

<td style="text-align:left;">

oklahomacity\_ok

</td>

<td style="text-align:left;">

04

</td>

<td style="text-align:right;">

4

</td>

</tr>

<tr>

<td style="text-align:left;">

oklahomacity\_ok

</td>

<td style="text-align:left;">

05

</td>

<td style="text-align:right;">

81

</td>

</tr>

<tr>

<td style="text-align:left;">

oklahomacity\_ok

</td>

<td style="text-align:left;">

06

</td>

<td style="text-align:right;">

176

</td>

</tr>

<tr>

<td style="text-align:left;">

shelby\_tn

</td>

<td style="text-align:left;">

01

</td>

<td style="text-align:right;">

1

</td>

</tr>

<tr>

<td style="text-align:left;">

shelby\_tn

</td>

<td style="text-align:left;">

02

</td>

<td style="text-align:right;">

93

</td>

</tr>

<tr>

<td style="text-align:left;">

shelby\_tn

</td>

<td style="text-align:left;">

03

</td>

<td style="text-align:right;">

181

</td>

</tr>

<tr>

<td style="text-align:left;">

shelby\_tn

</td>

<td style="text-align:left;">

04

</td>

<td style="text-align:right;">

85

</td>

</tr>

<tr>

<td style="text-align:left;">

shelby\_tn

</td>

<td style="text-align:left;">

05

</td>

<td style="text-align:right;">

44

</td>

</tr>

<tr>

<td style="text-align:left;">

shelby\_tn

</td>

<td style="text-align:left;">

06

</td>

<td style="text-align:right;">

45

</td>

</tr>

</tbody>

</table>

</div>

### Since CARES Act (March 27)

#### Evictions

``` r
# Number of evictions, since Cares (9,672)
evictions_data %>%
  filter(file_date > "2020-03-27") %>%
  # group_by(location) %>%
  count()
```

    ## # A tibble: 1 x 1
    ##       n
    ##   <int>
    ## 1  9672

``` r
# Number of evictions, by location, since Cares
kable(evictions_data %>%
  filter(file_date > "2020-03-27") %>%
  group_by(location) %>%
  count()) %>%
  kable_styling(bootstrap_options = c("striped", "hover", "condensed", full_width = FALSE))
```

<table class="table table-striped table-hover table-condensed" style="margin-left: auto; margin-right: auto;">

<thead>

<tr>

<th style="text-align:left;">

location

</th>

<th style="text-align:right;">

n

</th>

</tr>

</thead>

<tbody>

<tr>

<td style="text-align:left;">

chatham\_ga

</td>

<td style="text-align:right;">

466

</td>

</tr>

<tr>

<td style="text-align:left;">

dekalb\_ga

</td>

<td style="text-align:right;">

1010

</td>

</tr>

<tr>

<td style="text-align:left;">

fulton\_ga

</td>

<td style="text-align:right;">

1247

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:right;">

732

</td>

</tr>

<tr>

<td style="text-align:left;">

milwaukee\_wi

</td>

<td style="text-align:right;">

1608

</td>

</tr>

<tr>

<td style="text-align:left;">

neworleans\_la

</td>

<td style="text-align:right;">

128

</td>

</tr>

<tr>

<td style="text-align:left;">

oklahomacity\_ok

</td>

<td style="text-align:right;">

1193

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:right;">

295

</td>

</tr>

<tr>

<td style="text-align:left;">

shelby\_tn

</td>

<td style="text-align:right;">

1835

</td>

</tr>

<tr>

<td style="text-align:left;">

stlouis\_mo

</td>

<td style="text-align:right;">

75

</td>

</tr>

<tr>

<td style="text-align:left;">

toledo\_oh

</td>

<td style="text-align:right;">

279

</td>

</tr>

<tr>

<td style="text-align:left;">

tulsa\_ok

</td>

<td style="text-align:right;">

804

</td>

</tr>

</tbody>

</table>

``` r
# Number of evictions, by month, since Cares
kable(evictions_data %>% 
  filter(file_date > "2020-03-27") %>%
  group_by(file_month) %>%
  count()) %>%
  kable_styling(bootstrap_options = c("striped", "hover", "condensed", full_width = FALSE))
```

<table class="table table-striped table-hover table-condensed" style="margin-left: auto; margin-right: auto;">

<thead>

<tr>

<th style="text-align:right;">

file\_month

</th>

<th style="text-align:right;">

n

</th>

</tr>

</thead>

<tbody>

<tr>

<td style="text-align:right;">

3

</td>

<td style="text-align:right;">

261

</td>

</tr>

<tr>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

1622

</td>

</tr>

<tr>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2848

</td>

</tr>

<tr>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

4865

</td>

</tr>

<tr>

<td style="text-align:right;">

7

</td>

<td style="text-align:right;">

76

</td>

</tr>

</tbody>

</table>

``` r
# Number of evictions, by month and location, since Cares
kable(evictions_data %>% 
  filter(file_date > "2020-03-27") %>%
  group_by(location, file_month) %>%
  count()) %>%
  kable_styling(bootstrap_options = c("striped", "hover", "condensed", full_width = FALSE)) %>%
  scroll_box(width = "100%", height = "400px") 
```

<div style="border: 1px solid #ddd; padding: 0px; overflow-y: scroll; height:400px; overflow-x: scroll; width:100%; ">

<table class="table table-striped table-hover table-condensed" style="margin-left: auto; margin-right: auto;">

<thead>

<tr>

<th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;">

location

</th>

<th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;">

file\_month

</th>

<th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;">

n

</th>

</tr>

</thead>

<tbody>

<tr>

<td style="text-align:left;">

chatham\_ga

</td>

<td style="text-align:right;">

3

</td>

<td style="text-align:right;">

26

</td>

</tr>

<tr>

<td style="text-align:left;">

chatham\_ga

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

69

</td>

</tr>

<tr>

<td style="text-align:left;">

chatham\_ga

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

122

</td>

</tr>

<tr>

<td style="text-align:left;">

chatham\_ga

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

238

</td>

</tr>

<tr>

<td style="text-align:left;">

chatham\_ga

</td>

<td style="text-align:right;">

7

</td>

<td style="text-align:right;">

11

</td>

</tr>

<tr>

<td style="text-align:left;">

dekalb\_ga

</td>

<td style="text-align:right;">

3

</td>

<td style="text-align:right;">

44

</td>

</tr>

<tr>

<td style="text-align:left;">

dekalb\_ga

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

321

</td>

</tr>

<tr>

<td style="text-align:left;">

dekalb\_ga

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

312

</td>

</tr>

<tr>

<td style="text-align:left;">

dekalb\_ga

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

333

</td>

</tr>

<tr>

<td style="text-align:left;">

fulton\_ga

</td>

<td style="text-align:right;">

3

</td>

<td style="text-align:right;">

45

</td>

</tr>

<tr>

<td style="text-align:left;">

fulton\_ga

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

338

</td>

</tr>

<tr>

<td style="text-align:left;">

fulton\_ga

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

321

</td>

</tr>

<tr>

<td style="text-align:left;">

fulton\_ga

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

543

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:right;">

3

</td>

<td style="text-align:right;">

34

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

190

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

235

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

273

</td>

</tr>

<tr>

<td style="text-align:left;">

milwaukee\_wi

</td>

<td style="text-align:right;">

3

</td>

<td style="text-align:right;">

3

</td>

</tr>

<tr>

<td style="text-align:left;">

milwaukee\_wi

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

15

</td>

</tr>

<tr>

<td style="text-align:left;">

milwaukee\_wi

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

68

</td>

</tr>

<tr>

<td style="text-align:left;">

milwaukee\_wi

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

1473

</td>

</tr>

<tr>

<td style="text-align:left;">

milwaukee\_wi

</td>

<td style="text-align:right;">

7

</td>

<td style="text-align:right;">

49

</td>

</tr>

<tr>

<td style="text-align:left;">

neworleans\_la

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

128

</td>

</tr>

<tr>

<td style="text-align:left;">

oklahomacity\_ok

</td>

<td style="text-align:right;">

3

</td>

<td style="text-align:right;">

5

</td>

</tr>

<tr>

<td style="text-align:left;">

oklahomacity\_ok

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

49

</td>

</tr>

<tr>

<td style="text-align:left;">

oklahomacity\_ok

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

546

</td>

</tr>

<tr>

<td style="text-align:left;">

oklahomacity\_ok

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

587

</td>

</tr>

<tr>

<td style="text-align:left;">

oklahomacity\_ok

</td>

<td style="text-align:right;">

7

</td>

<td style="text-align:right;">

6

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:right;">

3

</td>

<td style="text-align:right;">

22

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

134

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

139

</td>

</tr>

<tr>

<td style="text-align:left;">

shelby\_tn

</td>

<td style="text-align:right;">

3

</td>

<td style="text-align:right;">

62

</td>

</tr>

<tr>

<td style="text-align:left;">

shelby\_tn

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

363

</td>

</tr>

<tr>

<td style="text-align:left;">

shelby\_tn

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

702

</td>

</tr>

<tr>

<td style="text-align:left;">

shelby\_tn

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

708

</td>

</tr>

<tr>

<td style="text-align:left;">

stlouis\_mo

</td>

<td style="text-align:right;">

3

</td>

<td style="text-align:right;">

16

</td>

</tr>

<tr>

<td style="text-align:left;">

stlouis\_mo

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

35

</td>

</tr>

<tr>

<td style="text-align:left;">

stlouis\_mo

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

24

</td>

</tr>

<tr>

<td style="text-align:left;">

toledo\_oh

</td>

<td style="text-align:right;">

3

</td>

<td style="text-align:right;">

4

</td>

</tr>

<tr>

<td style="text-align:left;">

toledo\_oh

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

65

</td>

</tr>

<tr>

<td style="text-align:left;">

toledo\_oh

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

109

</td>

</tr>

<tr>

<td style="text-align:left;">

toledo\_oh

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

101

</td>

</tr>

<tr>

<td style="text-align:left;">

tulsa\_ok

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

43

</td>

</tr>

<tr>

<td style="text-align:left;">

tulsa\_ok

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

270

</td>

</tr>

<tr>

<td style="text-align:left;">

tulsa\_ok

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

481

</td>

</tr>

<tr>

<td style="text-align:left;">

tulsa\_ok

</td>

<td style="text-align:right;">

7

</td>

<td style="text-align:right;">

10

</td>

</tr>

</tbody>

</table>

</div>

``` r
  # arrange(desc(n, location))
```

#### Writs Filed and Served

``` r
## WRIT COUNTS

# Number of writs FILED, by location
kable(writ_data %>%
  # Filter for cases with writ filing dates
  filter(!(is.na(writ_date))&(writ_date != "no_information")) %>%
  # Filter for cases with writs filed after CARES
  filter(writ_date > "2020-03-27") %>%
  group_by(location) %>%
  count()) %>%
  kable_styling(bootstrap_options = c("striped", "hover", "condensed", full_width = FALSE))
```

<table class="table table-striped table-hover table-condensed" style="margin-left: auto; margin-right: auto;">

<thead>

<tr>

<th style="text-align:left;">

location

</th>

<th style="text-align:right;">

n

</th>

</tr>

</thead>

<tbody>

<tr>

<td style="text-align:left;">

fulton\_ga

</td>

<td style="text-align:right;">

1

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:right;">

122

</td>

</tr>

<tr>

<td style="text-align:left;">

oklahomacity\_ok

</td>

<td style="text-align:right;">

356

</td>

</tr>

<tr>

<td style="text-align:left;">

shelby\_tn

</td>

<td style="text-align:right;">

109

</td>

</tr>

</tbody>

</table>

``` r
# Number of writs SERVED, by location
kable(writ_data %>%
  # Filter for cases with writ served dates
  filter(!(is.na(writ_served_date))&(writ_served_date != "no_information")) %>%
  # Filter for cases with writs served after CARES
  filter(writ_served_date > "2020-03-27") %>%
  group_by(location) %>%
  count()) %>%
  kable_styling(bootstrap_options = c("striped", "hover", "condensed", full_width = FALSE))
```

<table class="table table-striped table-hover table-condensed" style="margin-left: auto; margin-right: auto;">

<thead>

<tr>

<th style="text-align:left;">

location

</th>

<th style="text-align:right;">

n

</th>

</tr>

</thead>

<tbody>

<tr>

<td style="text-align:left;">

dekalb\_ga

</td>

<td style="text-align:right;">

291

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:right;">

20

</td>

</tr>

<tr>

<td style="text-align:left;">

oklahomacity\_ok

</td>

<td style="text-align:right;">

262

</td>

</tr>

<tr>

<td style="text-align:left;">

shelby\_tn

</td>

<td style="text-align:right;">

174

</td>

</tr>

</tbody>

</table>

``` r
# Number of writs FILED, by month
kable(writ_data %>%
  # Filter for cases with writ filing dates
  filter(!(is.na(writ_date))&(writ_date != "no_information")) %>%
  # Filter for cases with writs filed after CARES
  filter(writ_date > "2020-03-27") %>%
  group_by(writ_month) %>%
  count()) %>%
  kable_styling(bootstrap_options = c("striped", "hover", "condensed", full_width = FALSE))
```

<table class="table table-striped table-hover table-condensed" style="margin-left: auto; margin-right: auto;">

<thead>

<tr>

<th style="text-align:left;">

writ\_month

</th>

<th style="text-align:right;">

n

</th>

</tr>

</thead>

<tbody>

<tr>

<td style="text-align:left;">

03

</td>

<td style="text-align:right;">

42

</td>

</tr>

<tr>

<td style="text-align:left;">

04

</td>

<td style="text-align:right;">

64

</td>

</tr>

<tr>

<td style="text-align:left;">

05

</td>

<td style="text-align:right;">

177

</td>

</tr>

<tr>

<td style="text-align:left;">

06

</td>

<td style="text-align:right;">

302

</td>

</tr>

<tr>

<td style="text-align:left;">

07

</td>

<td style="text-align:right;">

3

</td>

</tr>

</tbody>

</table>

``` r
# Number of writs SERVED, by month
kable(writ_data %>%
  # Filter for cases with writ filing dates
  filter(!(is.na(writ_served_date))&(writ_served_date != "no_information")) %>%
  # Filter for cases with writs served after CARES
  filter(writ_served_date > "2020-03-27") %>%
  group_by(writ_served_month) %>%
  count()) %>%
  kable_styling(bootstrap_options = c("striped", "hover", "condensed", full_width = FALSE))
```

<table class="table table-striped table-hover table-condensed" style="margin-left: auto; margin-right: auto;">

<thead>

<tr>

<th style="text-align:left;">

writ\_served\_month

</th>

<th style="text-align:right;">

n

</th>

</tr>

</thead>

<tbody>

<tr>

<td style="text-align:left;">

03

</td>

<td style="text-align:right;">

1

</td>

</tr>

<tr>

<td style="text-align:left;">

04

</td>

<td style="text-align:right;">

94

</td>

</tr>

<tr>

<td style="text-align:left;">

05

</td>

<td style="text-align:right;">

414

</td>

</tr>

<tr>

<td style="text-align:left;">

06

</td>

<td style="text-align:right;">

238

</td>

</tr>

</tbody>

</table>

``` r
# Number of writs FILED, by location and month
kable(writ_data %>%
  # Filter for cases with writ filing dates
  filter(!(is.na(writ_date))&(writ_date != "no_information")) %>%
  # Filter for cases with writs filed after CARES
  filter(writ_date > "2020-03-27") %>%
  group_by(location, writ_month) %>%
  count()) %>%
  kable_styling(bootstrap_options = c("striped", "hover", "condensed", full_width = FALSE))
```

<table class="table table-striped table-hover table-condensed" style="margin-left: auto; margin-right: auto;">

<thead>

<tr>

<th style="text-align:left;">

location

</th>

<th style="text-align:left;">

writ\_month

</th>

<th style="text-align:right;">

n

</th>

</tr>

</thead>

<tbody>

<tr>

<td style="text-align:left;">

fulton\_ga

</td>

<td style="text-align:left;">

06

</td>

<td style="text-align:right;">

1

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

03

</td>

<td style="text-align:right;">

42

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

04

</td>

<td style="text-align:right;">

63

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

05

</td>

<td style="text-align:right;">

14

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

06

</td>

<td style="text-align:right;">

3

</td>

</tr>

<tr>

<td style="text-align:left;">

oklahomacity\_ok

</td>

<td style="text-align:left;">

04

</td>

<td style="text-align:right;">

1

</td>

</tr>

<tr>

<td style="text-align:left;">

oklahomacity\_ok

</td>

<td style="text-align:left;">

05

</td>

<td style="text-align:right;">

163

</td>

</tr>

<tr>

<td style="text-align:left;">

oklahomacity\_ok

</td>

<td style="text-align:left;">

06

</td>

<td style="text-align:right;">

189

</td>

</tr>

<tr>

<td style="text-align:left;">

oklahomacity\_ok

</td>

<td style="text-align:left;">

07

</td>

<td style="text-align:right;">

3

</td>

</tr>

<tr>

<td style="text-align:left;">

shelby\_tn

</td>

<td style="text-align:left;">

06

</td>

<td style="text-align:right;">

109

</td>

</tr>

</tbody>

</table>

``` r
# Number of writs SERVED, by location and month
kable(writ_data %>%
  # Filter for cases with writ filing dates
  filter(!(is.na(writ_served_date))&(writ_served_date != "no_information")) %>%
  # Filter for cases with writs served after CARES
  filter(writ_served_date > "2020-03-27") %>%
  group_by(location, writ_served_month) %>%
  count()) %>%
  kable_styling(bootstrap_options = c("striped", "hover", "condensed", full_width = FALSE))
```

<table class="table table-striped table-hover table-condensed" style="margin-left: auto; margin-right: auto;">

<thead>

<tr>

<th style="text-align:left;">

location

</th>

<th style="text-align:left;">

writ\_served\_month

</th>

<th style="text-align:right;">

n

</th>

</tr>

</thead>

<tbody>

<tr>

<td style="text-align:left;">

dekalb\_ga

</td>

<td style="text-align:left;">

05

</td>

<td style="text-align:right;">

278

</td>

</tr>

<tr>

<td style="text-align:left;">

dekalb\_ga

</td>

<td style="text-align:left;">

06

</td>

<td style="text-align:right;">

13

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

04

</td>

<td style="text-align:right;">

5

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

05

</td>

<td style="text-align:right;">

11

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

06

</td>

<td style="text-align:right;">

4

</td>

</tr>

<tr>

<td style="text-align:left;">

oklahomacity\_ok

</td>

<td style="text-align:left;">

03

</td>

<td style="text-align:right;">

1

</td>

</tr>

<tr>

<td style="text-align:left;">

oklahomacity\_ok

</td>

<td style="text-align:left;">

04

</td>

<td style="text-align:right;">

4

</td>

</tr>

<tr>

<td style="text-align:left;">

oklahomacity\_ok

</td>

<td style="text-align:left;">

05

</td>

<td style="text-align:right;">

81

</td>

</tr>

<tr>

<td style="text-align:left;">

oklahomacity\_ok

</td>

<td style="text-align:left;">

06

</td>

<td style="text-align:right;">

176

</td>

</tr>

<tr>

<td style="text-align:left;">

shelby\_tn

</td>

<td style="text-align:left;">

04

</td>

<td style="text-align:right;">

85

</td>

</tr>

<tr>

<td style="text-align:left;">

shelby\_tn

</td>

<td style="text-align:left;">

05

</td>

<td style="text-align:right;">

44

</td>

</tr>

<tr>

<td style="text-align:left;">

shelby\_tn

</td>

<td style="text-align:left;">

06

</td>

<td style="text-align:right;">

45

</td>

</tr>

</tbody>

</table>

### Since State-Issued Moratoria

[Moratoria by
State](https://docs.google.com/spreadsheets/u/1/d/e/2PACX-1vTH8dUIbfnt3X52TrY3dEHQCAm60e5nqo0Rn1rNCf15dPGeXxM9QN9UdxUfEjxwvfTKzbCbZxJMdR7X/pubhtml)
as compiled by ?. “State Summaries” below are taken from here.

**We have data for:**

  - Florida
  - Georgia
  - Louisiana
  - Montana
  - Ohio
  - Oklahoma
  - Tennessee
  - Wisconsin

<!-- end list -->

``` r
# See which states we have evictions data for
evictions_data %>%
  separate(col = location,
           into = c("city", "state"),
           sep = "_",
           remove = F) %>%
  select(-city) %>%
  group_by(state) %>%
  count()
```

    ## # A tibble: 8 x 2
    ## # Groups:   state [8]
    ##   state     n
    ##   <chr> <int>
    ## 1 fl     5129
    ## 2 ga    22886
    ## 3 la     1117
    ## 4 mo      436
    ## 5 oh     1499
    ## 6 ok     8566
    ## 7 tn     7785
    ## 8 wi     4384

#### Florida

**Moratorium Bottom Line**

  - Began: April 2
  - Still in effect: Yes
  - Expires: Aug. 1
  - Covers: Evictions related to COVID-19

**State Summary**

  - On **April 2**, Governor DeSantis suspended statutes giving a cause
    of action for eviction *related to COVID19* and foreclosure *for 45
    days*. On May 14, the order was extended to June 2 and on June 1 it
    was extended to July 1 and on June 30 it was *extended to August 1*.
  - The Florida Supreme Court suspended the requirement for the clerk to
    issue writs of possession “forthwith” until July 2.
  - The Governor announced a $250 million housing assistance program,
    which provides $120 million to the state housing authorities, and
    $120 million to counties to assist renters.

##### Eviction Filings

``` r
# View which locations within FL we have data for
kable(evictions_data %>%
  filter(str_detect(location, "_fl")) %>%
  group_by(location) %>%
  count()) %>%
  kable_styling(bootstrap_options = c("striped", "hover", "condensed", full_width = FALSE))
```

<table class="table table-striped table-hover table-condensed" style="margin-left: auto; margin-right: auto;">

<thead>

<tr>

<th style="text-align:left;">

location

</th>

<th style="text-align:right;">

n

</th>

</tr>

</thead>

<tbody>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:right;">

3460

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:right;">

1669

</td>

</tr>

</tbody>

</table>

``` r
# View number of evictions since moratorium
kable(evictions_data %>%
  # Only places in FL
  filter(str_detect(location, "_fl")) %>%
  # Since April 2
  filter(file_date > "2020-04-02") %>%
  group_by(location) %>%
  count()) %>%
  kable_styling(bootstrap_options = c("striped", "hover", "condensed", full_width = FALSE))
```

<table class="table table-striped table-hover table-condensed" style="margin-left: auto; margin-right: auto;">

<thead>

<tr>

<th style="text-align:left;">

location

</th>

<th style="text-align:right;">

n

</th>

</tr>

</thead>

<tbody>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:right;">

676

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:right;">

254

</td>

</tr>

</tbody>

</table>

``` r
## Break it down by location

# View eviction cases since hillsborough_fl's moratorium
kable(evictions_data %>%
  # Only places in hillsborough_fl
  filter(location == "hillsborough_fl") %>%
  # Since April 2
  filter(file_date > "2020-04-02")) %>%
  kable_styling(bootstrap_options = c("striped", "hover", "condensed", full_width = FALSE)) %>%
  scroll_box(width = "100%", height = "400px") 
```

<div style="border: 1px solid #ddd; padding: 0px; overflow-y: scroll; height:400px; overflow-x: scroll; width:100%; ">

<table class="table table-striped table-hover table-condensed" style="margin-left: auto; margin-right: auto;">

<thead>

<tr>

<th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;">

location

</th>

<th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;">

case\_number

</th>

<th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;">

file\_date

</th>

<th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;">

file\_month

</th>

<th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;">

file\_year

</th>

<th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;">

plaintiff

</th>

<th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;">

defendant

</th>

<th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;">

defendant\_address

</th>

<th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;">

plaintiff\_attorney

</th>

<th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;">

defendant\_attorney

</th>

<th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;">

case\_type

</th>

<th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;">

writ\_date

</th>

<th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;">

writ\_served\_date

</th>

</tr>

</thead>

<tbody>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-027119

</td>

<td style="text-align:left;">

2020-04-30

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

dietz michael

</td>

<td style="text-align:left;">

vincent joseph 6803 1/2 s. westshore blvd apt d tampa fl 33616

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-027143

</td>

<td style="text-align:left;">

2020-04-30

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

dietz michael

</td>

<td style="text-align:left;">

munoz oscar 205 holland ave temple terrace fl 33617

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-027167

</td>

<td style="text-align:left;">

2020-04-30

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

dietz michael

</td>

<td style="text-align:left;">

thomas bryan delsondred 6808 s shamrock rd tampa fl 33616|thomas kelly
deshon 6808 s shamrock rd tampa fl 33616

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-027215

</td>

<td style="text-align:left;">

2020-04-30

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

dietz michael

</td>

<td style="text-align:left;">

noggle cassie l 4523 s renellie dr tampa fl 33611|monton samuel 4523 s
renellie dr tampa fl 33611

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-027450

</td>

<td style="text-align:left;">

2020-04-30

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

livingston kayla adams|livingston zackery freeman

</td>

<td style="text-align:left;">

any and all unnamed tenants 10626 county road 579 thonotosassa fl
33592|coniglio amber 10626 county road 579 thonotosassa fl 33592

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction- possession only

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-027458

</td>

<td style="text-align:left;">

2020-04-30

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

orozco rolando

</td>

<td style="text-align:left;">

hernandez eduardo 7213 n gunlock ave tampa fl 33614

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction- possession only

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-027460

</td>

<td style="text-align:left;">

2020-04-30

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

dickerson samuel

</td>

<td style="text-align:left;">

glover denise 3109 e 29th ave tampa fl 33605|martin george 3109 e 29th
ave tampa fl 33605

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-027528

</td>

<td style="text-align:left;">

2020-04-30

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

rosenblatt jeffrey

</td>

<td style="text-align:left;">

austin robert 8331 paddlewheel st tampa fl 33637|austin kimberly 8331
paddlewheel st tampa fl 33637

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-027548

</td>

<td style="text-align:left;">

2020-04-30

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

dietze michael

</td>

<td style="text-align:left;">

algarin idaliss 6803 s westshore blvd apt a tampa fl 33616

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-027564

</td>

<td style="text-align:left;">

2020-04-30

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

scaglione 5th avenue apartments llc

</td>

<td style="text-align:left;">

in occupancy unknown parties 1804 1/2 east 5th ave. apt 4 tampa fl
33605|meads nyshia 1804 1/2 east 5th ave. apt. 4 tampa fl 33605

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt unlawful detainer

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-027666

</td>

<td style="text-align:left;">

2020-04-30

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

saad investment inc.

</td>

<td style="text-align:left;">

covington tyrone 500 110th avenue n st. petersburg fl 33716|ettouati
zakariae 2509 sherwood street winter haven fl 33881|alia inc. 2509
sherwood street winter haven fl 33881|covington investments corp. 1225
south 78th street tampa fl 33619

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-027477

</td>

<td style="text-align:left;">

2020-04-29

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

thomas chandy|thomas chandy

</td>

<td style="text-align:left;">

ramirez jaime e. 1118 lake shore ranch dr seffner fl 33584|ramirez
shirlana l. 1118 lake shore ranch dr seffner fl 33584|ramirez jaime e
1118 lake shore ranch dr. seffner fl 33584|ramirez shirlana l 1118 lake
shore ranch dr seffner fl 33584

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-027266

</td>

<td style="text-align:left;">

2020-04-29

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

hakeem investments florida lllp

</td>

<td style="text-align:left;">

barnett victor d 13106 north florida avenue apartment \#214 tampa fl
33612

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-026938

</td>

<td style="text-align:left;">

2020-04-29

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

alin erik|erik alin

</td>

<td style="text-align:left;">

preston timothy 103 e. kentucky ave apt 4 tampa fl 33603

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-026995

</td>

<td style="text-align:left;">

2020-04-29

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

nguyen sang|nguyen anh

</td>

<td style="text-align:left;">

johnson maurice arnold 2005 e. 142nd ave apt 6 tampa fl 33613

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-026999

</td>

<td style="text-align:left;">

2020-04-29

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

nguyen sang|nguyen anh

</td>

<td style="text-align:left;">

castro diaz jose luis 14002 carmen ct. apt \#a tampa fl 33613

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-027005

</td>

<td style="text-align:left;">

2020-04-29

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

easterly matthew f

</td>

<td style="text-align:left;">

filor kathleen 4409 w prescott st tampa fl 33616

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction- possession only

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-027023

</td>

<td style="text-align:left;">

2020-04-29

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

vawter investments llc|vawter lee david lewis jr

</td>

<td style="text-align:left;">

bruce kerry james 502 east davis blvd tampa fl 33606

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-027043

</td>

<td style="text-align:left;">

2020-04-29

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

mehta ramesh

</td>

<td style="text-align:left;">

garnett sherisse 14205-b n 12th street tampa fl 33613

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-027046

</td>

<td style="text-align:left;">

2020-04-29

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

glennwood property services llc

</td>

<td style="text-align:left;">

cato tony

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-027067

</td>

<td style="text-align:left;">

2020-04-29

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

savitt andrew

</td>

<td style="text-align:left;">

rivera henry 819a e broad st tampa fl 33604

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-027068

</td>

<td style="text-align:left;">

2020-04-29

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

gohar javed

</td>

<td style="text-align:left;">

stephens danielle 314 tweed ave seffner fl 33584

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-026931

</td>

<td style="text-align:left;">

2020-04-28

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

essex mayra

</td>

<td style="text-align:left;">

all and any unknown occupants 938 brenton leaf drive ruskin fl
33570|casanova maikel armando jr 938 brenton leaf drive ruskin fl 33570

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt unlawful detainer

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

2020-05-27

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-026803

</td>

<td style="text-align:left;">

2020-04-28

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

phung hien

</td>

<td style="text-align:left;">

hopkins shawndra 909 e humphrey st apt \#b tampa fl 33604

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-026805

</td>

<td style="text-align:left;">

2020-04-28

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

phung hien

</td>

<td style="text-align:left;">

ruiz hector 909 e humphrey st apt \#c tampa fl 33604

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-026821

</td>

<td style="text-align:left;">

2020-04-28

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

le nguyen|la thao

</td>

<td style="text-align:left;">

diaye mariama n 1010 e. hillsborough ave. tampa fl 33601

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-026849

</td>

<td style="text-align:left;">

2020-04-28

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

raffety robert

</td>

<td style="text-align:left;">

craig aubrie 716 oakgrove dr \# 236 brandon fl 33510

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-026859

</td>

<td style="text-align:left;">

2020-04-27

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

timber falls apartments|timberfalls apartments llc|tzadik management

</td>

<td style="text-align:left;">

throw frances m 11319 winter ct apt d tampa fl 33612

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction- possession only

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-026883

</td>

<td style="text-align:left;">

2020-04-27

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

rental marketing solutions llc

</td>

<td style="text-align:left;">

franz dustin 8309 n. marks st. unit \#b tampa fl 33604

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction- possession only

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-026902

</td>

<td style="text-align:left;">

2020-04-27

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

skipper palms plaza llc

</td>

<td style="text-align:left;">

bravo|kings supermarket inc. 2540 east bearss avenue tampa fl 33613

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction- possession only

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-026824

</td>

<td style="text-align:left;">

2020-04-27

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

palm court apartments|tampa palms mmg llc|tzadik management

</td>

<td style="text-align:left;">

springer mark j 13020 kain palm blvd apt 301 tampa fl 33647

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction- possession only

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-026845

</td>

<td style="text-align:left;">

2020-04-27

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

palm court apartments|tampa palms mmg llc|tzadik management

</td>

<td style="text-align:left;">

henserson laderria 13036 kain palm blvd apt 102 tampa fl 33647

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction- possession only

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-026809

</td>

<td style="text-align:left;">

2020-04-27

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

avesta del rio apartments|tzadik acquisitions llc|tzadik management

</td>

<td style="text-align:left;">

coleman hilda g 6806 north 50th street apt d tampa fl 33617

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction- possession only

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-026810

</td>

<td style="text-align:left;">

2020-04-27

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

zamn properties llc|merchant muneer m

</td>

<td style="text-align:left;">

wofford mark 1430 delano trent street ruskin fl 33570

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction- possession only

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-026773

</td>

<td style="text-align:left;">

2020-04-27

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

jones alan

</td>

<td style="text-align:left;">

santana crystal 3620 n 55th st tampa fl 33619|santana maria 3620 n 55th
st tampa fl 33619

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-026778

</td>

<td style="text-align:left;">

2020-04-27

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

wilcox linda

</td>

<td style="text-align:left;">

gibson jerome 1905 n taliaferro ave apt 2a tampa fl 33602

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction- possession only

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-026779

</td>

<td style="text-align:left;">

2020-04-27

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

carrera ernest

</td>

<td style="text-align:left;">

mercer mary rose 2401 bayshore blvd unit 1001 tampa fl 33629

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-026788

</td>

<td style="text-align:left;">

2020-04-27

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

brown william a

</td>

<td style="text-align:left;">

denson christina nicole 106 w. stanley st. apt. d tampa fl 33604

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-026969

</td>

<td style="text-align:left;">

2020-04-27

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

tzadik acquisitions llc|tzadik management|avesta del rio apartments

</td>

<td style="text-align:left;">

romero tasha 6808 n 50th st apt c tampa fl 33617

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction- possession only

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-026780

</td>

<td style="text-align:left;">

2020-04-24

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

oxford place at tampa palms condominium association inc

</td>

<td style="text-align:left;">

plata family trust dated may 22 2006|occupants unknown tenants / 5125
palm springs blvd unit 11-207 tampa fl 33647|guanayem hanna george 5125
palm springs blvd unit 11-207 tampa fl 33647|plata melissa 5125 palm
springs blvd unit 11- 207 tampa fl 33647|plata nellie 4273 enfield court
palm harbor fl 34685|plata fernando 4273 enfield court palm harbor fl
34685

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt unlawful detainer

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-026509

</td>

<td style="text-align:left;">

2020-04-24

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

espinosa guillermo|valrico holdings llc

</td>

<td style="text-align:left;">

mcqueen cliff 12130 feldwood creek ln riverview fl 33579

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt unlawful detainer

</td>

<td style="text-align:left;">

2020-05-12

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-026568

</td>

<td style="text-align:left;">

2020-04-24

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

dixon carol

</td>

<td style="text-align:left;">

feliz eva m 8205 briargate ct tampa fl 33615

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-026570

</td>

<td style="text-align:left;">

2020-04-24

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

hujar duelda l

</td>

<td style="text-align:left;">

ivizarry wanda 523 maydell dr apt a tampa fl 33619

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-026575

</td>

<td style="text-align:left;">

2020-04-24

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

dykes diana c

</td>

<td style="text-align:left;">

tipton tina 19109 brown rd lutz fl 33559

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-026599

</td>

<td style="text-align:left;">

2020-04-24

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

50th street property services llc

</td>

<td style="text-align:left;">

thomas jermaine 2310 s 50th st lot 11a tampa fl 33619

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-026600

</td>

<td style="text-align:left;">

2020-04-24

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

grandview family communities llc

</td>

<td style="text-align:left;">

willis kayla 11614 cantebury dr 4 seffner fl 33584

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-026601

</td>

<td style="text-align:left;">

2020-04-24

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

glennwood property services llc

</td>

<td style="text-align:left;">

keeth pamela 5012 habersham ln tampa fl 33619

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-026603

</td>

<td style="text-align:left;">

2020-04-24

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

cuevas rolando i sr

</td>

<td style="text-align:left;">

cuevas alanda 1802 humphrey st. tampa fl 33604|cuevas rolando i jr 1802
e humphrey st. tampa fl 33604

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt unlawful detainer

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-026645

</td>

<td style="text-align:left;">

2020-04-24

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

tzadik management|heritage cove mmg llc|heritage cove apartments

</td>

<td style="text-align:left;">

barrow danecia 7302 heritage hills dr apt a temple terrace fl 33637

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction- possession only

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-026694

</td>

<td style="text-align:left;">

2020-04-24

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

tzadik management|heritage cove mmg llc|heritage cove apartments

</td>

<td style="text-align:left;">

bellamy kathleen 7309 heritage hills d apt d temple terrace fl 33637

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction- possession only

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-026699

</td>

<td style="text-align:left;">

2020-04-24

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

tzadik management|heritage cove mmg llc|heritage cove apartments

</td>

<td style="text-align:left;">

washinton starquan 7407 heritage hills dr apt a temple terrace fl
33637|washington jamella 7407 heritage hills dr apt a temple terrace fl
33637

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction- possession only

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-026711

</td>

<td style="text-align:left;">

2020-04-24

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

tzadik management|heritage cove mmg llc|heritage cove apartments

</td>

<td style="text-align:left;">

lise tinana n 7408 heritage hills dr apt b temple terrace fl 33637

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction- possession only

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-026717

</td>

<td style="text-align:left;">

2020-04-24

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

tzadik management|heritage cove mmg llc|heritage cove apartments

</td>

<td style="text-align:left;">

reed deandre 7408 heritage hills dr apt c temple terrace fl 33637|harris
kennard 7408 heritage hills dr apt c temple terrace fl 33637

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction- possession only

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-026718

</td>

<td style="text-align:left;">

2020-04-24

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

tzadik management|heritage cove mmg llc|heritage cove apartments

</td>

<td style="text-align:left;">

gillespie latrise 7410 heritage hills dr apt d temple terrace fl 33637

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction- possession only

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-026722

</td>

<td style="text-align:left;">

2020-04-24

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

tzadik management|heritage cove mmg llc|heritage cove apartments

</td>

<td style="text-align:left;">

bowman shakera 9104 heritage hills dr apt d temple terrace fl 33637

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction- possession only

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-026728

</td>

<td style="text-align:left;">

2020-04-24

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

tampa 2020-1 inc|bravo home management inc

</td>

<td style="text-align:left;">

hisman charlie 1007 davis dr tampa fl 33619|columbia erica 1007 davis dr
tampa fl 33619|hisman tasha 1007 davis dr tampa fl 33619

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction- possession only

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-026752

</td>

<td style="text-align:left;">

2020-04-24

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

goyanes ana beatriz

</td>

<td style="text-align:left;">

martinez soto bellmarie 4907 murray hill drive tampa fl 33615|guerra
campo mileydys 4907 murray hill drive tampa fl 33615

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt unlawful detainer

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-026222

</td>

<td style="text-align:left;">

2020-04-23

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

o’grady patricia “patty”

</td>

<td style="text-align:left;">

abreu ana 501 knights run ave. unit 2119 harbour island tampa fl
33602|abreu daniel 501 knights run ave. unit 2119 harbour island tampa
fl 33602

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-026451

</td>

<td style="text-align:left;">

2020-04-23

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

tzadik management|heritage cove mmg llc|heritage cove apartments

</td>

<td style="text-align:left;">

spain kina 7301 heritage hills dr apt d temple terrace fl 33637

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction- possession only

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-026035

</td>

<td style="text-align:left;">

2020-04-22

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

wallis charles

</td>

<td style="text-align:left;">

hill samantha parsons village mhp 1014 n parsons avenue lot 20 seffner
fl 33584

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-026036

</td>

<td style="text-align:left;">

2020-04-22

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

messina michele a

</td>

<td style="text-align:left;">

harrison rickie 1017 e 23rd ave tampa fl 33605

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction- possession only

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-026049

</td>

<td style="text-align:left;">

2020-04-22

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

middleton lisa

</td>

<td style="text-align:left;">

myrick laurier richard 5508 n 34th st tampa fl 33610

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction- possession only

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-026050

</td>

<td style="text-align:left;">

2020-04-22

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

greene barbara|greene robin

</td>

<td style="text-align:left;">

peavey bobbi jo 3511 e. knollwood tampa fl 33610

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt unlawful detainer

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-026131

</td>

<td style="text-align:left;">

2020-04-22

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

austin myron l ii

</td>

<td style="text-align:left;">

singleton terrell 12308 kentbrook manor ln riverview fl 33579

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction- possession only

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

2020-04-27

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-025757

</td>

<td style="text-align:left;">

2020-04-21

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

2310 w saint joseph st llc

</td>

<td style="text-align:left;">

seetaram gavin 2310 w. st. joseph st. tampa fl 33607

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction- possession only

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-025780

</td>

<td style="text-align:left;">

2020-04-21

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

santos mike

</td>

<td style="text-align:left;">

lugo damaris l 6601 n nebraska ave apt 3 tampa fl 33604|mercado victor l
6601 n nebraska ave apt 3 tampa fl 33604

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-025781

</td>

<td style="text-align:left;">

2020-04-21

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

santos mike

</td>

<td style="text-align:left;">

mcmillan renetha marioliecya 1009 e 26th ave apt 1 tampa fl 33605|pierre
louis 1009 e 26th ave apt 1 tampa fl 33605

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-025782

</td>

<td style="text-align:left;">

2020-04-21

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

santos mike

</td>

<td style="text-align:left;">

baker al jr 10108 n 10th street apt b tampa fl 33612

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-025783

</td>

<td style="text-align:left;">

2020-04-21

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

santos mike

</td>

<td style="text-align:left;">

hester craig 2528 w cherry st apt a tampa fl 33607

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-025784

</td>

<td style="text-align:left;">

2020-04-21

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

santos mike

</td>

<td style="text-align:left;">

whitehead nathaniel l 1608 e kirby st tampa fl 33604|whitehead wanda l
1608 e kirby st tampa fl 33604

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-025785

</td>

<td style="text-align:left;">

2020-04-21

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

rodriguez monica

</td>

<td style="text-align:left;">

pizarro jose samuel jr 12130 us hwy 41 s lot 32 gibsonton fl
33534|guerrero deanna 12130 us hwy 41 s lot 32 gibsonton fl 33534

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt unlawful detainer

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-025804

</td>

<td style="text-align:left;">

2020-04-21

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

di masi maria elena|di masi leonardo

</td>

<td style="text-align:left;">

ogden scott 759 isleton drive brandon fl 33511|ogden angela 759 isleton
drive brandon fl 33511

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-ca-003477

</td>

<td style="text-align:left;">

2020-04-21

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

perry gregory|eagles point ventures llc|eagles point ventures llc

</td>

<td style="text-align:left;">

perry gregory 15501 bruce b. downs blvd. apt. 4110 tampa fl 33647|eagles
point ventures llc|eagles point ventures llc

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

removal of tenant

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-025825

</td>

<td style="text-align:left;">

2020-04-21

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

salvia diane m

</td>

<td style="text-align:left;">

king colbi elaine|fletcher lacey|mcknight joshua

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-025904

</td>

<td style="text-align:left;">

2020-04-21

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

pepperwood apartments dpm llc

</td>

<td style="text-align:left;">

bonilla herrera melvin 13743 susan kay drive apt. c tampa fl 33613

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-025453

</td>

<td style="text-align:left;">

2020-04-20

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

cwb properties inc

</td>

<td style="text-align:left;">

broskey edwin 910 half moon cir lutz fl 33548

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-025454

</td>

<td style="text-align:left;">

2020-04-20

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

sns freight llc

</td>

<td style="text-align:left;">

llabona rolando german 6115 hartford st prowlerrv vin\#1ec1g3122t2880350
tampa fl 33619

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt unlawful detainer

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-025482

</td>

<td style="text-align:left;">

2020-04-20

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

clayton kathi|clayton michael

</td>

<td style="text-align:left;">

dela rosa benito 1118 10th st sw ruskin fl 33570|dela rosa trinidad 1118
10 th st sw ruskin fl 33570|dela rosa lolo jr 1118 10 th st sw ruskin fl
33570|george lydia j 1118 sw 10th st ruskin fl 33570

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-025545

</td>

<td style="text-align:left;">

2020-04-20

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

snake eyes llc

</td>

<td style="text-align:left;">

cflsd & l inc. 8443 n. florida ave. tampa fl 33604|dutt harpaul narain
8443 n. florida ave. tampa fl 33604

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-025566

</td>

<td style="text-align:left;">

2020-04-20

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

south county land & homes llc

</td>

<td style="text-align:left;">

monroe michele 19066 red bird lane lithia fl 33547|monroe michele 19066
red bird lane lithia fl 33547|bissette brian 19066 red bird lane lithia
fl 33547|bissette brian 19066 red bird lane lithia fl 33547

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-025593

</td>

<td style="text-align:left;">

2020-04-20

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

raffoul abdallah

</td>

<td style="text-align:left;">

booker evelin 18101 misty blue lane tampa fl 33647|booker james 18101
misty blue lane tampa fl 33647

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction- possession only

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-025353

</td>

<td style="text-align:left;">

2020-04-20

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

nguyen anh|nguyen sang

</td>

<td style="text-align:left;">

maddox keevius t 14010 carmen ct apt \#b tampa fl 33613

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-025371

</td>

<td style="text-align:left;">

2020-04-20

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

nguyen anh|nguyen sang

</td>

<td style="text-align:left;">

mcdonald robyn mynnon 1512 e 140th ave apt c tampa fl 33613

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-025383

</td>

<td style="text-align:left;">

2020-04-20

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

nguyen anh|nguyen sang

</td>

<td style="text-align:left;">

scholfield darnell 1401 college park ct apt \#b tampa fl 33612

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-025397

</td>

<td style="text-align:left;">

2020-04-20

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

nguyen anh|nguyen sang

</td>

<td style="text-align:left;">

santiago rebecca a 12425 n 58th st apt \#c tampa fl 33617

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-025403

</td>

<td style="text-align:left;">

2020-04-20

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

nguyen anh|nguyen sang

</td>

<td style="text-align:left;">

cooper denisha nicole 1702 e idell street apt b tampa fl 33604

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-025414

</td>

<td style="text-align:left;">

2020-04-20

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

kim mina

</td>

<td style="text-align:left;">

byrd dylan wade 8409 n 40th st tampa fl 33604

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-025417

</td>

<td style="text-align:left;">

2020-04-20

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

nguyen anh|nguyen sang

</td>

<td style="text-align:left;">

brown donell l 1909 e 137th ave apt b tampa fl 33613

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-025418

</td>

<td style="text-align:left;">

2020-04-18

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

coas group inc.

</td>

<td style="text-align:left;">

tucker cristal 109 little pepper lane seffner fl 33584|tucker thomas 109
little pepper lane seffner fl 33584

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-025189

</td>

<td style="text-align:left;">

2020-04-17

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

bay west club|lakeshore colonial llc

</td>

<td style="text-align:left;">

doe john 214 jason drive lot no 371 tampa fl 33615|mederos lazaro r 214
jason drive lot no 371 tampa fl 33615|de oca perez jorge montes 214
jason drive lot no 371 tampa fl 33615

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction- possession only

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-025214

</td>

<td style="text-align:left;">

2020-04-17

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

wang geng

</td>

<td style="text-align:left;">

taylor roscoe 8308 windsor bluff drive tampa fl 33647

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-025254

</td>

<td style="text-align:left;">

2020-04-17

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

jennings thomas

</td>

<td style="text-align:left;">

best amber 114 w. wilder ave tampa fl 33603|bryan damon 114 w. wilder
ave tampa fl 33603

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt unlawful detainer

</td>

<td style="text-align:left;">

2020-05-12

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-025345

</td>

<td style="text-align:left;">

2020-04-17

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

rafi family revocable trust

</td>

<td style="text-align:left;">

cully carissa 11009 golden silence drive riverview fl 33579|soto sulma
11009 golden silence drive riverview fl 33579

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-025022

</td>

<td style="text-align:left;">

2020-04-17

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

cicala george

</td>

<td style="text-align:left;">

gallyard tosha 8116 n 14th st. tampa fl 33604

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-025040

</td>

<td style="text-align:left;">

2020-04-17

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

killing ralph

</td>

<td style="text-align:left;">

pratts viktoria angelee 3411 north 52nd street tampa fl 33619|mulero
petra 3411 north 52nd street tampa fl 33619

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-025045

</td>

<td style="text-align:left;">

2020-04-17

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

alin erik|a+ properties inc

</td>

<td style="text-align:left;">

jones cynthia sheila 3602 e chelsea street tampa fl 33610

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-025076

</td>

<td style="text-align:left;">

2020-04-17

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

spence james

</td>

<td style="text-align:left;">

demetrio portilla 10907 lee st. tampa fl 33610

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-025099

</td>

<td style="text-align:left;">

2020-04-17

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

50th street property services llc

</td>

<td style="text-align:left;">

hunter samantha 2310 s 50th st lot \#7 tampa fl 33619

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-025100

</td>

<td style="text-align:left;">

2020-04-17

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

camelot family comm llc

</td>

<td style="text-align:left;">

ford shanee 11618 courageous court lot 85 thonotosassa fl 33592

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-025103

</td>

<td style="text-align:left;">

2020-04-17

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

countryside village mhp|valrico family communities llc

</td>

<td style="text-align:left;">

trevino maximiliano 1221 n valrico rd lot 4 valrico fl 33594

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-025104

</td>

<td style="text-align:left;">

2020-04-17

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

valrico family communities llc

</td>

<td style="text-align:left;">

crawford angelisa 1221 n valrico rd lot 38 valrico fl 33594

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-025105

</td>

<td style="text-align:left;">

2020-04-17

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

treasure cove llc

</td>

<td style="text-align:left;">

tickles jacob

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-025119

</td>

<td style="text-align:left;">

2020-04-17

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

la thao|le nguyen

</td>

<td style="text-align:left;">

le raicies adam maguel 3717 n whittier st tampa fl 33619

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-025176

</td>

<td style="text-align:left;">

2020-04-16

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

vantage on hillsborough|bridgeview apartments llc

</td>

<td style="text-align:left;">

alvarez gerson 5305 reflections club dr. apt. 206 tampa fl 33634

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction- possession only

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-024661

</td>

<td style="text-align:left;">

2020-04-16

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

sutter anthony|ferrel melissa

</td>

<td style="text-align:left;">

bolden april 731 debbie circle tampa fl 33613

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction- possession only

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-024687

</td>

<td style="text-align:left;">

2020-04-16

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

morris michael

</td>

<td style="text-align:left;">

mccrrary billy 2335 w nassau st tampa fl 33607

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction- possession only

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-024889

</td>

<td style="text-align:left;">

2020-04-16

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

hamburg marc d

</td>

<td style="text-align:left;">

baxley shannon m 920 e 19th ave tampa fl 33605

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-024346

</td>

<td style="text-align:left;">

2020-04-15

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

meysembourg mark

</td>

<td style="text-align:left;">

evens britany m 8317 n 13th st \#a tampa fl 33612|evens daphine m 8317 n
13th street \#a tampa fl 33612

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-024488

</td>

<td style="text-align:left;">

2020-04-15

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

karnia sebastian

</td>

<td style="text-align:left;">

fiffie sandra 910 e annie st. apt. c tampa fl 33612

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-024489

</td>

<td style="text-align:left;">

2020-04-15

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

gjnmjjr llc

</td>

<td style="text-align:left;">

azpeitia christie deanna 3727 w. cass street tampa fl 33609

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-024515

</td>

<td style="text-align:left;">

2020-04-14

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

carastro douglas a|carastro douglas a

</td>

<td style="text-align:left;">

ball sarah a. 5000 culbreath key way unit 8-301 tampa fl 33611

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt unlawful detainer

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-024581

</td>

<td style="text-align:left;">

2020-04-14

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

heritage cove mmg llc|tzadik management|heritage cove apartments

</td>

<td style="text-align:left;">

pollock yancy l 7405 heritage hills dr apt c temple terrace fl 33637

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction- possession only

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-024092

</td>

<td style="text-align:left;">

2020-04-14

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

5208giddensave llc

</td>

<td style="text-align:left;">

hawkins breanna 100 w giddens ave @205 tampa fl 33603

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-024148

</td>

<td style="text-align:left;">

2020-04-14

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

savitt andrew

</td>

<td style="text-align:left;">

olmo christian|monsalve camila

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-024237

</td>

<td style="text-align:left;">

2020-04-14

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

jackson ebone

</td>

<td style="text-align:left;">

gillispie mckenzie 6803 sapphire ct temple terrace fl 33607|gillispie
freda 6803 sapphire ct temple terrace fl 33607|gillispie gabriel 6803
sapphire ct temple terrace fl 33607|freeman stacey 6803 sapphire ct
temple terrace fl 33607

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt unlawful detainer

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-024169

</td>

<td style="text-align:left;">

2020-04-13

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

601 carolyn corp|bravo home management inc

</td>

<td style="text-align:left;">

poe christina 601 carolyn dr brandon fl 33510|poe david 601 carolyn dr
brandon fl 33510

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction- possession only

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-023846

</td>

<td style="text-align:left;">

2020-04-13

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

ct2 properties llc

</td>

<td style="text-align:left;">

morales marta 702 pearl circle brandon fl 33510

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-023850

</td>

<td style="text-align:left;">

2020-04-13

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

mirza sikandar|hagerty marjorie r

</td>

<td style="text-align:left;">

dobson shane 1423 saddle gold court brandon fl 33511

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-023729

</td>

<td style="text-align:left;">

2020-04-13

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

riverfront apartments

</td>

<td style="text-align:left;">

parkhurst kari lee 5305 north blvd \#202 tampa fl 33603

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-023785

</td>

<td style="text-align:left;">

2020-04-13

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

moreno georgina

</td>

<td style="text-align:left;">

tenant unknown 302 lime tree rd unit a tampa fl 33619|ortiz silvana 302
lime tree rd unit a tampa fl 33619

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-023789

</td>

<td style="text-align:left;">

2020-04-13

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

vo lang

</td>

<td style="text-align:left;">

vega alejandro 2713 charleston dr plant city fl 33563

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-023872

</td>

<td style="text-align:left;">

2020-04-13

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

rini ken|rolison joette

</td>

<td style="text-align:left;">

dixon amanda 11707 rodney rd riverview fl 33579

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-023874

</td>

<td style="text-align:left;">

2020-04-13

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

carrillo samadhi s

</td>

<td style="text-align:left;">

mclauglin joseph l 3706 w ildewild ave apt 503 tampa fl 33614

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-023876

</td>

<td style="text-align:left;">

2020-04-13

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

sawyer cynthia

</td>

<td style="text-align:left;">

shoupe ryan rebecca|shoupe justin allen 2450 kirkland rd rear unit dover
fl 33527

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-023880

</td>

<td style="text-align:left;">

2020-04-13

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

hanson simone e

</td>

<td style="text-align:left;">

dandridge larry don 1703 staysail drive valrico fl 33594

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-023889

</td>

<td style="text-align:left;">

2020-04-13

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

mcknight susan

</td>

<td style="text-align:left;">

hodge william 1017 e holland ave \#b tampa fl 33612

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-023894

</td>

<td style="text-align:left;">

2020-04-13

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

mcknight susan

</td>

<td style="text-align:left;">

baxter tannia 1017 e holland ave \#a tampa fl 33612

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-023917

</td>

<td style="text-align:left;">

2020-04-10

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

westshore apartments inc.

</td>

<td style="text-align:left;">

palma naya a 4601 grayview court apt.\# c-214 tampa fl 33609

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-023859

</td>

<td style="text-align:left;">

2020-04-10

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

park pointe apartments llc

</td>

<td style="text-align:left;">

farris david j 5646 louis xiv ct. apt.\# a tampa fl 33614|le pal kelly
john a 5646 louis xiv ct. apt.\# a tampa fl 33614

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-023838

</td>

<td style="text-align:left;">

2020-04-10

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

zee and a llc

</td>

<td style="text-align:left;">

gangnam style restaurant group llc 701 e. fletcher avenue tampa fl 33612

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

2020-05-13

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-023807

</td>

<td style="text-align:left;">

2020-04-09

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

park pointe apartments llc

</td>

<td style="text-align:left;">

palmer april d 3401 waterloo ct. apt\# c tampa fl 33614

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-023822

</td>

<td style="text-align:left;">

2020-04-09

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

olivera dailyn

</td>

<td style="text-align:left;">

ryan christopher mcneal 7350 west pocahontas avenue rear apartment tampa
fl 33634

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction- possession only

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-023756

</td>

<td style="text-align:left;">

2020-04-09

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

bastille bettina|bastille mark

</td>

<td style="text-align:left;">

denning sarah 6017 n. dexter avenue tampa fl 33604|longo matthew 6017
n. dexter avenue tampa fl 33604

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction- possession only

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-023764

</td>

<td style="text-align:left;">

2020-04-09

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

chesson wesley

</td>

<td style="text-align:left;">

tenants unknown 17129 rainbow terrace odessa fl 33556|doe jane 17129
rainbow terrace odessa fl 33556|weeks nakoma 17129 rainbow terrace
odessa fl 33556

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt unlawful detainer

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-023523

</td>

<td style="text-align:left;">

2020-04-09

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

barnum ronnie a

</td>

<td style="text-align:left;">

unknown alex / alexis 5103 big stand lane wimauma fl 33598

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt unlawful detainer

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-023525

</td>

<td style="text-align:left;">

2020-04-09

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

celestine maria l

</td>

<td style="text-align:left;">

phillips demetria sade 8109 brickleton woods ave gibsonton fl
33534|oliver tyler j 8109 brickleton woods ave gibsonton fl 33534

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction- possession only

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-023574

</td>

<td style="text-align:left;">

2020-04-09

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

brosseau karen

</td>

<td style="text-align:left;">

bondoc misuzu s 7120 turkey creek rd plant city fl 33567|felker dennis j
7120 turkey creek rd plant city fl 33567

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-023588

</td>

<td style="text-align:left;">

2020-04-09

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

camelot family communities llc

</td>

<td style="text-align:left;">

brown xavier 11612 round table way lot 93 thonotosassa fl 33592

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-023594

</td>

<td style="text-align:left;">

2020-04-09

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

grandview family communities llc

</td>

<td style="text-align:left;">

humphreys austin 11610 galway road lot\#29 seffner fl 33584

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-023604

</td>

<td style="text-align:left;">

2020-04-09

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

50th street property services llc

</td>

<td style="text-align:left;">

starling latoya 2310 s 50th st lot\# 23 tampa fl 33619

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-023616

</td>

<td style="text-align:left;">

2020-04-09

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

waterside family communities llc

</td>

<td style="text-align:left;">

ferguson bobby jr 8536 honeywell rd. lot \#71 gibsonton fl 33584

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-023190

</td>

<td style="text-align:left;">

2020-04-08

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

wallis charles

</td>

<td style="text-align:left;">

pruitte mindy parsons village mhp 1014 n parsons ave lot \# 14 seffner
fl 33584

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

2020-04-08

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-023208

</td>

<td style="text-align:left;">

2020-04-08

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

wallis charles

</td>

<td style="text-align:left;">

white meghan 1014 n parsons ave lot 3 seffner fl 33584

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

2020-04-23

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-023281

</td>

<td style="text-align:left;">

2020-04-08

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

park pointe apartments llc

</td>

<td style="text-align:left;">

bassey samuel j 5642 louis xiv ct. apt.\# c tampa fl 33614

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-023289

</td>

<td style="text-align:left;">

2020-04-08

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

barsoum kimberly|barsoum maged

</td>

<td style="text-align:left;">

tenant unknown 6115 nundy ave \#4 gibsonton fl 33534|rodriguez alyssa
6115 nundy ave \#4 gibsonton fl 33534

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-023290

</td>

<td style="text-align:left;">

2020-04-08

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

crespo oropesa ruben

</td>

<td style="text-align:left;">

mckeney ricardo jr 1601 e. 148th ave. rv on property backyard lutz fl
33549

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-023292

</td>

<td style="text-align:left;">

2020-04-08

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

barsoum kimberly|barsoum maged

</td>

<td style="text-align:left;">

tenant unknown 4015 e 10th ave tampa fl 33605

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-023351

</td>

<td style="text-align:left;">

2020-04-08

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

baywater apartments llc

</td>

<td style="text-align:left;">

afon lie 6910 w. waters avenue apt.\# 1704 tampa fl 33634|nunez olian
6910 w. waters avenue apt.\# 1704 tampa fl 33634

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-023393

</td>

<td style="text-align:left;">

2020-04-08

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

park pointe apartments llc

</td>

<td style="text-align:left;">

blasini sheisa m 5602 josephine ct. apt.\# c tampa fl 33614

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-023395

</td>

<td style="text-align:left;">

2020-04-08

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

park pointe apartments llc

</td>

<td style="text-align:left;">

wright ralph g 5653 louis xiv ct. apt.\# b tampa fl 33614

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-023396

</td>

<td style="text-align:left;">

2020-04-08

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

baywater apartments llc

</td>

<td style="text-align:left;">

shutts angela 6910 w. waters avenue apt.\# 1001 tampa fl 33634|griffin
timothy 6910 w. waters avenue apt.\# 1001 tampa fl 33634

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-023397

</td>

<td style="text-align:left;">

2020-04-08

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

baywater apartments llc

</td>

<td style="text-align:left;">

morejon yarise t 6910 w. waters avenue apt.\# 1607 tampa fl
33634|marcilli yorvis 6910 w. waters avenue apt.\# 1607 tampa fl 33634

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-022910

</td>

<td style="text-align:left;">

2020-04-07

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

mai quang

</td>

<td style="text-align:left;">

richard micheal nicholas 16119 northglenn dr tampa fl 33618

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-022911

</td>

<td style="text-align:left;">

2020-04-07

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

caceres luis

</td>

<td style="text-align:left;">

ortiz nancy 2501 w hamilton ave tampa fl 33614

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-023170

</td>

<td style="text-align:left;">

2020-04-07

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

tampa industrial portfolio investors llc

</td>

<td style="text-align:left;">

supersonic of florida inc juan gonzalez ra 1919 absher road st. cloud fl
34471

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction- possession only

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-023182

</td>

<td style="text-align:left;">

2020-04-07

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

arcon properties llp

</td>

<td style="text-align:left;">

rosa tanaris 4410 n. hale avenue apt. 54 tampa fl 33614

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction- possession only

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-022765

</td>

<td style="text-align:left;">

2020-04-07

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

garcia yunny

</td>

<td style="text-align:left;">

hernandez alexis 3006 w wilder ave tampa fl 33614

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction- possession only

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-022801

</td>

<td style="text-align:left;">

2020-04-06

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

pepperwood apartments dpm llc

</td>

<td style="text-align:left;">

grimsley denesha 13721 susan kay drive apt. d tampa fl 33613

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-022902

</td>

<td style="text-align:left;">

2020-04-06

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

hatjioannou jeffrey

</td>

<td style="text-align:left;">

touch martini bar|hm-18 llc joseph l. diaz as registered agent 3242
henderson blvd. suite 310 tampa fl 33609-3097

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-022538

</td>

<td style="text-align:left;">

2020-04-06

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

fraticelli david

</td>

<td style="text-align:left;">

tenants all unknown 7620 dennison dr tampa fl 33619|almenares olosude
lenardo 7620 dennison dr tampa fl 33619

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction- possession only

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-022597

</td>

<td style="text-align:left;">

2020-04-06

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

larracy management llc

</td>

<td style="text-align:left;">

howard vernessa 2529 e. stanley matthew circle tampa fl 33604

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-022284

</td>

<td style="text-align:left;">

2020-04-06

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

treasure home solution llc

</td>

<td style="text-align:left;">

vasquez ana 9607 n aster ave apt a tampa fl 33612|soto stephanie 9607 n
aster apt a tampa fl 33612

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-022334

</td>

<td style="text-align:left;">

2020-04-06

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

blackfist united llc

</td>

<td style="text-align:left;">

colon dennis 3012 n 49 st apt a tampa fl 33605

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction- possession only

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-ca-003070

</td>

<td style="text-align:left;">

2020-04-03

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

dmd group inc.

</td>

<td style="text-align:left;">

etl tampa llc 911 chestnut street clearwater fl 33756

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

removal of tenant

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-022392

</td>

<td style="text-align:left;">

2020-04-03

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

town & country apartments llc

</td>

<td style="text-align:left;">

de jesus alfonso 8304 oak forest court apt 11-111 tampa 33615 united
states

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction- possession only

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-022429

</td>

<td style="text-align:left;">

2020-04-03

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

estate of onnolee jurkowski|jurkowski greg

</td>

<td style="text-align:left;">

hambaugh david 10716 drummond rd. tampa fl 33615

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt unlawful detainer

</td>

<td style="text-align:left;">

2020-05-21

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-022516

</td>

<td style="text-align:left;">

2020-04-03

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

abv holdings llc

</td>

<td style="text-align:left;">

mitchell lakeitha s. 2603 e. 29th ave. apt. b tampa fl 33605

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction- possession only

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-022225

</td>

<td style="text-align:left;">

2020-04-03

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

celeste of west florida llc

</td>

<td style="text-align:left;">

terrill charlene 6201 ohio st gibsonton fl 33534

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction- possession only

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-034810

</td>

<td style="text-align:left;">

2020-06-11

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

branand brian

</td>

<td style="text-align:left;">

bacon ife domonique 6212 n. 44th street tampa fl 33610

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt unlawful detainer

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-034815

</td>

<td style="text-align:left;">

2020-06-11

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

chacon anthony

</td>

<td style="text-align:left;">

williams charmaine 5117 n habana ave tampa fl 33614

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-034832

</td>

<td style="text-align:left;">

2020-06-11

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

attias dror|reizer eran

</td>

<td style="text-align:left;">

carter jasmine 3705 n 57th street apt a tampa fl 33619

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt unlawful detainer

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-034850

</td>

<td style="text-align:left;">

2020-06-11

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

villacis zulma

</td>

<td style="text-align:left;">

guerraz robert lopez 8309 elkwood lane b tampa fl 33615|llopiz yusney
alvarez 8309 elkwood lane b tampa fl 33615

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-034881

</td>

<td style="text-align:left;">

2020-06-11

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

tzadik management|tzadik oaks apartments|tzadik oaks llc

</td>

<td style="text-align:left;">

nealey martel 1280 e 113th ave apt 201 tampa fl 33612

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction- possession only

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-034934

</td>

<td style="text-align:left;">

2020-06-11

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

lake carlton arms apartments|lake carlton arms a florida partnership

</td>

<td style="text-align:left;">

roland michael 17852-a jamestwon way lutz fl 33558

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt unlawful detainer

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-035006

</td>

<td style="text-align:left;">

2020-06-11

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

hagan elizabeth

</td>

<td style="text-align:left;">

shannon alissia 9321 cerulean drive \#305 riverview fl 33578|shannon
quiona 9321 cerulean drive \#305 riverview fl 33578|calip matoyia 9321
cerulean drive \#305 riverview fl 33578

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-035017

</td>

<td style="text-align:left;">

2020-06-11

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

stokes hattie|stokes karl v

</td>

<td style="text-align:left;">

parker darious t 3202 e 28th ave tampa fl 33605

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt unlawful detainer

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-035052

</td>

<td style="text-align:left;">

2020-06-11

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

gallo wayne

</td>

<td style="text-align:left;">

fancher rachael 3913 w. cass st. tampa fl 33609

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-035053

</td>

<td style="text-align:left;">

2020-06-11

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

noel alan s

</td>

<td style="text-align:left;">

noel brandi 10544 skewlee rd thonotosassa fl 33592

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt unlawful detainer

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-035055

</td>

<td style="text-align:left;">

2020-06-11

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

maye john

</td>

<td style="text-align:left;">

figueroa eddie 8414 n. lois ave apt d tampa fl 33614|rosario lorena 8414
n. lois ave apt d tampa fl 33614

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction- possession only

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-034522

</td>

<td style="text-align:left;">

2020-06-10

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

nestor mariano imperiale llc

</td>

<td style="text-align:left;">

unknown party in possession 8206 woodgate ct. tampa fl 33615|ramirez
pedro f 8206 woodgate ct tampa fl 33615

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt unlawful detainer

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-034527

</td>

<td style="text-align:left;">

2020-06-10

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

everett zelda

</td>

<td style="text-align:left;">

everett johnny 5007 e. sligh ave apt d tampa fl 33617

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt unlawful detainer

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-034528

</td>

<td style="text-align:left;">

2020-06-10

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

papas john|papas jenette m

</td>

<td style="text-align:left;">

lara marienna 8412 westbridge drive tampa fl 33615|vega brian 8412
westridge drive tampa fl 33615

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-034546

</td>

<td style="text-align:left;">

2020-06-10

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

fl portfolio 1 llc

</td>

<td style="text-align:left;">

fashion evant and rentals 2202 w waters ave ste 2 tampa fl 33604|marquez
herbello aimee 2202 w waters ave ste 2 tampa fl 33604

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-034577

</td>

<td style="text-align:left;">

2020-06-10

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

rahman mike

</td>

<td style="text-align:left;">

jai african hair braiding 7730 palm river rd \# 700 tampa fl
33619|touray jainaba 7730 palm river rd \#700 tampa fl 33619

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-034611

</td>

<td style="text-align:left;">

2020-06-10

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

ih6 property florida lp

</td>

<td style="text-align:left;">

occupant unknown 12307 yellow rose circle riverview fl 33569

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt unlawful detainer

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-034612

</td>

<td style="text-align:left;">

2020-06-10

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

zahoor riffat

</td>

<td style="text-align:left;">

sayyid jibrael 106 oak ridge ave room \#3 temple terrace fl 33617

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt unlawful detainer

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-034613

</td>

<td style="text-align:left;">

2020-06-10

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

mlk enterprises inc.

</td>

<td style="text-align:left;">

occupants unknown 907 s. alexander street plant city fl 33563|tenamore
joseph 907 s. alexander st plant city fl 33563|jet enterprises 907 s.
alexander st plant city fl 33563

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt distress for rent $15.000.01-$30000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-034614

</td>

<td style="text-align:left;">

2020-06-10

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

ih6 property florida lp

</td>

<td style="text-align:left;">

occupant unknown 3801 polumbo dr valrico fl 33596

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt unlawful detainer

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-034655

</td>

<td style="text-align:left;">

2020-06-10

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

tzadik management|tzadik oaks llc|tzadik oaks apartments

</td>

<td style="text-align:left;">

silva jackie 1252 e 113th ave apt 207 tampa fl 33612

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction- possession only

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-034658

</td>

<td style="text-align:left;">

2020-06-10

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

tzadik management|tzadik oaks apartments|tzadik oaks llc

</td>

<td style="text-align:left;">

crawford bryce 1256 e 113th ave apt 102 tampa fl 33612|el-noursi maryam
1256 e 113th ave apt 102 tampa fl 33612

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction- possession only

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-034668

</td>

<td style="text-align:left;">

2020-06-10

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

tzadik oaks llc|tzadik management|tzadik oaks apartments

</td>

<td style="text-align:left;">

campbell-harris dominic 1270 e 113th ave apt 108 tampa fl 33612

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction- possession only

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-034669

</td>

<td style="text-align:left;">

2020-06-10

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

kentwood family communities llc

</td>

<td style="text-align:left;">

gadley charlece 4821 williams rd \# 12 tampa fl 33610

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-034670

</td>

<td style="text-align:left;">

2020-06-10

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

tzadik oaks llc|tzadik management|tzadik oaks apartments

</td>

<td style="text-align:left;">

judge christopher 1270 e 113th ave apt 111 tampa fl 33612

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction- possession only

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-034671

</td>

<td style="text-align:left;">

2020-06-10

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

bargo david

</td>

<td style="text-align:left;">

kelley nicole 1301 eagleview drive brandon fl 33510

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-034672

</td>

<td style="text-align:left;">

2020-06-10

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

grandview family communities llc

</td>

<td style="text-align:left;">

oliver sarah 11608 galway road lot \#30 seffner fl 33584

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-034674

</td>

<td style="text-align:left;">

2020-06-10

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

leverette markus lee

</td>

<td style="text-align:left;">

hewitt samuel m 9401 crescent loop circle apt. 303 tampa fl 33619

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt unlawful detainer

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-034677

</td>

<td style="text-align:left;">

2020-06-10

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

sharma nityanand

</td>

<td style="text-align:left;">

green adreia lena 7507 presley place unit b a/k/a 90 tampa fl 33617

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction- possession only

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-034276

</td>

<td style="text-align:left;">

2020-06-09

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

poole clyde

</td>

<td style="text-align:left;">

humphrey trish 5437 trail drive seffner fl 33584|humphreys shawn 5437
trail drive seffner fl 33584

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-034284

</td>

<td style="text-align:left;">

2020-06-09

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

poole clyde

</td>

<td style="text-align:left;">

russell katie 6116 nudy ave unit a gibsonton fl 33534

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-034286

</td>

<td style="text-align:left;">

2020-06-09

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

poole clyde

</td>

<td style="text-align:left;">

provencher john 6116 nundy ave unit b gibsonton fl 33534

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-034302

</td>

<td style="text-align:left;">

2020-06-09

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

reyes elsa

</td>

<td style="text-align:left;">

colon omi 109 w floribraska ave tampa fl 33603

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction- possession only

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-034305

</td>

<td style="text-align:left;">

2020-06-09

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

mcgiffen kimberly a|westermann herbert f

</td>

<td style="text-align:left;">

mcgiffen joshua 2909 bear oak drive valrico fl 33594

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt unlawful detainer

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-034357

</td>

<td style="text-align:left;">

2020-06-09

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

lima caceres ingrid|miranda jose

</td>

<td style="text-align:left;">

hunt cristal 2040 park village drive ruskin fl 33570|marin misael 2040
park village drive ruskin fl 33570

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-034358

</td>

<td style="text-align:left;">

2020-06-09

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

atbl properties llc

</td>

<td style="text-align:left;">

rivers wanda elaine 3420 north 55th street unit a tampa fl 33619|belin
marva cotell 3420 north 55th street unit a tampa fl 33619

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction- possession only

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-034368

</td>

<td style="text-align:left;">

2020-06-09

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

granberry estelle

</td>

<td style="text-align:left;">

pittman brian 2509 e osborne ave tampa fl 33610

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt unlawful detainer

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-034062

</td>

<td style="text-align:left;">

2020-06-08

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

silas kenneth

</td>

<td style="text-align:left;">

butler ke’ara lavern 9318 b grandfield rd thonotoassa fl 33592

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-034073

</td>

<td style="text-align:left;">

2020-06-08

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

beasley gizella

</td>

<td style="text-align:left;">

osborne kensy shay 3705 n garrsion st apt a tampa fl 33616

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-034077

</td>

<td style="text-align:left;">

2020-06-08

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

walston gene

</td>

<td style="text-align:left;">

keys joseph 12210 north 16th st \#333 tampa fl 33612

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt unlawful detainer

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-034079

</td>

<td style="text-align:left;">

2020-06-08

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

araujo leah

</td>

<td style="text-align:left;">

mcelreath tara 18104 fall creek dr lutz fl 33558

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt unlawful detainer

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-034080

</td>

<td style="text-align:left;">

2020-06-08

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

serra kevin

</td>

<td style="text-align:left;">

martin qadir 6103 lakeside drive lutz fl 33558|martinez anel 6103
lakeside drive lutz fl 33558

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction- possession only

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-034082

</td>

<td style="text-align:left;">

2020-06-08

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

alderson lylia|alderson robert e.

</td>

<td style="text-align:left;">

weems rochele patrice 10820 lakeside vista dr. riverview fl 33596|weems
willie james iii 10820 lakeside vista dr. riverview fl 33596

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction- possession only

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-034119

</td>

<td style="text-align:left;">

2020-06-08

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

tzadik management|tampa palms mmg llc|palm court apartments

</td>

<td style="text-align:left;">

ford phinnie 13020 kain palms apt 102 tampa fl 33612

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction- possession only

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-034121

</td>

<td style="text-align:left;">

2020-06-08

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

beckford orlando

</td>

<td style="text-align:left;">

fierro maria 705 calm dr brandon fl 33511|fierro luis 705 calm dr
brandon fl 33511

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-034130

</td>

<td style="text-align:left;">

2020-06-08

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

barsoum kimberly|barsoum maged

</td>

<td style="text-align:left;">

unknown tenant 6115 nundy ave. gibsonton fl 33534|pierson donna 6115
nundy ave. gibsonton fl 33534

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-034134

</td>

<td style="text-align:left;">

2020-06-08

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

tzadik management|tampa palms mmg llc|palm court apartments

</td>

<td style="text-align:left;">

daniels rosa 13036 kain palms blvd apt 302 tampa fl 33612

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction- possession only

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-034140

</td>

<td style="text-align:left;">

2020-06-08

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

tzadik management|the villas apartments|tampa villas mmg llc

</td>

<td style="text-align:left;">

sosa lorenzo 14356 lucerne dr ste 101 tampa fl 33612

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction- possession only

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-ca-004761

</td>

<td style="text-align:left;">

2020-06-08

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

toho group llc|all others in possession|fernandez sylvia|diaz peggy|115
black orchid llc

</td>

<td style="text-align:left;">

fernandez sylvia|diaz peggy|115 black orchid llc|toho group llc|all
others in possession

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

removal of tenant

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-034191

</td>

<td style="text-align:left;">

2020-06-08

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

schendel christopher

</td>

<td style="text-align:left;">

marshall roy 1109 terra mar drive tampa fl 33613

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction- possession only

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-034209

</td>

<td style="text-align:left;">

2020-06-08

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

cacciatore mercedes|cacciatore richard

</td>

<td style="text-align:left;">

cacciatore carol 3210 w nassau st tampa fl 33607

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction- possession only

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-033758

</td>

<td style="text-align:left;">

2020-06-05

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

luva lisandra

</td>

<td style="text-align:left;">

gantt lybron 2209 thrace st. tampa fl 33605|mckinzie sally 2209 thrace
st. tampa fl 33605

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-033770

</td>

<td style="text-align:left;">

2020-06-05

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

tzadik management|columbia oaks apartments|columbia sherman investments
llc

</td>

<td style="text-align:left;">

murray robert 12717 n 19th st unit a3 tampa fl 33612

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction- possession only

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-033771

</td>

<td style="text-align:left;">

2020-06-05

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

tzadik management|heritage cove mmg llc|heritage cove apartments

</td>

<td style="text-align:left;">

sanders brianna 9106 heritage cove dr apt a temple terrace fl 33637

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction- possession only

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-033777

</td>

<td style="text-align:left;">

2020-06-05

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

pethtel francine|pethtel russell

</td>

<td style="text-align:left;">

conkel robert 10019 newminster loop ruskin fl 33573

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt unlawful detainer

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-033781

</td>

<td style="text-align:left;">

2020-06-05

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

principle eagle realty

</td>

<td style="text-align:left;">

tenant unknown 1711 e idell st unit b tampa fl 33604|walker jasmine 1711
e idell st unit b tampa fl 33604

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-033782

</td>

<td style="text-align:left;">

2020-06-05

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

principle eagle realty

</td>

<td style="text-align:left;">

tenant unknown 1711 e idell st unit a tampa fl 33604|lewis kuisha 1711 e
idell st unit a tampa fl 33604|hamilton sandy 1711 e idell st unit a
tampa fl 33604

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-033783

</td>

<td style="text-align:left;">

2020-06-05

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

layne linda sue

</td>

<td style="text-align:left;">

powers charles 631 s 63rd street apt b tampa fl 33619

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction- possession only

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-033784

</td>

<td style="text-align:left;">

2020-06-05

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

layne linda sue

</td>

<td style="text-align:left;">

diaz jose 631 s 63rd street apt a tampa fl 33619|delgado rosa 631 s 63rd
street apt a tampa fl 33619

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction- possession only

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-033785

</td>

<td style="text-align:left;">

2020-06-05

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

ruiz nubia arias

</td>

<td style="text-align:left;">

occupant unknown 12510 four oaks road tampa fl 33624|mcswain mary 12510
four oaks road tampa fl 33624

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt unlawful detainer

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-033786

</td>

<td style="text-align:left;">

2020-06-05

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

zuloaga laverde luis e

</td>

<td style="text-align:left;">

tenant 3 unknown|tenant 2 unknown|tenant 1 unknown|smith vincent kenneth
1218 e 18th ave tampa fl 33605|sisk dawn m 1218 e 18th ave. tampa fl
33605|santiago michele 1218 e 18th ave. tampa fl 33605

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt unlawful detainer

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-033898

</td>

<td style="text-align:left;">

2020-06-05

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

langee chris|mcn trailer park

</td>

<td style="text-align:left;">

gunn amber marcia 106 esther st. tampa fl 33614

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-033909

</td>

<td style="text-align:left;">

2020-06-05

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

langee chris

</td>

<td style="text-align:left;">

mullen elyse k. 702 e. robson st. tampa fl 33604

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction- possession only

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-033423

</td>

<td style="text-align:left;">

2020-06-04

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

tzadik acquisitions llc|tzadik management|avesta del rio apartments

</td>

<td style="text-align:left;">

deer ronald 5202 e sligh ave apt a tampa fl 33617

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction- possession only

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-033435

</td>

<td style="text-align:left;">

2020-06-04

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

tzadik acquisitions llc|tzadik management|tzm bella mar apartments

</td>

<td style="text-align:left;">

singletary ashley 1401 e 127th ave apt f tampa fl 33612

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction- possession only

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-033454

</td>

<td style="text-align:left;">

2020-06-04

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

barber ronnie

</td>

<td style="text-align:left;">

unknown jd 908 e. seward st \#a tampa fl 33604

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-033455

</td>

<td style="text-align:left;">

2020-06-04

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

morales henrietta|morales juliana

</td>

<td style="text-align:left;">

konestsky kristie 3817 river grove court tampa fl 33610|morales fidelis
3817 river grove court tampa fl 33610

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt unlawful detainer

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-033458

</td>

<td style="text-align:left;">

2020-06-04

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

reinhard dennis

</td>

<td style="text-align:left;">

levy bernard 1901 e. 32nd street apt. a tampa fl 33605

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction- possession only

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-033462

</td>

<td style="text-align:left;">

2020-06-04

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

mcn trailer park|langee chris

</td>

<td style="text-align:left;">

hopkins reginald 105 brian st tampa fl 33614

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-033466

</td>

<td style="text-align:left;">

2020-06-04

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

mcn trailer park|langee chris

</td>

<td style="text-align:left;">

martin dominique 123 brian st tampa fl 33614

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-033470

</td>

<td style="text-align:left;">

2020-06-04

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

davis mary

</td>

<td style="text-align:left;">

walton james 6216 n 38th st tampa fl 33610

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt unlawful detainer

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-033472

</td>

<td style="text-align:left;">

2020-06-04

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

advanced horizon vi llc

</td>

<td style="text-align:left;">

outsource llc c/o registered agent solutions inc. 155 office plaza drive
suite a tallahassee fl 32301

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-033552

</td>

<td style="text-align:left;">

2020-06-04

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

pemberton kelly

</td>

<td style="text-align:left;">

lopez diaz miguel 5218 a pine street seffner fl 33584

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-033160

</td>

<td style="text-align:left;">

2020-06-03

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

atchison thomas

</td>

<td style="text-align:left;">

morales sean 4033 river view avenure tampa fl 33607

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction- possession only

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-033193

</td>

<td style="text-align:left;">

2020-06-03

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

magana aladro yasmani

</td>

<td style="text-align:left;">

brian yoel 1802 e poinsettia ave tampa fl 33612

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-033204

</td>

<td style="text-align:left;">

2020-06-03

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

zota ernesto

</td>

<td style="text-align:left;">

breton amy 5215 holland ave. temple terrace fl 33617

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction- possession only

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-033209

</td>

<td style="text-align:left;">

2020-06-03

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

revere apartments llc|revere landings

</td>

<td style="text-align:left;">

zubiate-velez matilde|cubiate-velez matilde 13612 platte creek cir.
apt.\#10 tampa fl 33613|feliciano anna 13612 platte creek cir. apt. \#10
tampa fl 33613

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction- possession only

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-033213

</td>

<td style="text-align:left;">

2020-06-03

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

westshore center llc

</td>

<td style="text-align:left;">

total specialty publications llc 1715 n. westshore boulevard suite 266
tampa fl 33607

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction- possession only

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-033261

</td>

<td style="text-align:left;">

2020-06-03

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

double paul thomas

</td>

<td style="text-align:left;">

clemons marquise antwon 1548 deer tree ln brandon fl 33510

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction- possession only

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-033264

</td>

<td style="text-align:left;">

2020-06-03

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

the 5041 sunridge palms \#101 land trust|john lawless esq as trustee

</td>

<td style="text-align:left;">

tenant unknown 5041 sunridge palms unit 101 tampa fl 33617|houston
shelly 5041 sunridge palms unit 101 tampa fl 33617

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction- possession only

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-033268

</td>

<td style="text-align:left;">

2020-06-03

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

glennwood property services llc

</td>

<td style="text-align:left;">

kent heather 5013 harbersham lane tampa fl 33619

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-ca-004637

</td>

<td style="text-align:left;">

2020-06-03

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

capitano joseph sr

</td>

<td style="text-align:left;">

morales sean 4033 n. river view ave tamp fl 33607

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

ejectment

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-033269

</td>

<td style="text-align:left;">

2020-06-03

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

livingston family communities llc

</td>

<td style="text-align:left;">

rosa stephanie 15839 martha circle lot \# 42 lutz fl 33549

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-033270

</td>

<td style="text-align:left;">

2020-06-03

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

moore-hill jocelyn

</td>

<td style="text-align:left;">

edwards micheline 2608 e 97th ave tampa fl 33612|edwards deon 2608 e
97th ave tampa fl 33612

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-033280

</td>

<td style="text-align:left;">

2020-06-03

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

mendoza hipolito

</td>

<td style="text-align:left;">

unknown tenant 4006 myrtle ave apt b tampa fl 33603|herrera maria a 4006
myrtle ave apt b tampa fl 33603

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-ca-004646

</td>

<td style="text-align:left;">

2020-06-03

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

fraga plant llc

</td>

<td style="text-align:left;">

the cato corporation 2509 thonotosassa road plant city fl 33563

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

removal of tenant

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-032977

</td>

<td style="text-align:left;">

2020-06-02

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

britt simone

</td>

<td style="text-align:left;">

britt kendall g jr 9737 magnolia view ct apt 303 riverview fl 33578

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt unlawful detainer

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-032979

</td>

<td style="text-align:left;">

2020-06-02

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

evict them llc

</td>

<td style="text-align:left;">

mooser kristen 3189 bayshore oaks dr tampa fl 33611|bash eric 3189
bayshore oaks dr tampa fl 33611

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-032987

</td>

<td style="text-align:left;">

2020-06-02

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

mcdill columbus property parnership iii llp

</td>

<td style="text-align:left;">

daniel andy 1005 w busch blvd \#209e tampa fl 33612

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-032988

</td>

<td style="text-align:left;">

2020-06-02

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

park springs apartments|park springs harmony housing llc

</td>

<td style="text-align:left;">

markiel debbie 206 park springs circle \#2 plant city fl 33566|reed
destiny 206 park springs circle \#2 plant city fl 33566

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction- possession only

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-033011

</td>

<td style="text-align:left;">

2020-06-02

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

grady square|apartments at grady square llc

</td>

<td style="text-align:left;">

yohannes daniel t. 2615 n. grady avenue apt. \#1279 tampa fl 33607

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction- possession only

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-ca-004576

</td>

<td style="text-align:left;">

2020-06-02

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

global north bay llc

</td>

<td style="text-align:left;">

youfit health clubs llc 111 - 2nd avenue n.e. suite 1402 c/o christy
stross registered agent st. petersburg fl 33701|yf racetrack llc 111 2nd
avenue n.e. suite 1402 c/o christy stross registered agent st.
petersburg fl 33701

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

distress for rent

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-033107

</td>

<td style="text-align:left;">

2020-06-02

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

avesta del rio apartments|tzadik acquisitions llc|tzadik management

</td>

<td style="text-align:left;">

watson laquanda 5032 e sligh ave apt d tampa fl 33617

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction- possession only

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-033114

</td>

<td style="text-align:left;">

2020-06-02

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

tzadik acquisitions llc|tzadik management|avesta del rio apartments

</td>

<td style="text-align:left;">

williams khareema 5204 e slighave apt c tampa fl 33617

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction- possession only

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-033116

</td>

<td style="text-align:left;">

2020-06-02

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

tzadik acquisitions llc|tzadik management|tzm bella mar apartments

</td>

<td style="text-align:left;">

harmon romeneshia 1401e 1127th ave apt b tampa fl 33612

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction- possession only

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-033117

</td>

<td style="text-align:left;">

2020-06-02

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

tzadik acquisitions llc|tzadik management|tzm bella mar apartments

</td>

<td style="text-align:left;">

jimenez jose 1401 e 127th ave apt i tampa fl 33612

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction- possession only

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-033118

</td>

<td style="text-align:left;">

2020-06-02

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

craft james

</td>

<td style="text-align:left;">

romo-gutierrez ricardo 4101 central avenue north tampa fl 33603

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction- possession only

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-033119

</td>

<td style="text-align:left;">

2020-06-02

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

bbnv llc

</td>

<td style="text-align:left;">

boyd samantha 6611 simmons loop riverview fl 33578|boyle samantha 6611
simmons loop riverview fl 33578|taylor michael john 6611 simmons loop
riverview fl 33578

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt unlawful detainer

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-033120

</td>

<td style="text-align:left;">

2020-06-02

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

tzadik acquisitions llc|tzadik management|tzm bella mar apartments

</td>

<td style="text-align:left;">

springs traviss 1403 e 127th ave apt o tampa fl 33612

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction- possession only

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-033121

</td>

<td style="text-align:left;">

2020-06-02

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

tzadik acquisitions llc|tzadik management|tzm bella mar apartments

</td>

<td style="text-align:left;">

valdes justiz eva 1407 e 127th ave apt b tampa fl 33612

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction- possession only

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-033122

</td>

<td style="text-align:left;">

2020-06-02

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

tzadik acquisitions llc|tzadik management|tzm bella mar apartments

</td>

<td style="text-align:left;">

salters valencia 12418 15th st apt k tampa fl 33612

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction- possession only

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-033123

</td>

<td style="text-align:left;">

2020-06-02

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

tzadik acquisitions llc|tzadik management|tzm bella mar apartments

</td>

<td style="text-align:left;">

howard roderick 12418 n 15th st apt n tampa fl 33612

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction- possession only

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-033124

</td>

<td style="text-align:left;">

2020-06-02

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

tzadik acquisitions llc|tzadik management|tzm bella mar apartments

</td>

<td style="text-align:left;">

barreirro roberto 12418 spicer pl apt k tampa fl 33612

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction- possession only

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-032678

</td>

<td style="text-align:left;">

2020-06-01

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

hunt marvin

</td>

<td style="text-align:left;">

santiago ricky 9002 n 10th street apt b tampa fl 33604

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-032682

</td>

<td style="text-align:left;">

2020-06-01

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

vazquez jesus pelaez

</td>

<td style="text-align:left;">

piedrafita agustin 10101 chimney hill ct. tampa fl 33615

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-032684

</td>

<td style="text-align:left;">

2020-06-01

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

better housing company llc

</td>

<td style="text-align:left;">

king ariel tonisha 3822 e river hills dr. apt. b tampa fl 33604|conteh
deja rugletu 3822 e. river hills dr. apt. b tampa fl 33604

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-032689

</td>

<td style="text-align:left;">

2020-06-01

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

belluccia john

</td>

<td style="text-align:left;">

hampton shon 7024 n orleans tampa fl 33604

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-032704

</td>

<td style="text-align:left;">

2020-06-01

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

schertzer meredith croken life estate croken frederick ii trustee

</td>

<td style="text-align:left;">

sundeck patricia 4815 19th ave s tampa fl 33619

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-032769

</td>

<td style="text-align:left;">

2020-06-01

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

srp sub llc

</td>

<td style="text-align:left;">

occupants unknown 11702 branch mooring dr tampa fl 33635

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt unlawful detainer

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-032772

</td>

<td style="text-align:left;">

2020-06-01

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

srp sub llc

</td>

<td style="text-align:left;">

occupants unknown 1503 e 33rd ave tampa fl 33610

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt unlawful detainer

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-032781

</td>

<td style="text-align:left;">

2020-06-01

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

swh 2017-1 borrower lp

</td>

<td style="text-align:left;">

occupant unknown 4519 fountainbleau rd tampa fl 33634

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt unlawful detainer

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-032790

</td>

<td style="text-align:left;">

2020-06-01

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

thr florida lp

</td>

<td style="text-align:left;">

occupant unknown 13907 hayward place tampa fl 33618

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt unlawful detainer

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-032809

</td>

<td style="text-align:left;">

2020-06-01

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

srp sub llc

</td>

<td style="text-align:left;">

occupant unknown 2005 red bridge dr brandon fl 33511

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt unlawful detainer

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-032642

</td>

<td style="text-align:left;">

2020-06-01

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

v6 ventures tr 1001 llc

</td>

<td style="text-align:left;">

brantley celena 2601 e. genesee street tampa fl 33610|bayless maurice
2601 e genesee street tampa fl 33610

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction- possession only

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-032667

</td>

<td style="text-align:left;">

2020-05-31

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

garcia-rivera luis

</td>

<td style="text-align:left;">

curtis penny 521 frandor place apollo beach fl 33572

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt unlawful detainer

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-032573

</td>

<td style="text-align:left;">

2020-05-29

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

good question investments inc

</td>

<td style="text-align:left;">

mays rasheedah 2810 somerset park dr apt 101 tampa fl 33613

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-032584

</td>

<td style="text-align:left;">

2020-05-29

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

constant marie

</td>

<td style="text-align:left;">

constant ernst jr 8441 quarterhorse dr. riverview fl 33578

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt unlawful detainer

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-032526

</td>

<td style="text-align:left;">

2020-05-29

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

renaissance properties llc

</td>

<td style="text-align:left;">

velasquez alysia 10004 davis st lot g gibsonton fl 33534

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-032543

</td>

<td style="text-align:left;">

2020-05-29

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

surujbali desmond

</td>

<td style="text-align:left;">

chable yolanda 16 chestnut dr. lot\#16 plant city fl 33565|hernandez
crisanto 16 chestnut dr. lot\#16 plant city fl 33565|blas elizabeth 16
chestnut dr. lot\#16 plant city fl 33565

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction- possession only

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-032546

</td>

<td style="text-align:left;">

2020-05-29

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

denholtz tcw llc

</td>

<td style="text-align:left;">

oasis climatic us inc 5553 w waters ave suite 311 tampa fl 33634

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction- possession only

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-032566

</td>

<td style="text-align:left;">

2020-05-29

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

mhp tampa gardens llc

</td>

<td style="text-align:left;">

tenants all unknown 11017 e 92 hwy \#6b seffner fl 33584|mckenzie
phillip w 11017 e 92 hwy \#6b seffner fl 33584|mckenzie tara d 11017 e
92 hwy \#6b seffner fl 33584

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-032572

</td>

<td style="text-align:left;">

2020-05-29

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

glennwood property services llc

</td>

<td style="text-align:left;">

gray samuel 5007 habersham lane tampa fl 33619

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-ca-004483

</td>

<td style="text-align:left;">

2020-05-28

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

2408 w. kennedy blvd. property inc.

</td>

<td style="text-align:left;">

2408 w. kennedy llc 303 s. melville avenue tampa fl 33606

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

removal of tenant

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-032244

</td>

<td style="text-align:left;">

2020-05-28

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

elly nesis company inc

</td>

<td style="text-align:left;">

rivera jordan 4102 tartan pl tampa fl 33624

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-032262

</td>

<td style="text-align:left;">

2020-05-28

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

elly nesis company inc

</td>

<td style="text-align:left;">

reyes nailyn 6001 s. dale mabry hwy apt \#9 tampa fl 33611

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-032351

</td>

<td style="text-align:left;">

2020-05-28

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

girgis adel s

</td>

<td style="text-align:left;">

clement norman 1461 west busch blvd tampa fl 33612

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-032352

</td>

<td style="text-align:left;">

2020-05-28

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

executive document firm|wright fred

</td>

<td style="text-align:left;">

williams charity denise 3107 n 26th ave tampa fl 33605

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-032353

</td>

<td style="text-align:left;">

2020-05-28

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

patrona rental properties llc

</td>

<td style="text-align:left;">

leggett joleisa 3202 n yukon st apt b tampa fl 33604|williams ryans 3202
e. yukon st. apt. b tampa fl 33604

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-032354

</td>

<td style="text-align:left;">

2020-05-28

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

cohen alder

</td>

<td style="text-align:left;">

parker david 7502 e humphrey st apt d tampa fl 33604

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt unlawful detainer

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-032355

</td>

<td style="text-align:left;">

2020-05-28

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

patrona rental properties llc

</td>

<td style="text-align:left;">

kelsey kimberly ann 3202 e yukon st. apt. a tampa fl 33604

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-032390

</td>

<td style="text-align:left;">

2020-05-28

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

2921 n. 15th st tampa fl 33605 land trust|willian fernandes

</td>

<td style="text-align:left;">

unknown occupant \#2 2921 n. 15th street tampa fl 33605|unknown occupant
\#1 2921 n. 15th street tampa fl 33605

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt unlawful detainer

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-032398

</td>

<td style="text-align:left;">

2020-05-28

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

allen griffin arlene m

</td>

<td style="text-align:left;">

edwards unique 2012 warrington way tampa fl 33619

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction- possession only

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-032403

</td>

<td style="text-align:left;">

2020-05-28

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

diana cohen

</td>

<td style="text-align:left;">

ruiz maritza 5114 lawnton court tampa fl 33624|jane doe 5114 lawnton
court tampa fl 33624|john doe 5114 lawnton court tampa fl 33624|harrison
jones tyisha rene 5114 lawnton court tampa fl 33624|jones michelin 5114
lawnton court tampa fl 33624

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt unlawful detainer

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-032413

</td>

<td style="text-align:left;">

2020-05-28

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

esd property holdings llc

</td>

<td style="text-align:left;">

jane doe 8409 n. 18th street tampa fl 33604|john doe 8409 n. 18th street
tampa fl 33604

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction- possession only

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-032418

</td>

<td style="text-align:left;">

2020-05-28

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

esd property holdings llc

</td>

<td style="text-align:left;">

jane doe 4224 palifox street tampa fl 33604|john doe 4224 palifox street
tampa fl 33604

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction- possession only

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-032419

</td>

<td style="text-align:left;">

2020-05-28

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

esd property holdings llc

</td>

<td style="text-align:left;">

jane doe 4506 e. 22nd avenue tampa fl 33609|john doe 4506 e. 22nd avenue
tampa fl 33609

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction- possession only

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-032447

</td>

<td style="text-align:left;">

2020-05-28

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

kellen investments llc

</td>

<td style="text-align:left;">

nelson mark 3012 n 73rd street tampa fl 33619

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt distress for rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-032466

</td>

<td style="text-align:left;">

2020-05-28

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

amzak focus laurel crossing 112 llc|laurel crossings apartments

</td>

<td style="text-align:left;">

deleary george jr 3814 w euclid ave \#24 tampa fl 33629

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction- possession only

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-032503

</td>

<td style="text-align:left;">

2020-05-28

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

tzadik acquisitions llc|tzadik management|avesta del rio apartments

</td>

<td style="text-align:left;">

gallon roshanna 5011 east sligh ave apt d tampa fl 33617

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction- possession only

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-032505

</td>

<td style="text-align:left;">

2020-05-28

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

tmz lago bello apartments|tzadik acquisitions llc|tzadik management

</td>

<td style="text-align:left;">

sosa torres dunnis 13659 gragston circle tampa fl 33613

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction- possession only

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-032507

</td>

<td style="text-align:left;">

2020-05-28

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

villa amor|tzadik management|royal village apartments

</td>

<td style="text-align:left;">

marino channel 13812 n 19th st apt 201 tampa fl 33613

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction- possession only

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-032004

</td>

<td style="text-align:left;">

2020-05-27

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

diaz julia

</td>

<td style="text-align:left;">

diaz luis 1322 dragon head dr valrico fl 33594|rodriguez margarita 1322
dragon head dr valrico fl 33594|vazquez julisa 1322 dragon head dr
valrico fl 33594

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt unlawful detainer

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-032039

</td>

<td style="text-align:left;">

2020-05-27

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

schell scott m|glass properties llc

</td>

<td style="text-align:left;">

gonzalez armando phillip 8406 n tampa street lot 30 tampa fl 33604

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-032041

</td>

<td style="text-align:left;">

2020-05-27

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

ugol ruth|ugol ruben

</td>

<td style="text-align:left;">

tenants unknown 15402 casey rd tampa fl 33624|rios evelyn 15402 casey rd
tampa fl 33624|rios david 15402 casey rd tampa fl 33624|vida center of
praise community church llc 15402 casey rd tampa fl 33624

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-032077

</td>

<td style="text-align:left;">

2020-05-27

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

siesta village mobile home park

</td>

<td style="text-align:left;">

occupants all other 205 vista drive tampa fl 33613|lopez stephanie j 205
vista drive tampa fl 33613

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-032087

</td>

<td style="text-align:left;">

2020-05-27

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

gatti partners llc

</td>

<td style="text-align:left;">

hernandez mario 12301-b n. 11th street tampa fl 33612

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction- possession only

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-032106

</td>

<td style="text-align:left;">

2020-05-27

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

esd property holdings llc

</td>

<td style="text-align:left;">

jane doe 2411 e. ida street tampa fl 33610|john doe 2411 e. ida street
tampa fl 33610

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction- possession only

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

2020-06-10

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-032175

</td>

<td style="text-align:left;">

2020-05-27

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

surujbali desmond

</td>

<td style="text-align:left;">

moody kevin 111 pearl st. apt. 1b plant city fl 33563

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction- possession only

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-031671

</td>

<td style="text-align:left;">

2020-05-26

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

ortega deandrea

</td>

<td style="text-align:left;">

sanchez thadea 7403 34th ave s tampa fl 33619

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

2020-05-29

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-031747

</td>

<td style="text-align:left;">

2020-05-26

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

mayol javier

</td>

<td style="text-align:left;">

muhammad tony 4200 n 15th st tampa fl 33610

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-031749

</td>

<td style="text-align:left;">

2020-05-26

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

reaves herold

</td>

<td style="text-align:left;">

barnes joe 1211 e warren street plant city fl 33563|barnes stephanie
1211 e warren street plant city fl 33563

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-031799

</td>

<td style="text-align:left;">

2020-05-26

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

surujbali desmond

</td>

<td style="text-align:left;">

ramos ovidio perez 42 walnut loop lot\#42 plant city fl 33565

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction- possession only

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-031816

</td>

<td style="text-align:left;">

2020-05-26

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

janvier jean m

</td>

<td style="text-align:left;">

joseph guerda 3720 garrison st tampa fl 33619

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-031849

</td>

<td style="text-align:left;">

2020-05-26

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

bote patricia

</td>

<td style="text-align:left;">

flores carlos 530 n miller rd valrico fl 33594|guzman tiffnie 530 n
miller rd valrico fl 33594

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-031852

</td>

<td style="text-align:left;">

2020-05-26

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

bonilla jose j

</td>

<td style="text-align:left;">

garcia miguel 10810 boyette rd \#1141 riverview fl 33569

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-031856

</td>

<td style="text-align:left;">

2020-05-26

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

ben capital inc

</td>

<td style="text-align:left;">

ray hansen james 6106 anna ave gibsonton fl 33534

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-031857

</td>

<td style="text-align:left;">

2020-05-26

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

dja management llc

</td>

<td style="text-align:left;">

griffin simone 8216 n marks street \#a tampa fl 33604

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-031697

</td>

<td style="text-align:left;">

2020-05-22

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

estate of habibollah s. amrooei|amrooei shahla g|amrooei danoosh s

</td>

<td style="text-align:left;">

estate of habibollah s. amrooei|amrooei shahla g 14502 n dale mabry hwy
suite 200 tampa fl 33618|amrooei danoosh s 14502 n dale mabry hwy suite
200 tampa fl 33618|layali tampa lounge llc 4819 e busch blvd suite
204-207 tampa fl 33617

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-031416

</td>

<td style="text-align:left;">

2020-05-22

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

nomany tommy

</td>

<td style="text-align:left;">

montalvo eva 4904 country hills dr. tampa fl 33624

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-031419

</td>

<td style="text-align:left;">

2020-05-22

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

laslo kyong e|laslo william j jr

</td>

<td style="text-align:left;">

mcentarfer alec 9537 balm-riverview road riverview fl
33569|hall-gearhart morgan 9537 blam-riverview road riverview fl 33569

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

2020-05-24

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-031421

</td>

<td style="text-align:left;">

2020-05-22

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

nash anna

</td>

<td style="text-align:left;">

johnson charles 11316 bacale lane \#2 gibsonton fl 33534

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-031428

</td>

<td style="text-align:left;">

2020-05-22

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

morris michael

</td>

<td style="text-align:left;">

boyd lamont 2335 w nassau st tampa fl 33607

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction- possession only

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-031460

</td>

<td style="text-align:left;">

2020-05-22

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

camelot family communities llc

</td>

<td style="text-align:left;">

mullens traci 11609 courageous court lot 72 thonosassa fl 33592

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-031468

</td>

<td style="text-align:left;">

2020-05-22

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

livingston family communities llc

</td>

<td style="text-align:left;">

davis erica 15868 martha cir lot \#14 lutz fl 33549

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-031470

</td>

<td style="text-align:left;">

2020-05-22

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

river run mobile home park llc

</td>

<td style="text-align:left;">

hardage donald 8401 bowles rd lot 6 tampa fl 33637

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-ca-004337

</td>

<td style="text-align:left;">

2020-05-21

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

a2 llc

</td>

<td style="text-align:left;">

the vigor group llc c/o united states corporation agents 5575 s. semoran
blvd. unit 36 orlando fl 32882

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

delinquent tenant

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-031398

</td>

<td style="text-align:left;">

2020-05-21

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

peak 47 llc

</td>

<td style="text-align:left;">

whitfiled keisha 4701 east citrus circle apartment \# 3 tampa fl 33617

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction- possession only

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-031411

</td>

<td style="text-align:left;">

2020-05-21

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

los fuentes mobile home park 3 llc

</td>

<td style="text-align:left;">

lara cristobal 3201 turkey creek rd. lot 4 plant city fl 33566|alvarez
omar 3201 turkey creek rd. lot 4 plant city fl 33566|lopez baut ruben
3201 turkey creek rd. lot 4 plant city fl 33566

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt unlawful detainer

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-031152

</td>

<td style="text-align:left;">

2020-05-21

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

perez juan carlos

</td>

<td style="text-align:left;">

chavez lian joa 6430 north gomez ave tampa fl 33614|perez mejias osnay
6430 north gomez ave tampa fl 33614

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-031327

</td>

<td style="text-align:left;">

2020-05-21

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

minnifield tina marie

</td>

<td style="text-align:left;">

harris terry j 528 oakbriar place brandon fl 33510

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-ca-004278

</td>

<td style="text-align:left;">

2020-05-20

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

beltran manual|beltran-barajas anselmo

</td>

<td style="text-align:left;">

beltran-barajas anselmo|melendez susan

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

unlawful detainer

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-030892

</td>

<td style="text-align:left;">

2020-05-20

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

young crystal

</td>

<td style="text-align:left;">

moore jamal 1015 e lake ave tampa fl 33605

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-030893

</td>

<td style="text-align:left;">

2020-05-20

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

young crystal

</td>

<td style="text-align:left;">

lamoureux tiffany 1010 e 15th ave tampa fl 33605

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-030894

</td>

<td style="text-align:left;">

2020-05-20

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

young crystal

</td>

<td style="text-align:left;">

williams shawn 7401 s faul st tampa fl 33616

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-030895

</td>

<td style="text-align:left;">

2020-05-20

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

young crystal

</td>

<td style="text-align:left;">

mcelroy craig 2112 w palmetto st tampa fl 33607

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-030896

</td>

<td style="text-align:left;">

2020-05-20

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

young crystal

</td>

<td style="text-align:left;">

nevarez javier 1021 e columbus dr tampa fl 33605

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-030897

</td>

<td style="text-align:left;">

2020-05-20

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

del valle florencia|lopez sylvia y

</td>

<td style="text-align:left;">

kuiken kenneth 2821 n 20th street tampa fl 33605|fellows terry 2821 n
20th street tampa fl 33605|collins mickey 2821 n 20th street tampa fl
33605

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-030898

</td>

<td style="text-align:left;">

2020-05-20

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

young crystal

</td>

<td style="text-align:left;">

nish alecia 8111 n 10th street tampa fl 33604

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-030932

</td>

<td style="text-align:left;">

2020-05-20

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

hines reginald l

</td>

<td style="text-align:left;">

choates tabita 3414 n 53rd st unit a tampa fl 33619

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-030991

</td>

<td style="text-align:left;">

2020-05-20

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

clark richard

</td>

<td style="text-align:left;">

burrell shawn 13734 n nebraska ave tampa fl 33613

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-030992

</td>

<td style="text-align:left;">

2020-05-20

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

junross realty inc

</td>

<td style="text-align:left;">

perkins renesha 1529a east 128th avenue tampa fl 33612

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-031000

</td>

<td style="text-align:left;">

2020-05-20

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

dlktb enterprises llc

</td>

<td style="text-align:left;">

mota ronnie 1015 & 1017 w waters ave tampa fl 33604

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-031011

</td>

<td style="text-align:left;">

2020-05-20

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

woshi terrace square apartments llc

</td>

<td style="text-align:left;">

colson stephanie lynn 5906 terrace square drive unit a tampa fl 33617

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction- possession only

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-031013

</td>

<td style="text-align:left;">

2020-05-20

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

camelot family comm llc|camelot family comm llc

</td>

<td style="text-align:left;">

stevens erica 11625 courageous court lot 66 thontosassa fl 33592

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-031015

</td>

<td style="text-align:left;">

2020-05-20

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

la thao|le nguyen

</td>

<td style="text-align:left;">

ortiz borges ana cecilia 10201 n 23rd st tampa fl 33612

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-031027

</td>

<td style="text-align:left;">

2020-05-20

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

garcia felicite

</td>

<td style="text-align:left;">

garcia tarnisha 1280 e 113th ave. apt. 112 tampa fl 33612

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt unlawful detainer

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-031029

</td>

<td style="text-align:left;">

2020-05-20

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

rjce properties llc

</td>

<td style="text-align:left;">

taco bus 01 inc c/o umar farooq 2320 fletcher ave. tampa fl 33612|umar
farooq 2320-2318 e fletcher avenue tampa fl 33612

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction- possession only

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-031030

</td>

<td style="text-align:left;">

2020-05-20

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

tzadik management|tzadik oaks llc|tzadik oaks apartments

</td>

<td style="text-align:left;">

porsch tiana 1266 e 113th ave apt 214 tampa fl 33612

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction- possession only

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-031059

</td>

<td style="text-align:left;">

2020-05-20

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

garcia eliseo lozano

</td>

<td style="text-align:left;">

unknown tenant 1612 hughes dr. plant city fl 33563|torres samuel 1612
hughes dr. plant city fl 33563

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-031061

</td>

<td style="text-align:left;">

2020-05-20

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

hayes enterprises llc

</td>

<td style="text-align:left;">

tenant unknown 13402 monte carlo court \#41 tampa fl 33612|solis sabilon
olga lorena 13402 monte carlo ct. \#41 tampa fl 33612

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-031062

</td>

<td style="text-align:left;">

2020-05-20

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

hayes enterprises llc

</td>

<td style="text-align:left;">

tenant unknown 13435 la place circle \#66 tampa fl 33612|wilson connetia
13435 la place circle \#66 tampa fl 33612

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-031074

</td>

<td style="text-align:left;">

2020-05-20

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

robles park llc

</td>

<td style="text-align:left;">

andre darby 413 e. nordica street unit 191 tampa fl 33603

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction- possession only

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-031088

</td>

<td style="text-align:left;">

2020-05-20

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

rockhouse renovations and investments inc

</td>

<td style="text-align:left;">

cartagena elizabeth 2008 w humphrey street tampa fl 33604

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt unlawful detainer

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

2020-06-11

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-030698

</td>

<td style="text-align:left;">

2020-05-19

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

daudu mopelola

</td>

<td style="text-align:left;">

jones shannon 6106 n 23rd st tampa fl 33610

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-030699

</td>

<td style="text-align:left;">

2020-05-19

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

sutter anthony|ferrell melissa

</td>

<td style="text-align:left;">

hill rosemarie 226 halliday park dr tampa fl 33612

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-030700

</td>

<td style="text-align:left;">

2020-05-19

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

diaz perez juan luis

</td>

<td style="text-align:left;">

munet robert 2601 s 68th st aptb tampa fl 33619

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-030701

</td>

<td style="text-align:left;">

2020-05-19

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

marinucci enterprises llc

</td>

<td style="text-align:left;">

hernandez candida 7516 n clark ave tampa fl 33614|rodriguez noel 7516 n
clark ave tampa fl 33614

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

2020-06-04

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-030714

</td>

<td style="text-align:left;">

2020-05-19

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

duong wendy

</td>

<td style="text-align:left;">

fleming lisa p 418 halifax bay court apollo beach fl 33572

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction- possession only

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-030722

</td>

<td style="text-align:left;">

2020-05-19

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

morris michael

</td>

<td style="text-align:left;">

brown nathaniel 2335 w nassau st tampa fl 33607

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction- possession only

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-030791

</td>

<td style="text-align:left;">

2020-05-19

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

group one management llc

</td>

<td style="text-align:left;">

newsome benjamin l. 508 n. excelda ave tampa fl 33609|collins kellie h.
508 n. excelda ave tampa fl 33609

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction- possession only

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-030797

</td>

<td style="text-align:left;">

2020-05-19

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

nguyen anh|nguyen sang

</td>

<td style="text-align:left;">

heremic vedrana 2004 e 140th ave apt 5 tampa fl 33613

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-030806

</td>

<td style="text-align:left;">

2020-05-19

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

potenziani peter

</td>

<td style="text-align:left;">

jewell michael 705 e. hanlon street tampa fl 33604

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt unlawful detainer

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-030830

</td>

<td style="text-align:left;">

2020-05-19

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

vaughn mayor c

</td>

<td style="text-align:left;">

simpson josh 8410 n. 40th st room \#2 tampa fl 33604

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction- possession only

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-030832

</td>

<td style="text-align:left;">

2020-05-19

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

wallis charles

</td>

<td style="text-align:left;">

wilson chekyrah 1014 n parsons ave lot 6 seffner fl 33584

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-030850

</td>

<td style="text-align:left;">

2020-05-19

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

i touch llc

</td>

<td style="text-align:left;">

occupants all other 4801 e hillsborough ave lot\# l-30 tampa fl
33610|vasquez nilda 4801 e hillsborough ave l-30 tampa fl 33610

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-030853

</td>

<td style="text-align:left;">

2020-05-19

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

northdale llc

</td>

<td style="text-align:left;">

cornerstone pub inc 3893-95 northdale blvd tampa fl 33624|gone corporate
inc 3893-95 northdale blvd tampa fl 33624

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-030857

</td>

<td style="text-align:left;">

2020-05-19

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

french quarter llc

</td>

<td style="text-align:left;">

myhre kevin 14622 n dale mabry hwy tampa fl 33618|myhre lauren 14622 n
dale mabry hwy tampa fl 33618|she money 14622 n dale mabry hwy tampa fl
33618

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-030878

</td>

<td style="text-align:left;">

2020-05-19

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

tzadik management|tzadik oaks llc|tzadik oaks apartments

</td>

<td style="text-align:left;">

oliver jordan 1262 e 113th ave apt 109 tampa fl 33612

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction- possession only

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-030879

</td>

<td style="text-align:left;">

2020-05-19

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

tzadik management|tzadik oaks llc|tzadik oaks apartments

</td>

<td style="text-align:left;">

johnson charles 1268 e 113th ave apt 105 tampa fl 33612

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction- possession only

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-030880

</td>

<td style="text-align:left;">

2020-05-19

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

tzadik management|tzadik oaks llc|tzadik oaks apartments

</td>

<td style="text-align:left;">

johnson daniel 1276 e 113th ave apt 107 tampa fl 33612

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction- possession only

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-ca-004240

</td>

<td style="text-align:left;">

2020-05-19

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

moj realty llc

</td>

<td style="text-align:left;">

rios juan 1850 providence lakes blvd. brandon fl 33511|mckinney mark
5327 lime ave. sffner fl 33584|ocho blanco llc 112 pierce christie dr.
valrico fl 33594

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

removal of tenant

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-030495

</td>

<td style="text-align:left;">

2020-05-18

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

fletcher lynn m

</td>

<td style="text-align:left;">

galeno robert 1739 tarah trace drive brandon fl 33510|unknown tenant
18108 peregrines perch pl\#7304 lutz fl 33558

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-030497

</td>

<td style="text-align:left;">

2020-05-18

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

tampa 492 llc

</td>

<td style="text-align:left;">

crackd management llc 12918 dupont circle tampa fl 33626

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction- possession only

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-030528

</td>

<td style="text-align:left;">

2020-05-18

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

segui enterprises inc.

</td>

<td style="text-align:left;">

dianez acosta claudia b. 3422 west lambright ave \# a tampa fl
33614|martinez richard felix 3422 west lambright ave \#a tampa fl 33614

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-030536

</td>

<td style="text-align:left;">

2020-05-18

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

frank alon

</td>

<td style="text-align:left;">

zachowicz tiffany 4015 bayshore blvd unit 9e tampa fl 33611|betancourt
richard 4015 bayshore blvd unit 9e tampa fl 33611

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-030539

</td>

<td style="text-align:left;">

2020-05-18

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

nunez kirenia

</td>

<td style="text-align:left;">

montney stephen 12506 pittsfield ave tampa fl 33624

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt unlawful detainer

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-030650

</td>

<td style="text-align:left;">

2020-05-18

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

tzadik oaks llc|tzadik management|tzadik oaks apartments

</td>

<td style="text-align:left;">

brown bobby 1260 e 113th ave apt 102 tampa fl 33612

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction- possession only

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-030652

</td>

<td style="text-align:left;">

2020-05-18

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

tzadik management|tzadik oaks apartments|tzadik oaks llc

</td>

<td style="text-align:left;">

leeks keandra 1252 e 113th ave apt 208 tampa fl 33612

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction- possession only

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-030653

</td>

<td style="text-align:left;">

2020-05-18

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

tzadik management|tampa palms mmg llc|palm court apartments

</td>

<td style="text-align:left;">

bellis navilla 13010 kain palms blvd w apt 204 tampa fl 33647

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction- possession only

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-030655

</td>

<td style="text-align:left;">

2020-05-18

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

tzadik management|shadow pines apartments|columbia sherman investments
llc

</td>

<td style="text-align:left;">

hicks ronnieshia 12202 n 15th st apt 807 tampa fl 33612

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction- possession only

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-030656

</td>

<td style="text-align:left;">

2020-05-18

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

tzadik management|shadow pines apartments|columbia sherman investments
llc

</td>

<td style="text-align:left;">

singleton octavia 12202 n 15th st \#806 tampa fl 33612

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction- possession only

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-029974

</td>

<td style="text-align:left;">

2020-05-15

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

rodgriguez reguera arletis

</td>

<td style="text-align:left;">

arroyo carmen 317 grennvale drive tampa fl 33615

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-030003

</td>

<td style="text-align:left;">

2020-05-15

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

dixon kristopher|richardson courtney

</td>

<td style="text-align:left;">

stafford marty 2715 west state road 60 plant city fl 33567

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-030048

</td>

<td style="text-align:left;">

2020-05-15

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

tzadik management|columbia sherman investments llc|columbia oaks
apartments

</td>

<td style="text-align:left;">

scriven terieka 12717 n 19th st unit c6 tampa fl 33612

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction- possession only

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-030084

</td>

<td style="text-align:left;">

2020-05-15

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

12739 fl ave llc

</td>

<td style="text-align:left;">

tenants unknown 312 rosa linda ln tampa fl 33612|stansbury gloriann 312
rosa linda ln tampa fl 33612

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-030110

</td>

<td style="text-align:left;">

2020-05-15

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

tzadik management|columbia sherman investments llc|shadow pines
apartments

</td>

<td style="text-align:left;">

bonner claudette 12202 n 15th st 708 tampa fl 33612|bonner shadwick
12202 n 15th st 708 tampa fl 33612

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction- possession only

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-030113

</td>

<td style="text-align:left;">

2020-05-15

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

cirilo luis e.

</td>

<td style="text-align:left;">

wehbe brenda 11940 n. us hwy 301 lot 75b thonotosassa fl 33592

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-030139

</td>

<td style="text-align:left;">

2020-05-15

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

tzadik management|columbia sherman investments llc|shadow pines
apartments

</td>

<td style="text-align:left;">

smith jhane 12202 n 15th st 507 tampa fl 33612

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction- possession only

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-030151

</td>

<td style="text-align:left;">

2020-05-15

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

mhp tampa island llc

</td>

<td style="text-align:left;">

unknown tenants 5035 pine st \#9 seffner fl 33584|whittle caitlin 5035
pine street \#9 seffner fl 33584

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-030176

</td>

<td style="text-align:left;">

2020-05-15

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

rainbow city llc|vance kay lynn

</td>

<td style="text-align:left;">

ventimiglia andrew 1150 fletcher lane a-16 plant city fl 33563

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-030197

</td>

<td style="text-align:left;">

2020-05-15

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

romarie sanchez medina llc

</td>

<td style="text-align:left;">

soto lexica 1405 holland ave \#a tampa fl 33612

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-030249

</td>

<td style="text-align:left;">

2020-05-15

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

simons d barry|the renee catia gaddis trust dated 2/18/97|the sara
simone knight trust|abrosa realty llc|mosdell inc|close ties investments
llc

</td>

<td style="text-align:left;">

srj restaurants inc. 5575 s semoran blvd 36 orlando fl 32822|rt tampa
franchise lp ct corporation 1200 s pine island road plantation fl 33324

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction- possession only

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-029742

</td>

<td style="text-align:left;">

2020-05-14

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

donat hagai

</td>

<td style="text-align:left;">

shumake shirley 2827 anthony st unit a tampa fl 33619

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-029750

</td>

<td style="text-align:left;">

2020-05-14

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

gordon nicholas a

</td>

<td style="text-align:left;">

lee janice 4204 e ellicott st tampa fl 33610|sampson larry 4204 e
ellicot st tampa fl 33610

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-029751

</td>

<td style="text-align:left;">

2020-05-14

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

donat doron|donat hagai

</td>

<td style="text-align:left;">

cruz reynaldo 8120 semmes st tampa fl 33604

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-029752

</td>

<td style="text-align:left;">

2020-05-14

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

gabriel connie

</td>

<td style="text-align:left;">

and any other persons 8919 paul buchman hwy plant city fl 33565|everett
hollis l jr 8919 paul buchman hwy plant city fl 33565

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt unlawful detainer

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-029754

</td>

<td style="text-align:left;">

2020-05-14

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

schoonmaker helen

</td>

<td style="text-align:left;">

whitmer timothy 2902 w. price avenue tampa fl 33611

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-029758

</td>

<td style="text-align:left;">

2020-05-14

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

mhp tampa estates llc

</td>

<td style="text-align:left;">

williams amber g 6018 black dairy rd \#12 seffner fl 33584|brown antonio
d 6018 black dairy rd \# 12 seffner fl 33584

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-029760

</td>

<td style="text-align:left;">

2020-05-14

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

mhp tampa air llc

</td>

<td style="text-align:left;">

all unknown tenant(s) 10726 skewlee rd lot \#9 thonotosassa fl
33592|vonada sarah 107276 skewlee rd lot \#9 thonotosassa fl 33592

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-029764

</td>

<td style="text-align:left;">

2020-05-14

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

roberts jonathon|trugillo tiffany|mhp tampa air llc

</td>

<td style="text-align:left;">

roberts jonathon 6114 macmanor rd \#10 seffner fl 33584|trugillo tiffany
6114 macmanor rd 10 seffner fl 33584|mhp tampa air llc 11213 e sligh ave
seffner fl 33584

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-029775

</td>

<td style="text-align:left;">

2020-05-14

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

mhp tampa estates llc

</td>

<td style="text-align:left;">

brown brandi 11226 sarahjoe bright pl seffner fl 33584|brown robert
11226 sarahjoe bright pl seffner fl 33584

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-029793

</td>

<td style="text-align:left;">

2020-05-14

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

arcon properties llp

</td>

<td style="text-align:left;">

fernandez kaitlin 4807 w. flamingo road; \#10 tampa fl 33611|fernandez
devin 4807 w. flamingo road \#10 tampa fl 33611

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction- possession only

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-029809

</td>

<td style="text-align:left;">

2020-05-14

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

e.l.m. north llc

</td>

<td style="text-align:left;">

bishop peter a. 1433 delano trent street ruskin fl 33570

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction- possession only

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-029846

</td>

<td style="text-align:left;">

2020-05-14

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

burger jeffrey

</td>

<td style="text-align:left;">

gabbert jessika s 1415 east 140th ave apt g tampa fl 33613

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-029872

</td>

<td style="text-align:left;">

2020-05-14

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

dahabra maher

</td>

<td style="text-align:left;">

ruski william 5431 mobile dr seffner fl 33584|heiser jacquelyne 5431
mobile dr seffner fl 33584

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction- possession only

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-029878

</td>

<td style="text-align:left;">

2020-05-14

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

north rome mobile home court llc

</td>

<td style="text-align:left;">

ruiz ivelisse 6700 n. rome ave. lot \#516b tampa fl 33604

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-029879

</td>

<td style="text-align:left;">

2020-05-14

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

dash real estate network llc

</td>

<td style="text-align:left;">

tenants unknown 5240 e broadway ave unit 66 tampa fl 33619|lettsome
tiffon 5240 e broadway ave unit 66 tampa fl 33619|thomas mary 5240 e
broadway ave unit 66 tampa fl 33619

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-029892

</td>

<td style="text-align:left;">

2020-05-14

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

columbia sherman investments llc|tzadik management|columbia oaks
apartments

</td>

<td style="text-align:left;">

yochebed israel 12717 n 19th st unit a4 tampa fl 33612

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction- possession only

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-029905

</td>

<td style="text-align:left;">

2020-05-14

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

columbia sherman investments llc|tzadik management|columbia oaks
apartments

</td>

<td style="text-align:left;">

battle reginold 12717 n 19th st unit a7 tampa fl 33612

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction- possession only

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-029913

</td>

<td style="text-align:left;">

2020-05-14

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

columbia sherman investments llc|tzadik management|columbia oaks
apartments

</td>

<td style="text-align:left;">

yeargin wilhelmina 12717 n 19th st unit b8 tampa fl 33612

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction- possession only

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-029478

</td>

<td style="text-align:left;">

2020-05-13

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

lu xiuli|ling yiping

</td>

<td style="text-align:left;">

miffin laqweata silvia leeandra 16620 brigaddon dr tampa fl
33618|holston brandon craig 16620 brigadoon dr tampa fl 33618

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-029501

</td>

<td style="text-align:left;">

2020-05-13

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

parsons green apartments|lukose joseph

</td>

<td style="text-align:left;">

vereen imani parsons greens apartments \#202 200 cook st brandon fl
33511

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-029531

</td>

<td style="text-align:left;">

2020-05-13

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

rodriguez antonio

</td>

<td style="text-align:left;">

alsina jimenez angel l 3017 w ivy st tampa fl 33607

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-029535

</td>

<td style="text-align:left;">

2020-05-13

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

g\&h tampa development llc

</td>

<td style="text-align:left;">

creal jamilah 5912 n nebraska ave \#12 tampa fl 33604

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-029536

</td>

<td style="text-align:left;">

2020-05-13

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

3223 azalea blossom land trust|trinity management group llc|a big
blessed family llc

</td>

<td style="text-align:left;">

tyre shana 3223 azalea blossom drive plant city fl 33567|tyre david 3223
azalea blossom drive plant city fl 33567

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction- possession only

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-029544

</td>

<td style="text-align:left;">

2020-05-13

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

benyamine abdellatif

</td>

<td style="text-align:left;">

brown jeri 4024 e river hills drive tampa fl 33617

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-029584

</td>

<td style="text-align:left;">

2020-05-13

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

giacalone lisa|corigliano michelle

</td>

<td style="text-align:left;">

buydos shawn 2011 e. columbus drive tampa fl 33605

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction- possession only

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

2020-05-27

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-029590

</td>

<td style="text-align:left;">

2020-05-13

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

franco cruz carlos javier

</td>

<td style="text-align:left;">

nazario martiz sandra 8331 galewood circle tampa fl 33615

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt unlawful detainer

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-029592

</td>

<td style="text-align:left;">

2020-05-13

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

vo lang

</td>

<td style="text-align:left;">

unknown tenants 706 e ottio st plant city fl 33563|lozano juan garcia
706 e ottio st plant city fl 33563

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-029636

</td>

<td style="text-align:left;">

2020-05-13

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

hayes enterprises llc

</td>

<td style="text-align:left;">

tenant unknown 13401 monte carlo court \#35 tampa fl 33612|garcia karen
13401 monte carlo court \#35 tampa fl 33612

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-029640

</td>

<td style="text-align:left;">

2020-05-13

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

hayes enterprises llc

</td>

<td style="text-align:left;">

tenant unknown 13401 monte carlo court \#38 tampa fl 33612|vergara celso
13401 monte carlo court \#38 tampa fl 33612

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-029670

</td>

<td style="text-align:left;">

2020-05-13

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

surujbali desmond

</td>

<td style="text-align:left;">

ramirez maria 79 pine oak dr. plant city fl 33563

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction- possession only

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-029675

</td>

<td style="text-align:left;">

2020-05-13

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

tzadik management|tampa commons mmg llc|village commons

</td>

<td style="text-align:left;">

wilford ashley 1504 e 138th ave apt h tampa fl 33612

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction- possession only

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-029679

</td>

<td style="text-align:left;">

2020-05-13

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

tzadik management|columbia oaks apartments|columbia sherman investments
llc

</td>

<td style="text-align:left;">

lasing trinity 12717 n 19th st unit c8 tampa fl 33612

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction- possession only

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-029167

</td>

<td style="text-align:left;">

2020-05-12

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

brown william a

</td>

<td style="text-align:left;">

martell robinson andrae 7908 n florida ave apt 3 tampa fl 33604

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-029168

</td>

<td style="text-align:left;">

2020-05-12

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

vider marsha len

</td>

<td style="text-align:left;">

mcmichael tammy lynn 9408 n newport ave. tampa fl 33612

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt unlawful detainer

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-029203

</td>

<td style="text-align:left;">

2020-05-12

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

giani jr joseph j

</td>

<td style="text-align:left;">

hewitt linda 8601-d boulder ct apt 304d tampa fl 33615

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction- possession only

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-029248

</td>

<td style="text-align:left;">

2020-05-12

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

muriel miguel

</td>

<td style="text-align:left;">

fuentes boris 809 w peninsular st tampa fl 33603|zabala zoraida 809 w
peninsular st tampa fl 33603

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction- possession only

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-029249

</td>

<td style="text-align:left;">

2020-05-12

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

monroe lucretia

</td>

<td style="text-align:left;">

unknown tenant 6255 canopy tree dr apt 2-6255 tampa fl 33610|johnson
erika 6255 canopy tree dr apt 2-6255 tampa fl 33610

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt unlawful detainer

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-029250

</td>

<td style="text-align:left;">

2020-05-12

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

zellner ljwan

</td>

<td style="text-align:left;">

pierre willisa s 7802 river resort lane apt a tampa fl 33617

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt unlawful detainer

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-029329

</td>

<td style="text-align:left;">

2020-05-12

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

pepperwood apartments dpm llc

</td>

<td style="text-align:left;">

urtecho paguada noel andres 13729 susan kay drive apt. c tampa fl
33613|paguada keyla 13729 susan kay drive apt. c tampa fl 33613|rivera
luis 13729 susan kay drive apt. c tampa fl 33613

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction- possession only

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-029344

</td>

<td style="text-align:left;">

2020-05-12

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

g & h tampa development llc

</td>

<td style="text-align:left;">

serrano evan 5912 n nebraska ave \#11 tampa fl 33604|frascino alicia
5912 n nebraska ave \#11 tampa fl 33604

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-029349

</td>

<td style="text-align:left;">

2020-05-12

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

territo kathleen y

</td>

<td style="text-align:left;">

brozena joann 19103 tracy court lutz fl 33548

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt unlawful detainer

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-ca-003991

</td>

<td style="text-align:left;">

2020-05-11

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

allstate business centers inc.

</td>

<td style="text-align:left;">

mitchell andropolis j|androtek appliance llc 2538 w pine st. unit c
tampa fl 33607

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

delinquent tenant

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-028977

</td>

<td style="text-align:left;">

2020-05-11

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

a and m investment trust llc trustee

</td>

<td style="text-align:left;">

amuari sanit 4225 garden ln tampa fl 33610

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-028994

</td>

<td style="text-align:left;">

2020-05-11

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

melgoza contreras maunela

</td>

<td style="text-align:left;">

tenant unknown 3418 lindsey st white commercial vehicle dover fl 33527

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt unlawful detainer

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-029012

</td>

<td style="text-align:left;">

2020-05-11

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

middletown property management llc

</td>

<td style="text-align:left;">

finch joseph 2221 e 17th ave apt b tampa fl 33605

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction- possession only

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-029049

</td>

<td style="text-align:left;">

2020-05-11

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

clearview enterprises llc|renaissance properties llc

</td>

<td style="text-align:left;">

owens walter e sr 10004 davis st gibsonton fl 33534|owens walter e jr
10004 davis st lot a1 gibsonton fl 33534

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-029050

</td>

<td style="text-align:left;">

2020-05-11

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

duque antonio

</td>

<td style="text-align:left;">

mcgowan darian le 14832 shaw rd tampa fl 33625|cortez william mark 14832
shaw rd tampa fl 33625

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-029052

</td>

<td style="text-align:left;">

2020-05-11

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

rojas garcia agro

</td>

<td style="text-align:left;">

delgado maria 9914 connecticut st gibsonton fl 33534

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-029095

</td>

<td style="text-align:left;">

2020-05-11

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

perkins elizabeth m|clark larry c ii

</td>

<td style="text-align:left;">

bodden joseph e 13224 pine creek circle riverview fl 33579

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-029116

</td>

<td style="text-align:left;">

2020-05-11

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

florida tenant pro llc

</td>

<td style="text-align:left;">

smith keith t 11016 black sawn court seffner fl 33584

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction- possession only

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-028817

</td>

<td style="text-align:left;">

2020-05-08

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

byers laura

</td>

<td style="text-align:left;">

pardo leslie 6014 laketree lane unit c tampa fl 33617

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction- possession only

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-028823

</td>

<td style="text-align:left;">

2020-05-08

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

dominguez gilberto

</td>

<td style="text-align:left;">

ulloa-reyes niurka 4913 murray hill dr tampa fl 33615

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-028859

</td>

<td style="text-align:left;">

2020-05-08

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

grand pavilion owner llc

</td>

<td style="text-align:left;">

jones kenneth 3129 grand pavilion drive \#102 tampa fl 33613

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction- possession only

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-028863

</td>

<td style="text-align:left;">

2020-05-08

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

morris michael

</td>

<td style="text-align:left;">

webb dorrell 2334 w nassau st tampa fl 33607

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-028918

</td>

<td style="text-align:left;">

2020-05-08

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

higgins janice marie|higgins john james

</td>

<td style="text-align:left;">

taylor trent 9614 n. boulevard tampa fl 33612|winstead todd 9614
n. boulevard tampa fl 33612|sandage diane 9614 n. boulevard tampa fl
33612

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-028922

</td>

<td style="text-align:left;">

2020-05-08

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

pinker julia

</td>

<td style="text-align:left;">

raulerson stephanie 12667 w franklin rd thonotosassa fl 33592|raulerson
glenn 12667 w. franklin rd thonotosassa fl 33592

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-028925

</td>

<td style="text-align:left;">

2020-05-08

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

vaughn mayor

</td>

<td style="text-align:left;">

unknown frank 8410 n 40th st tampa fl 33604

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction- possession only

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-028926

</td>

<td style="text-align:left;">

2020-05-08

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

ormsby sonya

</td>

<td style="text-align:left;">

ormsby daniella 4413 vieux carre cir tampa fl 33613

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-028928

</td>

<td style="text-align:left;">

2020-05-08

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

bloomfield-st. pete properties llc|neptune village

</td>

<td style="text-align:left;">

doe john 2525 gulf city rd. lot 40 ruskin fl 33570|rudow joseph edward
2525 gulf city rd. lot 40 ruskin fl 33570

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction- possession only

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-028929

</td>

<td style="text-align:left;">

2020-05-08

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

asymptotic llc

</td>

<td style="text-align:left;">

guy jasmine lynn 9416 n 50th st unit c tampa fl 33617

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-028932

</td>

<td style="text-align:left;">

2020-05-08

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

florida trustee services llc

</td>

<td style="text-align:left;">

yogus edward matthew 2411 thrace st tampa fl 33605

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-028934

</td>

<td style="text-align:left;">

2020-05-08

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

duncan angela

</td>

<td style="text-align:left;">

guyer stephanie 7215 e emma st tampa fl 33610

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-028935

</td>

<td style="text-align:left;">

2020-05-08

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

smith ernest

</td>

<td style="text-align:left;">

williams marquita 9323 goldenrod rd unit a thonotosassa fl 33592

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt unlawful detainer

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-028939

</td>

<td style="text-align:left;">

2020-05-08

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

duncan angela

</td>

<td style="text-align:left;">

tenants unknown 3112 e columbus dr tampa fl 33605|salazar frank 3112 e
columbus dr tampa fl 33605

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-028941

</td>

<td style="text-align:left;">

2020-05-08

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

duncan angela

</td>

<td style="text-align:left;">

malone raimone 3510 e 10th ave tampa fl 33605

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-028946

</td>

<td style="text-align:left;">

2020-05-08

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

grand central at kennedy master property owners’

</td>

<td style="text-align:left;">

clifton c. curry jr. revocable trust 750 w lumsden road tampa fl
33511|curry mary elizabeth 1120 e. kennedy blvd. \#517 tampa fl 33602

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction- possession only

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-ca-003984

</td>

<td style="text-align:left;">

2020-05-08

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

highway 60 & 301 center inc

</td>

<td style="text-align:left;">

gonzalez jorge l 105 s highway 301 suite 126 tampa fl 33619|pink and
purple llc 105 us highway 301 south suite 126 tampa fl 33619

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

removal of tenant

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-028640

</td>

<td style="text-align:left;">

2020-05-07

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

sutter anthony|ferrell melissa

</td>

<td style="text-align:left;">

krouse james 13723 charles st tampa fl 33613|jenkins daniel 13723
charles st tampa fl 33613

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction- possession only

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-028669

</td>

<td style="text-align:left;">

2020-05-07

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

lakeshore villas|cax lakeshore llc

</td>

<td style="text-align:left;">

doe john 15413 lakeshore villa circle lot no. 293 tampa fl 33613|miller
kirby elliot 15413 lakeshore villa circle lot no. 293 tampa fl
33613|miller peggy 15413 lakeshore villa circle lot no. 293 tampa fl
33613

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction- possession only

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-028697

</td>

<td style="text-align:left;">

2020-05-07

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

wedekamm robert

</td>

<td style="text-align:left;">

robles mark 4020 w waters ave tampa fl 33614

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-028698

</td>

<td style="text-align:left;">

2020-05-07

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

brown carl david jr

</td>

<td style="text-align:left;">

unknown occupant 3 104 n. david st. plant city fl 33566|unknown occupant
2 104 n david st. plant city fl 33566|unknown occupant 1 104 n. david
st. plant city fl 33566

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt unlawful detainer

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-028699

</td>

<td style="text-align:left;">

2020-05-07

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

50th street propety services llc

</td>

<td style="text-align:left;">

cunningham nicholas 2310 50th street lot 11b tampa fl 33619

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-028700

</td>

<td style="text-align:left;">

2020-05-07

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

waterside family communities llc

</td>

<td style="text-align:left;">

martinez selena 8536 honeywell rd lot \#2 gibsonton fl 33584

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-028707

</td>

<td style="text-align:left;">

2020-05-07

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

gulf south realty

</td>

<td style="text-align:left;">

blair anthony 10603 n nebraska ave \#10 tampa fl 33612

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-028349

</td>

<td style="text-align:left;">

2020-05-06

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

muriel miguel a

</td>

<td style="text-align:left;">

fuentes boris 809 w peninsular st tampa fl 33603|zabala zoraida 809 w
peninsular st tampa fl 33603

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-028356

</td>

<td style="text-align:left;">

2020-05-06

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

donat hagai

</td>

<td style="text-align:left;">

alvarez michelle 1007 e bouganvillea ave unit a tampa fl 33612

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-028357

</td>

<td style="text-align:left;">

2020-05-06

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

friedman mirela|maharaj adna

</td>

<td style="text-align:left;">

ocasio crystal 22512 davis st tampa fl 33605|ocasio wilbverto 2212 davis
street tampa fl 33605|bonilla wallenda 2212 davis street tampa fl 33605

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-028358

</td>

<td style="text-align:left;">

2020-05-06

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

gay patty denise

</td>

<td style="text-align:left;">

bell applereshia 2435 berry road plant city fl 33567|gay eula mea jr
2435 berry road plant city fl 33567

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction- possession only

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-028385

</td>

<td style="text-align:left;">

2020-05-06

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

wilson veralee

</td>

<td style="text-align:left;">

clark vanessa darlene 3013 thelma st tampa fl 33605

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt unlawful detainer

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-028411

</td>

<td style="text-align:left;">

2020-05-06

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

s\&m investments of tampa llc

</td>

<td style="text-align:left;">

unknown tenant 1524 e 139th ave tampa fl 33612|wingo sterling 1524 e
139th ave tampa fl 33612

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-028478

</td>

<td style="text-align:left;">

2020-05-06

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

jennings david

</td>

<td style="text-align:left;">

rodriguez beatriz 15101 north 15th street \#6b lutz fl
33549|carrosquillo luis 15101 north 15th street \# 6b lutz fl 33549|howe
shannon 15101 north 15th street \#6b lutz fl 33549

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-ca-003902

</td>

<td style="text-align:left;">

2020-05-06

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

everett clark

</td>

<td style="text-align:left;">

heritage property and casualty insurance company 200 e. gaines street
tallahassee fl 32399

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

delinquent tenant

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-028591

</td>

<td style="text-align:left;">

2020-05-06

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

mcclain family trust

</td>

<td style="text-align:left;">

turner jessica 1206 northwood drive seffner fl 33584|turner chris 1206
northwood drive seffner fl 33584

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-028197

</td>

<td style="text-align:left;">

2020-05-05

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

smith maydell

</td>

<td style="text-align:left;">

mcguire kevin d 5708 w knights griffin rd plant city fl 33565

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction- possession only

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

2020-05-05

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-028211

</td>

<td style="text-align:left;">

2020-05-05

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

calderon-correa daniela c

</td>

<td style="text-align:left;">

holguin carlos humberto 13243 prestwick dr riverview fl 33579|suco
brandi 6209 cannoli place riverview fl 33578-8397

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction- possession only

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-028263

</td>

<td style="text-align:left;">

2020-05-05

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

lorton george h

</td>

<td style="text-align:left;">

any and all unnamed tenants 7501 dartmouth avenue tampa fl 33604|barsch
donald 7501 dartmouth avenue tampa fl 33604

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $15.000.01-$30000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-028266

</td>

<td style="text-align:left;">

2020-05-05

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

weyrauch colin

</td>

<td style="text-align:left;">

cunningham kevin 3805 lake grove court unit no: garage apartment brandon
fl 33511

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt unlawful detainer

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-028277

</td>

<td style="text-align:left;">

2020-05-05

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

eckley bryan r

</td>

<td style="text-align:left;">

blanco fiorella dipietro 14642 bournemouth rd. tampa fl 33626

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction- possession only

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-028313

</td>

<td style="text-align:left;">

2020-05-05

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

bernaby aaron

</td>

<td style="text-align:left;">

collister barbie jo 4201 w wyoming ave tampa fl 33616

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt unlawful detainer

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-ca-003872

</td>

<td style="text-align:left;">

2020-05-05

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

liotine shawna|liotine joseph joe|l9 investments llc|liotine
shawna|liotine joseph joe|l9 investments llc|westchase medical holdings
llc|westchase medical holdings llc

</td>

<td style="text-align:left;">

traviesa a. trey|westchase medical holdings llc|liotine shawna 17404
brown road odessa fl 33556|liotine shawna 17404 brown road odessa fl
33556|liotine joseph joe 17404 brown road odessa fl 33556|liotine joseph
joe 17404 brown road odessa fl 33556|l9 investments llc c/o joseph
liotine r.a. 17404 brown road odessa fl 33556|l9 investments llc c/o
joseph liotine r.a. 17404 brown road odessa fl 33556

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

removal of tenant

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-028182

</td>

<td style="text-align:left;">

2020-05-05

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

flair douglas

</td>

<td style="text-align:left;">

carino john 4103 cragmont dr tampa fl 33610

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-028196

</td>

<td style="text-align:left;">

2020-05-05

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

santos mike

</td>

<td style="text-align:left;">

kosiorek sheila 820 e 1226th ave tampa fl 33612

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-ca-003832

</td>

<td style="text-align:left;">

2020-05-04

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

mooney longbranch ii llc

</td>

<td style="text-align:left;">

unknown tenant(s)/any other(s) in possession 5138 letourneau circle
tampa fl 33610|abdel feras 9416 lisbon street seffner fl 33584

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

delinquent tenant

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-028026

</td>

<td style="text-align:left;">

2020-05-04

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

kearney jon

</td>

<td style="text-align:left;">

fargo alex 3240 laurel dale dr tampa fl 33618|lamberth brittany 3240
laurel dale dr tampa fl 33618

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction- possession only

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-028043

</td>

<td style="text-align:left;">

2020-05-04

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

simmons alva

</td>

<td style="text-align:left;">

newsome stephanie 6445 cypressdale drive unit 201 riverview fl 33578

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction- possession only

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-028050

</td>

<td style="text-align:left;">

2020-05-04

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

ch capital inc

</td>

<td style="text-align:left;">

keaton kenya 4111 east 99th avenue tampa fl 33617|williams dianna 4111
east 99th avenue tampa fl 33617

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-028065

</td>

<td style="text-align:left;">

2020-05-04

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

waterview at rocky point|sweetwater cove property lp

</td>

<td style="text-align:left;">

mccarthy theodore mason 5435-d ginger cove dr. tampa fl 33634|young
kristen a. 5435-d ginger cove dr. tampa fl 33634

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction- possession only

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-028085

</td>

<td style="text-align:left;">

2020-05-04

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

southeast property acquisitions llc

</td>

<td style="text-align:left;">

collazos sergio 2328 w. lasalle street tampa fl 33607

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction- possession only

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-028096

</td>

<td style="text-align:left;">

2020-05-04

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

palladini edward

</td>

<td style="text-align:left;">

swain debbie 806 w park ave \#a tampa fl 33602

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-028102

</td>

<td style="text-align:left;">

2020-05-04

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

dou- gua managment llc

</td>

<td style="text-align:left;">

nget mariam 10323 boggy moss dr riverview fl 33578

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-028106

</td>

<td style="text-align:left;">

2020-05-04

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

la thao

</td>

<td style="text-align:left;">

polite katrina p 2909 east 97th ave tampa fl 33612

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-028107

</td>

<td style="text-align:left;">

2020-05-04

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

la thao|le nguyen

</td>

<td style="text-align:left;">

carrasquillo lorna 1715 e river cove st tampa fl 33604

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-028126

</td>

<td style="text-align:left;">

2020-05-04

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

bethlehem real estate partners

</td>

<td style="text-align:left;">

caldwell brian 2525 bethlehem road plant city fl 33565|terrell shawn
2525 n. bethlehem rd plant city fl 33565|powledge ashley 2525
n. bethlehem rd plant city fl 33565

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt unlawful detainer

</td>

<td style="text-align:left;">

2020-06-01

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-027983

</td>

<td style="text-align:left;">

2020-05-03

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

coas group inc

</td>

<td style="text-align:left;">

occupant 2 unknown 101 little pepper lane seffner fl 33584|occupant 1
unknown 101 little pepper lane seffner fl 33584|duran ruthann 101 little
pepper lane seffner fl 33584

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-027765

</td>

<td style="text-align:left;">

2020-05-01

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

heard tommy d sr

</td>

<td style="text-align:left;">

hernandez moises 14606 palomar court dover fl 33527

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-027766

</td>

<td style="text-align:left;">

2020-05-01

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

kenny julianne|georgia rose salon & spa llc

</td>

<td style="text-align:left;">

zackery kendrick 13130 elk mountain dr \#8 riverview fl 33579

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-027802

</td>

<td style="text-align:left;">

2020-05-01

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

jf & partner property investments llc

</td>

<td style="text-align:left;">

rayner tanesha 1606 east 31st avenue tampa fl 33610

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction- possession only

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-027803

</td>

<td style="text-align:left;">

2020-05-01

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

perkins david

</td>

<td style="text-align:left;">

dings bruce r 1615 hall rd \#9 plant city fl 33565

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-027821

</td>

<td style="text-align:left;">

2020-05-01

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

le nguyen|la thao

</td>

<td style="text-align:left;">

liviu hornea 7511 lakeshore dr. tampa fl 33604

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-027822

</td>

<td style="text-align:left;">

2020-05-01

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

via media communication inc|bravo home management inc

</td>

<td style="text-align:left;">

lewis juanita 2005 goldendale court brandon fl 33511|lewis joseph 2005
goldendale court brandon fl 33511

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction- possession only

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-027831

</td>

<td style="text-align:left;">

2020-05-01

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

heritage cove apartments|heritage cove mmg llc|tzadik management

</td>

<td style="text-align:left;">

mayhue charvonia 7402 heritage hills dr apt 7304-d temple terrace fl
33637

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction- possession only

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-027841

</td>

<td style="text-align:left;">

2020-05-01

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

heritage cove apartments|heritage cove mmg llc|tzadik management obo
heritage cove mmg llc

</td>

<td style="text-align:left;">

neal lori 7402 heritage hills dr apt 9104-b temple terrace fl 33637

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction- possession only

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-027862

</td>

<td style="text-align:left;">

2020-05-01

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

river view apartments|river view apartments llc

</td>

<td style="text-align:left;">

eniola tony 5607 del prado dr. apt. \#101 tampa fl 33617|mabe amberlyn
r. 5607 del prado dr. apt.\#101 tampa fl 33617

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction- possession only

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-027904

</td>

<td style="text-align:left;">

2020-05-01

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

odom donald|scott teresa

</td>

<td style="text-align:left;">

odom calvin w. 3843 link rd lithia fl 33547

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt unlawful detainer

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-027908

</td>

<td style="text-align:left;">

2020-05-01

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

cintron daniel

</td>

<td style="text-align:left;">

fonseca rafael 1812 e 143rd ave apt 2 tampa fl 33613|rios cindy 1812 e
143rd ave apt 2 tampa fl 33613|miller patsy 1812 e 143rd ave apt 2 tampa
fl 33613

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

2020-06-08

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-027920

</td>

<td style="text-align:left;">

2020-05-01

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

quinn matthew j.

</td>

<td style="text-align:left;">

quinn thomas james 820 terra vista st brandon fl 33511

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt unlawful detainer

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-027924

</td>

<td style="text-align:left;">

2020-05-01

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

garcia oscar

</td>

<td style="text-align:left;">

unknown claudia 3915 del valle ave tampa fl 33614|guerra leon osmany
3915 del valle ave tampa fl 33614

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-037025

</td>

<td style="text-align:left;">

2020-06-23

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

batista osmany barea 8408 willow forest ct tampa fl 33634

</td>

<td style="text-align:left;">

martinez cedeno yolanda zulema 8408 willow forest ct tampa fl
33634|fleitas gutierrez dunya 8408 willow forest ct tampa fl 33634

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-037138

</td>

<td style="text-align:left;">

2020-06-23

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

family real estate sycs inc 5413 us hwy 92 w plant city fl 33566|c/o
pedro alfaro 5413 us hwy 92 w plant city fl 33566|c/o greg preseau 5413
us hwy 92 west plant city fl 33567

</td>

<td style="text-align:left;">

harris keith 1109 tanner road \#7 plant city fl 33566

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-037162

</td>

<td style="text-align:left;">

2020-06-23

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

barger adam 10652 broadland pass thonotosassa fl 33592|barger leah l
10652 broadland pass thonotosassa fl 33592

</td>

<td style="text-align:left;">

newell candace 2002 fruitridge st brandon fl 33510|rhodes lee 2002
fruitridge st brandon fl 33510

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-037188

</td>

<td style="text-align:left;">

2020-06-23

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

palladini edward 2414 riverside dr tampa fl 33602

</td>

<td style="text-align:left;">

gonzales irene 2200 north glenwood ave tampa fl 33602

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-037189

</td>

<td style="text-align:left;">

2020-06-23

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

brewer vonda f 105 inwood cir brandon fl 33510

</td>

<td style="text-align:left;">

brewer brent 105 inwood cir brandon fl 33510

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt unlawful detainer

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-037195

</td>

<td style="text-align:left;">

2020-06-23

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

delta housing 4x llc 5401 w. kennedy blvd. ste. 1030 tampa fl 33609

</td>

<td style="text-align:left;">

watlon angie 10024 rosemary leaf lane riverview fl 33578

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction- possession only

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-037196

</td>

<td style="text-align:left;">

2020-06-23

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

gamma real estate investment llc 5401 w. kennedy blvd. ste. 1030 tampa
fl 33609

</td>

<td style="text-align:left;">

bonneval matthew 7804 bristol park drive apollo beach fl 33572

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction- possession only

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-037198

</td>

<td style="text-align:left;">

2020-06-23

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

albury michael 9521 sunstone blvd thonotosassa fl 33592

</td>

<td style="text-align:left;">

philyor yolanda 4038-a cortez dr tampa fl 33614

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction- possession only

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-037218

</td>

<td style="text-align:left;">

2020-06-23

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

nguyen sang po box 280357 tampa fl 33682|nguyen anh po box 280357 tampa
fl 33682

</td>

<td style="text-align:left;">

poole nikki 1700 e idell st apt a tampa fl 33604

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-037269

</td>

<td style="text-align:left;">

2020-06-23

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

gool maria juditha 1814 n. 15th street second floor tampa fl 33605

</td>

<td style="text-align:left;">

fields mark 18009 lanai drive tampa fl 33647

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt unlawful detainer

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-036826

</td>

<td style="text-align:left;">

2020-06-22

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

al-fa cabinets inc 4803 north grady avenue tampa fl 33614

</td>

<td style="text-align:left;">

elotmani noureddine 13208 sunkiss loop windemere fl 34786|network
mobility solutions llc 13208 sunkiss loop windermere fl 34786

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $15.000.01-$30000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-036828

</td>

<td style="text-align:left;">

2020-06-22

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

wallis charles 3101 bloomingdale ave lot 7 valrico fl 33596

</td>

<td style="text-align:left;">

bagshaw autumn 3101 bloomingdale avenue lot 6 valrico fl 33596

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-036875

</td>

<td style="text-align:left;">

2020-06-22

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

saavedra elizabeth p.o. box 9233 tampa fl 33674

</td>

<td style="text-align:left;">

tenants unknown 6521 riverview drive lot \#7 riverview fl 33578|ellerbee
samantha lynn 6521 riverview drive lot \#7 riverview fl 33578

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-036890

</td>

<td style="text-align:left;">

2020-06-22

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

blanco herrera luis roberto 8209 natchez st tampa fl 33637

</td>

<td style="text-align:left;">

philon james lavon 4814s 86th st tampa fl 33619|philon aileen adelaida
4814 s 86th st tampa fl 33619

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-036898

</td>

<td style="text-align:left;">

2020-06-22

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

jackson richard r 1704 w watrous ave tampa fl 33606

</td>

<td style="text-align:left;">

tenants unknown bi 5018 n hale ave tampa fl 33614|gale william b b1 5018
n hale ave tampa fl 33614

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-036901

</td>

<td style="text-align:left;">

2020-06-22

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

tzadik acquisitions llc|tzadik management 12406 n 15th street tampa fl
33612|tzm bella mar apartments

</td>

<td style="text-align:left;">

hudley brittany 1307 e 127th ave apt h tampa fl 33612

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction- possession only

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-036902

</td>

<td style="text-align:left;">

2020-06-22

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

a investment properties of tampa inc c/o anthony lefler ra 1514 1/2 e
8th ave tampa fl 33605

</td>

<td style="text-align:left;">

gatcon lucia 2306 w st louis st tampa fl 33607

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-036921

</td>

<td style="text-align:left;">

2020-06-22

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

newport properties inc 3310 w. cypress st suite 206 tampa fl 33607|bravo
home management inc 3310 w. cypress st suite 206 tampa fl 33607

</td>

<td style="text-align:left;">

unknown occupants 1214 grassy meadows brandon fl 33511|hutcherson tyron
1214 grassy meadows brandon fl 33511|worthen cameron 1214 grassy meadows
place brandon fl 33511

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction- possession only

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-036946

</td>

<td style="text-align:left;">

2020-06-22

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

tampa professiona; center 4023 n armenia ave \#100 tampa fl 33607

</td>

<td style="text-align:left;">

vargas raphael 4023 n armenia ave \#300 tampa fl 33607

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-036980

</td>

<td style="text-align:left;">

2020-06-22

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

gollakner gerald 8815 shenandoah run wesley chapel fl 33544

</td>

<td style="text-align:left;">

knight anitra 4628 courtland st tampa fl 33610

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-036996

</td>

<td style="text-align:left;">

2020-06-22

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

lanz manuel 5108 n habana ave suite 4 tampa fl 33614

</td>

<td style="text-align:left;">

durant james 2321 n 52nd street apt b tampa fl 33619

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-036751

</td>

<td style="text-align:left;">

2020-06-20

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

curtis-sundome llc po box 25531 tampa fl 33622|the 2003 llc po box 25531
tampa fl 33622|pk properties a florida general partnership po box 25531
tampa fl 33622

</td>

<td style="text-align:left;">

einstein and noah corp 555 zang street suite 300 lakewood co 80228

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $15.000.01-$30000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-036557

</td>

<td style="text-align:left;">

2020-06-19

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

taylor sarah 2375 canopy creel way \#403 land o lakes fl 34639

</td>

<td style="text-align:left;">

franklin latrice marie 8417 laurelon pl tampa fl 33637

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-036558

</td>

<td style="text-align:left;">

2020-06-19

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

wallis charles 3101 bloomingdale ave lot 7 valrico fl 33596

</td>

<td style="text-align:left;">

gonzalez maria 8504 richmond st lot 10 gibsonton fl 33596

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-036559

</td>

<td style="text-align:left;">

2020-06-19

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

mendoza marjorie massiel 120 shore pkwy tampa fl 33615

</td>

<td style="text-align:left;">

marrero joshua 120 shore pkwy tampa fl 33615

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-036560

</td>

<td style="text-align:left;">

2020-06-19

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

the reserve at brandon 1918 plantation key circle brandon fl
33511|sienna park holdings llc 1918 plantation key circle brandon fl
33511

</td>

<td style="text-align:left;">

rostron audrey 305 providence road \#301 brandon fl 33511|mulvaney glenn
305 providence road \#301 brandon fl 33511

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction- possession only

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-036617

</td>

<td style="text-align:left;">

2020-06-19

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

marjo family inc 5820 luzon pl orlando fl 32839

</td>

<td style="text-align:left;">

stone george 4204 n manhattan ave tampa fl 33614

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction- possession only

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-036618

</td>

<td style="text-align:left;">

2020-06-19

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

tampa commercial properties llc 100 wallace avenue suite 100 sarasota fl
34237

</td>

<td style="text-align:left;">

unknown subtenant \#1 6832 e broadway avenue tampa fl 33619|bradley
anthony eugene 1311 holmes avenue tampa fl 33605

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-036622

</td>

<td style="text-align:left;">

2020-06-19

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

the park on waters 307 s. fielding ave tampa fl 33606-4121|jax park llc
307 s. fielding ave tampa fl 33606-4121

</td>

<td style="text-align:left;">

cadogan mary 8510 n. armenia ave. apt. \#1902 tampa fl 33604

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction- possession only

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-036624

</td>

<td style="text-align:left;">

2020-06-19

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

edenfield dianne c/o thompson commercial law group 615 w. de leon street
tampa fl 33606

</td>

<td style="text-align:left;">

hall gaylien a jr 13952 fletcher’s mill drive tampa fl 33613

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt unlawful detainer

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-036625

</td>

<td style="text-align:left;">

2020-06-19

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

torgersrud lynda c/o hosanna real estate services inc p.o. box 2487
eaton park fl 33840|novack thomas c/o hosanna real estate servicesinc.
po box 2487 eaton park fl 33840|hannaford denise c/o hosanna real estate
services inc p. o. box 2487 eaton park fl 33840

</td>

<td style="text-align:left;">

unknown tenant 8923 n 40th street unit \#6 tampa fl 33604|wilson
brittany 8923 n 40th street unit\#6 tampa fl 33604

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-036642

</td>

<td style="text-align:left;">

2020-06-19

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

torgersrud lynda c/o hosanna real estate services inc p.o. box 2487
eaton park fl 33840|novack thomas c/o hosanna real estate servicesinc.
po box 2487 eaton park fl 33840|hannaford denise c/o hosanna real estate
services inc p. o. box 2487 eaton park fl 33840

</td>

<td style="text-align:left;">

unknown tenants 8923 n. 40th st unit \#9 tampa fl 33604|anderson jarvis
wesley 8923 n 40th unit \# 9 tampa fl 33604

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-036663

</td>

<td style="text-align:left;">

2020-06-19

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

trans am sfe ii llc 4870 n. hiatus rd sunrise fl 33351

</td>

<td style="text-align:left;">

doe jane 4705 ranchway ct tampa fl 33624|doe john 4705 ranchway ct tampa
fl 33624

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt unlawful detainer

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-036668

</td>

<td style="text-align:left;">

2020-06-19

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

otalvaro diana 3409 stanley rd plant city fl 33565|otalvaro mario 3409
stanley rd plant city fl 33565

</td>

<td style="text-align:left;">

reyes omar 7609 woodbridge blvd tampa fl 33615

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-036671

</td>

<td style="text-align:left;">

2020-06-19

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

impact marketing group international inc p.o. box 262015 tampa fl 33685

</td>

<td style="text-align:left;">

horn dorie 7816 robert e lee rd tampa fl 33637|cothron georgianna leigh
7816 robert e lee rd tampa fl 33637

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt unlawful detainer

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-036701

</td>

<td style="text-align:left;">

2020-06-19

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

3805 s westshore llc 3203 w. cypress st. tampa fl 33607

</td>

<td style="text-align:left;">

baugh michael 3805 s westshore blvd units b and c tampa fl 33611

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-036704

</td>

<td style="text-align:left;">

2020-06-19

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

jeff 1 llc 4870 n. hiatus road sunrise fl 33351

</td>

<td style="text-align:left;">

doe jane 4223 w grace st. tampa fl 33607|doe john 4223 w grace st. tampa
fl 33607

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt unlawful detainer

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-036717

</td>

<td style="text-align:left;">

2020-06-19

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

simon kimberly 123 shaddock dr auburndale fl 33823

</td>

<td style="text-align:left;">

powell lincoln 4107 n 30th st tampa fl 33610

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-036732

</td>

<td style="text-align:left;">

2020-06-19

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

guyster emilia po box 455 elfers fl 34680

</td>

<td style="text-align:left;">

hobdy brenda 8702 mallard reserve dr \#105 tampa fl 33614

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-036609

</td>

<td style="text-align:left;">

2020-06-18

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

trans am sfe ii llc 4870 n. hiatus road sunrise fl 33351

</td>

<td style="text-align:left;">

doe jane 3501 king richard ct. seffner fl 33584|doe john 3501 king
richard ct. seffner fl 33584

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt unlawful detainer

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-036313

</td>

<td style="text-align:left;">

2020-06-18

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

its brandon lp 101 e. kennedy blvd. tampa fl 33602

</td>

<td style="text-align:left;">

livingston annie 9321 everhart road room 219 riverview fl 33578

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $15.000.01-$30000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-036330

</td>

<td style="text-align:left;">

2020-06-18

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

the park at lake como 307 s. fielding ave tampa fl 33606-4121|town &
country property holdings llc 307 s. fielding ave tampa fl 33606-4121

</td>

<td style="text-align:left;">

cuesta jessica 8378 crystal harbour dr. apt. 201 tampa fl 33615

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction- possession only

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-036343

</td>

<td style="text-align:left;">

2020-06-18

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

surujbali desmond 912 shoal’s landing dr. brandon fl 33511

</td>

<td style="text-align:left;">

gonzalez martina 2 walnut loop lot\#2 plant city fl 33565

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction- possession only

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-036355

</td>

<td style="text-align:left;">

2020-06-18

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

cremeans robert po box 2205 riverview fl 33568

</td>

<td style="text-align:left;">

tenant unknown 6210b michigan ave gibsonton fl 33534|ward anthony 6210b
michigan ave gibsonton fl 33534

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-036359

</td>

<td style="text-align:left;">

2020-06-18

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

cremeans robert po box 2205 riverview fl 33568

</td>

<td style="text-align:left;">

tenant unknown 10013 massachusetts st gibsonton fl 33534|kouts william
10013 massachusetts st gibsonton fl 33534

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-036360

</td>

<td style="text-align:left;">

2020-06-18

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

capron debra b 5312 marys miracle lane tampa fl 33610

</td>

<td style="text-align:left;">

gay daniel k 5312 marys miracle lane tampa fl 33610|mccullum jessica p
5312 marys miracle lane tampa fl 33610

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt unlawful detainer

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-036362

</td>

<td style="text-align:left;">

2020-06-18

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

young crystal 8145 n nebraska ave tampa fl 33604

</td>

<td style="text-align:left;">

jones paris 2804 n tampa st unit b tampa fl 33602

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-036363

</td>

<td style="text-align:left;">

2020-06-18

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

jones gerard 8425 del rey ct \#3 tampa fl 33617

</td>

<td style="text-align:left;">

jones brittany 8425 del rey ct \#3 tampa fl 33617

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt unlawful detainer

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-036367

</td>

<td style="text-align:left;">

2020-06-18

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

brainard realty 205 w mlk blvd ste 202 tampa fl 33603

</td>

<td style="text-align:left;">

sheppeard horace 910 alicia ave unit 2d tampa fl 33604

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-036377

</td>

<td style="text-align:left;">

2020-06-18

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

roberts chester 2402 n ridgewood ave tampa fl 33602|roberts olga 2402
ridgewood ave tampa fl 33602

</td>

<td style="text-align:left;">

occupants all other 1410 w rambla st tampa fl 33612|lewis eric 1410 w
rambla st tampa fl 33612

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-036378

</td>

<td style="text-align:left;">

2020-06-18

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

riverfront apartments 5305 n boulevard tampa fl 33603

</td>

<td style="text-align:left;">

devine leangel deneisha 5305 n blvd apt 212 tampa fl 33603|neal sedaria
veuncha 5305 n blvd apt 212 tampa fl 33603|dukes tazmin torien 5305 n
blvd apt 212 tampa fl 33603

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-036379

</td>

<td style="text-align:left;">

2020-06-18

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

long lyndi 2324 willage green blvd plant city fl 33566

</td>

<td style="text-align:left;">

sherman kimberly 1703 s golfview drive plant city fl 33566

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction- possession only

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-036386

</td>

<td style="text-align:left;">

2020-06-18

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

pineda margarita y 4033 forecast drive brandon fl 33511

</td>

<td style="text-align:left;">

maricharl jose 4033 forecast drive brandon fl 33511|mejia miya 4033
forecast drive brandon fl 33511

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction- possession only

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-036404

</td>

<td style="text-align:left;">

2020-06-18

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

mehta ramesh 9443 leatherwood ave tampa fl 33647

</td>

<td style="text-align:left;">

lee sandra 3302 e gennesee st tampa fl 33610|lee angela 3302e genesee st
tampa fl 33610

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-036408

</td>

<td style="text-align:left;">

2020-06-18

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

elly nesis company inc 3959 van dyke road suite 393 lutz fl 33558

</td>

<td style="text-align:left;">

rivera milagro c 4122 mctavish place tampa fl 33624

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-036426

</td>

<td style="text-align:left;">

2020-06-18

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

elly nesis company inc 3959 van dyke road suite 393 lutz fl 33558

</td>

<td style="text-align:left;">

mayol leslie 6001 south dale mabry highway unit \#12 tampa fl 33611

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-ca-005080

</td>

<td style="text-align:left;">

2020-06-18

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

terre investments llc c/o john n. muratides esq. p.o. box 3299 tampa fl
33601

</td>

<td style="text-align:left;">

coast dental services llc c/o adam diasti dds registered agent 5706
benjamin center dr. suite 103 tampa fl 33634

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

delinquent tenant

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-036091

</td>

<td style="text-align:left;">

2020-06-17

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

charneco caban prudencio 8622 n 39th st tampa fl 33604

</td>

<td style="text-align:left;">

olmeda franky 8622 n 39th st tampa fl 33604

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-036095

</td>

<td style="text-align:left;">

2020-06-17

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

charneco caban prudencio 8622 n 39th st tampa fl 33604

</td>

<td style="text-align:left;">

davis james l jr 8622 n 39th st tampa fl 33604

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-036115

</td>

<td style="text-align:left;">

2020-06-17

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

tampa real estate holdings llc 1925 e 6th ave tampa fl 33605

</td>

<td style="text-align:left;">

reese craig 3520 sarh st tampa fl 33605

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-036118

</td>

<td style="text-align:left;">

2020-06-17

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

sodre raul 1108 kingfish pl apollo beach fl 33572

</td>

<td style="text-align:left;">

moore gloria 5012-b east 97th ave. tampa fl 33617

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-036119

</td>

<td style="text-align:left;">

2020-06-17

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

sodre raul 1108 kingfish pl apollo beach fl 33572

</td>

<td style="text-align:left;">

ramos edward 5116 east 97th ave. apt. b tampa fl 33617

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $15.000.01-$30000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-036120

</td>

<td style="text-align:left;">

2020-06-17

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

2715 west sligh llc 5401 w. kennedy blvd. ste. 1030 tampa fl 33609

</td>

<td style="text-align:left;">

lantigua bismeiry 8519 jr manor drive tampa fl 33634

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction- possession only

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-036121

</td>

<td style="text-align:left;">

2020-06-17

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

surujbali desmond 912 shoal’s landing dr. brandon fl 33511

</td>

<td style="text-align:left;">

perales elsa 1809 candlelight lane lot\#103 plant city fl 33565

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction- possession only

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-036123

</td>

<td style="text-align:left;">

2020-06-17

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

cherub group llc c/o 2380 drew st ste 2 clearwater fl 33765

</td>

<td style="text-align:left;">

nina studio & spa corp 3612 s dale mabry highway unit a tampa fl 33629

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction- possession only

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-036126

</td>

<td style="text-align:left;">

2020-06-17

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

raffety robert r 2742 durant trails blvd dover fl 33527

</td>

<td style="text-align:left;">

tenants unknown 716 oakgrove dr unit 236 brandon fl 33510|craig aubrie
716 oak grove dr unit 236 brandon fl 33510

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction- possession only

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-036129

</td>

<td style="text-align:left;">

2020-06-17

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

mcn trailer park 3125 w hillsborough ave tampa fl 33614|langee chris
3125 w hillsborough ave tampa fl 33614

</td>

<td style="text-align:left;">

hamblin joshua 113 agnes st tampa fl 33614

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-036130

</td>

<td style="text-align:left;">

2020-06-17

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

mcn trailer park 3125 w hillsborough ave tampa fl 33614|langee chris
3125 w hillsborough ave tampa fl 33614

</td>

<td style="text-align:left;">

robinson cameron 126 brian st tampa fl 33614|perez ronnie 126 brian st
tampa fl 33614

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-036134

</td>

<td style="text-align:left;">

2020-06-17

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

martin michael 131 w. davis blvd. tampa fl 33606

</td>

<td style="text-align:left;">

crippen christopher 131 w. davis blvd. tampa fl 33606

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt unlawful detainer

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-036136

</td>

<td style="text-align:left;">

2020-06-17

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

advanta llc fbo michael elberg p.o. box 268063 weston fl 33326

</td>

<td style="text-align:left;">

tenant 1 unknown 8435 gardner road unit 6 tampa fl 33625|rodriguez ana
8435 gardner road unit \#6 tampa fl 33625

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-036139

</td>

<td style="text-align:left;">

2020-06-17

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

hernandez dorothy 8416 n 39th st tampa fl 33604

</td>

<td style="text-align:left;">

hernandez brandi 8418 n 39th st tampa fl 33604

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-036141

</td>

<td style="text-align:left;">

2020-06-17

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

0006 llc 13720 old st. augustine rd ste 8-298 jacksonville fl 32258

</td>

<td style="text-align:left;">

zampitella caitlyn 301 e. janette unit b tampa fl 33603

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction- possession only

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-035827

</td>

<td style="text-align:left;">

2020-06-16

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

nikitina anna 10210 east sligh ave tampa fl 33610

</td>

<td style="text-align:left;">

masgau mia m 1107 us hwy 92 lot 5 seffner fl 33584|smith thomas 1107 us
hwy 92 lot 5 seffner fl 33584

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-035844

</td>

<td style="text-align:left;">

2020-06-16

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

tinamat theera 4701 w iowa ave tampa fl 33616

</td>

<td style="text-align:left;">

singleton keith e 4701 w iowa ave tampa fl 33616

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt unlawful detainer

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-035847

</td>

<td style="text-align:left;">

2020-06-16

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

jefferson robert 10219 carriage glen court tampa fl 33615

</td>

<td style="text-align:left;">

tenants unknown 1903 east ellicott street tampa fl 33610|buchanan mary
kay 1903 east ellicott street tampa fl 33610

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-035862

</td>

<td style="text-align:left;">

2020-06-16

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

nguyen anh po box 280357 tampa fl 33682|nguyen sang po box 280357 tampa
fl 33682

</td>

<td style="text-align:left;">

ammons mikeondra 1401 college park ct apt \#a tampa fl 33612

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-035865

</td>

<td style="text-align:left;">

2020-06-16

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

nguyen sang po box 280357 tampa fl 33682|nguyen anh po box 280357 tampa
fl 33682

</td>

<td style="text-align:left;">

fields quanshae 1510 e 140th ave apt \#a tampa fl 33613

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-035866

</td>

<td style="text-align:left;">

2020-06-16

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

nguyen sang po box 280357 tampa fl 33682|nguyen anh po box 280357 tampa
fl 33682

</td>

<td style="text-align:left;">

bryant monica anita 2004 e 140th ave apt \#10 tampa fl 33613

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-035867

</td>

<td style="text-align:left;">

2020-06-16

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

nguyen sang po box 280357 tampa fl 33682|nguyen anh po box 280357 tampa
fl 33682

</td>

<td style="text-align:left;">

hernandez norma e 1403 college park ct apt \#a tampa fl 33612

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-035868

</td>

<td style="text-align:left;">

2020-06-16

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

nguyen sang po box 280357 tampa fl 33682|nguyen anh po box 280357 tampa
fl 33682

</td>

<td style="text-align:left;">

peterson vaneisha 1507 e 142nd ave apt \#d tampa fl 33613

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-035869

</td>

<td style="text-align:left;">

2020-06-16

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

drc holdings co. llc c/o john e. mcmillan 5309 e. busch blvd. temple
terrace fl 33617|land trust 1051 c/o john e. mcmillan 5309 e. busch
blvd. temple terrace fl 33617

</td>

<td style="text-align:left;">

atkinson jeffrey charles 3010 w. binnicker ave. apt. \#10 tampa fl 33611

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction- possession only

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-035870

</td>

<td style="text-align:left;">

2020-06-16

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

mohamed ken 13932 mlk blvd dover fl 33527

</td>

<td style="text-align:left;">

rodriguz samantha 2214 donegal court valrico fl 33594

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-035871

</td>

<td style="text-align:left;">

2020-06-16

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

trivedi mayur 10007 princess palm ave tampa fl 33619

</td>

<td style="text-align:left;">

tenant unknown 10007 princess palm ave \#221 tampa fl 33619|steeele
jason anthoney 10007 princess palm ave \#221 tampa fl 33619|sweeney
michelle 1007 princess palm ave \#201 tampa fl 33619

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction- possession only

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-035874

</td>

<td style="text-align:left;">

2020-06-16

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

dushant amin 240 nw 76th drive suite d gainesville fl 32607

</td>

<td style="text-align:left;">

patel kamini 9107 tillinghast dr. tampa fl 33636|patel veena 9107
tillinghast dr. tampa fl 33636|patel ann pinal 9107 tillinghast dr.
tampa fl 33636|patel ashokbai 9107 tillinghast dr. tampa fl 33636

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction- possession only

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-035877

</td>

<td style="text-align:left;">

2020-06-16

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

milan dennys david 1014 westside dr tampa fl 33619

</td>

<td style="text-align:left;">

francia diana 1506 e genesee st tampa fl 33610

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-035878

</td>

<td style="text-align:left;">

2020-06-16

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

li zheqing po box 18731 tampa fl 33679

</td>

<td style="text-align:left;">

ferraro christopher joseph 9310 leatherwood ave tampa fl 33647

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-035881

</td>

<td style="text-align:left;">

2020-06-16

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

jackson dennis 1610 2nd st se ruskin fl 33570

</td>

<td style="text-align:left;">

taormina john 1610 2nd st se ruskin fl 33570|matonti kelly 1610 2nd st
se ruskin fl 33570

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-035884

</td>

<td style="text-align:left;">

2020-06-16

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

sanchez cecilia 9221 tudor drive a203 tampa fl 33615

</td>

<td style="text-align:left;">

ortega nicolas 8415 deer chase drive riverview fl 33578

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt unlawful detainer

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-035886

</td>

<td style="text-align:left;">

2020-06-16

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

surujbali desmond 912 shoal’s landing dr. brandon fl 33511

</td>

<td style="text-align:left;">

cortez jesus dolores 113 pearl st. apt. 1c plant city fl 33563

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt distress for rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-ca-004956

</td>

<td style="text-align:left;">

2020-06-15

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

francise & francise inc. 3203 w. cypress st. tampa fl 33607

</td>

<td style="text-align:left;">

basil justin 2419 w kenned blvd suite 100 tampa fl 33609|mosh posh llc
2419 w kennedy blvd suite 100 tampa fl 33609

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

delinquent tenant

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-035416

</td>

<td style="text-align:left;">

2020-06-15

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

vinh investment llc 3920 78th ave north lot 32c pinellas park fl 33781

</td>

<td style="text-align:left;">

dunmyer danielle 425 se 18th st lot h ruskin fl 33570

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction- possession only

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-035515

</td>

<td style="text-align:left;">

2020-06-15

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

barsa cindy 10853 boyette road riverview fl 33569

</td>

<td style="text-align:left;">

ratphimpha lynn 204 oakfield drive brandon fl 33511|nguyen michael 204
oakfield dive brandon fl 33511

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction- possession only

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-035518

</td>

<td style="text-align:left;">

2020-06-15

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

craig teresa 5512 turkey creek rd plant city fl 33567|yates shirley 5512
turkey creek rd plant city fl 33567

</td>

<td style="text-align:left;">

genry tiffany 5512 turkey creek rd plant city fl 33567|gentry james 5512
turkey creek rd plant city fl 33567

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt unlawful detainer

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-035565

</td>

<td style="text-align:left;">

2020-06-15

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

altis promenade llc 18065 promenade park lane lutz fl 33548

</td>

<td style="text-align:left;">

linder heather 3710 arcade trail apt 208 lutz fl 33548

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction- possession only

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-035568

</td>

<td style="text-align:left;">

2020-06-15

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

rodriguez edinson 11313 misty isle ln riverview fl 33579|sanchez johanny
11313 misty isle ln riverview fl 33579|rodriguez edinson 11313 misty
isle ln riverview fl 33579

</td>

<td style="text-align:left;">

vazquez ahsaki s. 2429 roanoke springs drive ruskin fl 33570

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-035598

</td>

<td style="text-align:left;">

2020-06-15

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

linares rosmery 7707 hinsdale drive tampa fl 33615

</td>

<td style="text-align:left;">

fernandez aquiles 9815 oaks street tampa fl 33635|maulin palacios
lilliam maria 9815 oaks street tampa fl 33635

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-035611

</td>

<td style="text-align:left;">

2020-06-15

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

sanders starr a 8206 franklin rd plant city fl 33565|sanders jeffrey
8206 franklin rd plant city fl 33565

</td>

<td style="text-align:left;">

lucas jeremy 5310 ike smith road plant city fl 33565|lucas kelli lynn
5310 ike smith rd plant city fl 33565

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-035613

</td>

<td style="text-align:left;">

2020-06-15

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

oaks at university i llc po box 62884 ft. myers fl 33906

</td>

<td style="text-align:left;">

fortier bethann 1508 e. 138th ave. apt. d tampa fl 33613

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction- possession only

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-035712

</td>

<td style="text-align:left;">

2020-06-15

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

vista gardens apartments llc 1701 east atlantic boulevard suite 4
pompano beach fl 33060

</td>

<td style="text-align:left;">

cavatta beverly a 3809 west iowa avenue unit 1 tampa fl 33616

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction- possession only

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-035297

</td>

<td style="text-align:left;">

2020-06-12

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

davison frederick 11314 n 52nd st \#9 tampa fl 33617

</td>

<td style="text-align:left;">

snow yoshicka 11312 n 52nd st \# 8 tampa fl 33617

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-035321

</td>

<td style="text-align:left;">

2020-06-12

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

davison frederick 11314 n 52nd st \#9 tampa fl 33617

</td>

<td style="text-align:left;">

johnson brent 11316 52nd st \#2 tampa fl 33617

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-035337

</td>

<td style="text-align:left;">

2020-06-12

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

davison frederick 11314 n 52nd st \#9 tampa fl 33617

</td>

<td style="text-align:left;">

joseph manuiel 11312 n 52 st \# 12 tampa fl 33617

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-035366

</td>

<td style="text-align:left;">

2020-06-12

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

university collection- fca llc 101 e kennedy blvd. suite 1500 tampa fl
33602

</td>

<td style="text-align:left;">

leake foods inc 2736 e fowler ave tampa fl 33612

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction- possession only

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-035383

</td>

<td style="text-align:left;">

2020-06-12

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

frontier travel park 13212 n nebraska ave tampa fl 33612

</td>

<td style="text-align:left;">

williams jasmine 112 michigan ave tampa fl 33612

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-035384

</td>

<td style="text-align:left;">

2020-06-12

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

santiago victor 3004 barret ave plant city fl 33566|afridi salim 3004
barret ave plant city fl 33566

</td>

<td style="text-align:left;">

jones kanetra shaneye 11218 e sligh ave seffner fl 33584

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-035406

</td>

<td style="text-align:left;">

2020-06-12

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

g & h tampa development llc 5912 n nebraska ave \#17 tampa fl 33604

</td>

<td style="text-align:left;">

white matt 5912 n nebraska ave \#1 tampa fl 33604

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-035409

</td>

<td style="text-align:left;">

2020-06-12

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

business parkway properties llc 6987 e. fowler ave. tampa fl 33617

</td>

<td style="text-align:left;">

arc winghouse llc 1409 kingsley ave. unit 2 orange park fl 32073

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-035410

</td>

<td style="text-align:left;">

2020-06-12

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

grewal christopher s c/o lieser skaff alexander 403 n. howard ave. tampa
fl 33606

</td>

<td style="text-align:left;">

yaufman james r ii 10817 magnolia street lower floor riverview fl 33569

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction- possession only

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-037186

</td>

<td style="text-align:left;">

2020-06-23

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

palladini edward 2414 north riverside dr tampa fl 33602

</td>

<td style="text-align:left;">

johnson alvin 2901 north albany ave apt 3 tampa fl 33602

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-038566

</td>

<td style="text-align:left;">

2020-06-30

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

ribot cesar l 4106 amber ridge ln valrico fl 33594|

</td>

<td style="text-align:left;">

ortiz felix 1602 n taylor road brandon fl 33510

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-038571

</td>

<td style="text-align:left;">

2020-06-30

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

geisler john w 1007 wildwood lane valrico fl 33594|

</td>

<td style="text-align:left;">

ortega jose alberto 1305 e dr m.l.king blvd plant city fl 33563

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-038572

</td>

<td style="text-align:left;">

2020-06-30

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

ribot cesar l 4106 amber ridge ln valrico fl 33594|

</td>

<td style="text-align:left;">

fry joseph 604 avocado dr seffner fl 33584

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-038582

</td>

<td style="text-align:left;">

2020-06-30

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

runyun catherine nicole 1211 n westshore blvd ste 102 tampa fl 33604|

</td>

<td style="text-align:left;">

gonzales kip 8705 n 13th street unit b tampa fl 33604

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction- possession only

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-038604

</td>

<td style="text-align:left;">

2020-06-30

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

negron danny 1028 sunshine drive e lakeland fl 33801|

</td>

<td style="text-align:left;">

wood seth 908 n palm drive plant city fl 33563|browning danielle elaine
908 n palm drive plant city fl 33563

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-038634

</td>

<td style="text-align:left;">

2020-06-30

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

maldonado joaquin po box 23471 tampa fl 33623|

</td>

<td style="text-align:left;">

hopf kyle 10715 dowry ave tampa fl 33615

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt unlawful detainer

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-038653

</td>

<td style="text-align:left;">

2020-06-30

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

hemby thomas r 6914 w. clifton st. tampa fl 33634|

</td>

<td style="text-align:left;">

hart tawfik d. 8322 jackson springs rd. tampa fl 33615

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt unlawful detainer

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-038211

</td>

<td style="text-align:left;">

2020-06-29

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

saunders larry renetta 5127 puritan cir tampa fl 33617|

</td>

<td style="text-align:left;">

williams richard e 5127 puritan cir tampa fl 33617

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt unlawful detainer

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-038261

</td>

<td style="text-align:left;">

2020-06-29

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

vann mary lee 3329 seminole trail wimauma fl 33594|bailey gina m 3329
seminole trail wimauma fl 33598|

</td>

<td style="text-align:left;">

bean jacob 3323 seminole trail wimauma fl 33598|morrell candice m 3323
seminole trail wimauma fl 33598

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-038269

</td>

<td style="text-align:left;">

2020-06-29

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

regency centers lp 2850 north andrews avenue ft. lauderdale fl 33311|

</td>

<td style="text-align:left;">

any unknown tenants|truly greek mediterranean|truly mediterranean grill
llc bloomingdale square unit 601 887 e. bloomingdale avenue brandon fl
33511

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction- possession only

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-038288

</td>

<td style="text-align:left;">

2020-06-29

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

hogland john 3006 cork rd plant city fl 33565|

</td>

<td style="text-align:left;">

hogland tarrah 3006 n. cork rd plant city fl 33565

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt unlawful detainer

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-038305

</td>

<td style="text-align:left;">

2020-06-29

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

j & j asset management c/o arjun joshi p.o. box 172396 tampa fl 33672|

</td>

<td style="text-align:left;">

tenant unknown 6311 hwy 674 wimauma fl 33598

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt unlawful detainer

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-038307

</td>

<td style="text-align:left;">

2020-06-29

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

boje sherrie r. c/o kristopher e. fernandez esquire 114 s. fremont
avenue tampa fl 33606|boje jeffrey w. c/o kristopher e. fernandez
esquire 114 s. fremont avenue tampa fl 33606|

</td>

<td style="text-align:left;">

rector megan 115 hickory creek drive rear barn brandon fl 33511

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt unlawful detainer

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-038068

</td>

<td style="text-align:left;">

2020-06-28

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

nguyen thi po box 260361 tampa fl 33685|c & n investment properties llc
po box 260361 tampa fl 33685|

</td>

<td style="text-align:left;">

dixon elizabeth 9404 eastfield rd. unit e thonotosassa fl 33592

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction- possession only

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-037941

</td>

<td style="text-align:left;">

2020-06-26

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

mcclendon eva mae 4801 highland av n tampa fl 33603|

</td>

<td style="text-align:left;">

mcclendon dionne 4801 highland ave tampa fl 33603

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-038030

</td>

<td style="text-align:left;">

2020-06-26

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

recchio anthony j 3730 w tyson ave \#b7 tampa fl 33611|fors karen e 3730
w tyson ave \#b7 tampa fl 33611|

</td>

<td style="text-align:left;">

barnett sean 3730 w tyson ave \#b7 tampa fl 33611

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt unlawful detainer

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-038042

</td>

<td style="text-align:left;">

2020-06-26

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

infante juan claudio 1211 n westshore blvd ste 102 tampa fl 33607|

</td>

<td style="text-align:left;">

alverez lester f hercules 8424 camden street unit c tampa fl
33614|warren jennifer r 8424 camden street unit c tampa fl 33614

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction- possession only

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-038045

</td>

<td style="text-align:left;">

2020-06-26

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

nguyen sang po box 280357 tampa fl 33682|nguyen anh po box 280357 tampa
fl 33682|

</td>

<td style="text-align:left;">

castro felix f 1515 e 140th ave apt \#f tampa fl 33613

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-038047

</td>

<td style="text-align:left;">

2020-06-26

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

mcbride llc 13364 canopy grove dr apt 102 tampa fl 33625|

</td>

<td style="text-align:left;">

cargele donna 8310 n 18th st apt a tampa fl 33604

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction- possession only

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-038049

</td>

<td style="text-align:left;">

2020-06-26

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

mcbride llc 13364 canopy grove dr apt 102 tampa fl 33625|

</td>

<td style="text-align:left;">

thomas malcolm 8310 n 18th st apt b tampa fl 33604

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction- possession only

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-038050

</td>

<td style="text-align:left;">

2020-06-26

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

nguyen sang po box 280357 tampa fl 33682|nguyen anh po box 280357 tampa
fl 33682|

</td>

<td style="text-align:left;">

gaynor miranda lee 1512 e 140th ave apt a tampa fl 33613

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-038052

</td>

<td style="text-align:left;">

2020-06-26

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

nguyen sang po box 280357 tampa fl 33682|nguyen anh po box 280357 tampa
fl 33682|

</td>

<td style="text-align:left;">

ugbomah barbara 12425 n 58th st apt a tampa fl 33617

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-038054

</td>

<td style="text-align:left;">

2020-06-26

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

williams tracy a 4718 west estrella st tampa fl 33629|

</td>

<td style="text-align:left;">

williams lisa giles 4718 west estrella st tampa fl 33629

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt unlawful detainer

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-038055

</td>

<td style="text-align:left;">

2020-06-26

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

the courtyards of south tampa apartments|japanese garden mobile estates
inc. 3902 n. marguerite street tampa fl 33603|

</td>

<td style="text-align:left;">

csc serviceworks inc. c/o ct corporation system registered agent 1200
south pine island road plantation fl 33324

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-038061

</td>

<td style="text-align:left;">

2020-06-26

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

maa management 13129 n 19th st tampa fl 33612|

</td>

<td style="text-align:left;">

broner jahnequa 13131 n 19th st \#206 tampa fl 33612

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction- possession only

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-038062

</td>

<td style="text-align:left;">

2020-06-26

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

tremblay sean 202 6th street nw ruskin fl 33570|

</td>

<td style="text-align:left;">

mobley kendrick 202 6th st nw ruskin fl 33570|williams fredrica rochelle
202 6th st nw ruskin fl 33570

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt unlawful detainer

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-038063

</td>

<td style="text-align:left;">

2020-06-26

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

belmont heights estates ii 307 s. fielding ave tampa fl
33606-4121|belmont heights associates phase ii ltd 307 s. fielding ave
tampa fl 33606-4121|

</td>

<td style="text-align:left;">

frazier keonna s. 3602 n. 22nd street apt. d tampa fl 33605

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction- possession only

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-037558

</td>

<td style="text-align:left;">

2020-06-25

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

jackson richard r 1704 w. watrous ave tampa fl 33606|

</td>

<td style="text-align:left;">

tenants unknown 919 helen st lutz fl 33548|mclaughlin william 9199 helen
st lutz fl 33548

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-037572

</td>

<td style="text-align:left;">

2020-06-25

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

jackson richard r 1704 w. watrous ave tampa fl 33606|

</td>

<td style="text-align:left;">

tenants unknown \#9 1510 e 148th ave lutz fl 33549|hobbin mark \#9 1510
e 148th ave lutz fl 33549

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-037693

</td>

<td style="text-align:left;">

2020-06-25

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

donat hagai 7747 115th st seminole fl 33772|

</td>

<td style="text-align:left;">

ramirez yoilan 5499 sawyer rd unit b tampa fl 33634

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-037781

</td>

<td style="text-align:left;">

2020-06-25

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

palladini edward 2414 riverside dr tampa fl 33602|

</td>

<td style="text-align:left;">

garcia jerryaxbelle 4607 north hubert ave apt 17 tampa fl 33614

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-037834

</td>

<td style="text-align:left;">

2020-06-25

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

trans am sfe ii llc 4870 n. hiatus road sunrise fl 33351|

</td>

<td style="text-align:left;">

doe jane 4010 w marietta st tampa fl 33616|doe john 4010 w marietta st
tampa fl 33616

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt unlawful detainer

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-037837

</td>

<td style="text-align:left;">

2020-06-25

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

trans am sfe ii llc 4870 n. hiatus road sunrise fl 33351|

</td>

<td style="text-align:left;">

doe jane 3910 dunaire dr. valrico fl 33596|doe john 3910 dunaire dr.
valrico fl 33596

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt unlawful detainer

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-037841

</td>

<td style="text-align:left;">

2020-06-25

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

nguyen thi po box 260361 tampa fl 33685|c & n investment properties llc
po box 260361 tampa fl 33685|

</td>

<td style="text-align:left;">

anderson octavia 9402 eastfield rd. unit e thonotosassa fl 33592

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-037851

</td>

<td style="text-align:left;">

2020-06-25

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

trans am sfe ii llc 4870 n. hiatus road sunrise fl 33351|

</td>

<td style="text-align:left;">

doe jane 11305 carrollwood estates dr tampa fl 33618|doe john 11305
carrollwood estates dr tampa fl 33618

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt unlawful detainer

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-037854

</td>

<td style="text-align:left;">

2020-06-25

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

jeff 1 llc 4870 n. hiatus road sunrise fl 33351|

</td>

<td style="text-align:left;">

doe jane 8911 navajo ave. tampa fl 33637|doe john 8911 navajo ave. tampa
fl 33637

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt unlawful detainer

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-037884

</td>

<td style="text-align:left;">

2020-06-25

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

hfsf 4 llc c/o kathryn copeland 721 first avenue north st. petersburg fl
33701|

</td>

<td style="text-align:left;">

jones sherman 4005 humphrey street unit 111 tampa fl 33617

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction- possession only

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-037270

</td>

<td style="text-align:left;">

2020-06-24

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

irrizarry juan m 7514 robindale road tampa fl 33619|

</td>

<td style="text-align:left;">

ghannad mellisa 7514 robindale road tampa fl 33619|molina-molina luis
miguel 7514 robindale road tampa fl 33619

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-037461

</td>

<td style="text-align:left;">

2020-06-24

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

mcdill columbus property parnership iii llp 2700 n macdill ave ste 115
tampa fl 33607|

</td>

<td style="text-align:left;">

weisman joshua d 12421 n florida ave ste 119 tampa fl 33612|cprlho
aristofanes a 12421 n florida ave ste 119 tampa fl 33619

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-037462

</td>

<td style="text-align:left;">

2020-06-24

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

mcdill columbus property parnership iii llp 2700 n macdill ave ste 115
tampa fl 33607|

</td>

<td style="text-align:left;">

lancaster terrell ali leroy 12421 n florida ave ste 115c tampa fl 33612

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-037463

</td>

<td style="text-align:left;">

2020-06-24

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

mcdill columbus property parnership iii llp 2700 n macdill ave ste 115
tampa fl 33607|

</td>

<td style="text-align:left;">

outlaw vivian 1005 w busch blvd ste 210 tampa fl 33612

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-037477

</td>

<td style="text-align:left;">

2020-06-24

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

guyster emilia 12907 pepper place tampa fl 33624|

</td>

<td style="text-align:left;">

jenkins seaira d 8014 n 12th street tampa fl 33604

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-037486

</td>

<td style="text-align:left;">

2020-06-24

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

columbia sherman investments llc|tzadik management 14323 lucerne dr ste
101 tampa fl 33612|columbia oaks apartments|

</td>

<td style="text-align:left;">

terry jimmnisha 12202 n 15th st unit 506 tampa fl 33612

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction- possession only

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-037492

</td>

<td style="text-align:left;">

2020-06-24

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

barsoum kimberly 6235 florence st gibsonton fl 33534|barsoum maged 6235
florence st gibsonton fl 33534|

</td>

<td style="text-align:left;">

tenant unknown 6110 shirley ave lot \#2 gibsonton fl 33534|martinez
gracie 6110 shirley ave lot \#2 gibsonton fl 33534

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-037493

</td>

<td style="text-align:left;">

2020-06-24

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

hadsock-cifredo teri 385 se 28th way melrose fl 32666|

</td>

<td style="text-align:left;">

unknown tenant 602 oak ridge dr brandon fl 33510|torres julio 602 oak
ridge dr brandon fl 33510

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-037496

</td>

<td style="text-align:left;">

2020-06-24

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

treasure cove mhp llc c/0 paul chad comingore 1971 w lumsden rd suite
340 brandon fl 33511|

</td>

<td style="text-align:left;">

smith shanel 12432 s us41 lot \# us 3 gibsonton fl 33534

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-037497

</td>

<td style="text-align:left;">

2020-06-24

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

santos mike po box 151897 tampa fl 33684|

</td>

<td style="text-align:left;">

garves daveshia 8724 n 13th st apt b tampa fl 33604

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-037498

</td>

<td style="text-align:left;">

2020-06-24

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

reynoso grasiela 5101 w. trapnell road dover fl 33527|reynoso manuel
5101 w trapnell road dover fl 33527|

</td>

<td style="text-align:left;">

peek marguerite louise 14604 franklin avenue dover fl 33527|peek elton
jr 14604 franklin avenue dover fl 33527

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

lt eviction and past due rent $0.00-$15000.00

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-ca-005166

</td>

<td style="text-align:left;">

2020-06-24

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

lfj portfolio i llc c/o ronald b. cohn esq. pob 380 tampa fl 33601|mlj
trust investment properties llc c/o ronald b. cohn esq. pob 380 tampa fl
33601|ldf portfolio i llc c/o ronald b. cohn esq. pob 380 tampa fl
33601|federighi portfolio ii llc c/o ronald b. cohn esq. pob 380 tampa
fl 33601|acv fridays llc c/o ronald b.cohn esq. pob 380 tampa fl 33601|

</td>

<td style="text-align:left;">

carlson restaurants worldwide inc. 4201 marsh lane carrollton tx
75007|central florida restaurants inc. 3550 mowry avenue suite 301
fremont ca 94538

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

removal of tenant

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-ca-005195

</td>

<td style="text-align:left;">

2020-06-24

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

american infoage llc c/o brick business law p.a. 3413 w. fletcher ave.
tampa fl 33618|

</td>

<td style="text-align:left;">

cottle keelan 3612 maloa way tampa fl 33614|bowman shawn 3612 maloa way
tampa fl 33614|beard michael 3612 maloa way tampa fl 33614|813 brewing
llc 4465 w. gandy blvd. ste 600 tampa fl 33611

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

distress for rent

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

</tbody>

</table>

</div>

``` r
# View eviction cases since pinellas_fl's moratorium
kable(evictions_data %>%
  # Only places in pinellas_fl
  filter(location == "pinellas_fl") %>%
  # Since April 2
  filter(file_date > "2020-04-02")) %>%
  kable_styling(bootstrap_options = c("striped", "hover", "condensed", full_width = FALSE)) %>%
  scroll_box(width = "100%", height = "400px") 
```

<div style="border: 1px solid #ddd; padding: 0px; overflow-y: scroll; height:400px; overflow-x: scroll; width:100%; ">

<table class="table table-striped table-hover table-condensed" style="margin-left: auto; margin-right: auto;">

<thead>

<tr>

<th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;">

location

</th>

<th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;">

case\_number

</th>

<th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;">

file\_date

</th>

<th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;">

file\_month

</th>

<th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;">

file\_year

</th>

<th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;">

plaintiff

</th>

<th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;">

defendant

</th>

<th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;">

defendant\_address

</th>

<th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;">

plaintiff\_attorney

</th>

<th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;">

defendant\_attorney

</th>

<th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;">

case\_type

</th>

<th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;">

writ\_date

</th>

<th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;">

writ\_served\_date

</th>

</tr>

</thead>

<tbody>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

20-002641-co

</td>

<td style="text-align:left;">

2020-04-30

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

arthur zinkerman

</td>

<td style="text-align:left;">

sarah wilson. et al

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

eviction possession only (non-monetary)

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:left;">

no\_information

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

20-002643-co

</td>

<td style="text-align:left;">

2020-04-30

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

michael x erbe

</td>

<td style="text-align:left;">

kevin scott

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

eviction possession only (non-monetary)

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:left;">

no\_information

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

20-002653-co

</td>

<td style="text-align:left;">

2020-04-30

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

r e martin enterprises ii inc

</td>

<td style="text-align:left;">

jody m. maiden dds llc. et al

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

eviction damages $15,000.01 - $30,000

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:left;">

no\_information

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

20-002654-co

</td>

<td style="text-align:left;">

2020-04-30

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

michelle lee hill

</td>

<td style="text-align:left;">

christopher joseph hill

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

unlawful detainer

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:left;">

no\_information

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

20-002655-co

</td>

<td style="text-align:left;">

2020-04-30

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

zb786 corp

</td>

<td style="text-align:left;">

tiffanie ellenburg

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

eviction damages $2,500.01 - $15,000

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:left;">

no\_information

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

20-002629-co

</td>

<td style="text-align:left;">

2020-04-29

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

treasure bay apartments, llc

</td>

<td style="text-align:left;">

scott helie, all other residing

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

eviction damages $0 - $2,500

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:left;">

no\_information

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

20-002630-co

</td>

<td style="text-align:left;">

2020-04-29

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

lori suzanne walker

</td>

<td style="text-align:left;">

anna cecelia lafler

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

unlawful detainer

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:left;">

no\_information

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

20-002637-co

</td>

<td style="text-align:left;">

2020-04-29

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

emanuel r jones

</td>

<td style="text-align:left;">

valerie davis jones.et al

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

unlawful detainer

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:left;">

no\_information

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

20-002631-co

</td>

<td style="text-align:left;">

2020-04-28

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

bill kalyvas

</td>

<td style="text-align:left;">

oldsmar enterprise inc

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

eviction damages $2,500.01 - $15,000

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:left;">

no\_information

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

20-002625-co

</td>

<td style="text-align:left;">

2020-04-28

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

bohdan nagorka

</td>

<td style="text-align:left;">

lynsey staples

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

eviction possession only (non-monetary)

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:left;">

no\_information

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

20-002626-co

</td>

<td style="text-align:left;">

2020-04-28

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

elizabeth ludwiszewski

</td>

<td style="text-align:left;">

jack gilchrist

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

eviction damages $0 - $2,500

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:left;">

no\_information

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

20-002627-co

</td>

<td style="text-align:left;">

2020-04-28

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

tender loving services llc

</td>

<td style="text-align:left;">

briggett t roberts

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

eviction possession only (non-monetary)

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:left;">

no\_information

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

20-002609-co

</td>

<td style="text-align:left;">

2020-04-27

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

george palmieri.et al

</td>

<td style="text-align:left;">

brandy goudy

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

unlawful detainer

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:left;">

no\_information

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

20-002611-co

</td>

<td style="text-align:left;">

2020-04-27

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

bruce burroughs.et al

</td>

<td style="text-align:left;">

diane steacker

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

unlawful detainer

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:left;">

no\_information

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

20-002616-co

</td>

<td style="text-align:left;">

2020-04-27

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

william donovan

</td>

<td style="text-align:left;">

lakendra mott. et al

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

eviction possession only (non-monetary)

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:left;">

no\_information

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

20-002617-co

</td>

<td style="text-align:left;">

2020-04-27

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

880 22nd ave s land trust corporate midwest investment llc tre

</td>

<td style="text-align:left;">

donald anthony brinson. et al

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

eviction possession only (non-monetary)

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:left;">

no\_information

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

20-002618-co

</td>

<td style="text-align:left;">

2020-04-27

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

the executive firm/ konstantin vectchen

</td>

<td style="text-align:left;">

tina ranson. et al

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

eviction possession only (non-monetary)

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:left;">

no\_information

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

20-002619-co

</td>

<td style="text-align:left;">

2020-04-27

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

jessie campbell

</td>

<td style="text-align:left;">

jasmine helm. et al

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

eviction possession only (non-monetary)

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:left;">

no\_information

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

20-002620-co

</td>

<td style="text-align:left;">

2020-04-27

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

wyatt springs inc

</td>

<td style="text-align:left;">

kayla maria reddick

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

eviction possession only (non-monetary)

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:left;">

no\_information

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

20-002608-co

</td>

<td style="text-align:left;">

2020-04-26

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

donald rylander. et al

</td>

<td style="text-align:left;">

gina wagner

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

eviction possession only (non-monetary)

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:left;">

no\_information

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

20-002595-co

</td>

<td style="text-align:left;">

2020-04-24

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

palm spring estates

</td>

<td style="text-align:left;">

miranda mundhenk. et al

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

eviction possession only (non-monetary)

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:left;">

no\_information

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

20-002596-co

</td>

<td style="text-align:left;">

2020-04-24

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

millicent armogan

</td>

<td style="text-align:left;">

lisa m thompson

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

eviction possession only (non-monetary)

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:left;">

no\_information

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

20-002600-co

</td>

<td style="text-align:left;">

2020-04-24

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

peter w yore

</td>

<td style="text-align:left;">

willio etienne , jr

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

eviction damages $0 - $2,500

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:left;">

no\_information

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

20-002602-co

</td>

<td style="text-align:left;">

2020-04-24

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

lake investment real estate llc

</td>

<td style="text-align:left;">

michelle baker

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

eviction damages $0 - $2,500

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:left;">

no\_information

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

20-002604-co

</td>

<td style="text-align:left;">

2020-04-24

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

pamela schultz

</td>

<td style="text-align:left;">

zoltan r szabady

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

eviction possession only (non-monetary)

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:left;">

no\_information

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

20-002606-co

</td>

<td style="text-align:left;">

2020-04-24

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

rental marketing solutions

</td>

<td style="text-align:left;">

valerie owens

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

eviction possession only (non-monetary)

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:left;">

no\_information

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

20-002607-co

</td>

<td style="text-align:left;">

2020-04-24

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

timothy a lamb

</td>

<td style="text-align:left;">

cynthia w kitchen

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

unlawful detainer

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:left;">

no\_information

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

20-002577-co

</td>

<td style="text-align:left;">

2020-04-23

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

laura f lake

</td>

<td style="text-align:left;">

katherine mobley

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

eviction possession only (non-monetary)

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:left;">

no\_information

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

20-002579-co

</td>

<td style="text-align:left;">

2020-04-23

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

1566 16th st s land trust corporate midwest inv llc tre

</td>

<td style="text-align:left;">

annette davis, doing business as lil nets

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

eviction damages $0 - $2,500

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:left;">

no\_information

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

20-002580-co

</td>

<td style="text-align:left;">

2020-04-23

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

1132 engman st land trust corporate midwest investment llc tre

</td>

<td style="text-align:left;">

stephen quiles

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

eviction damages $0 - $2,500

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:left;">

no\_information

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

20-002583-co

</td>

<td style="text-align:left;">

2020-04-23

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

naim mubarak

</td>

<td style="text-align:left;">

mashawn lois keys. et al

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

eviction possession only (non-monetary)

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:left;">

no\_information

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

20-002584-co

</td>

<td style="text-align:left;">

2020-04-23

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

roderick fitzpatrick

</td>

<td style="text-align:left;">

david stokes, richard daniels

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

eviction damages $0 - $2,500

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:left;">

no\_information

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

20-002585-co

</td>

<td style="text-align:left;">

2020-04-23

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

jemie russsell

</td>

<td style="text-align:left;">

miren menchaca

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

eviction damages $0 - $2,500

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:left;">

no\_information

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

20-002586-co

</td>

<td style="text-align:left;">

2020-04-23

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

pcrh fund lllp

</td>

<td style="text-align:left;">

caroline thompson

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

eviction possession only (non-monetary)

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:left;">

no\_information

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

20-002587-co

</td>

<td style="text-align:left;">

2020-04-23

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

palm spring estates

</td>

<td style="text-align:left;">

josh morganstern. et al

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

eviction possession only (non-monetary)

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:left;">

no\_information

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

20-002588-co

</td>

<td style="text-align:left;">

2020-04-23

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

middletown property management llc

</td>

<td style="text-align:left;">

sharda swain

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

eviction possession only (non-monetary)

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:left;">

no\_information

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

20-002591-co

</td>

<td style="text-align:left;">

2020-04-23

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

david mcdowell

</td>

<td style="text-align:left;">

kevin andrews

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

eviction possession only (non-monetary)

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:left;">

no\_information

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

20-002561-co

</td>

<td style="text-align:left;">

2020-04-22

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

daphna blum

</td>

<td style="text-align:left;">

monica pastwa

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

eviction possession only (non-monetary)

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:left;">

no\_information

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

20-002562-co

</td>

<td style="text-align:left;">

2020-04-22

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

bichaun yang

</td>

<td style="text-align:left;">

william roiland, et al

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

unlawful detainer

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:left;">

no\_information

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

20-002563-co

</td>

<td style="text-align:left;">

2020-04-22

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

downtown st pete apartments llc

</td>

<td style="text-align:left;">

inga tiedmann

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

unlawful detainer

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:left;">

no\_information

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

20-002565-co

</td>

<td style="text-align:left;">

2020-04-22

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

jeanne sonner wiley

</td>

<td style="text-align:left;">

anthony robilotto. et al

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

eviction possession only (non-monetary)

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:left;">

no\_information

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

20-002571-co

</td>

<td style="text-align:left;">

2020-04-22

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

2148 54th ave llc, doing business as enclave at sabal pointe

</td>

<td style="text-align:left;">

zaria anderson, breanna jones

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

eviction damages $0 - $2,500

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:left;">

no\_information

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

20-002578-co

</td>

<td style="text-align:left;">

2020-04-22

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

sid boughton.et al

</td>

<td style="text-align:left;">

farrah fitzgerald

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

unlawful detainer

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:left;">

no\_information

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

20-002554-co

</td>

<td style="text-align:left;">

2020-04-21

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

second half properties

</td>

<td style="text-align:left;">

fabre lovette. et al

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

eviction possession only (non-monetary)

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:left;">

no\_information

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

20-002555-co

</td>

<td style="text-align:left;">

2020-04-21

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

second half properties

</td>

<td style="text-align:left;">

ashley kinkel

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

eviction possession only (non-monetary)

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:left;">

no\_information

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

20-002536-co

</td>

<td style="text-align:left;">

2020-04-20

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

michael x erbe

</td>

<td style="text-align:left;">

nora jones

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

eviction possession only (non-monetary)

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:left;">

no\_information

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

20-002543-co

</td>

<td style="text-align:left;">

2020-04-20

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

806 broadway llc, et al

</td>

<td style="text-align:left;">

angela wilkerson, maria nomikos

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

eviction damages $0 - $2,500

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:left;">

no\_information

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

20-002544-co

</td>

<td style="text-align:left;">

2020-04-20

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

dean charles bournakel

</td>

<td style="text-align:left;">

matthew troy landon. et al

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

eviction possession only (non-monetary)

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:left;">

no\_information

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

20-002545-co

</td>

<td style="text-align:left;">

2020-04-20

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

lawanda richardson

</td>

<td style="text-align:left;">

corey laveal dennis

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

unlawful detainer

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:left;">

no\_information

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

20-002546-co

</td>

<td style="text-align:left;">

2020-04-20

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

dean c bournakel

</td>

<td style="text-align:left;">

edward pessenda. et al

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

eviction possession only (non-monetary)

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:left;">

no\_information

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

20-002548-co

</td>

<td style="text-align:left;">

2020-04-20

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

gran casa llc

</td>

<td style="text-align:left;">

gregory ebright

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

eviction damages $2,500.01 - $15,000

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:left;">

no\_information

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

20-002531-co

</td>

<td style="text-align:left;">

2020-04-20

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

george l mckinney

</td>

<td style="text-align:left;">

chanique lanita bell. et al

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

eviction damages $15,000.01 - $30,000

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:left;">

no\_information

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

20-002535-co

</td>

<td style="text-align:left;">

2020-04-19

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

susanne e lyons

</td>

<td style="text-align:left;">

david f lyons

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

unlawful detainer

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:left;">

no\_information

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

20-002519-co

</td>

<td style="text-align:left;">

2020-04-17

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

andrew mendenhall

</td>

<td style="text-align:left;">

jefferson merrill corry, also known as jeff corry

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

eviction damages $0 - $2,500

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:left;">

no\_information

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

20-002520-co

</td>

<td style="text-align:left;">

2020-04-17

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

andrey pristash

</td>

<td style="text-align:left;">

allen king. et al

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

eviction possession only (non-monetary)

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:left;">

no\_information

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

20-002525-co

</td>

<td style="text-align:left;">

2020-04-17

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

1566 16th st s land trust corporate midwest inv llc tre

</td>

<td style="text-align:left;">

dawn scott

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

eviction damages $0 - $2,500

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:left;">

no\_information

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

20-002526-co

</td>

<td style="text-align:left;">

2020-04-17

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

1566 16th st s land trust corporate midwest inv llc tre

</td>

<td style="text-align:left;">

derimiah j howlett

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

eviction damages $0 - $2,500

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:left;">

no\_information

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

20-002527-co

</td>

<td style="text-align:left;">

2020-04-17

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

3501 50th st n land trust

</td>

<td style="text-align:left;">

dalee crowley, marvin wright

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

eviction damages $0 - $2,500

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:left;">

no\_information

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

20-002529-co

</td>

<td style="text-align:left;">

2020-04-17

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

schiller investments llc

</td>

<td style="text-align:left;">

lydia reed

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

eviction damages $0 - $2,500

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:left;">

no\_information

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

20-002530-co

</td>

<td style="text-align:left;">

2020-04-17

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

dee mc cune. et al

</td>

<td style="text-align:left;">

vianne york. et al

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

eviction damages $2,500.01 - $15,000

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:left;">

no\_information

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

20-001911-ci

</td>

<td style="text-align:left;">

2020-04-16

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

xuezhi liu

</td>

<td style="text-align:left;">

you bin pan

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

delinquent tenant - circuit

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:left;">

no\_information

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

20-002506-co

</td>

<td style="text-align:left;">

2020-04-16

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

urban edge commerical l l c

</td>

<td style="text-align:left;">

4 u fitness l l c

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

eviction damages $2,500.01 - $15,000

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:left;">

no\_information

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

20-002508-co

</td>

<td style="text-align:left;">

2020-04-16

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

rental marketing solutions llc

</td>

<td style="text-align:left;">

priscilla williams

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

eviction possession only (non-monetary)

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:left;">

no\_information

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

20-002509-co

</td>

<td style="text-align:left;">

2020-04-16

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

j + j enterprises of ny inc

</td>

<td style="text-align:left;">

larry jenkins. et al

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

eviction possession only (non-monetary)

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:left;">

no\_information

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

20-002510-co

</td>

<td style="text-align:left;">

2020-04-16

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

silver lake mhc llc

</td>

<td style="text-align:left;">

sean griffin. et al

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

eviction possession only (non-monetary)

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:left;">

no\_information

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

20-002511-co

</td>

<td style="text-align:left;">

2020-04-16

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

j and j enterprises of ny inc

</td>

<td style="text-align:left;">

darnell jenkins. et al

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

eviction possession only (non-monetary)

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:left;">

no\_information

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

20-002513-co

</td>

<td style="text-align:left;">

2020-04-16

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

ed iskander

</td>

<td style="text-align:left;">

ruby anderson, sandra e more

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

eviction damages $0 - $2,500

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:left;">

no\_information

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

20-002493-co

</td>

<td style="text-align:left;">

2020-04-15

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

congaree river llc

</td>

<td style="text-align:left;">

earl alcover

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

eviction damages $15,000.01 - $30,000

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:left;">

no\_information

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

20-002494-co

</td>

<td style="text-align:left;">

2020-04-15

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

milen kolev

</td>

<td style="text-align:left;">

jonathan michael parker

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

eviction possession only (non-monetary)

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:left;">

no\_information

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

20-002495-co

</td>

<td style="text-align:left;">

2020-04-15

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

james yearout

</td>

<td style="text-align:left;">

lenny cabra, et al

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

eviction possession only (non-monetary)

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:left;">

no\_information

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

20-002496-co

</td>

<td style="text-align:left;">

2020-04-15

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

douglas delozier

</td>

<td style="text-align:left;">

forest wadley. et al

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

eviction possession only (non-monetary)

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:left;">

no\_information

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

20-002497-co

</td>

<td style="text-align:left;">

2020-04-15

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

douglas delozier

</td>

<td style="text-align:left;">

adam hawk, et al

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

eviction possession only (non-monetary)

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:left;">

no\_information

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

20-002498-co

</td>

<td style="text-align:left;">

2020-04-15

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

douglas delozier

</td>

<td style="text-align:left;">

kelly litell, et al

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

eviction possession only (non-monetary)

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:left;">

no\_information

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

20-002499-co

</td>

<td style="text-align:left;">

2020-04-15

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

edward wernsing

</td>

<td style="text-align:left;">

gina rodgers-price. et al

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

eviction possession only (non-monetary)

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:left;">

no\_information

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

20-002502-co

</td>

<td style="text-align:left;">

2020-04-15

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

d2m2 adventures llc

</td>

<td style="text-align:left;">

unknown squatters

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

unlawful detainer

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:left;">

no\_information

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

20-002482-co

</td>

<td style="text-align:left;">

2020-04-14

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

daniel c echols

</td>

<td style="text-align:left;">

craig c mauro. et al

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

eviction possession only (non-monetary)

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:left;">

no\_information

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

20-002485-co

</td>

<td style="text-align:left;">

2020-04-14

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

cyrwus floral gardens apartments llc

</td>

<td style="text-align:left;">

oskar wator. et al

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

eviction possession only (non-monetary)

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:left;">

no\_information

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

20-002488-co

</td>

<td style="text-align:left;">

2020-04-14

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

1831 9th street south land trust

</td>

<td style="text-align:left;">

karen giillam

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

eviction possession only (non-monetary)

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:left;">

no\_information

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

20-002490-co

</td>

<td style="text-align:left;">

2020-04-14

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

annexy group llc

</td>

<td style="text-align:left;">

kristin ferren.et al

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

unlawful detainer

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:left;">

no\_information

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

20-002466-co

</td>

<td style="text-align:left;">

2020-04-13

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

1776 nereid avenue realty corp

</td>

<td style="text-align:left;">

randy geffon

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

eviction possession only (non-monetary)

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:left;">

no\_information

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

20-002471-co

</td>

<td style="text-align:left;">

2020-04-13

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

1227 21st ave land trust corporate midwewst inv llc tre

</td>

<td style="text-align:left;">

jason bell

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

eviction damages $0 - $2,500

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:left;">

no\_information

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

20-002472-co

</td>

<td style="text-align:left;">

2020-04-13

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

american buisness center

</td>

<td style="text-align:left;">

latoya brown

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

eviction damages $0 - $2,500

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:left;">

no\_information

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

20-002473-co

</td>

<td style="text-align:left;">

2020-04-13

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

david vincent

</td>

<td style="text-align:left;">

victor nunes, vanda gaspar

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

eviction damages $0 - $2,500

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:left;">

no\_information

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

20-002474-co

</td>

<td style="text-align:left;">

2020-04-13

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

3217 tyrone blvd land trust no2 corporate midwest investment tre

</td>

<td style="text-align:left;">

calvin fletcher holmes, visionz technology llc

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

eviction damages $0 - $2,500

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:left;">

no\_information

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

20-002468-co

</td>

<td style="text-align:left;">

2020-04-10

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

wayne c rickert

</td>

<td style="text-align:left;">

tim salzano. et al

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

eviction possession only (non-monetary)

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:left;">

no\_information

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

20-002504-co

</td>

<td style="text-align:left;">

2020-04-10

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

carol l moody.et al

</td>

<td style="text-align:left;">

kayla dennison

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

unlawful detainer

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:left;">

no\_information

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

20-001822-ci

</td>

<td style="text-align:left;">

2020-04-10

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

richard hutchins, et al

</td>

<td style="text-align:left;">

larry williams

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

delinquent tenant - circuit

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:left;">

no\_information

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

20-002455-co

</td>

<td style="text-align:left;">

2020-04-09

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

mary duda

</td>

<td style="text-align:left;">

anthony suriano

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

eviction possession only (non-monetary)

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:left;">

no\_information

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

20-002457-co

</td>

<td style="text-align:left;">

2020-04-09

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

eddie mcmullen

</td>

<td style="text-align:left;">

timothy shilstone. et al

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

eviction possession only (non-monetary)

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:left;">

no\_information

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

20-002458-co

</td>

<td style="text-align:left;">

2020-04-09

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

wayne c rickert

</td>

<td style="text-align:left;">

jeffrey bruce snyder. et al

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

eviction possession only (non-monetary)

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:left;">

no\_information

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

20-002463-co

</td>

<td style="text-align:left;">

2020-04-09

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

broderick and associates inc

</td>

<td style="text-align:left;">

hercules m mihaelaras

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

eviction damages $2,500.01 - $15,000

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:left;">

no\_information

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

20-002445-co

</td>

<td style="text-align:left;">

2020-04-08

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

alfred restaino

</td>

<td style="text-align:left;">

teresa webb

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

eviction possession only (non-monetary)

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:left;">

no\_information

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

20-001778-ci

</td>

<td style="text-align:left;">

2020-04-08

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

hupp metropointe llc, et al

</td>

<td style="text-align:left;">

low slope solutions llc

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

delinquent tenant - circuit

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:left;">

no\_information

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

20-002449-co

</td>

<td style="text-align:left;">

2020-04-08

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

gateway mhp ltd

</td>

<td style="text-align:left;">

luis colon

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

eviction possession only (non-monetary)

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:left;">

no\_information

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

20-002450-co

</td>

<td style="text-align:left;">

2020-04-08

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

danika zhang

</td>

<td style="text-align:left;">

vanessa norton, keana ash

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

eviction damages $0 - $2,500

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:left;">

no\_information

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

20-002451-co

</td>

<td style="text-align:left;">

2020-04-08

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

swh 2017 1 borrower lp

</td>

<td style="text-align:left;">

unknown occupants

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

unlawful detainer

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:left;">

no\_information

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

20-002429-co

</td>

<td style="text-align:left;">

2020-04-07

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

robert gardeski

</td>

<td style="text-align:left;">

amanda jean costello. et al

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

eviction possession only (non-monetary)

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:left;">

no\_information

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

20-002430-co

</td>

<td style="text-align:left;">

2020-04-07

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

yusuf shamid

</td>

<td style="text-align:left;">

liz rodriguez

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

eviction damages $0 - $2,500

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:left;">

no\_information

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

20-002438-co

</td>

<td style="text-align:left;">

2020-04-07

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

christine lavine

</td>

<td style="text-align:left;">

rka commercial flooring inc. et al

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

eviction damages $2,500.01 - $15,000

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:left;">

no\_information

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

20-002439-co

</td>

<td style="text-align:left;">

2020-04-07

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

nellie g kelley

</td>

<td style="text-align:left;">

eric p booker

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

eviction damages $0 - $2,500

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:left;">

no\_information

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

20-002443-co

</td>

<td style="text-align:left;">

2020-04-07

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

l e t property holdings llc

</td>

<td style="text-align:left;">

thomas c reynolds

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

unlawful detainer

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:left;">

no\_information

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

20-002444-co

</td>

<td style="text-align:left;">

2020-04-07

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

florida federal plaza llc

</td>

<td style="text-align:left;">

subway real estate llc . et al

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

eviction damages $2,500.01 - $15,000

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:left;">

no\_information

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

20-002418-co

</td>

<td style="text-align:left;">

2020-04-06

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

rebecca lynn gibbs

</td>

<td style="text-align:left;">

ashley ray carlton.et al

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

unlawful detainer

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:left;">

no\_information

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

20-002420-co

</td>

<td style="text-align:left;">

2020-04-06

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

stephen novak

</td>

<td style="text-align:left;">

charleane m johnson. et al

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

eviction possession only (non-monetary)

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:left;">

no\_information

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

20-002422-co

</td>

<td style="text-align:left;">

2020-04-06

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

charles barrs.et al

</td>

<td style="text-align:left;">

laura barrs

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

unlawful detainer

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:left;">

no\_information

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

20-002423-co

</td>

<td style="text-align:left;">

2020-04-06

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

matthew marone

</td>

<td style="text-align:left;">

william culliford

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

eviction possession only (non-monetary)

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:left;">

no\_information

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

20-002425-co

</td>

<td style="text-align:left;">

2020-04-06

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

best rental place, inc

</td>

<td style="text-align:left;">

shawn sherman

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

eviction possession only (non-monetary)

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:left;">

no\_information

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

20-002426-co

</td>

<td style="text-align:left;">

2020-04-06

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

property ir1 llc

</td>

<td style="text-align:left;">

kilgore ventures inc

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

eviction damages $2,500.01 - $15,000

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:left;">

no\_information

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

20-002516-co

</td>

<td style="text-align:left;">

2020-04-06

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

billys used tires

</td>

<td style="text-align:left;">

ray mowery

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

eviction damages $0 - $2,500

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:left;">

no\_information

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

20-002399-co

</td>

<td style="text-align:left;">

2020-04-03

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

skm inc

</td>

<td style="text-align:left;">

nina a greenshaw. et al

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

eviction possession only (non-monetary)

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:left;">

no\_information

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

20-002405-co

</td>

<td style="text-align:left;">

2020-04-03

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

melissa neipert

</td>

<td style="text-align:left;">

drew odell

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

eviction possession only (non-monetary)

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:left;">

no\_information

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

20-002406-co

</td>

<td style="text-align:left;">

2020-04-03

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

ernest price. et al

</td>

<td style="text-align:left;">

nathan j harrison. et al

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

eviction possession only (non-monetary)

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:left;">

no\_information

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

20-002407-co

</td>

<td style="text-align:left;">

2020-04-03

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

r2 property co ltd inc

</td>

<td style="text-align:left;">

martin planty

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

eviction possession only (non-monetary)

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:left;">

no\_information

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

20-002409-co

</td>

<td style="text-align:left;">

2020-04-03

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

matthew allmyer

</td>

<td style="text-align:left;">

charles davis. et al

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

eviction possession only (non-monetary)

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:left;">

no\_information

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

20-002413-co

</td>

<td style="text-align:left;">

2020-04-03

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

patricia dixon. et al

</td>

<td style="text-align:left;">

laura williams. et al

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

eviction possession only (non-monetary)

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:left;">

no\_information

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

20-002967-co

</td>

<td style="text-align:left;">

2020-05-29

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

vernell h carter

</td>

<td style="text-align:left;">

rodney davis

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

eviction damages $0 - $2,500

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:left;">

no\_information

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

20-002970-co

</td>

<td style="text-align:left;">

2020-05-29

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

willie a coney

</td>

<td style="text-align:left;">

marneisha harper

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

eviction damages $0 - $2,500

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:left;">

no\_information

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

20-002971-co

</td>

<td style="text-align:left;">

2020-05-29

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

m v b group inc

</td>

<td style="text-align:left;">

park street food mart inc

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

eviction possession only (non-monetary)

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:left;">

no\_information

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

20-002981-co

</td>

<td style="text-align:left;">

2020-05-29

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

gse properties of seminole llc

</td>

<td style="text-align:left;">

katie mayer

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

eviction possession only (non-monetary)

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:left;">

no\_information

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

20-002982-co

</td>

<td style="text-align:left;">

2020-05-29

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

ajten resuloska

</td>

<td style="text-align:left;">

lina marie rojas tascon

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

eviction possession only (non-monetary)

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:left;">

no\_information

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

20-002984-co

</td>

<td style="text-align:left;">

2020-05-29

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

rise jordan park apartments llc

</td>

<td style="text-align:left;">

takiera king

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

eviction damages $0 - $2,500

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:left;">

no\_information

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

20-002987-co

</td>

<td style="text-align:left;">

2020-05-29

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

deborah nunez.et al

</td>

<td style="text-align:left;">

darcy gillespie.et al

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

unlawful detainer

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:left;">

no\_information

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

20-002988-co

</td>

<td style="text-align:left;">

2020-05-29

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

louis palms mobile home park llc

</td>

<td style="text-align:left;">

robert todd crane, et al

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

eviction damages $0 - $2,500

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:left;">

no\_information

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

20-002989-co

</td>

<td style="text-align:left;">

2020-05-29

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

brian caudill

</td>

<td style="text-align:left;">

grisel pacheco

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

eviction possession only (non-monetary)

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:left;">

no\_information

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

20-002997-co

</td>

<td style="text-align:left;">

2020-05-29

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

tina g yegge

</td>

<td style="text-align:left;">

mohamed abuhamra

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

eviction damages $15,000.01 - $30,000

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:left;">

no\_information

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

20-002954-co

</td>

<td style="text-align:left;">

2020-05-28

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

rachel george

</td>

<td style="text-align:left;">

jareece d swann

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

eviction possession only (non-monetary)

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:left;">

no\_information

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

20-002955-co

</td>

<td style="text-align:left;">

2020-05-28

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

rental marketing solutions llc

</td>

<td style="text-align:left;">

tracy smith

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

eviction possession only (non-monetary)

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:left;">

no\_information

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

20-002961-co

</td>

<td style="text-align:left;">

2020-05-28

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

robert williams

</td>

<td style="text-align:left;">

donna lawrentz

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

eviction possession only (non-monetary)

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:left;">

no\_information

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

20-002939-co

</td>

<td style="text-align:left;">

2020-05-27

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

flaggler rock llc

</td>

<td style="text-align:left;">

gjuanisky clark

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

eviction possession only (non-monetary)

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:left;">

no\_information

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

20-002940-co

</td>

<td style="text-align:left;">

2020-05-27

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

amphone bounphakom

</td>

<td style="text-align:left;">

all unknown persons

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

unlawful detainer

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:left;">

no\_information

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

20-002941-co

</td>

<td style="text-align:left;">

2020-05-27

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

333 estate llc

</td>

<td style="text-align:left;">

thuy franklin

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

eviction damages $0 - $2,500

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:left;">

no\_information

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

20-002923-co

</td>

<td style="text-align:left;">

2020-05-26

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

merion flagler lp

</td>

<td style="text-align:left;">

roneishia young

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

eviction possession only (non-monetary)

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:left;">

no\_information

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

20-002924-co

</td>

<td style="text-align:left;">

2020-05-26

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

willy rosado

</td>

<td style="text-align:left;">

terrell hugh thompson

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

eviction possession only (non-monetary)

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:left;">

no\_information

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

20-002925-co

</td>

<td style="text-align:left;">

2020-05-26

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

charel mhp llc

</td>

<td style="text-align:left;">

richard brown. et al

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

eviction possession only (non-monetary)

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:left;">

no\_information

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

20-002926-co

</td>

<td style="text-align:left;">

2020-05-26

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

delta mhp llc

</td>

<td style="text-align:left;">

burl mccranery. et al

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

eviction possession only (non-monetary)

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:left;">

no\_information

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

20-002928-co

</td>

<td style="text-align:left;">

2020-05-26

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

southern magnolia rentals llc

</td>

<td style="text-align:left;">

colleen f burton. et al

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

eviction possession only (non-monetary)

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:left;">

no\_information

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

20-002929-co

</td>

<td style="text-align:left;">

2020-05-26

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

southern magnolia rentals llc

</td>

<td style="text-align:left;">

devin lee, et al

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

eviction possession only (non-monetary)

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:left;">

no\_information

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

20-002980-co

</td>

<td style="text-align:left;">

2020-05-23

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

spinelli holdings ii llc

</td>

<td style="text-align:left;">

paul jackson. et al

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

eviction damages $2,500.01 - $15,000

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:left;">

no\_information

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

20-002910-co

</td>

<td style="text-align:left;">

2020-05-22

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

apartments at lakeside, llc

</td>

<td style="text-align:left;">

john doe

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

unlawful detainer

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:left;">

no\_information

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

20-002911-co

</td>

<td style="text-align:left;">

2020-05-22

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

merideth frye

</td>

<td style="text-align:left;">

dave swartz. et al

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

eviction possession only (non-monetary)

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:left;">

no\_information

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

20-002918-co

</td>

<td style="text-align:left;">

2020-05-22

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

adelaida reay

</td>

<td style="text-align:left;">

carlos castiblanco

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

unlawful detainer

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:left;">

no\_information

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

20-002919-co

</td>

<td style="text-align:left;">

2020-05-22

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

argus real estate, inc

</td>

<td style="text-align:left;">

doque pierahita. et al

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

eviction possession only (non-monetary)

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:left;">

no\_information

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

20-002920-co

</td>

<td style="text-align:left;">

2020-05-22

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

mari jean hotel, llc

</td>

<td style="text-align:left;">

niki cullin. et al

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

eviction possession only (non-monetary)

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:left;">

no\_information

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

20-002921-co

</td>

<td style="text-align:left;">

2020-05-22

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

argus real estate inc

</td>

<td style="text-align:left;">

anthony harris. et al

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

eviction possession only (non-monetary)

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:left;">

no\_information

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

20-002901-co

</td>

<td style="text-align:left;">

2020-05-21

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

dane kirby whitt

</td>

<td style="text-align:left;">

nichole whitt

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

unlawful detainer

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:left;">

no\_information

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

20-002902-co

</td>

<td style="text-align:left;">

2020-05-21

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

nancy stock

</td>

<td style="text-align:left;">

kathleen koch

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

unlawful detainer

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:left;">

no\_information

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

20-002903-co

</td>

<td style="text-align:left;">

2020-05-21

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

rem properties llc

</td>

<td style="text-align:left;">

melissa schurman, individually

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

eviction damages $2,500.01 - $15,000

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:left;">

no\_information

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

20-002905-co

</td>

<td style="text-align:left;">

2020-05-21

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

kathleen jordan

</td>

<td style="text-align:left;">

karen wall

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

unlawful detainer

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:left;">

no\_information

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

20-002889-co

</td>

<td style="text-align:left;">

2020-05-20

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

nicole colton-jones

</td>

<td style="text-align:left;">

darnell cooper

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

unlawful detainer

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:left;">

no\_information

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

20-002890-co

</td>

<td style="text-align:left;">

2020-05-20

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

berati 2 llc

</td>

<td style="text-align:left;">

jennifer white

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

eviction damages $0 - $2,500

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:left;">

no\_information

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

20-002891-co

</td>

<td style="text-align:left;">

2020-05-20

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

charel mhp llc

</td>

<td style="text-align:left;">

travis brien. et al

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

eviction possession only (non-monetary)

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:left;">

no\_information

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

20-002894-co

</td>

<td style="text-align:left;">

2020-05-20

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

cres 56th court owner llc

</td>

<td style="text-align:left;">

precision circuit solutions llc

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

eviction possession only (non-monetary)

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:left;">

no\_information

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

20-002875-co

</td>

<td style="text-align:left;">

2020-05-19

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

rental marketing solutions llc

</td>

<td style="text-align:left;">

kevin smith. et al

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

eviction possession only (non-monetary)

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:left;">

no\_information

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

20-002876-co

</td>

<td style="text-align:left;">

2020-05-19

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

patrick plummer, doing business as true mobility llc

</td>

<td style="text-align:left;">

latia enjai smith, also known as tia smith, and other tenants

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

eviction damages $0 - $2,500

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:left;">

no\_information

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

20-002877-co

</td>

<td style="text-align:left;">

2020-05-19

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

784 18th ave s land trust

</td>

<td style="text-align:left;">

betty jo pinnace. et al

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

eviction possession only (non-monetary)

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:left;">

no\_information

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

20-002879-co

</td>

<td style="text-align:left;">

2020-05-19

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

vincent guidi. et al

</td>

<td style="text-align:left;">

erica howard

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

eviction possession only (non-monetary)

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:left;">

no\_information

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

20-002881-co

</td>

<td style="text-align:left;">

2020-05-19

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

baywest apartments llc

</td>

<td style="text-align:left;">

steven curtis klein

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

eviction damages $0 - $2,500

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:left;">

no\_information

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

20-002882-co

</td>

<td style="text-align:left;">

2020-05-19

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

largo industrial park, llc

</td>

<td style="text-align:left;">

brian travis harrison

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

eviction possession only (non-monetary)

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:left;">

no\_information

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

20-002922-co

</td>

<td style="text-align:left;">

2020-05-19

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

james chevalier. et al

</td>

<td style="text-align:left;">

james slezak

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

eviction possession only (non-monetary)

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:left;">

no\_information

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

20-002856-co

</td>

<td style="text-align:left;">

2020-05-18

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

sun terrace m llc

</td>

<td style="text-align:left;">

paul joseph smith

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

eviction possession only (non-monetary)

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:left;">

no\_information

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

20-002857-co

</td>

<td style="text-align:left;">

2020-05-18

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

sun terrace m llc

</td>

<td style="text-align:left;">

charles k daugherty

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

eviction possession only (non-monetary)

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:left;">

no\_information

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

20-002858-co

</td>

<td style="text-align:left;">

2020-05-18

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

sun terrace m llc

</td>

<td style="text-align:left;">

christina diana batista

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

eviction possession only (non-monetary)

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:left;">

no\_information

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

20-002860-co

</td>

<td style="text-align:left;">

2020-05-18

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

geoffrey savage

</td>

<td style="text-align:left;">

rebecca richardson

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

unlawful detainer

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:left;">

no\_information

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

20-002861-co

</td>

<td style="text-align:left;">

2020-05-18

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

metropolitian properties inc

</td>

<td style="text-align:left;">

paul john reitenour

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

eviction damages $0 - $2,500

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:left;">

no\_information

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

20-002862-co

</td>

<td style="text-align:left;">

2020-05-18

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

vladimir jacaj

</td>

<td style="text-align:left;">

adam foley, abby mack

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

eviction damages $0 - $2,500

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:left;">

no\_information

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

20-002863-co

</td>

<td style="text-align:left;">

2020-05-18

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

kakusha properties llc

</td>

<td style="text-align:left;">

ronald otoole

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

eviction possession only (non-monetary)

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:left;">

no\_information

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

20-002865-co

</td>

<td style="text-align:left;">

2020-05-18

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

avanti trust

</td>

<td style="text-align:left;">

john lee nelson. et al

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

eviction possession only (non-monetary)

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:left;">

no\_information

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

20-002824-co

</td>

<td style="text-align:left;">

2020-05-15

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

doug klemm

</td>

<td style="text-align:left;">

james m asselin

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

eviction possession only (non-monetary)

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:left;">

no\_information

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

20-002829-co

</td>

<td style="text-align:left;">

2020-05-15

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

stephen williams

</td>

<td style="text-align:left;">

starlett clark, antonio swain

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

eviction damages $0 - $2,500

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:left;">

no\_information

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

20-002830-co

</td>

<td style="text-align:left;">

2020-05-15

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

craig lathrop

</td>

<td style="text-align:left;">

joseph marr

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

eviction possession only (non-monetary)

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:left;">

no\_information

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

20-002831-co

</td>

<td style="text-align:left;">

2020-05-15

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

pw llc

</td>

<td style="text-align:left;">

donald kendall. et al

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

eviction damages $2,500.01 - $15,000

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:left;">

no\_information

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

20-002832-co

</td>

<td style="text-align:left;">

2020-05-15

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

david soler

</td>

<td style="text-align:left;">

melissa webb. et al

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

eviction possession only (non-monetary)

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:left;">

no\_information

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

20-002835-co

</td>

<td style="text-align:left;">

2020-05-15

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

andrey pristash

</td>

<td style="text-align:left;">

samantha scott

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

eviction possession only (non-monetary)

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:left;">

no\_information

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

20-002836-co

</td>

<td style="text-align:left;">

2020-05-15

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

george carrington

</td>

<td style="text-align:left;">

keosha grant

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

eviction possession only (non-monetary)

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:left;">

no\_information

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

20-002838-co

</td>

<td style="text-align:left;">

2020-05-15

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

dion m jackson

</td>

<td style="text-align:left;">

aaron m jackson

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

eviction damages $2,500.01 - $15,000

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:left;">

no\_information

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

20-002841-co

</td>

<td style="text-align:left;">

2020-05-15

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

anthony francis tomaselli

</td>

<td style="text-align:left;">

mandy lynn arnold

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

unlawful detainer

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:left;">

no\_information

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

20-002842-co

</td>

<td style="text-align:left;">

2020-05-15

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

clifton martin

</td>

<td style="text-align:left;">

ronmie prince

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

eviction damages $0 - $2,500

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:left;">

no\_information

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

20-002843-co

</td>

<td style="text-align:left;">

2020-05-15

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

christopher starke

</td>

<td style="text-align:left;">

kira anne hendon. et al

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

eviction damages $2,500.01 - $15,000

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:left;">

no\_information

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

20-002844-co

</td>

<td style="text-align:left;">

2020-05-15

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

lempidakis famiy entr

</td>

<td style="text-align:left;">

vincent garguilo

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

eviction damages $2,500.01 - $15,000

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:left;">

no\_information

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

20-002848-co

</td>

<td style="text-align:left;">

2020-05-15

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

vinh investment llc

</td>

<td style="text-align:left;">

jessie barber

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

eviction possession only (non-monetary)

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:left;">

no\_information

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

20-002849-co

</td>

<td style="text-align:left;">

2020-05-15

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

vinh investment, llc

</td>

<td style="text-align:left;">

unknown tenant in possession

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

eviction possession only (non-monetary)

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:left;">

no\_information

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

20-002809-co

</td>

<td style="text-align:left;">

2020-05-14

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

vernell h carter

</td>

<td style="text-align:left;">

elizabeth mcintosh

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

eviction damages $0 - $2,500

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:left;">

no\_information

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

20-002812-co

</td>

<td style="text-align:left;">

2020-05-14

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

vernell h carter

</td>

<td style="text-align:left;">

james e sheffield

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

eviction damages $0 - $2,500

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:left;">

no\_information

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

20-002813-co

</td>

<td style="text-align:left;">

2020-05-14

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

levant group llc

</td>

<td style="text-align:left;">

greenberg dental associates llc. et al

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

eviction damages $15,000.01 - $30,000

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:left;">

no\_information

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

20-002814-co

</td>

<td style="text-align:left;">

2020-05-14

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

raja management corp, doing business as kenwood inn

</td>

<td style="text-align:left;">

leroy goodman

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

eviction damages $0 - $2,500

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:left;">

no\_information

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

20-002815-co

</td>

<td style="text-align:left;">

2020-05-14

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

chaf properties llc

</td>

<td style="text-align:left;">

lavatrice newton

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

eviction possession only (non-monetary)

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:left;">

no\_information

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

20-002816-co

</td>

<td style="text-align:left;">

2020-05-14

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

raja management corp

</td>

<td style="text-align:left;">

desmond royale

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

eviction possession only (non-monetary)

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:left;">

no\_information

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

20-002818-co

</td>

<td style="text-align:left;">

2020-05-14

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

kem carey

</td>

<td style="text-align:left;">

janet norwell

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

eviction possession only (non-monetary)

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:left;">

no\_information

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

20-002820-co

</td>

<td style="text-align:left;">

2020-05-14

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

barbara stafford

</td>

<td style="text-align:left;">

leslie kratochvil

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

eviction possession only (non-monetary)

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:left;">

no\_information

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

20-002821-co

</td>

<td style="text-align:left;">

2020-05-14

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

palm spring estates

</td>

<td style="text-align:left;">

thomas pampino

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

eviction possession only (non-monetary)

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:left;">

no\_information

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

20-002792-co

</td>

<td style="text-align:left;">

2020-05-13

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

michael demarinis

</td>

<td style="text-align:left;">

richard russo. et al

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

eviction possession only (non-monetary)

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:left;">

no\_information

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

20-002797-co

</td>

<td style="text-align:left;">

2020-05-13

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

andy orfitelli

</td>

<td style="text-align:left;">

matt roberts, any unknown person

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

eviction damages $0 - $2,500

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:left;">

no\_information

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

20-002800-co

</td>

<td style="text-align:left;">

2020-05-13

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

patricia o’neil

</td>

<td style="text-align:left;">

michelle joene patterson

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

unlawful detainer

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:left;">

no\_information

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

20-002802-co

</td>

<td style="text-align:left;">

2020-05-13

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

joyce enterprises inc

</td>

<td style="text-align:left;">

conner biggers

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

eviction possession only (non-monetary)

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:left;">

no\_information

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

20-002803-co

</td>

<td style="text-align:left;">

2020-05-13

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

richard martin management co inc

</td>

<td style="text-align:left;">

quanrui ding, individually

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

eviction damages $2,500.01 - $15,000

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:left;">

no\_information

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

20-002777-co

</td>

<td style="text-align:left;">

2020-05-12

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

jolanta wasowski mgr mbr. et al

</td>

<td style="text-align:left;">

leslie whipkey

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

eviction possession only (non-monetary)

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:left;">

no\_information

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

20-002778-co

</td>

<td style="text-align:left;">

2020-05-12

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

gaston mhp, inc

</td>

<td style="text-align:left;">

sonia gil, et al

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

eviction possession only (non-monetary)

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:left;">

no\_information

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

20-002779-co

</td>

<td style="text-align:left;">

2020-05-12

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

david d falzone

</td>

<td style="text-align:left;">

chelsea teixeira

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

eviction possession only (non-monetary)

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:left;">

no\_information

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

20-002780-co

</td>

<td style="text-align:left;">

2020-05-12

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

gaston mhp, inc

</td>

<td style="text-align:left;">

jerimiah mincy. et al

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

eviction possession only (non-monetary)

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:left;">

no\_information

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

20-002781-co

</td>

<td style="text-align:left;">

2020-05-12

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

gatson mhp, inc

</td>

<td style="text-align:left;">

kyle soloman. et al

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

eviction possession only (non-monetary)

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:left;">

no\_information

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

20-002782-co

</td>

<td style="text-align:left;">

2020-05-12

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

gaston mhp, inc

</td>

<td style="text-align:left;">

simon kairie. et al

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

eviction possession only (non-monetary)

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:left;">

no\_information

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

20-002784-co

</td>

<td style="text-align:left;">

2020-05-12

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

gregory rodgers. et al

</td>

<td style="text-align:left;">

heather bailey. et al

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

eviction possession only (non-monetary)

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:left;">

no\_information

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

20-002791-co

</td>

<td style="text-align:left;">

2020-05-12

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

peter dituri

</td>

<td style="text-align:left;">

anna johnson. et al

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

eviction possession only (non-monetary)

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:left;">

no\_information

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

20-002763-co

</td>

<td style="text-align:left;">

2020-05-11

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

elisa ballew, personal rep

</td>

<td style="text-align:left;">

amber farrar.et al

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

unlawful detainer

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:left;">

no\_information

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

20-002764-co

</td>

<td style="text-align:left;">

2020-05-11

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

melinda diana callahan

</td>

<td style="text-align:left;">

vincent wilson

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

eviction damages $2,500.01 - $15,000

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:left;">

no\_information

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

20-002765-co

</td>

<td style="text-align:left;">

2020-05-11

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

michelle a yankey

</td>

<td style="text-align:left;">

cody james zellner

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

eviction possession only (non-monetary)

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:left;">

no\_information

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

20-002767-co

</td>

<td style="text-align:left;">

2020-05-11

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

hh20, llc

</td>

<td style="text-align:left;">

jimmy larry boykin, jr. et al

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

eviction possession only (non-monetary)

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:left;">

no\_information

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

20-002768-co

</td>

<td style="text-align:left;">

2020-05-11

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

hh20, llc

</td>

<td style="text-align:left;">

william beveridge. et al

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

eviction possession only (non-monetary)

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:left;">

no\_information

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

20-002769-co

</td>

<td style="text-align:left;">

2020-05-11

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

mari jean hotel, llc

</td>

<td style="text-align:left;">

michael maxwell. et al

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

eviction possession only (non-monetary)

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:left;">

no\_information

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

20-002770-co

</td>

<td style="text-align:left;">

2020-05-11

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

rental marketing solutions llc

</td>

<td style="text-align:left;">

leon cole. et al

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

eviction possession only (non-monetary)

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:left;">

no\_information

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

20-002772-co

</td>

<td style="text-align:left;">

2020-05-11

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

mari jean hotel, llc

</td>

<td style="text-align:left;">

michael mcbee. et al

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

eviction possession only (non-monetary)

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:left;">

no\_information

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

20-002776-co

</td>

<td style="text-align:left;">

2020-05-11

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

edward r judy

</td>

<td style="text-align:left;">

jennifer meesig . et al

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

eviction possession only (non-monetary)

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:left;">

no\_information

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

20-002743-co

</td>

<td style="text-align:left;">

2020-05-08

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

real estate entities llc

</td>

<td style="text-align:left;">

natasha dorcin.et al

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

unlawful detainer

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:left;">

no\_information

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

20-002744-co

</td>

<td style="text-align:left;">

2020-05-08

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

paradise towers - seminole llc, as landlord for roger s hendricks

</td>

<td style="text-align:left;">

damien steele

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

eviction damages $0 - $2,500

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:left;">

no\_information

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

20-002745-co

</td>

<td style="text-align:left;">

2020-05-08

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

paradise towers- seminole llc, as landlord for roger s hendricks

</td>

<td style="text-align:left;">

robert john cooper

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

eviction damages $0 - $2,500

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:left;">

no\_information

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

20-002261-ci

</td>

<td style="text-align:left;">

2020-05-08

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

marilyn d rimar

</td>

<td style="text-align:left;">

subway real estate corp, et al

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

delinquent tenant - circuit

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:left;">

no\_information

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

20-002746-co

</td>

<td style="text-align:left;">

2020-05-08

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

cygram llc. et al

</td>

<td style="text-align:left;">

dimitrios tsoulgiannis

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

eviction possession only (non-monetary)

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:left;">

no\_information

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

20-002748-co

</td>

<td style="text-align:left;">

2020-05-08

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

chesapeake apartments llc

</td>

<td style="text-align:left;">

john correa. et al

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

eviction possession only (non-monetary)

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:left;">

no\_information

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

20-002749-co

</td>

<td style="text-align:left;">

2020-05-08

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

vinh vo

</td>

<td style="text-align:left;">

terrell carver. et al

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

eviction possession only (non-monetary)

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:left;">

no\_information

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

20-002716-co

</td>

<td style="text-align:left;">

2020-05-07

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

millicent armogan

</td>

<td style="text-align:left;">

jason allan taylor

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

eviction possession only (non-monetary)

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:left;">

no\_information

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

20-002717-co

</td>

<td style="text-align:left;">

2020-05-07

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

andy orfitelli

</td>

<td style="text-align:left;">

brianna holzerland

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

eviction damages $0 - $2,500

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:left;">

no\_information

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

20-002719-co

</td>

<td style="text-align:left;">

2020-05-07

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

millicent armogan

</td>

<td style="text-align:left;">

edward allan taylor

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

eviction possession only (non-monetary)

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:left;">

no\_information

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

20-002724-co

</td>

<td style="text-align:left;">

2020-05-07

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

richard l earnhardt, individually.et al

</td>

<td style="text-align:left;">

heidi christian, individually

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

unlawful detainer

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:left;">

no\_information

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

20-002726-co

</td>

<td style="text-align:left;">

2020-05-07

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

middletown property management llc

</td>

<td style="text-align:left;">

steve dora fifth. et al

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

eviction possession only (non-monetary)

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:left;">

no\_information

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

20-002728-co

</td>

<td style="text-align:left;">

2020-05-07

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

st markorious llc

</td>

<td style="text-align:left;">

michael james fitzpatrick. et al

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

eviction possession only (non-monetary)

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:left;">

no\_information

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

20-002734-co

</td>

<td style="text-align:left;">

2020-05-07

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

susan n corey

</td>

<td style="text-align:left;">

dream team motors inc

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

eviction damages $2,500.01 - $15,000

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:left;">

no\_information

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

20-002737-co

</td>

<td style="text-align:left;">

2020-05-07

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

naim mubarak

</td>

<td style="text-align:left;">

sherlondra houston

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

eviction possession only (non-monetary)

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:left;">

no\_information

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

20-002738-co

</td>

<td style="text-align:left;">

2020-05-07

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

neal kinzie

</td>

<td style="text-align:left;">

aisling morgaine

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

eviction possession only (non-monetary)

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:left;">

no\_information

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

20-002739-co

</td>

<td style="text-align:left;">

2020-05-07

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

delavan h smith

</td>

<td style="text-align:left;">

jasmine jackson

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

unlawful detainer

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:left;">

no\_information

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

20-002741-co

</td>

<td style="text-align:left;">

2020-05-07

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

chaf properties llc

</td>

<td style="text-align:left;">

johanna rosario

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

eviction possession only (non-monetary)

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:left;">

no\_information

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

20-002713-co

</td>

<td style="text-align:left;">

2020-05-06

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

73rd avenue apartments i llc

</td>

<td style="text-align:left;">

tina dimasse. et al

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

eviction possession only (non-monetary)

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:left;">

no\_information

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

20-002714-co

</td>

<td style="text-align:left;">

2020-05-06

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

73rd avenue apartments i llc

</td>

<td style="text-align:left;">

falasade seymore. et al

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

eviction possession only (non-monetary)

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:left;">

no\_information

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

20-002715-co

</td>

<td style="text-align:left;">

2020-05-06

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

ybor 1909, llc

</td>

<td style="text-align:left;">

alisonn starr gardner, doing business as serenitea shop, llc

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

eviction damages $0 - $2,500

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:left;">

no\_information

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

20-002695-co

</td>

<td style="text-align:left;">

2020-05-05

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

churchfield i, llc

</td>

<td style="text-align:left;">

madeline minier

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

eviction damages $2,500.01 - $15,000

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:left;">

no\_information

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

20-002696-co

</td>

<td style="text-align:left;">

2020-05-05

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

lirie selimi

</td>

<td style="text-align:left;">

tommy cook

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

eviction damages $0 - $2,500

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:left;">

no\_information

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

20-002699-co

</td>

<td style="text-align:left;">

2020-05-05

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

pamela miner

</td>

<td style="text-align:left;">

glen johnson

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

eviction possession only (non-monetary)

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:left;">

no\_information

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

20-002701-co

</td>

<td style="text-align:left;">

2020-05-05

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

rock island investments llc

</td>

<td style="text-align:left;">

roy coward

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

eviction damages $0 - $2,500

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:left;">

no\_information

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

20-002702-co

</td>

<td style="text-align:left;">

2020-05-05

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

rock island investments llc

</td>

<td style="text-align:left;">

jasmine bailey

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

eviction damages $0 - $2,500

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:left;">

no\_information

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

20-002708-co

</td>

<td style="text-align:left;">

2020-05-05

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

walter horbatch

</td>

<td style="text-align:left;">

wallace reynolds, et al

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

eviction possession only (non-monetary)

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:left;">

no\_information

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

20-002698-co

</td>

<td style="text-align:left;">

2020-05-04

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

muhamed faour

</td>

<td style="text-align:left;">

amber langefels. et al

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

eviction damages $2,500.01 - $15,000

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:left;">

no\_information

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

20-002678-co

</td>

<td style="text-align:left;">

2020-05-04

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

oakwood home enterprises llc

</td>

<td style="text-align:left;">

david laturno, unknown occupant

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

eviction damages $0 - $2,500

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:left;">

no\_information

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

20-002679-co

</td>

<td style="text-align:left;">

2020-05-04

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

oakwood home enterprises llc

</td>

<td style="text-align:left;">

william craig, patricia falcon, formerly known as unknown occupant

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

eviction damages $0 - $2,500

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:left;">

no\_information

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

20-002680-co

</td>

<td style="text-align:left;">

2020-05-04

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

florida coast capital group, llc, doing business as florida sands
mobiles home park

</td>

<td style="text-align:left;">

victoria fox, nick torini, formerly known as unknown occupant

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

eviction damages $0 - $2,500

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:left;">

no\_information

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

20-002681-co

</td>

<td style="text-align:left;">

2020-05-04

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

west coast group enterprises llc

</td>

<td style="text-align:left;">

jan dunaja

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

eviction possession only (non-monetary)

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:left;">

no\_information

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

20-002682-co

</td>

<td style="text-align:left;">

2020-05-04

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

david apple

</td>

<td style="text-align:left;">

nicholas rylander

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

eviction possession only (non-monetary)

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:left;">

no\_information

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

20-002683-co

</td>

<td style="text-align:left;">

2020-05-04

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

broadleaf properties llc

</td>

<td style="text-align:left;">

michael totten

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

eviction damages $2,500.01 - $15,000

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:left;">

no\_information

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

20-002688-co

</td>

<td style="text-align:left;">

2020-05-04

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

witold pepas

</td>

<td style="text-align:left;">

russell strack

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

eviction possession only (non-monetary)

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:left;">

no\_information

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

20-002659-co

</td>

<td style="text-align:left;">

2020-05-01

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

jane a waltz

</td>

<td style="text-align:left;">

fawn rea lerner gill

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

eviction damages $0 - $2,500

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:left;">

no\_information

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

20-002660-co

</td>

<td style="text-align:left;">

2020-05-01

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

elisabeth r gaines

</td>

<td style="text-align:left;">

alejandro llanos garcia

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

unlawful detainer

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:left;">

no\_information

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

20-002663-co

</td>

<td style="text-align:left;">

2020-05-01

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

73rd avenue apartments i llc

</td>

<td style="text-align:left;">

rick cooper

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

eviction possession only (non-monetary)

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:left;">

no\_information

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

20-002665-co

</td>

<td style="text-align:left;">

2020-05-01

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

leisure associates limited partnership

</td>

<td style="text-align:left;">

marie aileen scalabrino. et al

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

eviction possession only (non-monetary)

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:left;">

no\_information

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

20-002666-co

</td>

<td style="text-align:left;">

2020-05-01

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

franklin lockhart

</td>

<td style="text-align:left;">

brenda pohjola lockhart

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

eviction possession only (non-monetary)

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:left;">

no\_information

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

20-002668-co

</td>

<td style="text-align:left;">

2020-05-01

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

joseph w langford. et al

</td>

<td style="text-align:left;">

manwar al-shammari. et al

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

eviction possession only (non-monetary)

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:left;">

no\_information

</td>

</tr>

<tr>

<td style="text-align:left;">

pinellas\_fl

</td>

<td style="text-align:left;">

20-002673-co

</td>

<td style="text-align:left;">

2020-05-01

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

2020

</td>

<td style="text-align:left;">

megan r helms

</td>

<td style="text-align:left;">

brian senese.et al

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

unlawful detainer

</td>

<td style="text-align:left;">

no\_information

</td>

<td style="text-align:left;">

no\_information

</td>

</tr>

</tbody>

</table>

</div>

##### Writs Filed and Served

**Writs filed:**

``` r
# Check whether we have any 'writs filed' data for state
writ_data %>%
  # Only places in FL
  filter(str_detect(location, "_fl")) %>%
  # Not no_information or NA
  filter((!is.na(writ_date))&(writ_date != "no_information")) %>%
  group_by(location) %>%
  count()
```

    ## # A tibble: 1 x 2
    ## # Groups:   location [1]
    ##   location            n
    ##   <chr>           <int>
    ## 1 hillsborough_fl  1082

``` r
## If we do...

# See how many writs have been filed since moratorium
writ_data %>%
  # Only places in FL
  filter(str_detect(location, "_fl")) %>%
  # Not no_information or NA
  filter((!is.na(writ_date))&(writ_date != "no_information")) %>%
  # Since April 2
  filter(writ_date > "2020-04-02") %>%
  group_by(location) %>%
  count()
```

    ## # A tibble: 1 x 2
    ## # Groups:   location [1]
    ##   location            n
    ##   <chr>           <int>
    ## 1 hillsborough_fl    51

``` r
# See which writs have been filed since moratorium
kable(writ_data %>%
  # Only places in FL
  filter(str_detect(location, "_fl")) %>%
  # Not no_information or NA
  filter((!is.na(writ_date))&(writ_date != "no_information")) %>%
  # Since April 2
  filter(writ_date > "2020-04-02")) %>%
  kable_styling(bootstrap_options = c("striped", "hover", "condensed", full_width = FALSE)) %>%
  scroll_box(width = "100%", height = "400px") 
```

<div style="border: 1px solid #ddd; padding: 0px; overflow-y: scroll; height:400px; overflow-x: scroll; width:100%; ">

<table class="table table-striped table-hover table-condensed" style="margin-left: auto; margin-right: auto;">

<thead>

<tr>

<th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;">

location

</th>

<th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;">

case\_number

</th>

<th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;">

file\_date

</th>

<th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;">

writ\_date

</th>

<th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;">

writ\_month

</th>

<th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;">

writ\_day

</th>

<th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;">

writ\_year

</th>

<th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;">

writ\_served\_date

</th>

<th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;">

writ\_served\_month

</th>

<th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;">

writ\_served\_day

</th>

<th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;">

writ\_served\_year

</th>

</tr>

</thead>

<tbody>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-002489

</td>

<td style="text-align:left;">

2020-01-15

</td>

<td style="text-align:left;">

2020-04-21

</td>

<td style="text-align:left;">

04

</td>

<td style="text-align:left;">

21

</td>

<td style="text-align:left;">

2020

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-003248

</td>

<td style="text-align:left;">

2020-01-17

</td>

<td style="text-align:left;">

2020-05-12

</td>

<td style="text-align:left;">

05

</td>

<td style="text-align:left;">

12

</td>

<td style="text-align:left;">

2020

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-009832

</td>

<td style="text-align:left;">

2020-02-14

</td>

<td style="text-align:left;">

2020-04-03

</td>

<td style="text-align:left;">

04

</td>

<td style="text-align:left;">

03

</td>

<td style="text-align:left;">

2020

</td>

<td style="text-align:left;">

2020-03-04

</td>

<td style="text-align:left;">

03

</td>

<td style="text-align:left;">

04

</td>

<td style="text-align:left;">

2020

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-008297

</td>

<td style="text-align:left;">

2020-02-11

</td>

<td style="text-align:left;">

2020-05-19

</td>

<td style="text-align:left;">

05

</td>

<td style="text-align:left;">

19

</td>

<td style="text-align:left;">

2020

</td>

<td style="text-align:left;">

2020-02-25

</td>

<td style="text-align:left;">

02

</td>

<td style="text-align:left;">

25

</td>

<td style="text-align:left;">

2020

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-010603

</td>

<td style="text-align:left;">

2020-02-20

</td>

<td style="text-align:left;">

2020-05-20

</td>

<td style="text-align:left;">

05

</td>

<td style="text-align:left;">

20

</td>

<td style="text-align:left;">

2020

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-010773

</td>

<td style="text-align:left;">

2020-02-20

</td>

<td style="text-align:left;">

2020-05-20

</td>

<td style="text-align:left;">

05

</td>

<td style="text-align:left;">

20

</td>

<td style="text-align:left;">

2020

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-010485

</td>

<td style="text-align:left;">

2020-02-19

</td>

<td style="text-align:left;">

2020-05-14

</td>

<td style="text-align:left;">

05

</td>

<td style="text-align:left;">

14

</td>

<td style="text-align:left;">

2020

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-013546

</td>

<td style="text-align:left;">

2020-02-28

</td>

<td style="text-align:left;">

2020-04-03

</td>

<td style="text-align:left;">

04

</td>

<td style="text-align:left;">

03

</td>

<td style="text-align:left;">

2020

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-013127

</td>

<td style="text-align:left;">

2020-02-27

</td>

<td style="text-align:left;">

2020-04-06

</td>

<td style="text-align:left;">

04

</td>

<td style="text-align:left;">

06

</td>

<td style="text-align:left;">

2020

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-012503

</td>

<td style="text-align:left;">

2020-02-27

</td>

<td style="text-align:left;">

2020-05-05

</td>

<td style="text-align:left;">

05

</td>

<td style="text-align:left;">

05

</td>

<td style="text-align:left;">

2020

</td>

<td style="text-align:left;">

2020-03-11

</td>

<td style="text-align:left;">

03

</td>

<td style="text-align:left;">

11

</td>

<td style="text-align:left;">

2020

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-012509

</td>

<td style="text-align:left;">

2020-02-27

</td>

<td style="text-align:left;">

2020-04-09

</td>

<td style="text-align:left;">

04

</td>

<td style="text-align:left;">

09

</td>

<td style="text-align:left;">

2020

</td>

<td style="text-align:left;">

2020-03-03

</td>

<td style="text-align:left;">

03

</td>

<td style="text-align:left;">

03

</td>

<td style="text-align:left;">

2020

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-012058

</td>

<td style="text-align:left;">

2020-02-24

</td>

<td style="text-align:left;">

2020-04-08

</td>

<td style="text-align:left;">

04

</td>

<td style="text-align:left;">

08

</td>

<td style="text-align:left;">

2020

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-012129

</td>

<td style="text-align:left;">

2020-02-24

</td>

<td style="text-align:left;">

2020-04-03

</td>

<td style="text-align:left;">

04

</td>

<td style="text-align:left;">

03

</td>

<td style="text-align:left;">

2020

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-012142

</td>

<td style="text-align:left;">

2020-02-24

</td>

<td style="text-align:left;">

2020-04-06

</td>

<td style="text-align:left;">

04

</td>

<td style="text-align:left;">

06

</td>

<td style="text-align:left;">

2020

</td>

<td style="text-align:left;">

2020-03-11

</td>

<td style="text-align:left;">

03

</td>

<td style="text-align:left;">

11

</td>

<td style="text-align:left;">

2020

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-012224

</td>

<td style="text-align:left;">

2020-02-24

</td>

<td style="text-align:left;">

2020-04-06

</td>

<td style="text-align:left;">

04

</td>

<td style="text-align:left;">

06

</td>

<td style="text-align:left;">

2020

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-017105

</td>

<td style="text-align:left;">

2020-03-13

</td>

<td style="text-align:left;">

2020-04-06

</td>

<td style="text-align:left;">

04

</td>

<td style="text-align:left;">

06

</td>

<td style="text-align:left;">

2020

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-016461

</td>

<td style="text-align:left;">

2020-03-12

</td>

<td style="text-align:left;">

2020-04-23

</td>

<td style="text-align:left;">

04

</td>

<td style="text-align:left;">

23

</td>

<td style="text-align:left;">

2020

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-016463

</td>

<td style="text-align:left;">

2020-03-12

</td>

<td style="text-align:left;">

2020-04-06

</td>

<td style="text-align:left;">

04

</td>

<td style="text-align:left;">

06

</td>

<td style="text-align:left;">

2020

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-016897

</td>

<td style="text-align:left;">

2020-03-11

</td>

<td style="text-align:left;">

2020-04-03

</td>

<td style="text-align:left;">

04

</td>

<td style="text-align:left;">

03

</td>

<td style="text-align:left;">

2020

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-016576

</td>

<td style="text-align:left;">

2020-03-10

</td>

<td style="text-align:left;">

2020-04-03

</td>

<td style="text-align:left;">

04

</td>

<td style="text-align:left;">

03

</td>

<td style="text-align:left;">

2020

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-014818

</td>

<td style="text-align:left;">

2020-03-09

</td>

<td style="text-align:left;">

2020-04-22

</td>

<td style="text-align:left;">

04

</td>

<td style="text-align:left;">

22

</td>

<td style="text-align:left;">

2020

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-015429

</td>

<td style="text-align:left;">

2020-03-09

</td>

<td style="text-align:left;">

2020-04-07

</td>

<td style="text-align:left;">

04

</td>

<td style="text-align:left;">

07

</td>

<td style="text-align:left;">

2020

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-015313

</td>

<td style="text-align:left;">

2020-03-06

</td>

<td style="text-align:left;">

2020-05-13

</td>

<td style="text-align:left;">

05

</td>

<td style="text-align:left;">

13

</td>

<td style="text-align:left;">

2020

</td>

<td style="text-align:left;">

2020-03-16

</td>

<td style="text-align:left;">

03

</td>

<td style="text-align:left;">

16

</td>

<td style="text-align:left;">

2020

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-015200

</td>

<td style="text-align:left;">

2020-03-06

</td>

<td style="text-align:left;">

2020-04-20

</td>

<td style="text-align:left;">

04

</td>

<td style="text-align:left;">

20

</td>

<td style="text-align:left;">

2020

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-014992

</td>

<td style="text-align:left;">

2020-03-05

</td>

<td style="text-align:left;">

2020-04-07

</td>

<td style="text-align:left;">

04

</td>

<td style="text-align:left;">

07

</td>

<td style="text-align:left;">

2020

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-013727

</td>

<td style="text-align:left;">

2020-03-02

</td>

<td style="text-align:left;">

2020-05-20

</td>

<td style="text-align:left;">

05

</td>

<td style="text-align:left;">

20

</td>

<td style="text-align:left;">

2020

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-020870

</td>

<td style="text-align:left;">

2020-03-30

</td>

<td style="text-align:left;">

2020-04-21

</td>

<td style="text-align:left;">

04

</td>

<td style="text-align:left;">

21

</td>

<td style="text-align:left;">

2020

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-020938

</td>

<td style="text-align:left;">

2020-03-27

</td>

<td style="text-align:left;">

2020-05-05

</td>

<td style="text-align:left;">

05

</td>

<td style="text-align:left;">

05

</td>

<td style="text-align:left;">

2020

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-021104

</td>

<td style="text-align:left;">

2020-03-27

</td>

<td style="text-align:left;">

2020-05-13

</td>

<td style="text-align:left;">

05

</td>

<td style="text-align:left;">

13

</td>

<td style="text-align:left;">

2020

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-020554

</td>

<td style="text-align:left;">

2020-03-27

</td>

<td style="text-align:left;">

2020-04-15

</td>

<td style="text-align:left;">

04

</td>

<td style="text-align:left;">

15

</td>

<td style="text-align:left;">

2020

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-ca-002669

</td>

<td style="text-align:left;">

2020-03-20

</td>

<td style="text-align:left;">

2020-04-27

</td>

<td style="text-align:left;">

04

</td>

<td style="text-align:left;">

27

</td>

<td style="text-align:left;">

2020

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-019511

</td>

<td style="text-align:left;">

2020-03-20

</td>

<td style="text-align:left;">

2020-04-07

</td>

<td style="text-align:left;">

04

</td>

<td style="text-align:left;">

07

</td>

<td style="text-align:left;">

2020

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-019196

</td>

<td style="text-align:left;">

2020-03-19

</td>

<td style="text-align:left;">

2020-04-03

</td>

<td style="text-align:left;">

04

</td>

<td style="text-align:left;">

03

</td>

<td style="text-align:left;">

2020

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-018792

</td>

<td style="text-align:left;">

2020-03-18

</td>

<td style="text-align:left;">

2020-04-03

</td>

<td style="text-align:left;">

04

</td>

<td style="text-align:left;">

03

</td>

<td style="text-align:left;">

2020

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-018796

</td>

<td style="text-align:left;">

2020-03-18

</td>

<td style="text-align:left;">

2020-04-03

</td>

<td style="text-align:left;">

04

</td>

<td style="text-align:left;">

03

</td>

<td style="text-align:left;">

2020

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-018857

</td>

<td style="text-align:left;">

2020-03-18

</td>

<td style="text-align:left;">

2020-04-06

</td>

<td style="text-align:left;">

04

</td>

<td style="text-align:left;">

06

</td>

<td style="text-align:left;">

2020

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-018780

</td>

<td style="text-align:left;">

2020-03-18

</td>

<td style="text-align:left;">

2020-04-03

</td>

<td style="text-align:left;">

04

</td>

<td style="text-align:left;">

03

</td>

<td style="text-align:left;">

2020

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-018504

</td>

<td style="text-align:left;">

2020-03-17

</td>

<td style="text-align:left;">

2020-04-03

</td>

<td style="text-align:left;">

04

</td>

<td style="text-align:left;">

03

</td>

<td style="text-align:left;">

2020

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-018511

</td>

<td style="text-align:left;">

2020-03-17

</td>

<td style="text-align:left;">

2020-04-03

</td>

<td style="text-align:left;">

04

</td>

<td style="text-align:left;">

03

</td>

<td style="text-align:left;">

2020

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-018549

</td>

<td style="text-align:left;">

2020-03-17

</td>

<td style="text-align:left;">

2020-04-03

</td>

<td style="text-align:left;">

04

</td>

<td style="text-align:left;">

03

</td>

<td style="text-align:left;">

2020

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-018564

</td>

<td style="text-align:left;">

2020-03-17

</td>

<td style="text-align:left;">

2020-04-03

</td>

<td style="text-align:left;">

04

</td>

<td style="text-align:left;">

03

</td>

<td style="text-align:left;">

2020

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-018272

</td>

<td style="text-align:left;">

2020-03-16

</td>

<td style="text-align:left;">

2020-04-03

</td>

<td style="text-align:left;">

04

</td>

<td style="text-align:left;">

03

</td>

<td style="text-align:left;">

2020

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-018277

</td>

<td style="text-align:left;">

2020-03-16

</td>

<td style="text-align:left;">

2020-04-03

</td>

<td style="text-align:left;">

04

</td>

<td style="text-align:left;">

03

</td>

<td style="text-align:left;">

2020

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-018298

</td>

<td style="text-align:left;">

2020-03-16

</td>

<td style="text-align:left;">

2020-06-08

</td>

<td style="text-align:left;">

06

</td>

<td style="text-align:left;">

08

</td>

<td style="text-align:left;">

2020

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-026509

</td>

<td style="text-align:left;">

2020-04-24

</td>

<td style="text-align:left;">

2020-05-12

</td>

<td style="text-align:left;">

05

</td>

<td style="text-align:left;">

12

</td>

<td style="text-align:left;">

2020

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-025254

</td>

<td style="text-align:left;">

2020-04-17

</td>

<td style="text-align:left;">

2020-05-12

</td>

<td style="text-align:left;">

05

</td>

<td style="text-align:left;">

12

</td>

<td style="text-align:left;">

2020

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-023838

</td>

<td style="text-align:left;">

2020-04-10

</td>

<td style="text-align:left;">

2020-05-13

</td>

<td style="text-align:left;">

05

</td>

<td style="text-align:left;">

13

</td>

<td style="text-align:left;">

2020

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-023208

</td>

<td style="text-align:left;">

2020-04-08

</td>

<td style="text-align:left;">

2020-04-23

</td>

<td style="text-align:left;">

04

</td>

<td style="text-align:left;">

23

</td>

<td style="text-align:left;">

2020

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-022429

</td>

<td style="text-align:left;">

2020-04-03

</td>

<td style="text-align:left;">

2020-05-21

</td>

<td style="text-align:left;">

05

</td>

<td style="text-align:left;">

21

</td>

<td style="text-align:left;">

2020

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-028126

</td>

<td style="text-align:left;">

2020-05-04

</td>

<td style="text-align:left;">

2020-06-01

</td>

<td style="text-align:left;">

06

</td>

<td style="text-align:left;">

01

</td>

<td style="text-align:left;">

2020

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-027908

</td>

<td style="text-align:left;">

2020-05-01

</td>

<td style="text-align:left;">

2020-06-08

</td>

<td style="text-align:left;">

06

</td>

<td style="text-align:left;">

08

</td>

<td style="text-align:left;">

2020

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

<td style="text-align:left;">

NA

</td>

</tr>

</tbody>

</table>

</div>

**Writs served:**

``` r
# Check whether we have any 'writs served' data for state
writ_data %>%
  # Only places in FL
  filter(str_detect(location, "_fl")) %>%
  # Not no_information or NA
  filter((!is.na(writ_served_date))&(writ_served_date != "no_information")) %>%
  group_by(location) %>%
  count()
```

    ## # A tibble: 1 x 2
    ## # Groups:   location [1]
    ##   location            n
    ##   <chr>           <int>
    ## 1 hillsborough_fl   626

``` r
## If we do...

# See how many writs have been served since moratorium
writ_data %>%
  # Only places in FL
  filter(str_detect(location, "_fl")) %>%
  # Not no_information or NA
  filter((!is.na(writ_served_date))&(writ_served_date != "no_information")) %>%
  # Since April 2
  filter(writ_date > "2020-04-02") %>%
  group_by(location) %>%
  count()
```

    ## # A tibble: 1 x 2
    ## # Groups:   location [1]
    ##   location            n
    ##   <chr>           <int>
    ## 1 hillsborough_fl     6

``` r
# See which writs have been served since moratorium
kable(writ_data %>%
  # Only places in FL
  filter(str_detect(location, "_fl")) %>%
  # Not no_information or NA
  filter((!is.na(writ_served_date))&(writ_served_date != "no_information")) %>%
  # Since April 2
  filter(writ_date > "2020-04-02")) %>%
  kable_styling(bootstrap_options = c("striped", "hover", "condensed", full_width = FALSE))
```

<table class="table table-striped table-hover table-condensed" style="margin-left: auto; margin-right: auto;">

<thead>

<tr>

<th style="text-align:left;">

location

</th>

<th style="text-align:left;">

case\_number

</th>

<th style="text-align:left;">

file\_date

</th>

<th style="text-align:left;">

writ\_date

</th>

<th style="text-align:left;">

writ\_month

</th>

<th style="text-align:left;">

writ\_day

</th>

<th style="text-align:left;">

writ\_year

</th>

<th style="text-align:left;">

writ\_served\_date

</th>

<th style="text-align:left;">

writ\_served\_month

</th>

<th style="text-align:left;">

writ\_served\_day

</th>

<th style="text-align:left;">

writ\_served\_year

</th>

</tr>

</thead>

<tbody>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-009832

</td>

<td style="text-align:left;">

2020-02-14

</td>

<td style="text-align:left;">

2020-04-03

</td>

<td style="text-align:left;">

04

</td>

<td style="text-align:left;">

03

</td>

<td style="text-align:left;">

2020

</td>

<td style="text-align:left;">

2020-03-04

</td>

<td style="text-align:left;">

03

</td>

<td style="text-align:left;">

04

</td>

<td style="text-align:left;">

2020

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-008297

</td>

<td style="text-align:left;">

2020-02-11

</td>

<td style="text-align:left;">

2020-05-19

</td>

<td style="text-align:left;">

05

</td>

<td style="text-align:left;">

19

</td>

<td style="text-align:left;">

2020

</td>

<td style="text-align:left;">

2020-02-25

</td>

<td style="text-align:left;">

02

</td>

<td style="text-align:left;">

25

</td>

<td style="text-align:left;">

2020

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-012503

</td>

<td style="text-align:left;">

2020-02-27

</td>

<td style="text-align:left;">

2020-05-05

</td>

<td style="text-align:left;">

05

</td>

<td style="text-align:left;">

05

</td>

<td style="text-align:left;">

2020

</td>

<td style="text-align:left;">

2020-03-11

</td>

<td style="text-align:left;">

03

</td>

<td style="text-align:left;">

11

</td>

<td style="text-align:left;">

2020

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-012509

</td>

<td style="text-align:left;">

2020-02-27

</td>

<td style="text-align:left;">

2020-04-09

</td>

<td style="text-align:left;">

04

</td>

<td style="text-align:left;">

09

</td>

<td style="text-align:left;">

2020

</td>

<td style="text-align:left;">

2020-03-03

</td>

<td style="text-align:left;">

03

</td>

<td style="text-align:left;">

03

</td>

<td style="text-align:left;">

2020

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-012142

</td>

<td style="text-align:left;">

2020-02-24

</td>

<td style="text-align:left;">

2020-04-06

</td>

<td style="text-align:left;">

04

</td>

<td style="text-align:left;">

06

</td>

<td style="text-align:left;">

2020

</td>

<td style="text-align:left;">

2020-03-11

</td>

<td style="text-align:left;">

03

</td>

<td style="text-align:left;">

11

</td>

<td style="text-align:left;">

2020

</td>

</tr>

<tr>

<td style="text-align:left;">

hillsborough\_fl

</td>

<td style="text-align:left;">

20-cc-015313

</td>

<td style="text-align:left;">

2020-03-06

</td>

<td style="text-align:left;">

2020-05-13

</td>

<td style="text-align:left;">

05

</td>

<td style="text-align:left;">

13

</td>

<td style="text-align:left;">

2020

</td>

<td style="text-align:left;">

2020-03-16

</td>

<td style="text-align:left;">

03

</td>

<td style="text-align:left;">

16

</td>

<td style="text-align:left;">

2020

</td>

</tr>

</tbody>

</table>

#### Georgia

**Moratorium Bottom Line**

  - Began: March 14 (varies)
  - Still in effect: No
  - Expires: April 13 (varies)
  - Covers: Only applies directly to eviction cases in certain
    jurisdictions

**State Summary**

  - Georgia’s Supreme Court has issued guidance that courts are to
    prioritize essential functions from March 14, 2020 to April 13th,
    2020 and conduct video proceedings wherever possible.
  - Each circuit, municipal and magistrate court had a slightly
    different version and date range for adopting this ruling.

##### Eviction Filings

``` r
# View which locations within state we have data for
kable(evictions_data %>%
  filter(str_detect(location, "_ga")) %>%
  group_by(location) %>%
  count()) %>%
  kable_styling(bootstrap_options = c("striped", "hover", "condensed", full_width = FALSE))
```

<table class="table table-striped table-hover table-condensed" style="margin-left: auto; margin-right: auto;">

<thead>

<tr>

<th style="text-align:left;">

location

</th>

<th style="text-align:right;">

n

</th>

</tr>

</thead>

<tbody>

<tr>

<td style="text-align:left;">

chatham\_ga

</td>

<td style="text-align:right;">

2925

</td>

</tr>

<tr>

<td style="text-align:left;">

dekalb\_ga

</td>

<td style="text-align:right;">

9095

</td>

</tr>

<tr>

<td style="text-align:left;">

fulton\_ga

</td>

<td style="text-align:right;">

10866

</td>

</tr>

</tbody>

</table>

``` r
# View number of evictions since moratorium
kable(evictions_data %>%
  # Only places in FL
  filter(str_detect(location, "_ga")) %>%
  # Since April 2
  filter(file_date > "2020-03-14") %>%
  group_by(location) %>%
  count()) %>%
  kable_styling(bootstrap_options = c("striped", "hover", "condensed", full_width = FALSE))
```

<table class="table table-striped table-hover table-condensed" style="margin-left: auto; margin-right: auto;">

<thead>

<tr>

<th style="text-align:left;">

location

</th>

<th style="text-align:right;">

n

</th>

</tr>

</thead>

<tbody>

<tr>

<td style="text-align:left;">

chatham\_ga

</td>

<td style="text-align:right;">

593

</td>

</tr>

<tr>

<td style="text-align:left;">

dekalb\_ga

</td>

<td style="text-align:right;">

1635

</td>

</tr>

<tr>

<td style="text-align:left;">

fulton\_ga

</td>

<td style="text-align:right;">

2160

</td>

</tr>

</tbody>

</table>

``` r
## Break it down by location

# Chatham
# evictions_data %>%
#   # Only places in chatham_ga
#   filter(location == "chatham_ga") %>%
#   # Since DATE RELEVANT TO CHATHAM
#   filter(file_date > "??")
```

##### Writs Filed and Served

**Writs filed:**

``` r
# Check whether we have any 'writs filed' data for state
writ_data %>%
  # Only places in FL
  filter(str_detect(location, "_ga")) %>%
  # Not no_information or NA
  filter((!is.na(writ_date))&(writ_date != "no_information")) %>%
  group_by(location) %>%
  count()
```

    ## # A tibble: 1 x 2
    ## # Groups:   location [1]
    ##   location      n
    ##   <chr>     <int>
    ## 1 fulton_ga  1249

``` r
## If we do...

# See how many writs have been filed since moratorium

# See which writs have been filed since moratorium
```

**Writs served:**

``` r
# Check whether we have any 'writ served' data for state

## If we do...

# See how many writs have been served since moratorium

# See which writs have been served since moratorium
```

### TEMPLATE for state-by-state

#### \[Replace with state name\]

**Moratorium Bottom Line**

  - Began:
  - Still in effect:  
  - Expires:
  - Covers:

**State Summary**

Replace with summary text from [Moratoria by
State](https://docs.google.com/spreadsheets/u/1/d/e/2PACX-1vTH8dUIbfnt3X52TrY3dEHQCAm60e5nqo0Rn1rNCf15dPGeXxM9QN9UdxUfEjxwvfTKzbCbZxJMdR7X/pubhtml)

##### Eviction Filings

``` r
# View which locations within state we have data for

# View TOTAL number of evictions since moratorium by location

## Break it down by location

# View eviction cases since [location1]'s moratorium
# View eviction cases since [location2]'s moratorium
# etc.
```

##### Writs Filed and Served

**Writs filed:**

``` r
# Check whether we have any 'writs filed' data for state

## If we do...

# See how many writs have been filed since moratorium

# See which writs have been filed since moratorium
```

**Writs served:**

``` r
# Check whether we have any 'writs served' data for state

## If we do...

# See how many writs have been served since moratorium

# See which writs have been served since moratorium
```
