/*getting index date for patients*/
proc sql;
   create table min_date as
   select bene_id, min(CLM_FROM_DT) as index_date
   from all_t2dm
   group by bene_id;
 quit;

data all_t2dm;
   merge all_t2dm(in=a) min_date(in=b);
   by bene_id;
   if a;
 run;

proc sort data=all_t2dm;
  by bene_id CLM_FROM_DT;
run;

 /* only keep those index_date from Jan 1 2017 to Dec 31 2019*/
data all_t2dm_17_19;
    set all_t2dm;
    if index_date >= '01JAN2017'd and index_date <= '31DEC2019'd;
run;

data all_t2dm_17_19;
  merge all_t2dm_17_19(in=a) mbsfv2(in=b keep=bene_id bene_birth_dt);
  by bene_id;
  birth_date = bene_birth_dt;
  if a and b;
run;

/*only keep those with age >= 66 at the time of index date*/
data exclude65;
  set all_t2dm_17_19;
   age = int((index_date - birth_date)/365.25);
      if age >= 66;
run;

proc sort data=exclude65 nodupkey;
  by bene_id;
run;

proc print data=exclude65 noobs;
  title "T2DM Cohort: Index Date in 2017-2019 and Age 66+ at Index";
  format index_date birth_date date9.;
  var bene_id index_date birth_date age;
run;
