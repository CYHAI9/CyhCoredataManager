
pod  'CyhCoreDataManager'

1.创建一个数据库，名字是创建的coredata的文件名字
[[cyhCoredtaDB coredataDBShare] createCoredataDB:@"coredataModel"];

2.添加数据

[cyhCoredtaDB inserDataWith_CoredatamodelClass:[DataModel class] CoredataModel:^(DataModel * model) {
        
        model.num = model01.num;
        model.name = model01.name;
    
    } Error:^(NSError *error) {
       
    }];

3.查询数据

```
[cyhCoredtaDB selectDataWith_CoredatamoldeClass:[DataModel class] where:@"num = 100" Alldata_arr:^(NSArray *coredataModelArr) {
        
        [coredataModelArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
           DataModel * model = obj;
            NSLog(@"条件查询：%d==%@",model.num,model.name);
        }];
        
    } Error:^(NSError *error) {
        
    }];
 ```

4.更改数据
```
[cyhCoredtaDB updataDataWith_CoredatamoldeClass:[DataModel class] where:@"num = 100" result:^(DataModel * model){
        
        model.num = 10;
        
    } Error:^(NSError *error) {
        
    }];
```
5.删除数据
```
[cyhCoredtaDB deleteDataWith_CoredatamoldeClass:[DataModel class] where:@"num = 100" result:^(BOOL isResult) {
        
        NSLog(@"0失败1成功：%d",isResult);
    } Error:^(NSError *error) {
        
    }];
  ```
