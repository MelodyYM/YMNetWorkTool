//
//  YMNetWorkTool.m
//  YMNetWorkTool
//
//  Created by yangming on 16/5/29.
//  Copyright © 2016年 com.yangming. All rights reserved.
//

#import "YMNetWorkTool.h"

@implementation YMNetWorkTool

/**
 *  获得单利对象的方法
 *  即可以使用类方法也可以选择对象放方法实例化一个单利对象
 *  @return 返回实例化的单利对象
 */
+(instancetype)sharedNetWorkTool{
    
    static id _instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc]init];
    });
    return _instance;
}

/**
 *  POST网络请求
 *
 *  @param urlString         网络请求接口
 *  @param paramater         需要传入的参数
 *  @param completionHandler 网络请求返回的参数
 */
-(void)POSTWithUrlString:(NSString *)urlString paramater:(NSDictionary *)paramater completionHandler:(void (^)(NSData *data, NSURLResponse *response, NSError *error))completionHandler{
    
    //创建请求（POST）
    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    //设置请求方法
    request.HTTPMethod = @"POST";
    
    NSMutableString *strM = [NSMutableString stringWithFormat:@""];
    
    //将字典中的参数取出来!拼接成字符窜！参数和参数之间以 & 间隔
    [paramater enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        
        // Key: 服务器接收参数的 key 值.
        // Value : 上传给服务器的参数内容.
        NSString *Key = key;
        NSString *Value = obj;
        
        [strM appendString:[NSString stringWithFormat:@"%@=%@&",Key,Value]];
    }];
    
    // 处理字符串,去掉最后一个字符!
    strM = [strM substringToIndex:(strM.length - 1)];
    
    //设置请求体
    request.HTTPBody = [strM dataUsingEncoding:NSUTF8StringEncoding];
    
    
    //发送请求
    [[[NSURLSession sharedSession]dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        //执行完成之后的回调
        completionHandler(data,response,error);
        
    }] resume];
    
}

/**
 *  POST网络请求
 *
 *  @param urlString         网络请求接口
 *  @param paramater         需要传入的参数
 *  @param completionHandler 网络请求返回的参数
 */
-(void)GETWithUrlString:(NSString *)urlString paramater:(NSDictionary *)paramater completionHandler:(void (^)(NSData *data, NSURLResponse *response, NSError *error))completionHandler{
    
    //创建请求（POST）
    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    //设置请求方法
    request.HTTPMethod = @"GET";
    
    NSMutableString *strM = [NSMutableString stringWithFormat:@""];
    
    //将字典中的参数取出来!拼接成字符窜！参数和参数之间以 & 间隔
    [paramater enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        
        // Key: 服务器接收参数的 key 值.
        // Value : 上传给服务器的参数内容.
        NSString *Key = key;
        NSString *Value = obj;
        
        [strM appendString:[NSString stringWithFormat:@"%@=%@&",Key,Value]];
    }];
    
    // 处理字符串,去掉最后一个字符!
    strM = [strM substringToIndex:(strM.length - 1)];
    
    //设置请求体
    request.HTTPBody = [strM dataUsingEncoding:NSUTF8StringEncoding];
    
    //发送请求
    [[[NSURLSession sharedSession]dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        //执行完成之后的回调
        completionHandler(data,response,error);
        
    }] resume];
    
}



/**
 *  POST网络请求  自定义Block回调
 *
 *  @param urlString    网络请求的接口
 *  @param paramater    需要传入的参数
 *  @param SuccessBlock 请求成功后回到
 *  @param failBlock    请求失败后回调
 */
- (void)POSTWithUrlString:(NSString *)urlString paramater:(NSDictionary *)paramater Success:(SuccessBlock)SuccessBlock Fail:(failBlock)failBlock{
    
    
    
    // 1.创建请求 (POST请求)
    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    // 设置请求方法:
    request.HTTPMethod = @"POST";
    
    NSMutableString *strM = [NSMutableString stringWithFormat:@""];
    
    // 将字典中的参数取出来!拼接成字符串! 参数和参数之间以 & 间隔
    [paramater enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        
        // nameKey: 服务器接收参数的 key 值.
        // nameValue : 上传给服务器的参数内容.
        NSString *nameKey = key;
        NSString *nameValue = obj;
        
        [strM appendString:[NSString stringWithFormat:@"%@=%@&",nameKey,nameValue]];
        
    }];
    
    // 处理字符串,去掉最后一个字符!
    strM = [strM substringToIndex:(strM.length - 1)];
    
    NSLog(@"strM:%@",strM);
    
    // 设置请求体:
    request.HTTPBody = [strM dataUsingEncoding:NSUTF8StringEncoding];
    
    // 发送请求
    
    // 2. 发送请求
    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        // 成功:
        if (data && !error) { //没有错误,并且有数据返回!
            
            // 成功执行,执行成功的Block 回调!
            
            if (SuccessBlock) {
                // 执行 Block
                SuccessBlock(data,response);
            }
            
        }else // 网路请求失败
        {
            if (failBlock) {
                // 失败之后的回调!
                failBlock(error);
            }
            
        }
        
    }] resume];

}



/**
 *  GET网络请求  自定义Block回调
 *
 *  @param urlString    网络请求的接口
 *  @param paramater    需要传入的参数
 *  @param SuccessBlock 请求成功后回到
 *  @param failBlock    请求失败后回调
 */
- (void)GETWithUrlString:(NSString *)urlString paramater:(NSDictionary *)paramater Success:(SuccessBlock)SuccessBlock Fail:(failBlock)failBlock{
    
    // 1.创建请求 (POST请求)
    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    // 设置请求方法:
    request.HTTPMethod = @"POST";
    
    NSMutableString *strM = [NSMutableString stringWithFormat:@""];
    
    // 将字典中的参数取出来!拼接成字符串! 参数和参数之间以 & 间隔
    [paramater enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        
        // nameKey: 服务器接收参数的 key 值.
        // nameValue : 上传给服务器的参数内容.
        NSString *nameKey = key;
        NSString *nameValue = obj;
        
        [strM appendString:[NSString stringWithFormat:@"%@=%@&",nameKey,nameValue]];
        
    }];
    
    // 处理字符串,去掉最后一个字符!
    strM = [strM substringToIndex:(strM.length - 1)];
    
    NSLog(@"strM:%@",strM);
    
    // 设置请求体:
    request.HTTPBody = [strM dataUsingEncoding:NSUTF8StringEncoding];
    
    // 发送请求
    
    // 2. 发送请求
    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        // 成功:
        if (data && !error) { //没有错误,并且有数据返回!
            
            // 成功执行,执行成功的Block 回调!
            
            if (SuccessBlock) {
                // 执行 Block
                SuccessBlock(data,response);
            }
            
        }else // 网路请求失败
        {
            if (failBlock) {
                // 失败之后的回调!
                failBlock(error);
            }
        }
        
    }] resume];
    
}












@end
