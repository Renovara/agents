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

- [`knowledge/daily_mlf.yaml`](knowledge/daily_mlf.yaml)
  Marginal Loss Factors by connection point, versioned by effective date and version number.
  Expected live table: `external_data.nemweb.silver_marginal_loss_factors_daily_mlf`

- [`knowledge/dispatch_case_solution.yaml`](knowledge/dispatch_case_solution.yaml)
  DISPATCHCASESOLUTION shows information relating to the complete dispatch run.
  Expected live table: `external_data.nemweb.silver_dispatchis_reports_dispatch_case_solution`

- [`knowledge/dispatch_constraint.yaml`](knowledge/dispatch_constraint.yaml)
  DISPATCHCONSTRAINT sets out details of all binding and interregion constraints in each dispatch run.
  Expected live table: `external_data.nemweb.silver_dispatchis_reports_dispatch_constraint`

- [`knowledge/dispatch_interconnection.yaml`](knowledge/dispatch_interconnection.yaml)
  Inter-regional flow information common to or aggregated for regulated (i.e.
  Expected live table: `external_data.nemweb.silver_dispatchis_reports_dispatch_interconnection`

- [`knowledge/dispatch_interconnectorres.yaml`](knowledge/dispatch_interconnectorres.yaml)
  DISPATCHINTERCONNECTORRES sets out MW flow and losses on each interconnector for each dispatch period, including fields for the Frequency Controlled Ancillary Services export and import limits and extra reporting of the generic constraints that set the energy import and export limits.
  Expected live table: `external_data.nemweb.silver_dispatchis_reports_dispatch_interconnectorres`

- [`knowledge/dispatch_local_price.yaml`](knowledge/dispatch_local_price.yaml)
  Sets out local pricing offsets associated with each DUID connection point for each dispatch period.
  Expected live table: `external_data.nemweb.silver_dispatchis_reports_dispatch_local_price`

- [`knowledge/dispatch_offertrk.yaml`](knowledge/dispatch_offertrk.yaml)
  DISPATCHOFFERTRK is the energy and ancillary service bid tracking table for the Dispatch process.
  Expected live table: `external_data.nemweb.silver_next_day_dispatch_dispatch_offertrk`

- [`knowledge/dispatch_price.yaml`](knowledge/dispatch_price.yaml)
  DISPATCHPRICE records 5-minute dispatch prices for energy and FCAS, including whether an intervention has occurred, or price override (e.g.
  Expected live table: `external_data.nemweb.silver_dispatchis_reports_dispatch_price`

- [`knowledge/dispatch_regionsum.yaml`](knowledge/dispatch_regionsum.yaml)
  DISPATCHREGIONSUM sets out the 5-minute solution for each dispatch run for each region, including Frequency Control Ancillary Services (FCAS) data, demand, generation, and semi-scheduled forecasts.
  Expected live table: `external_data.nemweb.silver_dispatchis_reports_dispatch_regionsum`

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

- [`knowledge/nem_registration_exemption_list.yaml`](knowledge/nem_registration_exemption_list.yaml)
  Participant and asset registration list, including DUIDs, registered capacity, fuel source, and technology type.
  Expected live table: `external_data.nemweb.silver_nem_registration_exemption_list`

- [`knowledge/openelectricity_facilities.yaml`](knowledge/openelectricity_facilities.yaml)
  Facility-level metadata sourced from openelectricity.org.au.
  Expected live table: `external_data.nemweb.silver_openelectricity_facilities`

- [`knowledge/openelectricity_units.yaml`](knowledge/openelectricity_units.yaml)
  Unit-level metadata sourced from openelectricity.org.au.
  Expected live table: `external_data.nemweb.silver_openelectricity_units`

- [`knowledge/p5min_interconnectorsoln.yaml`](knowledge/p5min_interconnectorsoln.yaml)
  The five-minute predispatch (P5Min) system provides projected dispatch for 12 dispatch cycles (one hour).
  Expected live table: `external_data.nemweb.silver_p5_reports_p5min_interconnectorsoln`

- [`knowledge/p5min_local_price.yaml`](knowledge/p5min_local_price.yaml)
  Sets out local pricing offsets associated with each DUID connection point for each dispatch period.
  Expected live table: `external_data.nemweb.silver_p5_reports_p5min_local_price`

- [`knowledge/p5min_regionsolution.yaml`](knowledge/p5min_regionsolution.yaml)
  The five-minute predispatch (P5Min) system provides projected dispatch for 12 dispatch cycles (one hour).
  Expected live table: `external_data.nemweb.silver_p5_reports_p5min_regionsolution`

- [`knowledge/participant_registration_dudetailsummary.yaml`](knowledge/participant_registration_dudetailsummary.yaml)
  DUDETAILSUMMARY sets out a single summary unit table so reducing the need for participants to use the various dispatchable unit detail and owner tables to establish generating unit specific details.
  Expected live table: `external_data.nemweb.silver___participant_registration_dudetailsummary`

- [`knowledge/participant_registration_participant.yaml`](knowledge/participant_registration_participant.yaml)
  PARTICIPANT sets out Participant ID, name and class for all participants.
  Expected live table: `external_data.nemweb.silver___participant_registration_participant`

- [`knowledge/predispatch_interconnector_soln.yaml`](knowledge/predispatch_interconnector_soln.yaml)
  PREDISPATCHINTERCONNECTORRES records interconnector flows and losses for the periods calculated in each predispatch run.
  Expected live table: `external_data.nemweb.silver_predispatchis_reports_predispatch_interconnector_soln`

- [`knowledge/predispatch_local_price.yaml`](knowledge/predispatch_local_price.yaml)
  Sets out local pricing offsets associated with each DUID connection point for each dispatch period.
  Expected live table: `external_data.nemweb.silver_predispatchis_reports_predispatch_local_price`

- [`knowledge/predispatch_region_prices.yaml`](knowledge/predispatch_region_prices.yaml)
  PREDISPATCHPRICE records predispatch prices for each region by period for each predispatch run, including fields to handle the Ancillary Services functionality.
  Expected live table: `external_data.nemweb.silver_predispatchis_reports_predispatch_region_prices`

- [`knowledge/predispatch_region_solution.yaml`](knowledge/predispatch_region_solution.yaml)
  PREDISPATCH_REGION_SOLUTION sets out the overall regional Pre-Dispatch results for.
  Expected live table: `external_data.nemweb.silver_predispatchis_reports_predispatch_region_solution`

- [`knowledge/spdcpc.yaml`](knowledge/spdcpc.yaml)
  SPDCONNECTIONPOINTCONSTRAINT contains the LHS factor terms applied to connection points by generic constraints in dispatch, predispatch, and STPASA.
  Expected live table: `external_data.nemweb.silver___spdcpc`

- [`knowledge/spdrc.yaml`](knowledge/spdrc.yaml)
  SPDREGIONCONSTRAINT contains the LHS factor terms applied to aggregated regional gen/load by generic constraints in dispatch.
  Expected live table: `external_data.nemweb.silver___spdrc`
