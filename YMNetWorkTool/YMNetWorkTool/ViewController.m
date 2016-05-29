//
//  ViewController.m
//  YMNetWorkTool
//
//  Created by yangming on 16/5/29.
//  Copyright © 2016年 com.PeopleOnline. All rights reserved.
//

#import "ViewController.h"
#import "YMNetWorkTool.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 1、实例化一个单利对象
    YMNetWorkTool *netWork = [YMNetWorkTool sharedNetWorkTool];
    
    // 2、调用对象方法进行网络请求
    [netWork POSTWithUrlString:@"所需的网络接口" paramater:@{@"服务器的字段" : @"传的参数",@"服务器的字段1" : @"传的参数1"} Success:^(NSData *data, NSURLResponse *response) {
        
        NSLog(@"请求成功");
        
    } Fail:^(NSError *error) {
        
        NSLog(@"请求失败");
    }];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    
    
    
}

@end
