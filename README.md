# SHARK4R Statistics

This repository contains configuration fields and precomputed statistical values used in the [`SHARK4R`](https://github.com/sharksmhi/SHARK4R) quality control framework.  
These statistics are primarily intended for automated outlier detection and threshold-based quality control of SHARK-formatted marine monitoring data.

---

## Repository Structure

- **`code/`** — Scripts to update or generate statistics and field definitions.
  - `calculate_statistics.R` — Regenerate statistics from SHARK.
  - `convert_fields.R` — Convert `fields/fields.R` to `fields/fields.rds`.
- **`fields/`** — Configuration data for defining recommended and required fields per datatype.
  - `fields.R` — Human-editable field definitions (required/recommended fields for each datatype).
  - `fields.rds` — Serialized R object generated from `fields.R` via `convert_fields.R`.
- **`statistics/`** — Precomputed `.rds` files containing threshold values and summary statistics.

---

## Purpose

The `.rds` files provide **reference threshold values** (e.g., median, quartiles, mild/extreme upper/lower limits) for automated quality control of biological data.  

They can be loaded using `SHARK4R::load_shark4r_stats()`, and used with `SHARK4R` functions such as `SHARK4R::check_outliers()` and `SHARK4R::scatterplot()`.

---

## Usage

### 1. Load precomputed statistics from GitHub

```r
# Load SHARK4R statistics directly from GitHub, grouped by sea basin
stats <- load_shark4r_stats("sea_basin.rds")
```

This downloads the `.rds` file and reads it into R as a tibble/data frame.

---

### 2. Use statistics for outlier detection

The loaded object can be used with `check_outliers()`:

```r
# Example: Check values above "extreme_upper"
check_outliers(
  data = shark_data,
  parameter = "Chlorophyll a",
  datatype = "Mean",
  threshold_col = "extreme_upper",
  thresholds = stats
)

# Example: Check values by group (e.g., location_sea_basin)
check_outliers(
  data = shark_data,
  parameter = "Chlorophyll a",
  datatype = "Mean",
  threshold_col = "mild_upper",
  thresholds = stats,
  custom_group = "location_sea_basin"
)
```

---

## Field Definitions

The `fields/` directory defines **required** and **recommended** fields for each SHARK datatype (e.g., Phytoplankton, Zoobenthos, PhysicalChemical).

Field definitions are maintained in `fields/fields.R` as a named list. After editing, regenerate the `.rds` file:

```bash
Rscript code/convert_fields.R
```

The resulting `fields.rds` contains a list keyed by datatype, where each entry has `required` and `recommended` character vectors. Currently defined datatypes:

Bacterioplankton, Chlorophyll, Epibenthos, EpibenthosDropvideo, GreySeal, HarbourPorpoise, HarbourSeal, PhysicalChemical, Phytoplankton, Picoplankton, PrimaryProduction, RingedSeal, SealPathology, Sedimentation, Zoobenthos, Zooplankton.

---

## Update or regenerate statistics

You can update the `.rds` files directly from SHARK using the `code/calculate_statistics.R` script.
