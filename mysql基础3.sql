约束
--1.空属性约束 null
	--数据为空运算结果全是空
	--定义表时，尽量保证字段不为空 not null 
	create table t11(
		id int,
		name varchar(10) not null
	);
--2.默认值 default
	create table t12(
		id int not null,
		name varchar(10) not null,
		sex char(1) default '男' not null
	);
	not null 和 default 互不影响,可以在有默认值的情况下插入null值
--3.列描述(不是注释) comment
	create table t13(
		username varchar(10) not null comment '该字段描述用户名',
		password varchar(30) not null comment '该字段存储用户密码'
	);
--4.自动补零(zerofill)
	create table t14(
		num1 int,
		num2 int(4) zerofill
	);
	insert into t14 values(12,12); --num2不够会前置补零

--5.主键 primary key
	单一主键 
	--逐渐约束的属性不能为空,不能为重复,一张表有且只有一个主键
	--主键所在的列通常是一个整数类型
	create table t15(
		id int primary key comment '描述学生id',
		name varchar(10) not null comment '描述学生姓名'
	);
	insert into t15 values(1,'测试1'),(2,'测试2');
	insert into t15 values(1,'测试3');   -- 错误,主键冲突
	
	复合主键(多个字段共同做为主键)
	create table t16(
		id int comment '描述课程名称',
		name varchar(10) comment '描述课程名称',
		time datetime not null comment '时间',
		primary key(id,name) comment 'id与name作为复合主键'
	);
	--单个主键可以重复,组合主键不能重复
	创建表之后追加主键
	alter table tb_name add primary key(字段名);
	主键删除
	alter table tb_name drop primary key;

--6.自增长 auto_increment
	--当自增长字段插入时不给值,系统自动触发,在当前最大值基础上
		(只要表中出现过最大值x,即使x被删了,下次自增长时仍从x往后)+1
	--通常和主键搭配使用,作为逻辑主键
	
	--任何字段要想做自增长,前提必须是一个索引(key 栏有值)
	--自增长字段必须为整数
	--一张表有且只有一个自增长
	create table t17(
		id int primary key auto_increment,
		name varchar(10) not null
	);
	
--7.唯一键 unique
	--唯一键解决表中有多个字段需要唯一性约束的问题
	--唯一键允许数据为空,null不作比较,即可以插入多个null
	create table t18(
		id int unique,
		name varchar(10) not null
	);
	
--8.外键 
	foreign key(从表所在列) references 主表(列)
	--用于定义主表与从表的关系,解决冗余
	--外键加在从表上,外键约束对应主表列必须有主键约束或者唯一键约束
	--定义外键后,要求外键列数据必须在主表中存在或者为null
	--主表
	create table my_class(
		id int primary key comment '班级id',
		name varchar(10) not null comment '班级姓名'
	);
	--从表
	create table student(
		id int primary key comment '学生id',
		name varchar(10) not null comment '学生姓名',
		class_id int,
		foreign key(class_id) references my_class(id)
	);
	外键可以为NULL;
	班级必须存在或为null,即在从表插入数据时,应考虑主表是否存在对应的主键;