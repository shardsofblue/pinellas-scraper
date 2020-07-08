Initial Evictions Analysis
================
Roxanne Ready
7/8/2020

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
```

### Load & Prepare Data

``` r
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

    ## Warning: Expected 3 pieces. Missing pieces filled with `NA` in 21125 rows [1, 2,
    ## 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, ...].

    ## Warning: Expected 3 pieces. Missing pieces filled with `NA` in 22896 rows [1, 2,
    ## 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, ...].

## Analysis

### All of 2020

#### Evictions

``` r
# Number of evictions, total (51,802)
evictions_data %>%
  count() %>%
  arrange(desc(n))
```

    ## # A tibble: 1 x 1
    ##       n
    ##   <int>
    ## 1 51802

``` r
# Number of evictions, by location, total
evictions_data %>%
  group_by(location) %>%
  count() %>%
  arrange(desc(n))
```

    ## # A tibble: 12 x 2
    ## # Groups:   location [12]
    ##    location            n
    ##    <chr>           <int>
    ##  1 fulton_ga       10866
    ##  2 dekalb_ga        9095
    ##  3 shelby_tn        7785
    ##  4 oklahomacity_ok  4453
    ##  5 milwaukee_wi     4384
    ##  6 tulsa_ok         4113
    ##  7 hillsborough_fl  3460
    ##  8 chatham_ga       2925
    ##  9 pinellas_fl      1669
    ## 10 toledo_oh        1499
    ## 11 neworleans_la    1117
    ## 12 stlouis_mo        436

``` r
# Number of evictions, by month, total
evictions_data %>% 
  group_by(file_month) %>%
  count()
```

    ## # A tibble: 9 x 2
    ## # Groups:   file_month [9]
    ##   file_month     n
    ##        <dbl> <int>
    ## 1          1 16321
    ## 2          2 15860
    ## 3          3 10093
    ## 4          4  1622
    ## 5          5  2848
    ## 6          6  4865
    ## 7          7    76
    ## 8         12     1
    ## 9         NA   116

``` r
# Number of evictions, by month and location, total
evictions_data %>% 
  group_by(location, file_month) %>%
  count()
```

    ## # A tibble: 77 x 3
    ## # Groups:   location, file_month [77]
    ##    location   file_month     n
    ##    <chr>           <dbl> <int>
    ##  1 chatham_ga          1  1042
    ##  2 chatham_ga          2   945
    ##  3 chatham_ga          3   498
    ##  4 chatham_ga          4    69
    ##  5 chatham_ga          5   122
    ##  6 chatham_ga          6   238
    ##  7 chatham_ga          7    11
    ##  8 dekalb_ga           1  3194
    ##  9 dekalb_ga           2  3006
    ## 10 dekalb_ga           3  1913
    ## # … with 67 more rows

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
evictions_data %>% 
  filter(writ_date == "no_information") %>%
  group_by(location, writ_date) %>%
  count()
```

    ## # A tibble: 7 x 3
    ## # Groups:   location, writ_date [7]
    ##   location      writ_date          n
    ##   <chr>         <chr>          <int>
    ## 1 chatham_ga    no_information  2925
    ## 2 dekalb_ga     no_information  9095
    ## 3 milwaukee_wi  no_information  4384
    ## 4 neworleans_la no_information  1117
    ## 5 pinellas_fl   no_information  1669
    ## 6 stlouis_mo    no_information   436
    ## 7 toledo_oh     no_information  1499

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
evictions_data %>% 
  filter(writ_served_date == "no_information") %>%
  group_by(location, writ_served_date) %>%
  count()
```

    ## # A tibble: 7 x 3
    ## # Groups:   location, writ_served_date [7]
    ##   location      writ_served_date     n
    ##   <chr>         <chr>            <int>
    ## 1 chatham_ga    no_information    2925
    ## 2 fulton_ga     no_information   10866
    ## 3 milwaukee_wi  no_information    4384
    ## 4 neworleans_la no_information    1117
    ## 5 pinellas_fl   no_information    1669
    ## 6 stlouis_mo    no_information     436
    ## 7 toledo_oh     no_information    1499

``` r
## WRIT COUNTS

# Number of writs FILED, by location
writ_data %>%
  # Filter for cases with writ filing dates
  filter(!(is.na(writ_date))&(writ_date != "no_information")) %>%
  group_by(location) %>%
  count()
```

    ## # A tibble: 4 x 2
    ## # Groups:   location [4]
    ##   location            n
    ##   <chr>           <int>
    ## 1 fulton_ga        1249
    ## 2 hillsborough_fl  1082
    ## 3 oklahomacity_ok  1215
    ## 4 shelby_tn        1074

``` r
# Number of writs SERVED, by location
writ_data %>%
  # Filter for cases with writ served dates
  filter(!(is.na(writ_served_date))&(writ_served_date != "no_information")) %>%
  group_by(location) %>%
  count()
```

    ## # A tibble: 4 x 2
    ## # Groups:   location [4]
    ##   location            n
    ##   <chr>           <int>
    ## 1 dekalb_ga        1480
    ## 2 hillsborough_fl   626
    ## 3 oklahomacity_ok  1027
    ## 4 shelby_tn         449

``` r
# Number of writs FILED, by month
writ_data %>%
  # Filter for cases with writ filing dates
  filter(!(is.na(writ_date))&(writ_date != "no_information")) %>%
  group_by(writ_month) %>%
  count()
```

    ## # A tibble: 7 x 2
    ## # Groups:   writ_month [7]
    ##   writ_month     n
    ##   <chr>      <int>
    ## 1 01           493
    ## 2 02          2093
    ## 3 03          1488
    ## 4 04            64
    ## 5 05           177
    ## 6 06           302
    ## 7 07             3

``` r
# Number of writs SERVED, by month
writ_data %>%
  # Filter for cases with writ filing dates
  filter(!(is.na(writ_served_date))&(writ_served_date != "no_information")) %>%
  group_by(writ_served_month) %>%
  count()
```

    ## # A tibble: 6 x 2
    ## # Groups:   writ_served_month [6]
    ##   writ_served_month     n
    ##   <chr>             <int>
    ## 1 01                  252
    ## 2 02                 1426
    ## 3 03                 1158
    ## 4 04                   94
    ## 5 05                  414
    ## 6 06                  238

``` r
# Number of writs FILED, by location and month
writ_data %>%
  # Filter for cases with writ filing dates
  filter(!(is.na(writ_date))&(writ_date != "no_information")) %>%
  group_by(location, writ_month) %>%
  count()
```

    ## # A tibble: 21 x 3
    ## # Groups:   location, writ_month [21]
    ##    location        writ_month     n
    ##    <chr>           <chr>      <int>
    ##  1 fulton_ga       01            69
    ##  2 fulton_ga       02           771
    ##  3 fulton_ga       03           408
    ##  4 fulton_ga       06             1
    ##  5 hillsborough_fl 01            79
    ##  6 hillsborough_fl 02           510
    ##  7 hillsborough_fl 03           413
    ##  8 hillsborough_fl 04            63
    ##  9 hillsborough_fl 05            14
    ## 10 hillsborough_fl 06             3
    ## # … with 11 more rows

``` r
# Number of writs SERVED, by location and month
writ_data %>%
  # Filter for cases with writ filing dates
  filter(!(is.na(writ_served_date))&(writ_served_date != "no_information")) %>%
  group_by(location, writ_served_month) %>%
  count()
```

    ## # A tibble: 23 x 3
    ## # Groups:   location, writ_served_month [23]
    ##    location        writ_served_month     n
    ##    <chr>           <chr>             <int>
    ##  1 dekalb_ga       01                   28
    ##  2 dekalb_ga       02                  743
    ##  3 dekalb_ga       03                  418
    ##  4 dekalb_ga       05                  278
    ##  5 dekalb_ga       06                   13
    ##  6 hillsborough_fl 01                   29
    ##  7 hillsborough_fl 02                  249
    ##  8 hillsborough_fl 03                  328
    ##  9 hillsborough_fl 04                    5
    ## 10 hillsborough_fl 05                   11
    ## # … with 13 more rows

### Since CARES Act (March 27)

#### Evictions

``` r
# Number of evictions, since Cares (9,672)
evictions_data %>%
  filter(file_date > "2020-03-27") %>%
  # group_by(location) %>%
  count() %>%
  arrange(desc(n))
```

    ## # A tibble: 1 x 1
    ##       n
    ##   <int>
    ## 1  9672

``` r
# Number of evictions, by location, since Cares
evictions_data %>%
  filter(file_date > "2020-03-27") %>%
  group_by(location) %>%
  count() %>%
  arrange(desc(n))
```

    ## # A tibble: 12 x 2
    ## # Groups:   location [12]
    ##    location            n
    ##    <chr>           <int>
    ##  1 shelby_tn        1835
    ##  2 milwaukee_wi     1608
    ##  3 fulton_ga        1247
    ##  4 oklahomacity_ok  1193
    ##  5 dekalb_ga        1010
    ##  6 tulsa_ok          804
    ##  7 hillsborough_fl   732
    ##  8 chatham_ga        466
    ##  9 pinellas_fl       295
    ## 10 toledo_oh         279
    ## 11 neworleans_la     128
    ## 12 stlouis_mo         75

``` r
# Number of evictions, by month, since Cares
evictions_data %>% 
  filter(file_date > "2020-03-27") %>%
  group_by(file_month) %>%
  count()
```

    ## # A tibble: 5 x 2
    ## # Groups:   file_month [5]
    ##   file_month     n
    ##        <dbl> <int>
    ## 1          3   261
    ## 2          4  1622
    ## 3          5  2848
    ## 4          6  4865
    ## 5          7    76

``` r
# Number of evictions, by month and location, since Cares
evictions_data %>% 
  filter(file_date > "2020-03-27") %>%
  group_by(location, file_month) %>%
  count()
```

    ## # A tibble: 46 x 3
    ## # Groups:   location, file_month [46]
    ##    location   file_month     n
    ##    <chr>           <dbl> <int>
    ##  1 chatham_ga          3    26
    ##  2 chatham_ga          4    69
    ##  3 chatham_ga          5   122
    ##  4 chatham_ga          6   238
    ##  5 chatham_ga          7    11
    ##  6 dekalb_ga           3    44
    ##  7 dekalb_ga           4   321
    ##  8 dekalb_ga           5   312
    ##  9 dekalb_ga           6   333
    ## 10 fulton_ga           3    45
    ## # … with 36 more rows

``` r
  # arrange(desc(n, location))
```

#### Writs Filed and Served

``` r
## WRIT COUNTS

# Number of writs FILED, by location
writ_data %>%
  # Filter for cases with writ filing dates
  filter(!(is.na(writ_date))&(writ_date != "no_information")) %>%
  # Filter for cases with writs filed after CARES
  filter(writ_date > "2020-03-27") %>%
  group_by(location) %>%
  count()
```

    ## # A tibble: 4 x 2
    ## # Groups:   location [4]
    ##   location            n
    ##   <chr>           <int>
    ## 1 fulton_ga           1
    ## 2 hillsborough_fl   122
    ## 3 oklahomacity_ok   356
    ## 4 shelby_tn         109

``` r
# Number of writs SERVED, by location
writ_data %>%
  # Filter for cases with writ served dates
  filter(!(is.na(writ_served_date))&(writ_served_date != "no_information")) %>%
  # Filter for cases with writs served after CARES
  filter(writ_served_date > "2020-03-27") %>%
  group_by(location) %>%
  count()
```

    ## # A tibble: 4 x 2
    ## # Groups:   location [4]
    ##   location            n
    ##   <chr>           <int>
    ## 1 dekalb_ga         291
    ## 2 hillsborough_fl    20
    ## 3 oklahomacity_ok   262
    ## 4 shelby_tn         174

``` r
# Number of writs FILED, by month
writ_data %>%
  # Filter for cases with writ filing dates
  filter(!(is.na(writ_date))&(writ_date != "no_information")) %>%
  # Filter for cases with writs filed after CARES
  filter(writ_date > "2020-03-27") %>%
  group_by(writ_month) %>%
  count()
```

    ## # A tibble: 5 x 2
    ## # Groups:   writ_month [5]
    ##   writ_month     n
    ##   <chr>      <int>
    ## 1 03            42
    ## 2 04            64
    ## 3 05           177
    ## 4 06           302
    ## 5 07             3

``` r
# Number of writs SERVED, by month
writ_data %>%
  # Filter for cases with writ filing dates
  filter(!(is.na(writ_served_date))&(writ_served_date != "no_information")) %>%
  # Filter for cases with writs served after CARES
  filter(writ_served_date > "2020-03-27") %>%
  group_by(writ_served_month) %>%
  count()
```

    ## # A tibble: 4 x 2
    ## # Groups:   writ_served_month [4]
    ##   writ_served_month     n
    ##   <chr>             <int>
    ## 1 03                    1
    ## 2 04                   94
    ## 3 05                  414
    ## 4 06                  238

``` r
# Number of writs FILED, by location and month
writ_data %>%
  # Filter for cases with writ filing dates
  filter(!(is.na(writ_date))&(writ_date != "no_information")) %>%
  # Filter for cases with writs filed after CARES
  filter(writ_date > "2020-03-27") %>%
  group_by(location, writ_month) %>%
  count()
```

    ## # A tibble: 10 x 3
    ## # Groups:   location, writ_month [10]
    ##    location        writ_month     n
    ##    <chr>           <chr>      <int>
    ##  1 fulton_ga       06             1
    ##  2 hillsborough_fl 03            42
    ##  3 hillsborough_fl 04            63
    ##  4 hillsborough_fl 05            14
    ##  5 hillsborough_fl 06             3
    ##  6 oklahomacity_ok 04             1
    ##  7 oklahomacity_ok 05           163
    ##  8 oklahomacity_ok 06           189
    ##  9 oklahomacity_ok 07             3
    ## 10 shelby_tn       06           109

``` r
# Number of writs SERVED, by location and month
writ_data %>%
  # Filter for cases with writ filing dates
  filter(!(is.na(writ_served_date))&(writ_served_date != "no_information")) %>%
  # Filter for cases with writs served after CARES
  filter(writ_served_date > "2020-03-27") %>%
  group_by(location, writ_served_month) %>%
  count()
```

    ## # A tibble: 12 x 3
    ## # Groups:   location, writ_served_month [12]
    ##    location        writ_served_month     n
    ##    <chr>           <chr>             <int>
    ##  1 dekalb_ga       05                  278
    ##  2 dekalb_ga       06                   13
    ##  3 hillsborough_fl 04                    5
    ##  4 hillsborough_fl 05                   11
    ##  5 hillsborough_fl 06                    4
    ##  6 oklahomacity_ok 03                    1
    ##  7 oklahomacity_ok 04                    4
    ##  8 oklahomacity_ok 05                   81
    ##  9 oklahomacity_ok 06                  176
    ## 10 shelby_tn       04                   85
    ## 11 shelby_tn       05                   44
    ## 12 shelby_tn       06                   45

### Since State-Issued Moratoriums
