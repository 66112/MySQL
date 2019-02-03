事务： --ACID特性
	概念：一系列的sql语句在开启事务后,要么全都发生,要么都不发生;
	ACID:
	A:原子性
	  事务是一个不可分割的工作单位,事务中的所有操作,要么都发生,要么都不发生。
	C:一致性
	  事务使得数据库始终保持在一个一致的的状态。
	I:隔离性
	  多个用户并发访问数据库时,数据库为每一个用户开启的事务不会被其他用户所干扰。
	D:持久性
	  事务一旦提交,对数据库的修改就是永久性的。
	
	start truncation;   --开启一个事务
	  update account set bal = bal-2 where id=1;
	  update account set bal = bal+2 where id=2;
	  ...
	  1w个sql语句
	  
	 commit;   --结束一个事务
	 --如果中间出现任何异常 
	 rollback 恢复到事务开启之前的状态
	 
	 保存点 savepoint a;
	 
	 start transaction;
	 savepoint a;
	 SQL...
	 SQL...
	 savepoint b;
	 SQL...
	 rollback to b;   --一旦回到某个点,这个点之后的SQL语句全部删掉
	 commit;
	 
	--账户表
	create table account(
		id int primary key,
		name varchar(50) not null default '',
		balance decimal(10,2) not null default 0.0
	);
	insert into account values(1,'宋江',1000),(2,'武松',5),(3,'鲁智深',5000),(4,'林冲',2000);

	事务的隔离级别
							 脏读    不可重复读    幻读    加锁读
(read uncommitted)读未提交    对        对 		  对      不加锁
(read commited)	  读已提交    错        对        对      不加锁
(repeatable read) 可重复读    错        错        错      不加锁
(serializable)	  可串行化    错        错        错      加锁读

	--事务的并发问题
	脏读:事务1中所修改的内容,在没提交之前,事务2中也能看的到;
	不可重复读:事务1中所修改的内容,提交之后;事务2可以看到叫不可重复读,看不到叫可重复读;
	幻读:事务1进行了插入操作,提交之后;事务2能看到插入结果叫出现了幻读,
		看不到插入结果,叫未出现幻读;
		  例如：事务2刚看到事务1的钱为100,准备用这个数据操作,
		   但是这时事务1又花了50,这对事务2来说就像出现了幻觉;
	设置事务的隔离级别
	 set session transaction isolation level read uncommitted;
	查看当前事务级别
	 select @@tx_isolation;
	 
视图
	create view 视图名 as select 列1,列2... from emp where 条件;   -- 创建视图
	drop view 视图名;   --删除视图
	条件:
	  1.表要占用磁盘空间,视图不需要
	  2.视图不能添加索引
	  3.提高安全性
	  4.简化查询
	注意：视图是虚的,相当于表的别名,mysql可以更改视图,底层的表也会改变.两者相互影响
	
用户管理
	create user '用户名'@'登陆主机/ip',identified by '密码';  --创建用户
	drop user '用户名'@'主机ip';  --删除用户
	select host,user,password from mysql.user;   --查看创建的用户 
	set password = password('123'); --自己改密码
	set password for '用户名'@'主机名' = password('123456');  --root改密码
	
权限
	授予权限
	 grant 权限列表 on 库.对象名 to '用户名'@'登陆主机' [identified by '密码'];
	  权限列表 select,drop,update,insert,delete...
	 grant 库.* on 库.对象名 to '用户名'@'登陆主机';  --授予该库的所有权限
	 
	回收权限
	 revoke 权限列表 on 库.对象名 from '用户名'@'登陆主机';
	  revoke all on 库.对象名 from '用户名'@'登陆主机';  --回收所有权限