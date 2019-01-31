	多行子查询:
		如何查询和10号部门工作相同的雇员的名字,岗位,工资,部门号,但不包含10号部门
		 select name,job,sal,deptno
		 from emp;
		 where job in(select job from emp where deptno=10) and deptno<>10; --和任意一个相等
		 
		显示工资比30部门的所有员工的工资高的员工姓名、工资和部门
		 select name,sal,deptno from emp 
		   where sal > all(select sal from emp where deptno=30); --比所有的都大
		   
		 select name,sal,deptno from emp 
		   where sal > any(select sal from emp where deptno=30); --比任意一个都大
	
		查询和SMITH的部门和岗位完全相同的所有人,不包含SMITH本人
		 select deptno,name,job from emp where (deptno,job)=
		   (select deptno,job from emp where name = 'SMITH') and name <> 'SMITH';
	
		如何显示高于自己部门平均工资的员工信息
		 select name,sal,tmp.deptno from emp,
			(select deptno,avg(val) as asal from emp group by deptno) tmp; 
			--该查询结果就是名为tmp的一张表
			where emp.deptno=tmp.deptno and emp.sal>tmp.asal;
			内连接
	就是对多表查询的笛卡尔积进行过滤的查询方式,我们学习的都是内连接
	 select 字段 from 表1 inner join 表2 on 连接条件 and 其他条件;
	
	 select ename,dname from emp,dept 
		 where emp.deptno=dept.deptno and ename='SMITH';
内连接
	就是对多表查询的笛卡尔积进行过滤的查询方式,我们学习的都是内连接
	 select 字段 from 表1 inner join 表2 on 连接条件 and 其他条件;
	
	 select ename,dname from emp,dept 
		 where emp.deptno=dept.deptno and ename='SMITH';
	标准内连接写法:
	 select ename,dname from emp 
		inner join dept on emp.deptno=dept.deptno and ename='SMITH';
	
外连接
	 select student.name,my_class.name from student left join my_class 
		on my_class.id=student.class_id;
	left join:左边的表信息必须都存在,右边的表信息若没对应上就为null;
	 select student.name,my_class.name from student left join my_class 
		on my_class.id=student.class_id;
	right join:右边的表信息必须都存在,左边的表信息若没对应上就为null;
	