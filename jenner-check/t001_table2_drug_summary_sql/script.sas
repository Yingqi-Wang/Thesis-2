/* in 1- year follow up */
proc sql;
    create table drug_use_with_ad as
    select
        "Insulin" as Drug_Class, sum(insulin_user) as Users_with_AD, sum(insulin_user) / 3999 * 100 as Pct_with_AD format=8.1 from ad_drug_user_with_ad
    union all select
        "Metformin", sum(metformin_user), sum(metformin_user) / 3999 * 100 from ad_drug_user_with_ad
    union all select
        "Dipeptidyl Peptidase-4 Inhibitors", sum(dpp4_user), sum(dpp4_user) / 3999 * 100 from ad_drug_user_with_ad
    union all select
        "GLP-1 and Dual GLP-1/GIP Agonists", sum(glp1_user), sum(glp1_user) / 3999 * 100 from ad_drug_user_with_ad
    union all select
        "SGLT2 Inhibitors", sum(sglt2_user), sum(sglt2_user) / 3999 * 100 from ad_drug_user_with_ad
    union all select
        "Sulfonylureas", sum(sulf_user), sum(sulf_user) / 3999 * 100 from ad_drug_user_with_ad
    union all select
        "Thiazolidinediones", sum(tzd_user), sum(tzd_user) / 3999 * 100 from ad_drug_user_with_ad
    union all select
        "Alpha-glucosidase Inhibitors", sum(alpha_user), sum(alpha_user) / 3999 * 100 from ad_drug_user_with_ad;
quit;

 proc sql;
     create table drug_use_without_ad as
     select
         "Insulin" as Drug_Class, sum(insulin_user) as Users_without_AD, sum(insulin_user) / 244115 * 100 as Pct_without_AD format=8.1 from ad_drug_user_without_ad
     union all select
         "Metformin", sum(metformin_user), sum(metformin_user) / 244115 * 100 from ad_drug_user_without_ad
     union all select
         "Dipeptidyl Peptidase-4 Inhibitors", sum(dpp4_user), sum(dpp4_user) / 244115 * 100 from ad_drug_user_without_ad
     union all select
         "GLP-1 and Dual GLP-1/GIP Agonists", sum(glp1_user), sum(glp1_user) / 244115 * 100 from ad_drug_user_without_ad
     union all select
         "SGLT2 Inhibitors", sum(sglt2_user), sum(sglt2_user) / 244115 * 100 from ad_drug_user_without_ad
     union all select
         "Sulfonylureas", sum(sulf_user), sum(sulf_user) / 244115 * 100 from ad_drug_user_without_ad
     union all select
         "Thiazolidinediones", sum(tzd_user), sum(tzd_user) / 244115 * 100 from ad_drug_user_without_ad
     union all select
         "Alpha-glucosidase Inhibitors", sum(alpha_user), sum(alpha_user) / 244115 * 100 from ad_drug_user_without_ad;
 quit;

proc sql;
    create table drug_summary as
    select a.Drug_Class,
           a.Users_with_AD, a.Pct_with_AD,
           b.Users_without_AD, b.Pct_without_AD
    from drug_use_with_ad as a
    full join drug_use_without_ad as b
    on a.Drug_Class = b.Drug_Class;
quit;

proc print data=drug_summary noobs label;
    title "Antidiabetic Drug Use Among T2DM Patients With and Without AD (1-Year Follow-up)";
    label Drug_Class       = "Drug Class"
          Users_with_AD    = "Users (With AD)"
          Pct_with_AD      = "% (With AD)"
          Users_without_AD = "Users (Without AD)"
          Pct_without_AD   = "% (Without AD)";
run;
