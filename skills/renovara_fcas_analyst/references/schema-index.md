# Schema Index

Use this file to decide which YAML to open before writing SQL. Do not load every schema file by default.

## Query Discovery

1. Identify the business question.
2. Open the matching YAML file below.
3. Write the first query from the bundled YAML schema.
4. Use `DESCRIBE TABLE` only if the query errors, the object is live-only, or the YAML does not cover it.
5. Query the fully qualified table in `external_data.nemweb`.

If the YAML and live table differ after error-driven inspection:
- Trust live Databricks for table existence, column names, and types.
- Trust YAML for business meaning, comments, and `display_name`.

## Core Files

- [`knowledge/dispatch_price.yaml`](knowledge/dispatch_price.yaml)
  DISPATCHPRICE records 5-minute dispatch prices for energy and FCAS, including whether an intervention has occurred, or price override (e.g.
  Expected live table: `external_data.nemweb.silver_dispatchis_reports_dispatch_price`

- [`knowledge/dispatch_unit_solution.yaml`](knowledge/dispatch_unit_solution.yaml)
  DISPATCHLOAD set out the current SCADA MW and target MW for each dispatchable unit, including relevant Frequency Control Ancillary Services (FCAS) enabling targets for each five minutes and additional fields to handle the new Ancillary Services functionality.
  Expected live table: `external_data.nemweb.silver_next_day_dispatch_dispatch_unit_solution`

- [`knowledge/nem_participant_and_scheduled_loads.yaml`](knowledge/nem_participant_and_scheduled_loads.yaml)
  Production Units (PU) and Scheduled Loads — all registered Production Units and Scheduled Loads with their classifications and key metadata.
  Expected live table: `external_data.nemweb.silver_nem_participant_and_scheduled_loads`
