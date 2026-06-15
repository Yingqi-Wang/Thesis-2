options obs=100;

/* ------------------------------------------------------------------ *
 * Bundle setup: the original 15_Table2_visulization.sas reads two     *
 * patient-level datasets from the DUA-protected `ad` library:         *
 *   ad.drug_user_with_ad     (T2DM patients WITH Alzheimer's disease) *
 *   ad.drug_user_without_ad  (T2DM patients WITHOUT AD)               *
 * Each row is one beneficiary; each *_user column is a 0/1 flag for   *
 * whether that beneficiary used the drug class in the 1-year follow   *
 * up window. We stand up small synthetic versions with the same       *
 * column shape so the union-all summary SQL and the SGPLOT run        *
 * unchanged. The denominators (3999 / 244115) are the author's real   *
 * cohort sizes and are kept verbatim from the script.                 *
 * ------------------------------------------------------------------ */

data ad_drug_user_with_ad;
  input insulin_user metformin_user dpp4_user glp1_user
        sglt2_user sulf_user tzd_user alpha_user;
  datalines;
1 1 0 0 1 0 0 0
1 1 1 0 0 1 0 0
0 1 0 1 0 0 0 0
1 1 1 1 1 0 1 0
0 1 0 0 0 1 0 1
1 0 1 0 1 0 0 0
1 1 0 1 0 1 0 0
0 1 1 0 1 0 1 0
1 1 0 0 0 0 0 0
1 1 1 1 1 1 1 1
0 1 0 0 1 0 0 0
1 1 1 0 0 0 0 0
;
run;

data ad_drug_user_without_ad;
  input insulin_user metformin_user dpp4_user glp1_user
        sglt2_user sulf_user tzd_user alpha_user;
  datalines;
0 1 0 0 0 0 0 0
1 1 1 0 1 0 0 0
0 1 0 1 0 1 0 0
1 1 0 0 0 0 0 0
0 1 1 1 1 0 1 0
1 0 0 0 0 0 0 0
0 1 0 0 0 1 0 0
1 1 1 0 0 0 0 1
0 1 0 1 1 0 0 0
1 1 0 0 0 0 0 0
0 1 1 0 0 1 0 0
1 0 0 0 1 0 0 0
0 1 0 0 0 0 0 0
1 1 1 1 0 0 1 0
;
run;
