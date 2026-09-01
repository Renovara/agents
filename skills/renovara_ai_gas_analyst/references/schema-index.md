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

- [`knowledge/actual_flow_storage.yaml`](knowledge/actual_flow_storage.yaml)
  AEMO Gas Bulletin Board actual flow and storage.
  Expected live table: `external_data.nemweb.silver_gbb_actual_flow_storage`

- [`knowledge/basins.yaml`](knowledge/basins.yaml)
  AEMO Gas Bulletin Board basins list.
  Expected live table: `external_data.nemweb.silver_gbb_basins`

- [`knowledge/dispatch_price.yaml`](knowledge/dispatch_price.yaml)
  DISPATCHPRICE records 5-minute dispatch prices for energy and FCAS, including whether an intervention has occurred, or price override (e.g.
  Expected live table: `external_data.nemweb.silver_dispatchis_reports_dispatch_price`

- [`knowledge/facilities.yaml`](knowledge/facilities.yaml)
  AEMO Gas Bulletin Board facility register.
  Expected live table: `external_data.nemweb.silver_gbb_facilities`

- [`knowledge/linepack_capacity_adequacy.yaml`](knowledge/linepack_capacity_adequacy.yaml)
  AEMO Gas Bulletin Board Linepack Capacity Adequacy (LCA).
  Expected live table: `external_data.nemweb.silver_gbb_linepack_capacity_adequacy`

- [`knowledge/linepack_zones.yaml`](knowledge/linepack_zones.yaml)
  [AI-generated -- no AEMO documentation found] AEMO Gas Bulletin Board linepack zone register: the named pipeline segments (e.g.
  Expected live table: `external_data.nemweb.silver_gbb_linepack_zones`

- [`knowledge/locations.yaml`](knowledge/locations.yaml)
  AEMO Gas Bulletin Board locations list.
  Expected live table: `external_data.nemweb.silver_gbb_locations`

- [`knowledge/medium_term_capacity_outlook.yaml`](knowledge/medium_term_capacity_outlook.yaml)
  AEMO Gas Bulletin Board medium-term capacity outlook.
  Expected live table: `external_data.nemweb.silver_gbb_medium_term_capacity_outlook`

- [`knowledge/nodes_connection_points.yaml`](knowledge/nodes_connection_points.yaml)
  AEMO Gas Bulletin Board nodes and connection points.
  Expected live table: `external_data.nemweb.silver_gbb_nodes_connection_points`

- [`knowledge/nomination_forecast.yaml`](knowledge/nomination_forecast.yaml)
  AEMO Gas Bulletin Board nominations and forecasts.
  Expected live table: `external_data.nemweb.silver_gbb_nomination_forecast`

- [`knowledge/participants.yaml`](knowledge/participants.yaml)
  AEMO Gas Bulletin Board participants list.
  Expected live table: `external_data.nemweb.silver_gbb_participants`

- [`knowledge/short_term_capacity_outlook.yaml`](knowledge/short_term_capacity_outlook.yaml)
  AEMO Gas Bulletin Board short-term capacity outlook.
  Expected live table: `external_data.nemweb.silver_gbb_short_term_capacity_outlook`
