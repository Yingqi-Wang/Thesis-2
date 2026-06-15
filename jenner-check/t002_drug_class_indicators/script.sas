/* add all antidiabetic drug indicator */
data all_claims_with_ad;
  set all_claims_with_ad;
  insulin = 0;
  metformin = 0;
  dpp4 = 0;
  glp1 = 0;
  sglt2 = 0;
  sulf = 0;
  tzd = 0;
  alpha = 0;
  if upcase(bn) in: ('INSULIN') or upcase(gnn) in: ('INSULIN') then insulin = 1;
  if upcase(bn) in: ('METFORMIN') or upcase(gnn) in: ('METFORMIN') then metformin = 1;
  if upcase(bn) in: ('ALOGLIPTIN', 'LINAGLIPTIN', 'SAXAGLIPTIN', 'SITAGLIPTIN') or
     upcase(gnn) in: ('ALOGLIPTIN', 'LINAGLIPTIN', 'SAXAGLIPTIN', 'SITAGLIPTIN') then dpp4 = 1;
  if upcase(bn) in: ('DULAGLUTIDE', 'EXENATIDE', 'LIRAGLUTIDE', 'LIXISENATIDE', 'SEMAGLUTIDE', 'TIRZEPATIDE') or
     upcase(gnn) in: ('DULAGLUTIDE', 'EXENATIDE', 'LIRAGLUTIDE', 'LIXISENATIDE', 'SEMAGLUTIDE', 'TIRZEPATIDE') then glp1 = 1;
  if upcase(bn) in: ('BEXAGLIFLOZIN', 'CANAGLIFLOZIN', 'DAPAGLIFLOZIN', 'EMPAGLIFLOZIN') or
     upcase(gnn) in: ('BEXAGLIFLOZIN', 'CANAGLIFLOZIN', 'DAPAGLIFLOZIN', 'EMPAGLIFLOZIN') then sglt2 = 1;
  if upcase(bn) in: ('GLIMEPIRIDE', 'GLIPIZIDE', 'GLYBURIDE') or
     upcase(gnn) in: ('GLIMEPIRIDE', 'GLIPIZIDE', 'GLYBURIDE') then sulf = 1;
  if upcase(bn) in: ('ROSIGLITAZONE', 'PIOGLITAZONE') or
     upcase(gnn) in: ('ROSIGLITAZONE', 'PIOGLITAZONE') then tzd = 1;
  if upcase(bn) in: ('ACARBOSE', 'MIGLITOL') or
     upcase(gnn) in: ('ACARBOSE', 'MIGLITOL') then alpha = 1;
run;

/* one row per beneficiary: did they ever use each drug class */
proc sql;
    create table initiation_drug_user_with_ad as
    select bene_id,
           max(insulin) as insulin_user,
           max(metformin) as metformin_user,
           max(dpp4) as dpp4_user,
           max(glp1) as glp1_user,
           max(sglt2) as sglt2_user,
           max(sulf) as sulf_user,
           max(tzd) as tzd_user,
           max(alpha) as alpha_user
    from all_claims_with_ad
    group by bene_id;
quit;

proc print data=initiation_drug_user_with_ad noobs;
    title "Per-Beneficiary Antidiabetic Drug-Class Use Flags";
run;

proc means data=initiation_drug_user_with_ad sum n;
    title "Number of Beneficiaries Using Each Antidiabetic Drug Class";
    var insulin_user metformin_user dpp4_user glp1_user
        sglt2_user sulf_user tzd_user alpha_user;
run;
