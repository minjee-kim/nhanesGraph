test_that("nhanes_table", {
  nhanes_table("2008", "EPH", demographics = T, recode = T)
  nhanes_table(2007,"EPH")
  nhanes_table("2007-2008","EPH")
  nhanes_table("2007","EPH")
})
