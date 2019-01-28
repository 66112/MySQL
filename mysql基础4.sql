查询 
	1.单表查询
		select [distinct] [*]|[列名1,列名2..] 
			from 表名 [where][order by][group by];
		a.去重查询
		  distinct
		b.select语句可以为结果取别名
		  查询学生总成绩及学生姓名
		  select name,(chinese+math+english) as '总成绩'
			from student;
		  将所有姓唐的学生总成绩增加60%并输出姓名与总成绩
		  select name,(chinese+english+math)*1.6 as '总成绩'
				from teacher
				where name like '唐%';
		c.select的where子语句
		  where子句对查询进行过滤，不可使用select语句起的别名
		  因为,命令会先执行where条件,然后才执行select语句。
		  where在从磁盘上拿数据时就直接过滤
		  select * from teacher where name <> '唐僧'; 在结果中排除唐僧
		  比较运算符 > < != <>(排除)
					 between ... and ... 区间   左闭右闭
					 in(数1,数2,数3..)     满足数1或数2或数3的结果
					 like ''    模糊查询
					 not like ''
					 is null    判断是否为空
		  逻辑运算符 and
					 or
					 not 
		  查询所有李姓的学生成绩和他的姓名
		  select name,chinese,english,math from teacher where name like '李%';
		  查询所有英语成绩大于语文成绩的同学
		  select name,english,chinese from teacher where english>chinese;
		  查询所有总分大于200的学生姓名和他的总成绩
	(3)	  select name,(chinese+english+math) as '总成绩' 
	(1)		from teacher 
	(2)		where (chinese+math+english) > 200;
		  查询所有总分大于200并且数学成绩小于语文成绩的姓唐的学生
		  select name from teacher
			where (chinese+math+english)>200
			and math < chinese
			and name like '唐%';
		  查询英语分数在80~90之间的学生
		  select name,english 
			from teacher
			where english between 80 and 90;
		  查询英语成绩为89,90,91的所有同学姓名和英语成绩
		  select name,english from teacher
			where english in(89,90,91);