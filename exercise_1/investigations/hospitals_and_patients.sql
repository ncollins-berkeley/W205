
--SURVEY RESPONSES
create table hospitals_and_patients as
select x.providerid, x.weightedval as weightedsurvey ,y.weightedavg as weightedscore from
(select 
providerid,
(
(cast(nurse_a as float)/10 + cast(nurse_i as float)/9 + cast(nurse_d as float)/10) +
(cast(dr_a as float)/10 + cast(dr_i as float)/9 + cast(dr_d as float)/10) +
(cast(staff_a as float)/10 + cast(staff_i as float)/9 + cast(staff_d as float)/10) +
(cast(pain_a as float)/10 + cast(pain_i as float)/9 + cast(pain_d as float)/10) +
(cast(med_a as float)/10 + cast(med_i as float)/9 + cast(med_d as float)/10) +
(cast(cq_a as float)/10 + cast(cq_i as float)/9 + cast(cq_d as float)/10) +
(cast(dis_a as float)/10 + cast(dis_i as float)/9 + cast(dis_d as float)/10) +
(cast(overall_a as float)/10 + cast(overall_i as float)/9 + cast(overall_d as float)/10))/24 
weightedval
from
f_surveys) x
INNER JOIN
(select d_providers.providerid, x.weightedavg from d_providers 
INNER JOIN
(select providerid, avg(weightedscore) weightedavg, count(providerid) ct from f_scores_derived group by (providerid)) x
on x.providerid = d_providers.providerid
where ct >= 32) y
on x.providerid = y.providerid;

create table hosp_and_pat_correlation as
select corr(weightedsurvey, weightedscore) from hospitals_and_patients;
