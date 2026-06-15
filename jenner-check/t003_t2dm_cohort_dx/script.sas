/* Extract bene_id for patients with Type 2 diabetes from outpatient claims */
Data op_T2DM_2019;
  set op19;
      where prncpal_dgns_cd in: ('E11') or icd_dgns_cd1 in: ('E11') or icd_dgns_cd2 in: ('E11') or icd_dgns_cd3 in: ('E11') or icd_dgns_cd4 in: ('E11');
run;

Data op_T2DM_2020;
  set op20;
      where prncpal_dgns_cd in: ('E11') or icd_dgns_cd1 in: ('E11') or icd_dgns_cd2 in: ('E11') or icd_dgns_cd3 in: ('E11') or icd_dgns_cd4 in: ('E11');
run;

/* combine op 2019-2020*/
data op_T2DM;
  set op_T2DM_2019 op_T2DM_2020;
run;
proc sort data = op_T2DM;
  by bene_id;
run;

/*need more then 2 dx in op data, so deleting those who only have 1 dx in op data*/
proc sql;
  create table op_t2dm_count as
  select*, count(*) as dx_count
  from op_t2dm
  group by bene_id;
quit;
data op_t2dm;
  set op_t2dm_count;
  if dx_count > 1;
run;

proc print data=op_t2dm noobs;
  title "Outpatient Type 2 Diabetes Claims (>1 qualifying claim per beneficiary)";
  var bene_id CLM_FROM_DT prncpal_dgns_cd dx_count;
run;
