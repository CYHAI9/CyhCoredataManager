//
//  DataModel+CoreDataProperties.m
//  coreDataManager
//
//  Created by nopwd on 2017/8/19.
//  Copyright © 2017年 cyhaie. All rights reserved.
//

#import "DataModel+CoreDataProperties.h"

@implementation DataModel (CoreDataProperties)

+ (NSFetchRequest<DataModel *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"DataModel"];
}

@dynamic num;
@dynamic name;

@end
