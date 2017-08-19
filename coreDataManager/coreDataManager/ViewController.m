//
//  ViewController.m
//  coreDataManager
//
//  Created by nopwd on 2017/8/19.
//  Copyright © 2017年 cyhaie. All rights reserved.
//

#import "ViewController.h"
#import "dataModel.h"
#import "DataModel+CoreDataClass.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

   [[cyhCoredtaDB coredataDBShare] createCoredataDB:@"coredataModel"];
    
}

- (IBAction)add:(UIButton *)sender {
    
   __block dataModel * model01 = [dataModel new];
    model01.num = 100;
    model01.name = @"coredata数据";
    [cyhCoredtaDB inserDataWith_CoredatamodelClass:[DataModel class] CoredataModel:^(DataModel * model) {
        
        model.num = model01.num;
        model.name = model01.name;
    
    } Error:^(NSError *error) {
       
    }];
}


- (IBAction)select_where:(id)sender {
    //wherestr:nil 时则全部查询
    [cyhCoredtaDB selectDataWith_CoredatamoldeClass:[DataModel class] where:@"num = 100" Alldata_arr:^(NSArray *coredataModelArr) {
        
        [coredataModelArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
           DataModel * model = obj;
            NSLog(@"条件查询：%d==%@",model.num,model.name);
            
        }];
        
    } Error:^(NSError *error) {
        
    }];
    
}

- (IBAction)delect:(id)sender {
    //wherestr:nil 时则全部删除
    [cyhCoredtaDB deleteDataWith_CoredatamoldeClass:[DataModel class] where:@"num = 100" result:^(BOOL isResult) {
        
        NSLog(@"0失败1成功：%d",isResult);
    } Error:^(NSError *error) {
        
    }];
}

- (IBAction)updata:(id)sender {
    
    [cyhCoredtaDB updataDataWith_CoredatamoldeClass:[DataModel class] where:@"num = 100" result:^(DataModel * model){
        
        model.num = 10;
        
    } Error:^(NSError *error) {
        
    }];
    
}

@end
