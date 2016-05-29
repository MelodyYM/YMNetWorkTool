# YMNetWorkTool
简单实用的网络请求工具，可以根据自己的使用情况进行自定义更改

//
//  ViewController.m
//  YMNetWorkTool
//
//  Created by yangming on 16/5/29.
//  Copyright © 2016年 com.PeopleOnline. All rights reserved.
//

#import "ViewController.h"

//实用的时候先引入工具类
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


@end




//
//  YMNetWorkTool.h
//  YMNetWorkTool
//
//  Created by yangming on 16/5/29.
//  Copyright © 2016年 com.yangming. All rights reserved.
//

#import <Foundation/Foundation.h>


// 定义两个 Block : 1. 成功Block回调 2.失败的 Block 回调!
// 定义 Block 的方式:
typedef void(^SuccessBlock)(NSData *data, NSURLResponse *response);
typedef void(^failBlock)(NSError *error);


@interface YMNetWorkTool : NSObject


/**
 *  获得单利对象的方法
 *  即可以使用类方法也可以选择对象放方法实例化一个单利对象
 *  @return 返回实例化的单利对象
 */
+(instancetype)sharedNetWorkTool;


/**
 *  POST网络请求
 *
 *  @param urlString         网络请求接口
 *  @param paramater         需要传入的参数
 *  @param completionHandler 网络请求返回的参数
 */
-(void)POSTWithUrlString:(NSString *)urlString paramater:(NSDictionary *)paramater completionHandler:(void (^)(NSData *data, NSURLResponse *response, NSError *error))completionHandler;


/**
 *  POST网络请求
 *
 *  @param urlString         网络请求接口
 *  @param paramater         需要传入的参数
 *  @param completionHandler 网络请求返回的参数
 */
-(void)GETWithUrlString:(NSString *)urlString paramater:(NSDictionary *)paramater completionHandler:(void (^)(NSData *data, NSURLResponse *response, NSError *error))completionHandler;



/**
 *  POST网络请求  自定义Block回调
 *
 *  @param urlString    网络请求的接口
 *  @param paramater    需要传入的参数
 *  @param SuccessBlock 请求成功后回到
 *  @param failBlock    请求失败后回调
 */
- (void)POSTWithUrlString:(NSString *)urlString paramater:(NSDictionary *)paramater Success:(SuccessBlock)SuccessBlock Fail:(failBlock)failBlock;



/**
 *  GET网络请求  自定义Block回调
 *
 *  @param urlString    网络请求的接口
 *  @param paramater    需要传入的参数
 *  @param SuccessBlock 请求成功后回到
 *  @param failBlock    请求失败后回调
 */
- (void)GETWithUrlString:(NSString *)urlString paramater:(NSDictionary *)paramater Success:(SuccessBlock)SuccessBlock Fail:(failBlock)failBlock;












@end
