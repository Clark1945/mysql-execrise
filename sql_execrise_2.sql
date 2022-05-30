set sql_safe_updates = 0;
show databases;
use sql_tutorial;

create table `student`(
	`stu` int primary key auto_increment,
    `name` varchar(5) not null,
    `major` varchar(10) default "未修課",
    `score` int
);

select * from `student`;

insert into `student`(`name`,`major`,`score`) values(
	"Joe","English",82
);
insert into `student`(`name`,`major`,`score`) values(
	"Ben","Chinese",91
);
insert into `student`(`name`,`major`,`score`) values(
	"John","German",66
);
insert into `student`(`name`,`major`,`score`) values(
	"Carl","Polish",59
);
drop table `student`;
select * from `student`;
describe `student`; 
# 描述規格

alter table `student` drop `score`;
alter table `student` add (`分數` int);
#改變資料規格

update `student`
set `major` = '英語' ,`name`='英文應試生'
where `major` = 'English' or `major` ='英文';
#將Major為English或英文的改成英語，並將名字改成英文應試生

update `student`
set name="Joe" 
where stu=4;
#四號同學設定為Joe

delete from `student`
where `stu`=4 and `name`="Joe";
#將四號的Joe從資料表中刪除

delete from `student`
where `score`<60;
#清除不及格的同學資料

select `name`,`score` from `student`
where `score`>60 or `name` = "John"
order by `score` desc,`name`
limit 2;
#從學生資料表中找出分數大於60或是名字為John的人，將資料以分數排序，一樣則用分數排序。顯示出名字與分數。

select `name`,`score` from `student`
where `major` in('英語','English','英文');
#從學生資料表中 選擇 科系為 English 英語 英文 的學生，並顯示出名字 與 分數







