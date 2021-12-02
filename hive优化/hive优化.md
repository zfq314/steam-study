###### 1、优化第一步查看执行计划

```
explain query sql
```

2、hive maper 的指定和reducer的指定

```
maper数不能指定， 决定map的数据的决定因素有: input的文件总个数，input的文件大小，集群设置的文件块大小
reducer可以指定的
```

