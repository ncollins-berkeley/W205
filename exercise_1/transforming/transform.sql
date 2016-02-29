create table d_providers as 
select providerid, 
       hospitalname, 
       state, 
       hospitaltype, 
       hospitalownership, 
       emergencyservices 
from hospitals;

create table d_procedures as
select z.measurename as procedurename,
   z.measureid as procedureid
from measures z
INNER JOIN
(select distinct measureid as procedureid from
 (select measureid from general_procedures where measureid <> 'PC_01' and measureid <> 'EDV'
         union all
         select measureid from imaging_procedures) x) y
where y.procedureid = z.measureid;


create table f_scores as
select * from
(select x.providerid,
       x.measureid as procedureid,
       cast (x.score as float) as rawscore
       from 
(select * from general_procedures
where !( `score` = 'Not Available' or measureid = 'PC_01' or measureid = 'EDV')) x
INNER JOIN
(select measureid from measures) y
where y.measureid = x.measureid
UNION ALL
select x.providerid,
       x.measureid as procedureid,
       cast (x.score as float) as rawscore
from
(select * from imaging_procedures
where !( `score` = 'Not Available')) x
INNER JOIN
(select measureid from measures) y
where y.measureid = x.measureid) w
;


create table f_surveys as
select 
`providernumber` as `providerid`,
cast (rtrim(substr(`communicationwithnursesachievementpoints`,1,2)) as int) nurse_a,  
cast (rtrim(substr(`communicationwithnursesimprovementpoints`,1,2)) as int) nurse_i,  
cast (rtrim(substr(`communicationwithnursesdimensionscore`,1,2)) as int) nurse_d,  
cast (rtrim(substr(`communicationwithdoctorsachievementpoints`,1,2)) as int) dr_a,  
cast (rtrim(substr(`communicationwithdoctorsimprovementpoints`,1,2)) as int) dr_i,  
cast (rtrim(substr(`communicationwithdoctorsdimensionscore`,1,2)) as int) dr_d,  
cast (rtrim(substr(`responsivenessofhospitalstaffachievementpoints`,1,2)) as int) staff_a,  
cast (rtrim(substr(`responsivenessofhospitalstaffimprovementpoints`,1,2)) as int) staff_i,  
cast (rtrim(substr(`responsivenessofhospitalstaffdimensionscore`,1,2)) as int) staff_d,  
cast (rtrim(substr(`painmanagementachievementpoints`,1,2)) as int) pain_a,  
cast (rtrim(substr(`painmanagementimprovementpoints`,1,2)) as int) pain_i,  
cast (rtrim(substr(`painmanagementdimensionscore`,1,2)) as int) pain_d,  
cast (rtrim(substr(`communicationaboutmedicinesachievementpoints`,1,2)) as int) med_a,  
cast (rtrim(substr(`communicationaboutmedicinesimprovementpoints`,1,2)) as int) med_i,  
cast (rtrim(substr(`communicationaboutmedicinesdimensionscore`,1,2)) as int) med_d,  
cast (rtrim(substr(`cleanlinessandquietnessofhospitalenvironmentachievementpoints`,1,2)) as int) cq_a,  
cast (rtrim(substr(`cleanlinessandquietnessofhospitalenvironmentimprovementpoints`,1,2)) as int) cq_i,  
cast (rtrim(substr(`cleanlinessandquietnessofhospitalenvironmentdimensionscore`,1,2)) as int) cq_d,  
cast (rtrim(substr(`dischargeinformationachievementpoints`,1,2)) as int) dis_a,  
cast (rtrim(substr(`dischargeinformationimprovementpoints`,1,2)) as int) dis_i,  
cast (rtrim(substr(`dischargeinformationdimensionscore`,1,2)) as int) dis_d,  
cast (rtrim(substr(`overallratingofhospitalachievementpoints`,1,2)) as int) overall_a,  
cast (rtrim(substr(`overallratingofhospitalimprovementpoints`,1,2)) as int) overall_i,  
cast (rtrim(substr(`overallratingofhospitaldimensionscore`,1,2)) as int) overall_d  
from
(select * from survey_responses
where !(
  `communicationwithnursesachievementpoints` = 'Not Available' or  
  `communicationwithnursesimprovementpoints` = 'Not Available' or  
  `communicationwithnursesdimensionscore` = 'Not Available' or  
  `communicationwithdoctorsachievementpoints` = 'Not Available' or  
  `communicationwithdoctorsimprovementpoints` = 'Not Available' or  
  `communicationwithdoctorsdimensionscore` = 'Not Available' or  
  `responsivenessofhospitalstaffachievementpoints` = 'Not Available' or  
  `responsivenessofhospitalstaffimprovementpoints` = 'Not Available' or  
  `responsivenessofhospitalstaffdimensionscore` = 'Not Available' or  
  `painmanagementachievementpoints` = 'Not Available' or  
  `painmanagementimprovementpoints` = 'Not Available' or  
  `painmanagementdimensionscore` = 'Not Available' or  
  `communicationaboutmedicinesachievementpoints` = 'Not Available' or  
  `communicationaboutmedicinesimprovementpoints` = 'Not Available' or  
  `communicationaboutmedicinesdimensionscore` = 'Not Available' or  
  `cleanlinessandquietnessofhospitalenvironmentachievementpoints` = 'Not Available' or  
  `cleanlinessandquietnessofhospitalenvironmentimprovementpoints` = 'Not Available' or  
  `cleanlinessandquietnessofhospitalenvironmentdimensionscore` = 'Not Available' or  
  `dischargeinformationachievementpoints` = 'Not Available' or  
  `dischargeinformationimprovementpoints` = 'Not Available' or  
  `dischargeinformationdimensionscore` = 'Not Available' or  
  `overallratingofhospitalachievementpoints` = 'Not Available' or  
  `overallratingofhospitalimprovementpoints` = 'Not Available' or  
  `overallratingofhospitaldimensionscore` = 'Not Available' or  
  `hcahpsbasescore` = 'Not Available' or  
  `hcahpsconsistencyscore` = 'Not Available')) x;

create table d_procedures_derived 
as
select * from (
select 'AMI_10' procedureid, min(rawscore) minscore, max(rawscore) maxscore, 0 hilo from f_scores where procedureid = 'AMI_10' UNION ALL
select 'AMI_2' procedureid, min(rawscore) minscore, max(rawscore) maxscore, 0 hilo from f_scores where procedureid = 'AMI_2' UNION ALL
select 'AMI_7a' procedureid, min(rawscore) minscore, max(rawscore) maxscore, 0 hilo from f_scores where procedureid = 'AMI_7a' UNION ALL
select 'AMI_8a' procedureid, min(rawscore) minscore, max(rawscore) maxscore, 0 hilo from f_scores where procedureid = 'AMI_8a' UNION ALL
select 'CAC_1' procedureid, min(rawscore) minscore, max(rawscore) maxscore, 0 hilo from f_scores where procedureid = 'CAC_1' UNION ALL
select 'CAC_2' procedureid, min(rawscore) minscore, max(rawscore) maxscore, 0 hilo from f_scores where procedureid = 'CAC_2' UNION ALL
select 'CAC_3' procedureid, min(rawscore) minscore, max(rawscore) maxscore, 0 hilo from f_scores where procedureid = 'CAC_3' UNION ALL
select 'ED_1b' procedureid, min(rawscore) minscore, max(rawscore) maxscore, -1 hilo from f_scores where procedureid = 'ED_1b' UNION ALL
select 'ED_2b' procedureid, min(rawscore) minscore, max(rawscore) maxscore, -1 hilo from f_scores where procedureid = 'ED_2b' UNION ALL
select 'HF_1' procedureid, min(rawscore) minscore, max(rawscore) maxscore, 0 hilo from f_scores where procedureid = 'HF_1' UNION ALL
select 'HF_2' procedureid, min(rawscore) minscore, max(rawscore) maxscore, 0 hilo from f_scores where procedureid = 'HF_2' UNION ALL
select 'HF_3' procedureid, min(rawscore) minscore, max(rawscore) maxscore, 0 hilo from f_scores where procedureid = 'HF_3' UNION ALL
select 'IMM_2' procedureid, min(rawscore) minscore, max(rawscore) maxscore, 0 hilo from f_scores where procedureid = 'IMM_2' UNION ALL
select 'OP_1' procedureid, min(rawscore) minscore, max(rawscore) maxscore, -1 hilo from f_scores where procedureid = 'OP_1' UNION ALL
select 'OP_18b' procedureid, min(rawscore) minscore, max(rawscore) maxscore, -1 hilo from f_scores where procedureid = 'OP_18b' UNION ALL
select 'OP_2' procedureid, min(rawscore) minscore, max(rawscore) maxscore, 0 hilo from f_scores where procedureid = 'OP_2' UNION ALL
select 'OP_20' procedureid, min(rawscore) minscore, max(rawscore) maxscore, -1 hilo from f_scores where procedureid = 'OP_20' UNION ALL
select 'OP_21' procedureid, min(rawscore) minscore, max(rawscore) maxscore, -1 hilo from f_scores where procedureid = 'OP_21' UNION ALL
select 'OP_22' procedureid, min(rawscore) minscore, max(rawscore) maxscore, -1 hilo from f_scores where procedureid = 'OP_22' UNION ALL
select 'OP_23' procedureid, min(rawscore) minscore, max(rawscore) maxscore, 0 hilo from f_scores where procedureid = 'OP_23' UNION ALL
select 'OP_3b' procedureid, min(rawscore) minscore, max(rawscore) maxscore, -1 hilo from f_scores where procedureid = 'OP_3b' UNION ALL
select 'OP_4' procedureid, min(rawscore) minscore, max(rawscore) maxscore, 0 hilo from f_scores where procedureid = 'OP_4' UNION ALL
select 'OP_5' procedureid, min(rawscore) minscore, max(rawscore) maxscore, -1 hilo from f_scores where procedureid = 'OP_5' UNION ALL
select 'OP_6' procedureid, min(rawscore) minscore, max(rawscore) maxscore, 0 hilo from f_scores where procedureid = 'OP_6' UNION ALL
select 'OP_7' procedureid, min(rawscore) minscore, max(rawscore) maxscore, 0 hilo from f_scores where procedureid = 'OP_7' UNION ALL
select 'PN_6' procedureid, min(rawscore) minscore, max(rawscore) maxscore, 0 hilo from f_scores where procedureid = 'PN_6' UNION ALL
select 'SCIP_VTE_2' procedureid, min(rawscore) minscore, max(rawscore) maxscore, 0 hilo from f_scores where procedureid = 'SCIP_VTE_2' UNION ALL
select 'STK_1' procedureid, min(rawscore) minscore, max(rawscore) maxscore, 0 hilo from f_scores where procedureid = 'STK_1' UNION ALL
select 'STK_10' procedureid, min(rawscore) minscore, max(rawscore) maxscore, 0 hilo from f_scores where procedureid = 'STK_10' UNION ALL
select 'STK_2' procedureid, min(rawscore) minscore, max(rawscore) maxscore, 0 hilo from f_scores where procedureid = 'STK_2' UNION ALL
select 'STK_3' procedureid, min(rawscore) minscore, max(rawscore) maxscore, 0 hilo from f_scores where procedureid = 'STK_3' UNION ALL
select 'STK_4' procedureid, min(rawscore) minscore, max(rawscore) maxscore, 0 hilo from f_scores where procedureid = 'STK_4' UNION ALL
select 'STK_5' procedureid, min(rawscore) minscore, max(rawscore) maxscore, 0 hilo from f_scores where procedureid = 'STK_5' UNION ALL
select 'STK_6' procedureid, min(rawscore) minscore, max(rawscore) maxscore, 0 hilo from f_scores where procedureid = 'STK_6' UNION ALL
select 'STK_8' procedureid, min(rawscore) minscore, max(rawscore) maxscore, 0 hilo from f_scores where procedureid = 'STK_8' UNION ALL
select 'VTE_1' procedureid, min(rawscore) minscore, max(rawscore) maxscore, 0 hilo from f_scores where procedureid = 'VTE_1' UNION ALL
select 'VTE_2' procedureid, min(rawscore) minscore, max(rawscore) maxscore, 0 hilo from f_scores where procedureid = 'VTE_2' UNION ALL
select 'VTE_3' procedureid, min(rawscore) minscore, max(rawscore) maxscore, 0 hilo from f_scores where procedureid = 'VTE_3' UNION ALL
select 'VTE_4' procedureid, min(rawscore) minscore, max(rawscore) maxscore, 0 hilo from f_scores where procedureid = 'VTE_4' UNION ALL
select 'VTE_5' procedureid, min(rawscore) minscore, max(rawscore) maxscore, 0 hilo from f_scores where procedureid = 'VTE_5' UNION ALL
select 'VTE_6' procedureid, min(rawscore) minscore, max(rawscore) maxscore, -1 hilo from f_scores where procedureid = 'VTE_6' UNION ALL
select 'OP_10' procedureid, min(rawscore) minscore, max(rawscore) maxscore, -1 hilo from f_scores where procedureid = 'OP_10' UNION ALL
select 'OP_11' procedureid, min(rawscore) minscore, max(rawscore) maxscore, -1 hilo from f_scores where procedureid = 'OP_11' UNION ALL
select 'OP_13' procedureid, min(rawscore) minscore, max(rawscore) maxscore, -1 hilo from f_scores where procedureid = 'OP_13' UNION ALL
select 'OP_14' procedureid, min(rawscore) minscore, max(rawscore) maxscore, -1 hilo from f_scores where procedureid = 'OP_14' UNION ALL
select 'OP_8' procedureid, min(rawscore) minscore, max(rawscore) maxscore, -1 hilo from f_scores where procedureid = 'OP_8' UNION ALL
select 'OP_9' procedureid, min(rawscore) minscore, max(rawscore) maxscore, -1 hilo from f_scores where procedureid = 'OP_9'
) x;


create table f_scores_derived
as
select 
providerid,
procedureid,
abs( ((rawscore - minscore)/(maxscore-minscore)) + hilo) as weightedscore
from
(select 
x.providerid, x.procedureid, x.rawscore, y.minscore, y.maxscore, y.hilo
from 
f_scores x
INNER JOIN
d_procedures_derived y
on x.procedureid = y.procedureid) z;


