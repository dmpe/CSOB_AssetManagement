[![CRAN_Status_Badge](http://www.r-pkg.org/badges/version/CSOBam)](https://cran.r-project.org/package=CSOBam)
[![Build Status](https://travis-ci.org/dmpe/CSOB_AssetManagement.svg?branch=master)](https://travis-ci.org/dmpe/CSOB_AssetManagement)

# CSOB Asset Management R package

The goal of CSOBam is to be able to download data that are displayed publically on their website. Currently at <https://www.csobam.cz/portal/asset-management/produkty-a-sluzby/aktualni-hodnoty-a-vykonnost>.

## Example

This is a basic example which downloads the first page of funds' performance.

``` r
library(CSOBam)
funds <- managed_funds()
```

Downloading other pages have not worked, because you cannot load the content on specific page e.g. 2 without working around "cookies" somehow.
One idea is to load homepage and then extract all JSON ISINs which are passed in some <script></script> tags in HTML.

**Essentially, abandoned for now.**
