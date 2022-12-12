test_that("nhanes_viz", {
  nhanes_viz(graph_type = "Hist", file_name = "ENX_E", variable = "ENAATMPT")
  nhanes_viz(graph_type = "hist", file_name = "BPX_D", variable = "BPXSY2")
})
