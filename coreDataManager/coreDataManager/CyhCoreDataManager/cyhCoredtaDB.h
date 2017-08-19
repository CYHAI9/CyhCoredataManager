//
//  cyhCoredtaDB.h
//  coreDataManager
//
//  Created by nopwd on 2017/8/19.
//  Copyright © 2017年 cyhaie. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface cyhCoredtaDB : NSObject

+ (instancetype)coredataDBShare;
- (instancetype)createCoredataDB:(NSString * )DBname;
+ (void)inserDataWith_CoredatamodelClass:(Class)modelclass CoredataModel:(void (^)(id))Coredatamodel Error:(void (^)(NSError * error))resutError;

//+ (void)selectDataWith_CoredatamoldeClass:(Class)modelclass Alldata_arr:(void(^)(NSArray * coredataModelArr))CoredatamodelArr Error:(void (^)(NSError * error))resutError;

+ (void)selectDataWith_CoredatamoldeClass:(Class)modelclass where:(NSString *)whereStr Alldata_arr:(void(^)(NSArray * coredataModelArr))CoredatamodelArr Error:(void (^)(NSError * error))resutError;

+ (void)deleteDataWith_CoredatamoldeClass:(Class)modelclass where:(NSString *)whereStr result:(void(^)(BOOL isResult))isresult Error:(void (^)(NSError * error))resutError;

+ (void)updataDataWith_CoredatamoldeClass:(Class)modelclass where:(NSString *)whereStr result:(void(^)(id))Coredatamodel Error:(void (^)(NSError * error))resutError;

@end
