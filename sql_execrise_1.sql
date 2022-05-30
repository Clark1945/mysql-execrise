
#CREATE DATABASE `sql_tutorial`;
#DROP DATABASE `sql_tutorial`;
SHOW DATABASES;
USE `sql_tutorial`;
CREATE TABLE stu(
	`student_id` INT primary key auto_increment,
    `name` varchar(5) not null,
    `major` varchar(10) default 'ナコトの住民'
);

describe `stu`;
drop table `stu`;

alter table `stu` add gpa decimal(3,2);
alter table `stu` drop column gpa;

select * from `stu`;

insert into `stu` values(
'アサカ','作り物'
);
insert into `stu` values(
'ブリジット','ツンデレ'
);
insert into `stu`(`name`,`major`) values(
'カティア','聖女'
);
insert into `stu` values(
'ジゼル','エッチな人'
);
insert into `stu`(`name`,`major`) values('ダナ','');
#insert into `stu`(`name`,`major`,`student_id`) values('エデル',4);