test_that("nhanes_viz requires a file and a variable", {
  expect_error(nhanes_viz(), "file_name")
})
