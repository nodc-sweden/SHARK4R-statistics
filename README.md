# SHARK4R Statistics

This repository contains configuration fields and precomputed statistical values used in the [`SHARK4R`](https://github.com/sharksmhi/SHARK4R) quality control framework.  
These statistics are primarily intended for automated outlier detection and threshold-based quality control of SHARK-formatted marine monitoring data.

---

## Repository Structure

- **`code/`** — Scripts to update or generate statistics directly from SHARK.
- **`fields/`** — Configuration data for defining recommended and required fields.
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

## Update or regenerate statistics

You can update the `.rds` files directly from SHARK using the `code/calculate_statistics.R` script.
