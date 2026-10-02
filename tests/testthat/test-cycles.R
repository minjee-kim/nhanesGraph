test_that("years map onto current public cycles", {
  expect_equal(resolve_cycle(2008)$cycle, "2007-2008")
  expect_equal(resolve_cycle("2008")$cycle, "2007-2008")
  expect_equal(resolve_cycle("2007-2008")$cycle, "2007-2008")
  expect_equal(resolve_cycle(2017)$cycle, "2017-2018")
  expect_equal(resolve_cycle(2019)$cycle, "2017-2020")
  expect_equal(resolve_cycle(2020)$cycle, "2017-2020")
  expect_equal(resolve_cycle(2022)$cycle, "2021-2023")
  expect_equal(resolve_cycle("2021-2023")$cycle, "2021-2023")
  expect_error(resolve_cycle(1990), "1999")
  expect_error(resolve_cycle(2024), "2023")
})

test_that("short file names pick up the cycle suffix or prefix", {
  expect_equal(resolve_file_name("EPH", resolve_cycle(2008)), "EPH_E")
  expect_equal(resolve_file_name("DEMO", resolve_cycle("2021-2023")), "DEMO_L")
  expect_equal(resolve_file_name("DEMO", resolve_cycle("2017-2020")), "P_DEMO")
  expect_equal(resolve_file_name("DEMO_L", resolve_cycle(2022)), "DEMO_L")
})

test_that("the catalog includes the latest public cycle", {
  files <- nhanes_files()
  expect_true("2021-2023" %in% files$cycle)
  expect_true("DEMO_L" %in% files$data_file_name)
  expect_true("2017-2020" %in% files$cycle)
  expect_true("P_DEMO" %in% files$data_file_name)
  expect_true(nrow(files) > 1000)
})
