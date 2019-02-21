# mysql面试真题

执行"select * from test where id in(3,1,5);"的结果按照in中得条件排序,即:3,1,5
```sql
select * from test where id in(3,1,5) order by field(id,3,1,5);
```
