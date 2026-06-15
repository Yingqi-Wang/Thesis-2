options obs=100;

/* ------------------------------------------------------------------ *
 * Bundle setup: 02_getting_all_T2DM_2017_2020.sas reads CMS outpatient *
 * base claims and keeps any claim whose principal or secondary ICD-10  *
 * diagnosis code begins with E11 (Type 2 diabetes), using the SAS      *
 * `in: ('E11')` prefix-match operator. We stand up two small synthetic *
 * outpatient claim tables (two calendar years, as the author          *
 * concatenates multiple years) carrying bene_id, CLM_FROM_DT and the   *
 * principal + first four secondary diagnosis-code columns. The real    *
 * script screens 25 secondary columns; we keep the first five so the   *
 * E11 prefix logic is exercised on representative data.                *
 * ------------------------------------------------------------------ */

data op19;
  length bene_id $4 prncpal_dgns_cd $7 icd_dgns_cd1-icd_dgns_cd4 $7;
  informat CLM_FROM_DT yymmdd10.;
  format CLM_FROM_DT date9.;
  input bene_id $ CLM_FROM_DT prncpal_dgns_cd $
        icd_dgns_cd1 $ icd_dgns_cd2 $ icd_dgns_cd3 $ icd_dgns_cd4 $;
  datalines;
B001 2019-02-10 E119 I10 E785 . .
B001 2019-06-04 I10 E1165 . . .
B002 2019-03-22 J189 . . . .
B003 2019-01-15 E1140 E785 . . .
B004 2019-09-30 E119 . . . .
B005 2019-05-18 N390 E1122 I10 . .
;
run;

data op20;
  length bene_id $4 prncpal_dgns_cd $7 icd_dgns_cd1-icd_dgns_cd4 $7;
  informat CLM_FROM_DT yymmdd10.;
  format CLM_FROM_DT date9.;
  input bene_id $ CLM_FROM_DT prncpal_dgns_cd $
        icd_dgns_cd1 $ icd_dgns_cd2 $ icd_dgns_cd3 $ icd_dgns_cd4 $;
  datalines;
B001 2020-04-11 E1142 I10 . . .
B003 2020-07-08 I252 E119 . . .
B004 2020-02-26 E1165 E785 . . .
B006 2020-11-03 M179 . . . .
B007 2020-08-19 E1129 . . . .
B007 2020-12-01 E119 I10 . . .
;
run;
