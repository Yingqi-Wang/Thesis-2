options obs=100;

/* ------------------------------------------------------------------ *
 * Bundle setup: 12_Table1_analytic_cohort.sas reads Part D pharmacy   *
 * claims (ad.all_claims_with_ad) where each row is a fill with a       *
 * brand name (bn) and generic name (gnn), then flags eight            *
 * antidiabetic drug classes by matching those name fields. We mock a   *
 * small claims table with the same bene_id / bn / gnn columns drawn    *
 * from the exact drug names the author screens for.                    *
 * ------------------------------------------------------------------ */

data all_claims_with_ad;
  length bene_id $4 bn $20 gnn $20;
  input bene_id $ bn $ gnn $;
  datalines;
A001 LANTUS INSULIN
A001 GLUCOPHAGE METFORMIN
A002 JANUVIA SITAGLIPTIN
A002 . METFORMIN
A003 OZEMPIC SEMAGLUTIDE
A003 JARDIANCE EMPAGLIFLOZIN
A004 AMARYL GLIMEPIRIDE
A005 ACTOS PIOGLITAZONE
A005 . ACARBOSE
A006 TRULICITY DULAGLUTIDE
A006 INVOKANA CANAGLIFLOZIN
A007 . METFORMIN
A008 NOVOLOG INSULIN
A008 ONGLYZA SAXAGLIPTIN
A009 GLUCOTROL GLIPIZIDE
A010 FARXIGA DAPAGLIFLOZIN
A010 . METFORMIN
;
run;
