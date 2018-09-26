context("Tests a variety of funds and whether they can be downloaded")

library(CSOBam)


test_that("we can download funds from the first page", {
  df <- managed_funds(pages_to_scrap = 1, funds_to_scrap = NULL)
})

test_that("we can download funds from 5 pages", {
  df <- managed_funds(pages_to_scrap = 5, funds_to_scrap = NULL)
})

test_that("we can download funds from all pages", {
  df <- managed_funds(pages_to_scrap = "ALL", funds_to_scrap = NULL)
})

