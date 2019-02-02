索引：以空间换时间(B+树)
	水平分割：将大表划分为多张表;
	垂直分割：将表的列分为多个,再用主外键关系建立连接;
	create index index_name on 表名(作为索引的列名)
	create index emp_idx on emp(empno);
	
	I.主键索引
	II.唯一键索引
	III.普通索引
	create index emp_idx on emp(empno);
--优化	
	select * from biao where input like '%gitbook%';
	切记：模糊查询不要将%放在前边,否则查询效率会大大降低
	explain select * from emp where empno=12345;  --查询该语句的快慢
	
	IV.全文索引
	速度: 主键 > 唯一键 > 普通
	索引的使用：
		a.查询索引
		  show keys from 表名
		b.删除索引
		  alter table 表名 drop index 索引名
		  
	创建索引的原则:
		a.比较频繁作为查询条件的字段应该创建索引;
		b.唯一性太差的字段不适合单独创建索引,即使频繁作为查询条件;
		c.更新非常频繁的字段不适合创建索引;
		d.不会出现在where子句中的字段不适合创建索引