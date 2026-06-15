options obs=100;
ods graphics off;

/* ------------------------------------------------------------------ *
 * Bundle setup: 11_Table1_study_cohort.sas builds the Table 1         *
 * descriptive statistics for the study cohort — mean/SD age and the    *
 * sex, race and census-region distributions — from the DUA-protected   *
 * ad.Table1_study_ad table. We stand up a small synthetic cohort with  *
 * the same demographic columns the PROC MEANS / PROC FREQ steps read:  *
 *   age, sex_ident_cd (1=male,2=female), RTI_RACE_CD, Region.          *
 * ------------------------------------------------------------------ */

data Table1_study_ad;
  length Region $9;
  input age sex_ident_cd RTI_RACE_CD Region $;
  datalines;
72 1 1 Northeast
68 2 1 Midwest
75 2 2 South
70 1 1 West
81 2 3 South
67 1 1 Northeast
78 2 4 West
69 1 2 Midwest
84 2 1 South
71 1 1 Northeast
66 2 6 West
73 1 1 Midwest
79 2 2 South
70 1 1 West
77 2 1 Northeast
68 1 3 Midwest
82 2 1 South
74 1 2 West
67 2 1 Northeast
76 1 1 South
;
run;
