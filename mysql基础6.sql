	2.多表查询
		显示员工姓名、工资以及所在部门的名字
		 select ename,sal,dname
			from emp,dept; --(笛卡尔积),全排列
			where emp.deptno = dept.deptno; --将这两项合并,去掉冗余项
		  多表中冲突的列名要加上表名,以示区别
		
		显示部门号为10的部门名,员工名和工资
		 select dname,ename,sal
			from emp,dept
			where emp.deptno = dept.deptno
			and dept.deptno = 10;  --用两个表都没区别,但必须要指明是哪个表的
			
		显示各个员工的姓名、工资、工资级别
		 select name,sal,grade
			from emp,dept,salgrade
			where sal between losal and hisal;
			
		显示员工FORD的上级领导的姓名   
		 select name from emp where select mgr from emp  --子查询
			where name = 'FORD'; 
		 select manager.name from emp worker,emp manager --自连接(将一个表看成两个表)
			where worker.mgr = manager.empno and worker.name = 'FORD';
		 
	单行子查询:嵌套在其他sql语句中的select语句,也叫叫嵌套查询
	    显示'SMITH'同一部门的所有员工信息
		 select * 
			from emp
			where deptno = (select deptno
			from emp
			where ename = 'SMITH') and ename <> 'SMITH';
			
		查出'SMITH'的部门
		 select deptno
			from emp
			where ename = 'SMITH';