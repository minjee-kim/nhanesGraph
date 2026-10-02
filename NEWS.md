# nhanesGraph 1.1.0

The package can be installed and used again. CDC retired the XPT paths that RNHANES and this package used (`/Nchs/Nhanes/{cycle}/{file}.XPT` now returns an HTML page). Downloads go to the current public path:

`https://wwwn.cdc.gov/Nchs/Data/Nhanes/Public/{begin_year}/DataFiles/{file}.xpt`

Cycles now run through August 2021-August 2023, and the 2017-March 2020 pre-pandemic files (`P_` prefix) are included. Years 2019 and 2020 map to that pre-pandemic release. Years 2021-2023 map to `DEMO_L` and the other `_L` files.

`nhanes_files()` is a catalog refreshed from the CDC data pages (1,655 files). The Shiny search apps read that catalog instead of the 2022 snapshot and the RNHANES cycle list, which stopped at 2016 in the app text.
