options obs=100;

/* ------------------------------------------------------------------ *
 * Bundle setup: 04_add_index_date_and_exclude_65.sas derives each      *
 * beneficiary's index date as the earliest qualifying claim date,      *
 * restricts to index dates in 2017-2019, attaches date of birth, and   *
 * keeps beneficiaries aged 66+ at index. We supply two synthetic        *
 * tables matching what the real script consumes:                       *
 *   all_t2dm : multiple claims per beneficiary with CLM_FROM_DT         *
 *   mbsfv2   : one row per beneficiary with bene_birth_dt               *
 * The CLM_FROM_DT / bene_birth_dt values are read as SAS dates so the   *
 * date-literal range filter and age arithmetic run unchanged.          *
 * ------------------------------------------------------------------ */

data all_t2dm;
  length bene_id $4;
  informat CLM_FROM_DT yymmdd10.;
  format CLM_FROM_DT date9.;
  input bene_id $ CLM_FROM_DT;
  datalines;
C001 2017-03-12
C001 2018-01-05
C002 2016-11-20
C002 2017-08-14
C003 2019-02-28
C004 2017-06-01
C004 2017-09-22
C005 2020-04-10
C006 2018-12-03
C006 2019-05-17
;
run;

data mbsfv2;
  length bene_id $4;
  informat bene_birth_dt yymmdd10.;
  format bene_birth_dt date9.;
  input bene_id $ bene_birth_dt;
  datalines;
C001 1948-07-01
C002 1955-03-15
C003 1952-10-30
C004 1940-01-20
C005 1949-09-09
C006 1958-06-25
;
run;
