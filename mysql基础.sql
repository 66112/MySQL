一、数据库的基本操作语句
--创建库
create database Msg;
--使用库
use Msg;
--创建表
create table teacher(
	name varchar(32),  --姓名
	age int);   --年龄

--查看当前库中有哪些表
show tables;
--删除表teacher
drop table teacher;

--往表中插入数据
	insert into teacher(name,age)value('范冰冰',58);
	insert into teacher(age,name)value('78','冯小刚');
	insert 进阶
	
	若违反主键约束,要强行插入
	insert into tb_name values('1',...) on duplicate key update 字段=新值
	若无主键冲突
	replace into tb_name(字段) values(值);
--查询表中数据
	select name,age from teacher;
--删除表中信息
    delete from teacher [where name='fanbingbing'];
	I.不带where条件,删除全表信息,会返回总共删除的个数
	II.truncate table tb_name;  清空表,不会返回删除的个数,
	   直接把文件大小变为0,速度更快
	III.drop直接删除表结构,表结构一般和表内容不在一个文件内
--更新表的数据
	update tb_name set 属性名=属性值...[where条件][limit n];
	update tb_name set name = '张三' limit 2;  --更新前两行
	I.没有where语句的更新为列属性值全部更新
	II.列更新时,可以跟上limit来限制更新的个数
	III.有where条件,只会更新满足where条件的相应行
--查看表结构
    desc teacher;
--复制表结构
	create table test1 like test;
--复制表数据
	insert into test1 select* from test;
--SQL分类
	--1.DDL create,drop,alter
	--2.DML insert delete,update
	--3.DQL select 
	--4.DCL grant(授权),revoke(收权),commit
---------------------------------------------------
二、库的操作
--语法: create database [if not exists] db_name [createspecification],...
         --createspecification:
		        --charset          //
				--collecte         //比较方法
--1.创建库
create database company1;

--查看创建数据库的系统给定的语句
show create database company1;
--CREATE DATABASE `company1` /*!40100 DEFAULT CHARACTER SET latin1 */
--注意: /*!40100 DEFAULT ...*/
--表示mysql >=4.01版本才执行这句话

--如何查看当前数据库版本
select version();

--2.创建库,使用utf-8字符集
create database company2 charset=utf8;
--CREATE DATABASE `company2` /*!40100 DEFAULT CHARACTER SET utf8 */

--3.创建库,使用utf-8字符集,并制定校验规则
create database company3 charset=utf8 collate utf8_general_ci;

--查询字符集及校验规则
	show charset;
--校验规则
	utf_general_ci:不区分大小写
	utf8_bin:区分大小写
--创建 k1(utf8_general_ci),k2(utf8_bin)
create database k1 collate utf8_general_ci;
create database k2 collate utf8_bin;

use k1;   //不区分大小写排序
create table ttt(name char(1),id int);
insert into ttt(name,id) values('a',1),('A',2),('b',3),('B',4),('A',5);
--查询数据，按照name列排序
select name,id from ttt order by name;

use k2;   //区分大小写排序
create table ttt(name char(1),id int);
insert into ttt(name,id) values('a',1),('A',2),('b',3),('B',4),('A',5);
--查询数据，按照name列排序
select name,id from ttt order by name;

--删除库：drop database 库名;  --实际工作中禁止使用

--查看有哪些客户端登陆该数据库
show processlist;

--备份数据
--mysqldump -u root -p msg > msg.bk  在命令行输入
--恢复数据
mysql -u root -p 
create database msg;
use msg;
source ./msg.bk;

--修改字符集
alter database [if not exists] db_name charset=utf8;