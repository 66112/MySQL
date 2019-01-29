d.select的order by 语句
			select [distinct] [*]|[列名1,列名2..]
				from 表名
				[where]
				order by 列名 asc | desc;
		 I.asc升序(默认), desc降序
		 II.order by 语句处于select语句的末尾
		 III.order by 语句可以使用select起的别名
		
		 对所有数学成绩排序
		 select name,math
		 	from teacher
			order by math;
		 按照总分进行排序并输出学生姓名
		 select name,(chinese+math+english) as total
			from teacher
			order by total;
		 对所有姓蛋的学生按照成绩从高到低进行排序,输出总成绩和姓名
		 select name,(chinese+math+english) as total
			from teacher
			where name like '蛋%'
			order by total desc;
		
		e.select的分页查询(水平分割)利用条件过滤大量信息
			select 字段名 from 表名 where 条件 limit 起始位置,记录条数
		  
		  查询所有学生信息,每页显示2条记录,请分别显示第一页,第二页
		  select * from teacher 
			limit 0,2;  起始下标0，显示2条记录
			
		f.group by 语句
			create table emp(
				empnc int(6) unsigned zerofill not null comment '员工编号',
				ename varchar(10) comment '员工姓名',
				job varchar(9) comment '工作',
				mgr int(4) unsigned zerofill comment '该员工直属领导的编号',
				hiredate datetime comment '雇佣日期',
				sal decimal(7,2) comment '薪水',
				comm decimal(7,2) comment '奖金',
				deptno int(2) unsigned zerofill comment '员工所属部门的编号'
			);
			foreign key(deptno) references dept(deptno)
			create table dept(
				deptno int(2) unsigned zerofill primary key comment '部门编号',
				dname varchar(14) comment '部门名称',
				loc varchar(13) comment '部门地址'
			);
			
			 显示每个部门的平均和最高工资(sal deptno)
			  select avg(sal),max(sal),deptno
				from emp
				group by deptno;
				
			 显示每个部门的每种岗位的平均工资和最高工资
			  select avg(sal),max(sal) as ms
				from emp
				[where] 条件1 条件2  --执行顺序是从后向前执行
				group by deptno,job;  --先按部门分组,再按岗位分组
				order by deptno,ms desc; --部门是升序,ms是降序
				
			 显示平均工资低于2000的部门和它的平均工资
			  select deptno,avg(sal) as my_avg
				from emp;
				group by deptno
				having my_avg < 2000;   --分组之后过滤
			  group by 子句只能搭配 having 条件使用,不能使用where
			  
			 使用年薪进行排序
			  select name,sal*12+ifnull(comm,0) as total from emp order by total desc;
			 
			 显示工资高于平均工资的员工信息
			  select * from teacher
			    where english > (select avg(english) from teacher);
				
			 显示每种岗位的雇员总数,平均工资
			  select job,count(*),format(avg(sal),2) from emp group by job;
			  