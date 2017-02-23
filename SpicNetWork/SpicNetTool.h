//
//  SpicNetTool.h
//  SpicNetWork
//
//  Created by Sunshinking on 2017/2/23.
//  Copyright © 2017年 Spic. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "SpicResult.h"
@class SpicNetWorkManager;

#pragma mark - 非二进制数据
@interface SpicNetTool : NSObject

/**
 *  GET请求
 *
 *  @param url                  请求的URL
 *  @param params               请求的参数
 *  @param success              请求返回成功的回调
 *  @param failure              因网络等问题的回调
 *  @param showNetworkErrorInfo 是否显示网络错误信息：喵~网络不可用，请重试
 *  @param view                 请求过程中是否显示加载的View
 *
 *  @return 请求对象
 */
+ (SpicNetWorkManager *)get:(NSString *)url params:(NSDictionary *)params success:(void (^)(SpicResult *responseObj))success failure:(void (^)(NSError *error))failure showNetworkErrorInfo:(BOOL)showNetworkErrorInfo showProgresFromView:(UIView *)view;

/**
 *  POST请求
 *
 *  @param url                  请求的URL
 *  @param params               请求的参数
 *  @param success              请求返回成功的回调
 *  @param failure              因网络等问题的回调
 *  @param showNetworkErrorInfo 是否显示网络错误信息：喵~网络不可用，请重试
 *  @param view                 请求过程中是否显示加载的View
 *
 *  @return 请求对象
 */
+ (SpicNetWorkManager *)post:(NSString *)url params:(NSDictionary *)params success:(void (^)(SpicResult * responseObj))success failure:(void (^)(NSError *error))failure showNetworkErrorInfo:(BOOL)showNetworkErrorInfo showProgresFromView:(UIView *)view;

/**
 *  POST请求
 *
 *  @param url                  请求的URL
 *  @param params               请求的参数
 *  @param success              请求返回成功的回调
 *  @param failure              因网络等问题的回调
 *  @param showNetworkErrorInfo 是否显示网络错误信息：喵~网络不可用，请重试
 *  @param view                 请求过程中是否显示加载的View
 *
 *  @return 请求对象
 */
+ (SpicNetWorkManager *)post:(NSString *)url params:(NSDictionary *)params success:(void (^)(SpicResult * responseObj))success failure:(void (^)(NSError *error))failure showNetworkErrorInfo:(BOOL)showNetworkErrorInfo loadingFailureView:(UIView *)loadingFailureView showProgresFromView:(UIView *)view;
/**
 *  GET请求
 *
 *  @param url                  请求的URL
 *  @param params               请求的参数
 *  @param success              请求返回成功的回调
 *  @param failure              因网络等问题的回调
 *  @param showNetworkErrorInfo 是否显示网络错误信息：喵~网络不可用，请重试
 *  @param view                 请求过程中是否显示加载的View
 *
 *  @return 请求对象
 */
+ (SpicNetWorkManager *)get:(NSString *)url params:(NSDictionary *)params resultClass:(Class)resultClass success:(void (^)(id responseObj))success failure:(void (^)(NSError *error))failure showNetworkErrorInfo:(BOOL)showNetworkErrorInfo showProgresFromView:(UIView *)view;

/**
 *  POST请求
 *
 *  @param url                  请求的URL
 *  @param params               请求的参数
 *  @param success              请求返回成功的回调
 *  @param failure              因网络等问题的回调
 *  @param showNetworkErrorInfo 是否显示网络错误信息：喵~网络不可用，请重试
 *  @param view                 请求过程中是否显示加载的View
 *
 *  @return 请求对象
 */
+ (SpicNetWorkManager *)post:(NSString *)url params:(NSDictionary *)params resultClass:(Class)resultClass success:(void (^)(id responseObj))success failure:(void (^)(NSError *error))failure showNetworkErrorInfo:(BOOL)showNetworkErrorInfo showProgresFromView:(UIView *)view;

/**
 *  POST请求
 *
 *  @param url                  请求的URL
 *  @param params               请求的参数
 *  @param success              请求返回成功的回调
 *  @param failure              因网络等问题的回调
 *  @param showNetworkErrorInfo 是否显示网络错误信息：喵~网络不可用，请重试
 *  @param view                 请求过程中是否显示加载的View
 *
 *  @return 请求对象
 */
+ (SpicNetWorkManager *)post:(NSString *)url params:(NSDictionary *)params resultClass:(Class)resultClass success:(void (^)(id responseObj))success failure:(void (^)(NSError *error))failure showNetworkErrorInfo:(BOOL)showNetworkErrorInfo loadingFailureView:(UIView *)loadingFailureView showProgresFromView:(UIView *)view;

#pragma mark - 二进制数据
/**
 *  POST请求
 *
 *  @param url                  请求的URL
 *  @param params               请求的参数
 *  @param formDatas            二进制文件数组，里面存放的是 MKFormDataModel
 *  @param success              请求返回成功的回调
 *  @param failure              因网络等问题的回调
 *  @param showNetworkErrorInfo 是否显示网络错误信息：喵~网络不可用，请重试
 *  @param view                 请求过程中是否显示加载的View
 *
 *  @return 请求对象
 */
+ (SpicNetWorkManager *)post:(NSString *)url params:(NSDictionary *)params formDatas:(NSArray *)formDatas success:(void (^)(id responseObj))success failure:(void (^)(NSError *error))failure showNetworkErrorInfo:(BOOL)showNetworkErrorInfo showProgresFromView:(UIView *)view;

/**
 *  get请求加header
 *
 *  @param url                  请求的URL
 *  @param header               header字典 token{@"token":token}
 *  @param params                参数
 *  @param resultClass          传nil
 *  @param success              成功回调
 *  @param failure              失败回调
 *  @param showNetworkErrorInfo 网络错误提示
 *  @param view                 请求过程中是否显示加载的View
 *
 *  @return 请求对象
 */
+ (SpicNetWorkManager *)get:(NSString *)url header:(NSDictionary*)header params:(NSDictionary *)params resultClass:(Class)resultClass success:(void (^)(id responseObj))success failure:(void (^)(NSError *error))failure showNetworkErrorInfo:(BOOL)showNetworkErrorInfo showProgresFromView:(UIView *)view;
/**
 *  上传图片  带header
 *
 *  @param url                  url
 *  @param header               header字典 token{@"token":token}
 *  @param params               参数
 *  @param formDatas            二进制文件数组 里面放的是data数组
 *  @param success              成功回调
 *  @param failure              失败回调
 *  @param showNetworkErrorInfo 网络错误提示
 *  @param view                 请求过程中是否显示加载的View
 *
 *  @return 请求对象
 */
+ (SpicNetWorkManager *)post:(NSString *)url header:(NSDictionary*)header params:(NSDictionary *)params formDatas:(NSArray *)formDatas success:(void (^)(id responseObj))success failure:(void (^)(NSError *error))failure showNetworkErrorInfo:(BOOL)showNetworkErrorInfo showProgresFromView:(UIView *)view;
@end

