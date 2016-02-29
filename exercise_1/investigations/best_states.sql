
--BEST STATES:
create table best_states as
select state, avg(weightedscore) weightedavg, count(state) ct
from
(select x.providerid, x.state, y.weightedscore from
(select providerid, state from d_providers) x
INNER JOIN
(select providerid, weightedscore from f_scores_derived) y
on x.providerid = y.providerid) z
group by (state) order by weightedavg desc
limit 10;

