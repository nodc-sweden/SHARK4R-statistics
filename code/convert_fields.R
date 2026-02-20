# Convert fields.R to fields.rds
#
# Run this script after editing fields.R to regenerate the .rds file.
# Both files should be committed to the SHARK4R-statistics repository
# under the fields/ directory.
#
# Usage:
#   Rscript convert_fields.R

env <- new.env(parent = baseenv())
sys.source("fields/fields.R", envir = env)

if (!exists(".field_definitions", envir = env)) {
  stop("fields.R must define an object named '.field_definitions'.")
}

defs <- get(".field_definitions", envir = env)
saveRDS(defs, "fields.rds")

message("Converted fields.R -> fields.rds (", length(defs), " datatypes, ",
        file.size("fields.rds"), " bytes)")
