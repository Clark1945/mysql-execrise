show databases;
drop database `company_data`;
create database `company_data`;
use `company_data`;

create table `employee`(
`emp_id` int primary key,
`name` varchar(20),
`join_date` date,
`sex` varchar(5),
`salary` int,
`branch_id` int,
`sup_id` int 
);
create table `branch`(
`branch_id` int primary key,
`branch_name` varchar(20),
`manager_id` int,
foreign key (`manager_id`) references `employee` (`emp_id`) on delete set null
);
alter table `employee`
add foreign key(`branch_id`) references
`branch`(`branch_id`)
on delete set null;
#在employee中加入branch的branchID
#on delete set null 如果資料被刪除，關聯欄位設定為Null。

alter table `employee`
add foreign key(`sup_id`) references
`employee`(`emp_id`)
on delete set null;
#對自己做關聯。

create table `client`(
`client_id` int primary key,
`client_name` varchar(20),
`phone` varchar(20)
);

create table `works_with`(
`emp_id` int,
`client_id` int,
`total_sales` int,
primary key(`emp_id`,`client_id`),
foreign key(`emp_id`) references `employee`(`emp_id`) on delete cascade,
foreign key(`client_id`) references `client`(`client_id`) on delete cascade
);

insert into `employee` values(206,'小黃','1985-12-05','F',50000,1,null);

insert into `branch` values(1,'研發部',null);
insert into `branch` values(2,'行政部',null);
insert into `branch` values(3,'資訊部',null);
#邏輯，與branch關聯的employee，必須要先加入branch資料才能參照，加入成功。
insert into `employee` values(206,'小黃','1998-10-08','F',50000,1,null);
insert into `employee` values(207,'小白','1999-07-15','M',87000,2,206);
insert into `employee` values(208,'小洪','1962-08-07','F',43000,3,206);
insert into `employee` values(209,'小黑','1974-11-28','M',22192,3,207);
insert into `employee` values(210,'小星','1989-01-05','F',23763,1,207);
insert into `employee` values(211,'小不勞博尼','1999-09-09','M',75000,2,206);
insert into `employee` values(212,'小彬彬','1987-06-05','F',32000,2,207);

select * from `employee`;
select * from `branch`;
select * from `client`;
select * from `works_with`;

update `branch`
set `manager_id`=206
where `branch_id`=1;

update `branch`
set `manager_id`=207
where `branch_id`=2;

update `branch`
set `manager_id`=208
where `branch_id`=3;

insert into `client` values(400,'John','4449863');
insert into `client` values(401,'Willam','1335963');
insert into `client` values(402,'Kave','4449863');
insert into `client` values(403,'Andrej','4449863');
insert into `client` values(404,'Roland','4449863');

insert into `works_with` values(206,400,'74000');
insert into `works_with` values(207,401,'91000');
insert into `works_with` values(208,402,'56000');
insert into `works_with` values(209,403,'5800');
insert into `works_with` values(210,404,'46551');
insert into `works_with` values(211,400,'95500');
insert into `works_with` values(212,402,'81000');

select * from `employee`;
select * from `client`;
select * from `employee` order by `salary`;
select * from `employee` order by `salary` desc limit 3;
select distinct `name` from `employee`;
#設定顯示name為不重複

select count(`sup_id`) from `employee`;# sup_id存在的資料筆數
select count(*) from `employee`; #所有的資料筆數
select count(*) from `employee` where `join_date` > '1990-01-01' and `sex` = 'F'; #找出1990年後出生的女性員工資料筆數
select avg(`salary`) from `employee`; #得出平均薪資
select sum(`salary`) from `employee`; #得出所有薪資加總
select max(`salary`) from `employee`; #得出所有薪資中的最大值
select min(`salary`) from `employee`; #得出所有薪資中的最小值

select * from `client` where `phone` like '%3'; #找出電話號碼以3結尾的
select * from `client` where `phone` like '%1%'; #找出電話號碼中包含1的
select * from `employee` where `join_date` like '_____11%'; #找出找出11月入職的項目 ( _ 代表一個字元 % 代表多個)

select `name` from `employee`
union
select `client_name` from `client`
union 
select `branch_name` from `branch`;
#顯示出name+client_name+branch_name的結果。
 
select `emp_id` as `ID`,`name` as `名字` from `employee` union
select `client_id`,`client_name` from `client`;
#as 別稱
select `salary` from `employee` union 
select `total_sales` from `works_with`;
#salary(7筆)+total_sales(7筆資料)

insert into `branch` values (4,'不做事',null);

select `emp_id`,`name`,`branch_name` from `employee` join `branch` on `employee`.`emp_id`=`branch`.`manager_id`;#找出員工ID等於主管ID的資料並印出ID+名字+部門名稱。
select `emp_id`,`name`,`branch_name` from `employee` left join `branch` on `employee`.`emp_id`=`branch`.`manager_id`;#找出員工ID等於主管ID的資料並印出ID+名字+部門名稱，員工資料全顯示。
select `emp_id`,`name`,`branch_name` from `employee` right join `branch` on `employee`.`emp_id`=`branch`.`manager_id`;#找出員工ID等於主管ID的資料並印出ID+名字+部門名稱，部門資料全顯示。

select `manager_id` from `branch` where `branch_name`='研發部';
select `name` from `employee` where `emp_id`= (
select `manager_id` from `branch` where `branch_name`='研發部'
);#從部門中找出研發部的id，在放進員工名單中找出研發部人員的名字。

select `emp_id` from `works_with` where `total_sales` > 50000;
select `name` from `employee` where `emp_id` in (select `emp_id` from `works_with` where `total_sales` > 50000);#找出業績超過五萬的員工id，再用id找出姓名。
