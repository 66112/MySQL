
日期函数
	select current_date();
	select current_time();
	select current_timestamp();
	select date(current_timestamp());  --获取括号里时间的年-月-日 
	select time(current_timestamp());  --获取括号里时间的时-分-秒
	select date_add(date1,interval d_value_d_type);  --在date1上加日期或时间
	select date_sub(date2,interval d_value_d_type); --在date2上减日期或时间
	select datediff(date1,date2);   --两个日期差多少天
	select now();  --当前时间
		create table tmp(
			id int primary key auto_increment,
			birthday date
		);
		create table Msg(
			id int primary key auto_increment,
			conten varchar(100) not null,
			sendtime datetime  
		);
		select * from Msg 
			where date_add(sendtime,interval 10 minute) > now();
		10分钟内发过的消息

字符串函数
	select charset(str);   --查看str的字符集
	select concat(str1,str2,..);  --拼接字符串
	select instr(str1,str2);  --返回str2在str1中第一次出现的位置,没有返回0,下标从1开始
	select ucase(str);  --将小写字母转换为大写
	select lcase(str);  --将大写字母转换为小写
	select left(str,length);  --从str的左边起取length个字符
	select length(str);  --str长度,返回字节个数(切记！！！)
	select replace(str,str1,str2);  --在str中用str2替换str1
	select strcmp(str1,str2);  --逐字符比较两个字符串的大小,不区分大小写,str1>str2,返回1,=返回0,小于返回-1
	select substring(str,pos,[,len]);  --从str的pos位开始,取len个字符,从1开始
	select ltrim(str);  rtrim(str); trim(str);  --去除前空格或后空格
	
	--显示student表中的信息,显示格式:
	--'xxx的语文成绩是xxx分,数学xxx分,英语xxx分'
	select concat(name,'语文成绩:',chinese,'分 ') as '分数' from teacher;
	--求学生表中名字和名字占用的字节数
	select name,length(name) from teacher;
	--将表中所有名字中有'S'的都替换成'上海'
	select replace(name,'蛋','上海') from teacher;
	--截取表中name字段的第二个到第三个字符
	select substring(name,2,2),name from teacher;
	--将所有名字的第一个字母转成小写,其余字母全部大写
	select concat(lcase(substring(name,1,1)),
		ucase(substring(name,2))),name from teacher;
	select lcase(substring(name,1,1)),name from teacher;  --第一个小写
	select ucase(substring(name,2)),name from teacher;  --之后全部大写
	
数学函数
	select abs(num);  --绝对值
	select bin(num);  --转换为二进制
	select ceiling(num); --向上取整
	select floor(num);   --向下取整
	select rand();  --产生随机数,0~1之间 rand()*100;1~100之间
	select hex();  --十六进制
	select format(num,len);  --对num的小数位取len个,会四舍五入 format(rand()*10,0); 1~10
	select mod(num1,num2);  --取模  mod(5,2);  5%2=1
	select conv(num,from_base,to_base);  -- 将num从原进制转换为目标进制
	
其他函数
	select user();  --查看当前用户
	select database();  -- 当前的数据库
	md5(str);     --对一个字符串进行加密，转换后的长度为32个字节
	password()函数;  --对mysql用户加密
	ifnull(val1,val2);  --如果val1为null,就用val2;如果val1不为null,就用val1
聚合函数
	1.count函数
	  count(列名|*);统计总行数
	  count(列名)会排除值为null的情况,count(*)则不会
		select count(*) from teacher;
	2.sum函数
	  select sum(chinese) as '语文',sum(math) as '数学',sum(english) as '英语' from teacher;
	  ...