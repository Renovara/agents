-- Which fuel sources set the NSW1 energy price in Q1 2026 (AER chart basis)?
-- AER "price setter by fuel source" chart for NSW1, Q1 2026.
-- Chart basis: shares sum to 100% (battery generation side only,
-- p_include_battery_loads = false). Drop the final arg / pass true for the
-- AER prose basis (pct_of_intervals, batteries counted on both sides).
SELECT
  fuel_source,
  occasions,
  pct_normalised,      -- AER chart basis (sums to 100%)
  pct_of_intervals,    -- AER prose basis
  avg_offer_price,     -- AER "average price set" (offer price at the RRN)
  avg_rrp              -- dispatch price when this fuel set it
FROM external_data.nemweb.f_price_setter_by_fuel(
  'NSW1', '2026-01-01', '2026-04-01', 'quarter', false
)
ORDER BY occasions DESC;
