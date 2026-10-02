test_that("nhanes_table requires a file name", {
  expect_error(nhanes_table(2008), "file_name")
})
