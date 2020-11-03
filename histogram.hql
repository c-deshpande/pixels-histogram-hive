drop table color;
drop table red_count;
drop table green_count;
drop table blue_count;
drop table result;

create table color (red smallint, green smallint, blue smallint) row format delimited fields terminated by ',' stored as textfile;

load data local inpath '${hiveconf:P}' overwrite into table color;

create table red_count (type tinyint, intensity smallint, count bigint);

create table green_count (type tinyint, intensity smallint, count bigint);

create table blue_count (type tinyint, intensity smallint, count bigint);

from color insert overwrite table red_count select 1 as type, red, count(red) group by red; 

from color insert overwrite table green_count select 2 as type, green, count(green) group by green;

from color insert overwrite table blue_count select 3 as type, blue, count(blue) group by blue;

create table result (type tinyint, intensity smallint, count bigint);

insert overwrite table result select * from red_count union select * from green_count union select * from blue_count;

select * from result;