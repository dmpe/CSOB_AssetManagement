[![CRAN_Status_Badge](http://www.r-pkg.org/badges/version/CSOBam)](https://cran.r-project.org/package=CSOBam)
[![Build Status](https://travis-ci.org/dmpe/CSOB_AssetManagement.svg?branch=master)](https://travis-ci.org/dmpe/CSOB_AssetManagement)

# CSOB Asset Management R package

The goal of CSOBam is to be able to download data that are displayed publically on their website. Currently at <https://www.csobam.cz/portal/asset-management/produkty-a-sluzby/aktualni-hodnoty-a-vykonnost>.

## Example

This is a basic example which shows you how to download the first page of funds' performance.

``` r
library(CSOBam)

```


https://www.csobam.cz/portal/asset-management/produkty-a-sluzby/aktualni-hodnoty-a-vykonnost?p_p_id=etnpwfundsoverview_WAR_etnpwfunds_INSTANCE_jXONb9fydlIh&p_p_lifecycle=0&p_p_state=normal&p_p_mode=view&p_p_col_id=column-main&p_p_col_count=2&_etnpwfundsoverview_WAR_etnpwfunds_INSTANCE_jXONb9fydlIh_appState=&_etnpwfundsoverview_WAR_etnpwfunds_INSTANCE_jXONb9fydlIh_action=paginationTable&_etnpwfundsoverview_WAR_etnpwfunds_INSTANCE_jXONb9fydlIh_page=2&_etnpwfundsoverview_WAR_etnpwfunds_INSTANCE_jXONb9fydlIh_execution=e1s1

https://www.csobam.cz/portal/asset-management/produkty-a-sluzby/aktualni-hodnoty-a-vykonnost?p_p_id=etnpwfundsoverview_WAR_etnpwfunds_INSTANCE_jXONb9fydlIh&p_p_lifecycle=0&p_p_state=normal&p_p_mode=view&p_p_col_id=column-main&p_p_col_count=2&_etnpwfundsoverview_WAR_etnpwfunds_INSTANCE_jXONb9fydlIh_appState=&_etnpwfundsoverview_WAR_etnpwfunds_INSTANCE_jXONb9fydlIh_action=paginationTable&_etnpwfundsoverview_WAR_etnpwfunds_INSTANCE_jXONb9fydlIh_page=2&_etnpwfundsoverview_WAR_etnpwfunds_INSTANCE_jXONb9fydlIh_execution=e1s1