library(SHARK4R)

parameter <- get_shark_statistics()
sea_basin <- get_shark_statistics(group_col = "location_sea_basin")
scientific_name <- get_shark_statistics(group_col = "scientific_name")

saveRDS(parameter, file = "data/parameter.rds")
saveRDS(sea_basin, file = "data/sea_basin.rds")
saveRDS(scientific_name, file = "data/scientific_name.rds")
