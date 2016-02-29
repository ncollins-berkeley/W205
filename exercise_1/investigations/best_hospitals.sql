
--BEST HOSPITALS:
create table best_hospitals as
select d_providers.*,x.weightedavg,x.ct from d_providers
INNER JOIN
(select providerid, avg(weightedscore) weightedavg, count(providerid) ct from f_scores_derived group by (providerid)) x
on x.providerid = d_providers.providerid
where ct >= 32  --24
order by x.weightedavg desc
limit 10;
