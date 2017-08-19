//
//  DataModel+CoreDataProperties.h
//  coreDataManager
//
//  Created by nopwd on 2017/8/19.
//  Copyright © 2017年 cyhaie. All rights reserved.
//

#import "DataModel+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface DataModel (CoreDataProperties)

+ (NSFetchRequest<DataModel *> *)fetchRequest;

@property (nonatomic) int16_t num;
@property (nullable, nonatomic, copy) NSString *name;

@end

NS_ASSUME_NONNULL_END
