# Data Warehouse — Part 3

# ETL Decisions

## Decision 1 — Standardizing inconsistent date formats

#Problem:** The `date` column in `retail_transactions.csv` contained three different formats across rows: `DD/MM/YYYY` (e.g. `29/08/2023`), `DD-MM-YYYY` (e.g. `12-12-2023`), and `YYYY-MM-DD` (e.g. `2023-02-05`). Mixing these formats would cause incorrect sorting and grouping in time-based queries, and would break date functions in SQL.

**Resolution:** During the ETL process, all date values were parsed by trying each known format in sequence and converting them to the standard `YYYY-MM-DD` ISO format before loading into `dim_date`. This ensures consistent date arithmetic, correct month ordering in Q3 (month-over-month trend), and accurate quarter calculation.

---

### Decision 2 — Normalizing inconsistent category casing

**Problem:** The `category` column contained the same category written in different cases: `electronics` (lowercase), `Electronics` (title case), and `Grocery` (a different word entirely instead of `Groceries`). These inconsistencies would cause GROUP BY queries to treat them as separate categories, splitting results incorrectly — for example Q1 (revenue by category) would show separate rows for `electronics` and `Electronics`.

**Resolution:** All category values were converted to title case and `Grocery` was remapped to `Groceries` to match the standard category name used in the rest of the dataset. The standardized values (`Electronics`, `Clothing`, `Groceries`) were then loaded into `dim_product`.

---

### Decision 3 — Filling NULL values in store_city

**Problem:** The `store_city` column had 19 NULL/empty values across rows. Since `store_city` is a descriptive attribute stored in `dim_store`, loading it with NULLs would make store-level geographic analysis unreliable and break NOT NULL constraints in the warehouse schema.

**Resolution:** A lookup mapping was created from `store_name` to the correct `store_city` (e.g. `Chennai Anna` → `Chennai`, `Delhi South` → `Delhi`). Any row with a missing `store_city` was filled using this mapping before loading into `dim_store`. This approach is safe because store names are consistent across the dataset and each uniquely identifies a city.
