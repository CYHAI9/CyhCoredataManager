//
//  cyhCoredtaDB.m
//  coreDataManager
//
//  Created by nopwd on 2017/8/19.
//  Copyright © 2017年 cyhaie. All rights reserved.
//

#import "cyhCoredtaDB.h"

@interface cyhCoredtaDB ()

@property (nonatomic , strong)NSManagedObjectContext *context;
@end

@implementation cyhCoredtaDB
static cyhCoredtaDB * coredataDB;
+ (instancetype)coredataDBShare
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        coredataDB  = [[cyhCoredtaDB alloc] init];
    });
    
    return coredataDB;
}
- (instancetype)createCoredataDB:(NSString * )DBname
{
    ///这里对构建新版本的coredataModel有关键作用
    NSDictionary *optionsDictionary = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:YES],NSMigratePersistentStoresAutomaticallyOption, [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption, nil];
    
    //    //打开模型文件，参数为nil则打开包中所有模型文件并合并成一个
    //    NSManagedObjectModel *model = [NSManagedObjectModel mergedModelFromBundles:nil];
    //1.根据模型文件，创建NSManagedObjectModel模型类
    NSURL * fileURL = [[NSBundle mainBundle] URLForResource:DBname withExtension:@"momd"];
    NSManagedObjectModel *model = [[NSManagedObjectModel alloc] initWithContentsOfURL:fileURL];
    //创建数据解析器
    NSPersistentStoreCoordinator *storeCoordinator =
    [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:model];
    
    //创建数据库保存路径
    NSString * dbPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/Mycoredata.sqlite"];
    NSURL *url = [NSURL fileURLWithPath:dbPath];
    
    //添加SQLite持久存储到解析器
    NSError *error;
    [storeCoordinator addPersistentStoreWithType:NSSQLiteStoreType
                                   configuration:nil
                                             URL:url
                                         options:optionsDictionary
                                           error:&error];
    
    
    if( !error ){
        //创建对象管理上下文，并设置数据解析器
        [cyhCoredtaDB coredataDBShare].context = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
        [cyhCoredtaDB coredataDBShare].context.persistentStoreCoordinator = storeCoordinator;
        NSLog(@"数据库打开成功！");
    }else{
        NSLog(@"数据库打开失败！错误:%@",error.localizedDescription);
    }
    
    
    return self;
    
}

+ (void)inserDataWith_CoredatamodelClass:(Class)modelclass CoredataModel:(id (^)(id))Coredatamodel Error:(void (^)(NSError *))resutError
{
    NSEntityDescription * classDescription = [NSEntityDescription entityForName:NSStringFromClass(modelclass) inManagedObjectContext:[cyhCoredtaDB coredataDBShare].context];
   id modelobject = [[modelclass alloc] initWithEntity:classDescription insertIntoManagedObjectContext:[cyhCoredtaDB coredataDBShare].context];
     Coredatamodel(modelobject);
    NSError * error = nil;
    [[cyhCoredtaDB coredataDBShare].context save:&error];
    
    resutError(error);
}

+ (void)selectDataWith_CoredatamoldeClass:(Class)modelclass Alldata_arr:(void (^)(NSArray *))CoredatamodelArr Error:(void (^)(NSError *))resutError
{

    NSFetchRequest * request = [[NSFetchRequest alloc] initWithEntityName:NSStringFromClass(modelclass)];
    //n.
    NSError * error = nil;
    NSArray * array = [[cyhCoredtaDB coredataDBShare].context executeFetchRequest:request error:&error];

    CoredatamodelArr(array);
    
    resutError(error);
}


+ (void)selectDataWith_CoredatamoldeClass:(Class)modelclass where:(NSString *)whereStr Alldata_arr:(void (^)(NSArray *))CoredatamodelArr Error:(void (^)(NSError *))resutError
{
    NSFetchRequest * request = [[NSFetchRequest alloc] initWithEntityName:NSStringFromClass(modelclass)];
    if (whereStr) {
        //设置筛选条件
        // =
        // CONTAINS
        // BEGINSWITH
        // ENDSWITHD
        NSPredicate * predicate = [NSPredicate predicateWithFormat:whereStr];
        request.predicate = predicate;
    }
  
    //n.
    NSError * error = nil;
    NSArray * array = [[cyhCoredtaDB coredataDBShare].context executeFetchRequest:request error:&error];
    if (error) {
        NSLog(@"core错误：%@",error);
    }
    //    NSLog(@"%@===%@==%ld",mp.appearNum,mp.mac,array.count);
    CoredatamodelArr(array);
}

+ (void)deleteDataWith_CoredatamoldeClass:(Class)modelclass where:(NSString *)whereStr result:(void (^)(BOOL))isresult Error:(void (^)(NSError *))resutError
{
    NSEntityDescription *description = [NSEntityDescription entityForName:NSStringFromClass(modelclass) inManagedObjectContext:[cyhCoredtaDB coredataDBShare].context];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    if (whereStr) {
    NSPredicate * predicate = [NSPredicate predicateWithFormat:whereStr];
    request.predicate = predicate;
    }
    [request setIncludesPropertyValues:NO];
    [request setEntity:description];
    NSError *error = nil;
    NSArray *datas = [[cyhCoredtaDB coredataDBShare].context executeFetchRequest:request error:&error];
    if (!error && datas && [datas count])
    {
        for (NSManagedObject *obj in datas)
        {
            [[cyhCoredtaDB coredataDBShare].context deleteObject:obj];
        }
        if (![[cyhCoredtaDB coredataDBShare].context save:&error])
        {
             isresult(NO);
        }
        else
        {
            isresult(YES);
        }
    }
    
    resutError(error);
}

+ (void)updataDataWith_CoredatamoldeClass:(Class)modelclass where:(NSString *)whereStr result:(id (^)(id))Coredatamodel Error:(void (^)(NSError *))resutError
{

    NSPredicate * pre = [NSPredicate predicateWithFormat:whereStr];
    NSEntityDescription * description = [NSEntityDescription entityForName:NSStringFromClass(modelclass) inManagedObjectContext:[cyhCoredtaDB coredataDBShare].context];
    NSFetchRequest * request = [NSFetchRequest new];
    request.entity = description;
    request.predicate = pre;
    NSArray * array = [[cyhCoredtaDB coredataDBShare].context executeFetchRequest:request error:NULL];
    
    for (id modelobject in array) {
        
        Coredatamodel(modelobject);
        [[cyhCoredtaDB coredataDBShare].context updatedObjects];
        
    }
 

}

@end
