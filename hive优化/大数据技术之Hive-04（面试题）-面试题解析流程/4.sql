id 		stt 		edt
oppo	2021-06-05	2021-06-09
oppo	2021-06-11	2021-06-21

vivo	2021-06-05	2021-06-15
vivo	2021-06-09	2021-06-21

redmi	2021-06-05	2021-06-21
redmi	2021-06-09	2021-06-15
redmi	2021-06-17	2021-06-26

huawei	2021-06-05	2021-06-26
huawei	2021-06-09	2021-06-15
huawei	2021-06-17	2021-06-21

1)将当前行以前的数据中最大的edt放置当前行
select
    id,
    stt,
    edt,
    max(edt) over(partition by id order by stt rows between UNBOUNDED PRECEDING and 1 PRECEDING) maxEdt
from test4;t1
redmi	2021-06-05	2021-06-21	null
redmi	2021-06-09	2021-06-15	2021-06-21
redmi	2021-06-17	2021-06-26	2021-06-21

2)比较开始时间与移动下来的数据,如果开始时间大,则不需要操作,
反之则需要将移动下来的数据加一替换当前行的开始时间
如果是第一行数据,maxEDT为null,则不需要操作
select
    id,
    if(maxEdt is null,stt,if(stt>maxEdt,stt,date_add(maxEdt,1))) stt,
    edt
from t1;t2
redmi	2021-06-05	2021-06-21
redmi	2021-06-22	2021-06-15
redmi	2021-06-22	2021-06-26

3)将每行数据中的结束日期减去开始日期
select
    id,
    datediff(edt,stt) days
from
    t2;t3
redmi	16
redmi	-4
redmi	4

4)按照品牌分组,计算每条数据加一的总和
select
    id,
    sum(if(days>=0,days+1,0)) days
from
    t3
group by id;
redmi	22

5)最终HQL
select
    id,
    sum(if(days>=0,days+1,0)) days
from
    (select
    id,
    datediff(edt,stt) days
from
    (select
    id,
    if(maxEdt is null,stt,if(stt>maxEdt,stt,date_add(maxEdt,1))) stt,
    edt
from 
    (select
    id,
    stt,
    edt,
    max(edt) over(partition by id order by stt rows between UNBOUNDED PRECEDING and 1 PRECEDING) maxEdt
from test4)t1)t2)t3
group by id;