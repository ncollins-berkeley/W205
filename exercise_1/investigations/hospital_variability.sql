
--GREATEST VARIABILITY
create table hospital_variability as
select x.procedureid, x.procedurename, y.scorevariance, y.ct from 
d_procedures x
INNER JOIN
(select procedureid, var_pop(weightedscore) scorevariance, count(procedureid) ct from f_scores_derived group by (procedureid)) y
on x.procedureid = y.procedureid
where ct >= 500
order by scorevariance desc
limit 10;
