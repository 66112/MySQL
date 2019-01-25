三、表的操作
--创建表:
	create table 表名(
		字段1 类型1,
		字段2 类型2,
		...
	)charset=字符集 collate 校验规则 engine 存储引擎;
	
create table user(
	id int comment '用户唯一编号',
	name varchar(32) comment '用户名',
	passward char(32) comment '经过MD5加密的用户密码',
	birthday date
)charset=utf8 engine MyISAM;

--查看表的列描述
desc user;
show create table user\G   (不加;)

--修改表
	--增加列
	alter table 表名 add (field datatype);
	alter table user add addr varchar(60);  '默认插在最后边'
	alter table user add (sex int) after name;  '没有before'
	alter table user add bh int first;    '插在第一列'
	--改变列的类型
	alter table 表名 modify 列名 新的类型
	alter table user modify name varchar(60);
	--删除列,本列的数据全部没了
	alter table 表名 drop addr;
	--该表名
	alter table 表名 rename to 新表名;
	--修改表的字符集
	alter table user charset=latin1;
	--修改列的字符集
	alter table user modify name varchar(60) character set utf8; '不能用charset=utf8'
	
	create table t2(a,tinyint unsigned);
	alter table t2 add b tinyint unsigned;
	insert into t2 values(5,10);
	set sql_mode = 'NO_UNSIGNED_SUBTRACTION';  '临时配置'
--位操作
	create table t3(a bit(8),b int); 
	insert into t3 values(10,10);
	insert into t3 values(70,70);
	--注意：bit类型数据显示的是它的ASCII码
	hex(a):显示a的十六进制
	create table t4(sex bit(1));
	show warnings;    '显示警告信息'

--小数的基本使用
	float(m,n);  'm是总宽度,n是小数位数'
	float(4,2);  '-99.99 ~ 99.99'
	create table t5(sal float(4,2));
	insert into t5 values(-99.99),(99.99);
	insert into t5 values(99.999);  '报错'
	insert into t5 value(99.991);  '成功'
	--先四舍五入,再插入数据,如果越界,就报错
	
	decimal(m,d);   'm最大65,d最大30'
	create table t6(sal1 float(12,8),sal2 decimal(12,8));
--对精度要求高,推荐使用decimal

--字符串
	char(L) 'L表示长度,单位是字符[0-255]',L个字母或 L个汉字
	create table t7(info char(7));
	
	varchar(L) 'L <= 65535'
	create table t8(msg varchar(32));   --不能超过给定的字符个数
	create table t9(china,varchar(65535)); 
	--存字母最多65535个 charset=latin1
	--存汉字最多65535/3=21845-1=21844个 charset=utf8
	--mysql设定表列所有长度之和不能超过65535个字节
	
	--定长字符串检索效率高,空间利用率低;
	--变长字符串检索效率低,空间利用率高。
	
--日期和时间
	create table t10(a date,b datetime,c timestamp);
	date  -- 年月日
	datetime --年月日 时分秒
	timestamp --时间戳 整数
	insert into table t10 values('2019-1-22','2019-1-22 20:14:30','1997-7-1 0:0:0');
	now()  --获取当前时间,可自动转换成想要存储的类型
	insert into t10 values(now(),now(),now());
	
--枚举和set
	create table votes(
		name varchar(30),
		hobby set('登山','游泳','篮球','武术'),  '可多选'
		gender enum('男','女')                   '只能选一个'
	);
	insert into votes values('马云','武术,游泳','男');

	select * from votes where hobby='武术';
	select * from votes where like '武术';  --等价
	
	select find_in_set('a','a,b,c');
	--在后边的集合中找前面的元素,找到了返回下标;没找到,返回0;
	select * from votes where find_in_set('武术',hobby);
	--返回在 hobby 中有 武术 的人的名单 