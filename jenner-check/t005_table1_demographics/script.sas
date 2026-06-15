 /*mean age*/
 proc means data=Table1_study_ad mean std;
    title "Table 1: Mean (SD) Age, Study Cohort";
    var age;
 run;

 /* Calculate counts and percentages for sex_ident_cd */
 proc freq data=Table1_study_ad;
     title "Table 1: Sex Distribution";
     tables sex_ident_cd / out=sex_counts (rename=(percent=sex_pct));
 run;

 /* Calculate counts and percentages for RTI race code */
 proc freq data=Table1_study_ad;
     title "Table 1: Race Distribution";
     tables RTI_RACE_CD / out=race_counts (rename=(percent=race_pct));
 run;

 /* Calculate counts and percentages for census region */
 proc freq data=Table1_study_ad;
     title "Table 1: Region Distribution";
     tables Region / out=region_counts (rename=(percent=region_pct));
 run;

 proc print data=sex_counts noobs;
     title "Sex Counts Output Dataset (percent renamed to sex_pct)";
 run;
