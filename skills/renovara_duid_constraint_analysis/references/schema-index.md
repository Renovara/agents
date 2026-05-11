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

- [`knowledge/dispatch_constraint.yaml`](knowledge/dispatch_constraint.yaml)
  DISPATCHCONSTRAINT sets out details of all binding and interregion constraints in each dispatch run.
  Expected live table: `external_data.nemweb.silver_dispatchis_reports_dispatch_constraint`

- [`knowledge/dispatch_price.yaml`](knowledge/dispatch_price.yaml)
  DISPATCHPRICE records 5-minute dispatch prices for energy and FCAS, including whether an intervention has occurred, or price override (e.g.
  Expected live table: `external_data.nemweb.silver_dispatchis_reports_dispatch_price`

- [`knowledge/dispatch_unit_solution.yaml`](knowledge/dispatch_unit_solution.yaml)
  DISPATCHLOAD set out the current SCADA MW and target MW for each dispatchable unit, including relevant Frequency Control Ancillary Services (FCAS) enabling targets for each five minutes and additional fields to handle the new Ancillary Services functionality.
  Expected live table: `external_data.nemweb.silver_next_day_dispatch_dispatch_unit_solution`

- [`knowledge/gencondata.yaml`](knowledge/gencondata.yaml)
  GENCONDATA contains the catalogue of generic constraints used in PASA, predispatch, and dispatch processes.
  Expected live table: `external_data.nemweb.silver___gencondata`

- [`knowledge/genconset.yaml`](knowledge/genconset.yaml)
  GENCONSET maps generic constraint sets (GENCONSETID) to the individual constraints (GENCONID) they contain.
  Expected live table: `external_data.nemweb.silver___genconset`

- [`knowledge/nem_participant_and_scheduled_loads.yaml`](knowledge/nem_participant_and_scheduled_loads.yaml)
  Production Units (PU) and Scheduled Loads — all registered Production Units and Scheduled Loads with their classifications and key metadata.
  Expected live table: `external_data.nemweb.silver_nem_participant_and_scheduled_loads`

- [`knowledge/participant_registration_dudetailsummary.yaml`](knowledge/participant_registration_dudetailsummary.yaml)
  DUDETAILSUMMARY sets out a single summary unit table so reducing the need for participants to use the various dispatchable unit detail and owner tables to establish generating unit specific details.
  Expected live table: `external_data.nemweb.silver___participant_registration_dudetailsummary`

- [`knowledge/spdcpc.yaml`](knowledge/spdcpc.yaml)
  SPDCONNECTIONPOINTCONSTRAINT contains the LHS factor terms applied to connection points by generic constraints in dispatch, predispatch, and STPASA.
  Expected live table: `external_data.nemweb.silver___spdcpc`

- [`knowledge/spdrc.yaml`](knowledge/spdrc.yaml)
  SPDREGIONCONSTRAINT contains the LHS factor terms applied to aggregated regional gen/load by generic constraints in dispatch.
  Expected live table: `external_data.nemweb.silver___spdrc`
