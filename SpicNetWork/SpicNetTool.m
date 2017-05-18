//
//  SpicNetTool.m
//  SpicNetWork
//
//  Created by Sunshinking on 2017/2/23.
//  Copyright © 2017年 Spic. All rights reserved.
//

#import "SpicNetTool.h"

#import <AFHTTPSessionManager.h>
#import <AFNetworkReachabilityManager.h>
#import <sys/utsname.h>
#import<CommonCrypto/CommonCryptor.h>
//#import "KeychainItemWrapper.h"
#import "SpicNetWorkManager.h"
#import "SpicDataModel.h"
#import "NSString+StingTool.h"
//#import "Base64codeFunc.h"
#import "MBProgressHUD+XZ.h"
#import "SpicResult.h"
static const char encodingTable[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";


@implementation SpicNetTool
#pragma mark - 非二进制
+ (SpicNetWorkManager *)get:(NSString *)url params:(NSDictionary *)params success:(void (^)(SpicResult *))success failure:(void (^)(NSError *))failure showNetworkErrorInfo:(BOOL)showNetworkErrorInfo showProgresFromView:(UIView *)view
{
    //    return [self process:url params:params resultClass:[MKResult class] success:success failure:failure showNetworkErrorInfo:showNetworkErrorInfo showProgresFromView:view type:@"GET"];
    return [self process:url params:params resultClass:[SpicResult class] success:success failure:failure showNetworkErrorInfo:showNetworkErrorInfo showProgresFromView:view loadingFailureView:nil type:@"GET"];
}


+ (SpicNetWorkManager *)post:(NSString *)url params:(NSDictionary *)params success:(void (^)(SpicResult *))success failure:(void (^)(NSError *))failure showNetworkErrorInfo:(BOOL)showNetworkErrorInfo showProgresFromView:(UIView *)view
{
    return [self process:url params:params resultClass:[SpicResult class] success:success failure:failure showNetworkErrorInfo:showNetworkErrorInfo showProgresFromView:view loadingFailureView:nil type:@"POST"];
}

+ (SpicNetWorkManager *)post:(NSString *)url params:(NSDictionary *)params success:(void (^)(SpicResult *))success failure:(void (^)(NSError *))failure showNetworkErrorInfo:(BOOL)showNetworkErrorInfo loadingFailureView:(UIView *)loadingFailureView showProgresFromView:(UIView *)view
{
    return [self process:url params:params resultClass:[SpicResult class] success:success failure:failure showNetworkErrorInfo:showNetworkErrorInfo showProgresFromView:view loadingFailureView:loadingFailureView type:@"POST"];
}


+ (SpicNetWorkManager *)get:(NSString *)url params:(NSDictionary *)params resultClass:(Class)resultClass success:(void (^)(id))success failure:(void (^)(NSError *))failure showNetworkErrorInfo:(BOOL)showNetworkErrorInfo showProgresFromView:(UIView *)view
{
    //    return [self process:url params:params resultClass:resultClass success:success failure:failure showNetworkErrorInfo:showNetworkErrorInfo showProgresFromView:view type:@"GET"];
    return [self process:url params:params resultClass:resultClass success:success failure:failure showNetworkErrorInfo:showNetworkErrorInfo showProgresFromView:view loadingFailureView:nil type:@"GET"];
}
+ (SpicNetWorkManager *)get:(NSString *)url header:(NSDictionary*)header params:(NSDictionary *)params resultClass:(Class)resultClass success:(void (^)(id responseObj))success failure:(void (^)(NSError *error))failure showNetworkErrorInfo:(BOOL)showNetworkErrorInfo showProgresFromView:(UIView *)view
{
    return [self process:url header:header params:params resultClass:nil success:success failure:failure showNetworkErrorInfo:showNetworkErrorInfo showProgresFromView:view loadingFailureView:nil type:@"GET"];
}
+ (SpicNetWorkManager *)post:(NSString *)url params:(NSDictionary *)params resultClass:(Class)resultClass success:(void (^)(id))success failure:(void (^)(NSError *))failure showNetworkErrorInfo:(BOOL)showNetworkErrorInfo showProgresFromView:(UIView *)view
{
    return [self process:url params:params resultClass:resultClass success:success failure:failure showNetworkErrorInfo:showNetworkErrorInfo showProgresFromView:view loadingFailureView:nil type:@"POST"];
}

+ (SpicNetWorkManager *)post:(NSString *)url params:(NSDictionary *)params resultClass:(Class)resultClass success:(void (^)(id))success failure:(void (^)(NSError *))failure showNetworkErrorInfo:(BOOL)showNetworkErrorInfo loadingFailureView:(UIView *)loadingFailureView showProgresFromView:(UIView *)view
{
    return [self process:url params:params resultClass:resultClass success:success failure:failure showNetworkErrorInfo:showNetworkErrorInfo showProgresFromView:view loadingFailureView:loadingFailureView type:@"POST"];
}
#pragma mark - 222
+ (void)processResult:(id)responseObject loadingFailureView:(UIView *)loadingFailureView weakHud:(MBProgressHUD *)weakHud success:(void (^)(id))success resultClass:(Class)resultClass
{
    loadingFailureView.hidden = [@"0" isEqualToString:responseObject[@"result"]];
    
    [weakHud hide:YES];
    if (success) {
        if (resultClass) {
            id obj = responseObject;
            //            id obj = [resultClass objectWithKeyValues:responseObject];
            success(obj);
        } else {
            success(responseObject);
        }
    }
}

+ (void)processNetError:(NSError *)error loadingFailureView:(UIView *)loadingFailureView weakHud:(MBProgressHUD *)weakHud failure:(void (^)(id))failure showNetworkErrorInfo:(BOOL)showNetworkErrorInfo
{
    loadingFailureView.hidden = NO;
    
    [weakHud hide:YES];
    if (failure) {
        failure(error);
    }
    if (showNetworkErrorInfo) {
//        [MBProgressHUD showText:@""];
    }
}
#pragma mark -11111

+ (SpicNetWorkManager *)process:(NSString *)url params:(NSDictionary *)params resultClass:(Class)resultClass success:(void (^)(id))success failure:(void (^)(NSError *))failure showNetworkErrorInfo:(BOOL)showNetworkErrorInfo showProgresFromView:(UIView *)view loadingFailureView:(UIView *)loadingFailureView type:(NSString *)type
{
    //    loadingFailureView.hidden = YES;
    AFHTTPSessionManager *mgr  = [AFHTTPSessionManager manager];
    NSString *finalUrl = [NSString stringWithFormat:@"%@%@",@"",url];
    mgr.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/plain", nil];
    [mgr.requestSerializer setValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    //    NSMutableDictionary *theBaseParam = [self getBaseParam];
    //    [theBaseParam addEntriesFromDictionary:params];
    
    NSMutableDictionary *theBaseParam = [NSMutableDictionary dictionaryWithDictionary:params];
    
//    NSString *mastring = [NSString stringWithFormat:@"{\"a\":\"%@\",\"v\":\"%@\",\"ip\":\"%@\"}",[[UIDevice currentDevice] systemName],[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"],[NSString whatismyipdotcom]];
//    
//    NSData *data = [mastring dataUsingEncoding:NSUTF8StringEncoding];
//    
//    data = [self DESEncrypt:data WithKey:@"1qaz@WSX"];
//    NSString *string = [self convertDataToHexStr:data];
//    [theBaseParam setObject:string forKey:@"appToken"];
    
    //    NSMutableDictionary *finalParam = [self getEncriptParam:theBaseParam];
    
    MBProgressHUD *hud = nil;
    if (view) {
        hud = [MBProgressHUD showProgressFromView:view];
    }
    
   SpicNetWorkManager *request = nil;
    __weak typeof(hud) weakHud = hud;
    if ([type isEqualToString:@"GET"]) {
        //        finalParam
       request = (SpicNetWorkManager *)  [mgr GET:finalUrl parameters:theBaseParam progress: nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [self processResult:responseObject loadingFailureView:loadingFailureView weakHud:weakHud success:success resultClass:resultClass];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
             [self processNetError:error loadingFailureView:loadingFailureView weakHud:hud failure:failure showNetworkErrorInfo:showNetworkErrorInfo];
        }];
//        request = (SpicNetWorkManager *)[mgr GET:finalUrl parameters:theBaseParam success:^(AFHTTPRequestOperation *operation, id responseObject) {
//            
//            [self processResult:responseObject loadingFailureView:loadingFailureView weakHud:weakHud success:success resultClass:resultClass];
//            
//        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//            
//            [self processNetError:error loadingFailureView:loadingFailureView weakHud:hud failure:failure showNetworkErrorInfo:showNetworkErrorInfo];
//        }];
    } else if ([type isEqualToString:@"POST"]) {
        //        finalParam
        request = (SpicNetWorkManager *) [mgr POST:finalUrl parameters:theBaseParam progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [self processResult:responseObject loadingFailureView:loadingFailureView weakHud:weakHud success:success resultClass:resultClass];

        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
              [self processNetError:error loadingFailureView:loadingFailureView weakHud:hud failure:failure showNetworkErrorInfo:showNetworkErrorInfo];
        }];
//        request = (SpicNetWorkManager *)[mgr POST:finalUrl parameters:theBaseParam success:^(AFHTTPRequestOperation *operation, id responseObject) {
//            
//            [self processResult:responseObject loadingFailureView:loadingFailureView weakHud:weakHud success:success resultClass:resultClass];
//            
//        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//            
//            [self processNetError:error loadingFailureView:loadingFailureView weakHud:hud failure:failure showNetworkErrorInfo:showNetworkErrorInfo];
//        }];
    }
    return request;
}
+ (SpicNetWorkManager *)process:(NSString *)url header:(NSDictionary*)dic params:(NSDictionary *)params resultClass:(Class)resultClass success:(void (^)(id))success failure:(void (^)(NSError *))failure showNetworkErrorInfo:(BOOL)showNetworkErrorInfo showProgresFromView:(UIView *)view loadingFailureView:(UIView *)loadingFailureView type:(NSString *)type
{
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    NSString *finalUrl = [NSString stringWithFormat:@"%@%@",@"",url];
    mgr.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/plain", nil];
    [mgr.requestSerializer setValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [mgr.requestSerializer setValue:dic[@"token"] forHTTPHeaderField:@"token"];
    //    NSMutableDictionary *theBaseParam = [self getBaseParam];
    //    [theBaseParam addEntriesFromDictionary:params];
    
    NSMutableDictionary *theBaseParam = [NSMutableDictionary dictionaryWithDictionary:params];
    NSString *mastring = [NSString stringWithFormat:@"{\"a\":\"%@\",\"v\":\"%@\",\"ip\":\"%@\"}",[[UIDevice currentDevice] systemName],[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"],[NSString whatismyipdotcom]];
    
    NSData *data = [mastring dataUsingEncoding:NSUTF8StringEncoding];
    
    data = [self DESEncrypt:data WithKey:@"1qaz@WSX"];
    NSString *string = [self convertDataToHexStr:data];
    [theBaseParam setObject:string forKey:@"appToken"];
    //    NSMutableDictionary *finalParam = [self getEncriptParam:theBaseParam];
    
    MBProgressHUD *hud = nil;
    if (view) {
//        hud = [MBProgressHUD showProgressFromView:view];
    }
    
    SpicNetWorkManager *request = nil;
    __weak typeof(hud) weakHud = hud;
    if ([type isEqualToString:@"GET"]) {
        //        finalParam
        request = (SpicNetWorkManager *)  [mgr GET:finalUrl parameters:theBaseParam progress: nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [self processResult:responseObject loadingFailureView:loadingFailureView weakHud:weakHud success:success resultClass:resultClass];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [self processNetError:error loadingFailureView:loadingFailureView weakHud:hud failure:failure showNetworkErrorInfo:showNetworkErrorInfo];
        }];
//        request = (MKHttpRequestObject *)[mgr GET:finalUrl parameters:theBaseParam success:^(AFHTTPRequestOperation *operation, id responseObject) {
//            
//            [self processResult:responseObject loadingFailureView:loadingFailureView weakHud:weakHud success:success resultClass:resultClass];
//            
//        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//            
//            [self processNetError:error loadingFailureView:loadingFailureView weakHud:hud failure:failure showNetworkErrorInfo:showNetworkErrorInfo];
//        }];
    } else if ([type isEqualToString:@"POST"]) {
        //        finalParam
        request = (SpicNetWorkManager *) [mgr POST:finalUrl parameters:theBaseParam progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [self processResult:responseObject loadingFailureView:loadingFailureView weakHud:weakHud success:success resultClass:resultClass];
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [self processNetError:error loadingFailureView:loadingFailureView weakHud:hud failure:failure showNetworkErrorInfo:showNetworkErrorInfo];
        }];
//        request = (MKHttpRequestObject *)[mgr POST:finalUrl parameters:theBaseParam success:^(AFHTTPRequestOperation *operation, id responseObject) {
//            
//            [self processResult:responseObject loadingFailureView:loadingFailureView weakHud:weakHud success:success resultClass:resultClass];
//            
//        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//            
//            [self processNetError:error loadingFailureView:loadingFailureView weakHud:hud failure:failure showNetworkErrorInfo:showNetworkErrorInfo];
//        }];
    }
    return request;
    
}
+ (NSData *)DESEncrypt:(NSData *)data WithKey:(NSString *)key
{
    char keyPtr[kCCKeySizeAES256+1];
    bzero(keyPtr, sizeof(keyPtr));
    
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
    NSUInteger dataLength = [data length];
    
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    
    size_t numBytesEncrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt, kCCAlgorithmDES,
                                          kCCOptionPKCS7Padding | kCCOptionECBMode,
                                          keyPtr, kCCBlockSizeDES,
                                          NULL,
                                          [data bytes], dataLength,
                                          buffer, bufferSize,
                                          &numBytesEncrypted);
    if (cryptStatus == kCCSuccess) {
        return [NSData dataWithBytesNoCopy:buffer length:numBytesEncrypted];
    }
    
    free(buffer);
    return nil;
}
+ (NSString *)convertDataToHexStr:(NSData *)data {
    if (!data || [data length] == 0) {
        return @"";
    }
    NSMutableString *string = [[NSMutableString alloc] initWithCapacity:[data length]];
    
    [data enumerateByteRangesUsingBlock:^(const void *bytes, NSRange byteRange, BOOL *stop) {
        unsigned char *dataBytes = (unsigned char*)bytes;
        for (NSInteger i = 0; i < byteRange.length; i++) {
            NSString *hexStr = [NSString stringWithFormat:@"%x", (dataBytes[i]) & 0xff];
            if ([hexStr length] == 2) {
                [string appendString:hexStr];
            } else {
                [string appendFormat:@"0%@", hexStr];
            }
        }
    }];
    
    return string;
}
+ (NSString *)base64EncodedStringFrom:(NSData *)data
{
    if ([data length] == 0)
        return @"";
    
    char *characters = malloc((([data length] + 2) / 3) * 4);
    if (characters == NULL)
        return nil;
    NSUInteger length = 0;
    
    NSUInteger i = 0;
    while (i < [data length])
    {
        char buffer[3] = {0,0,0};
        short bufferLength = 0;
        while (bufferLength < 3 && i < [data length])
            buffer[bufferLength++] = ((char *)[data bytes])[i++];
        
        //  Encode the bytes in the buffer to four characters, including padding "=" characters if necessary.
        characters[length++] = encodingTable[(buffer[0] & 0xFC) >> 2];
        characters[length++] = encodingTable[((buffer[0] & 0x03) << 4) | ((buffer[1] & 0xF0) >> 4)];
        if (bufferLength > 1)
            characters[length++] = encodingTable[((buffer[1] & 0x0F) << 2) | ((buffer[2] & 0xC0) >> 6)];
        else characters[length++] = '=';
        if (bufferLength > 2)
            characters[length++] = encodingTable[buffer[2] & 0x3F];
        else characters[length++] = '=';
    }
    
    return [[NSString alloc] initWithBytesNoCopy:characters length:length encoding:NSASCIIStringEncoding freeWhenDone:YES];
}

#pragma mark - 二进制数据

+ (SpicNetWorkManager *)post:(NSString *)url params:(NSDictionary *)params formDatas:(NSArray *)formDatas success:(void (^)(id))success failure:(void (^)(NSError *))failure showNetworkErrorInfo:(BOOL)showNetworkErrorInfo showProgresFromView:(UIView *)view
{
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    NSString *finalUrl = [NSString stringWithFormat:@"%@%@", @"", url];
    mgr.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/plain", nil];
    //    NSMutableDictionary *theBaseParam = [self getBaseParam];
    //    [theBaseParam addEntriesFromDictionary:params];
    
    //    NSMutableDictionary *finalParam = [self getEncriptParam:theBaseParam];
    
    NSMutableDictionary *theBaseParam = [NSMutableDictionary dictionaryWithDictionary:params];
    
    MBProgressHUD *hud = nil;
    if (view) {
//        hud = [MBProgressHUD showProgressFromView:view];
    }
    
    SpicNetWorkManager *request = nil;
    __weak typeof(hud) weakHud = hud;
    //    finalParam
  request = (SpicNetWorkManager *) [mgr POST:finalUrl parameters:theBaseParam constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
      for (NSInteger i = 0; i < formDatas.count; i++) {
          SpicDataModel *dataModel = formDatas[i];
          
          [formData appendPartWithFileData:dataModel.data name:@"file" fileName:dataModel.headName mimeType:@"image/jpeg"];
      }
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [weakHud hideAnimated:YES];
        if (success) {
            id obj = responseObject;
            success(obj);
        }

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [weakHud hideAnimated:YES];
        if (failure) {
            failure(error);
        }
        if (showNetworkErrorInfo) {
//            [MBProgressHUD showText:NetworkFail];
        }

    }
     ];
//    request = (MKHttpRequestObject *)[mgr POST:finalUrl parameters:theBaseParam constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
//        for (NSInteger i = 0; i < formDatas.count; i++) {
//            MKFormDataModel *dataModel = formDatas[i];
//            
//            [formData appendPartWithFileData:dataModel.data name:@"file" fileName:dataModel.name mimeType:@"image/jpeg"];
//        }
//    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        [weakHud hide:YES];
//        if (success) {
//            id obj = responseObject;
//            success(obj);
//        }
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        [weakHud hide:YES];
//        if (failure) {
//            failure(error);
//        }
//        if (showNetworkErrorInfo) {
//            [MBProgressHUD showText:NetworkFail];
//        }
//    }];
    return request;
}
+ (SpicNetWorkManager *)post:(NSString *)url header:(NSDictionary*)header params:(NSDictionary *)params formDatas:(NSArray *)formDatas success:(void (^)(id responseObj))success failure:(void (^)(NSError *error))failure showNetworkErrorInfo:(BOOL)showNetworkErrorInfo showProgresFromView:(UIView *)view
{
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    NSString *finalUrl = [NSString stringWithFormat:@"%@%@", @"", url];
    mgr.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/plain", nil];
    [mgr.requestSerializer setValue:header[@"token"] forHTTPHeaderField:@"token"];
    //    NSMutableDictionary *theBaseParam = [self getBaseParam];
    //    [theBaseParam addEntriesFromDictionary:params];
    
    //    NSMutableDictionary *finalParam = [self getEncriptParam:theBaseParam];
    
    NSMutableDictionary *theBaseParam = [NSMutableDictionary dictionaryWithDictionary:params];
    NSString *mastring = [NSString stringWithFormat:@"{\"a\":\"%@\",\"v\":\"%@\",\"ip\":\"%@\"}",[[UIDevice currentDevice] systemName],[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"],[NSString whatismyipdotcom]];
    
    NSData *data = [mastring dataUsingEncoding:NSUTF8StringEncoding];
    
    data = [self DESEncrypt:data WithKey:@"1qaz@WSX"];
    NSString *string = [self convertDataToHexStr:data];
    [theBaseParam setObject:string forKey:@"appToken"];
    
    MBProgressHUD *hud = nil;
    if (view) {
//        hud = [MBProgressHUD showProgressFromView:view];
    }
    
    SpicNetWorkManager *request = nil;
    __weak typeof(hud) weakHud = hud;
    //    finalParam
   request = (SpicNetWorkManager *)  [mgr POST:finalUrl parameters:theBaseParam constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
       for (NSInteger i = 0; i < formDatas.count; i++) {
           SpicDataModel *dataModel = formDatas[i];
           
           [formData appendPartWithFileData:dataModel.data name:@"file" fileName:dataModel.headName mimeType:@"image/jpeg"];
       }
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [weakHud hideAnimated:YES];
        if (success) {
            id obj = responseObject;
            success(obj);
        }

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [weakHud hideAnimated:YES];
        if (failure) {
            failure(error);
        }
        if (showNetworkErrorInfo) {
//            [MBProgressHUD showText:NetworkFail];
        }

    }];
//    request = (MKHttpRequestObject *)[mgr POST:finalUrl parameters:theBaseParam constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
//        for (NSInteger i = 0; i < formDatas.count; i++) {
//            MKFormDataModel *dataModel = formDatas[i];
//            
//            [formData appendPartWithFileData:dataModel.data name:@"file" fileName:dataModel.name mimeType:@"image/jpeg"];
//        }
//    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        [weakHud hide:YES];
//        if (success) {
//            id obj = responseObject;
//            success(obj);
//        }
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        [weakHud hide:YES];
//        if (failure) {
//            failure(error);
//        }
//        if (showNetworkErrorInfo) {
//            [MBProgressHUD showText:NetworkFail];
//        }
//    }];
    return request;
    
}
#pragma mark - 私有方法

+ (NSMutableArray *)bubbleSortArray:(NSMutableArray *)list
{
    NSStringCompareOptions comparisonOptions = NSCaseInsensitiveSearch | NSNumericSearch | NSWidthInsensitiveSearch | NSForcedOrderingSearch;
    NSComparator sort = ^(NSString *obj1,NSString *obj2){
        NSRange range = NSMakeRange(0,obj1.length);
        return [obj1 compare:obj2 options:comparisonOptions range:range];
    };
    NSArray *resultArray2 = [list sortedArrayUsingComparator:sort];
    return list = [NSMutableArray arrayWithArray:resultArray2];
}


+ (NSMutableDictionary *)getEncriptParam:(NSMutableDictionary *)theBaseParam
{
    NSMutableDictionary *finalParam = theBaseParam;
    
    NSMutableArray *keyArrays = [NSMutableArray arrayWithArray:theBaseParam.allKeys];
    keyArrays = [self bubbleSortArray:keyArrays];
    
    //拼接
    NSMutableString *params = [[NSMutableString alloc] init];
    for (int i = 0; i < keyArrays.count; i++) {
        [params appendFormat:@"&%@=%@", keyArrays[i], theBaseParam[keyArrays[i]]];
    }
    
    [params deleteCharactersInRange:NSMakeRange(0, 1)];
    
    [params stringByReplacingOccurrencesOfString:@"(" withString:@"["];
    [params stringByReplacingOccurrencesOfString:@")" withString:@"]"];
    
    
    [params appendString:@"qJ7nqKZbEf1rDtLvycjV1fJV0/VUyJmK"];
    
    NSString * signStr = [NSString md5String:params];
    
    finalParam[@"sign"] = signStr;
    
    return finalParam;
}

//+ (NSMutableDictionary *)getBaseParam
//{
//    NSMutableDictionary *params = [NSMutableDictionary dictionary];
//
//    static NSMutableDictionary *base;
//    if (!base) {
//        UIDevice *device = [UIDevice currentDevice];
//        base = [NSMutableDictionary dictionary];
//
//        base[@"source"] = @"123";
//        base[@"os"] = @"iphone";
//        base[@"width"] = [NSString stringWithFormat:@"%.0f", [UIScreen width]];
//        base[@"height"] = [NSString stringWithFormat:@"%.0f", [UIScreen height]];
//        base[@"phoneType"] = [self getPhoneType];
//        base[@"osType"] = [device systemVersion];
//        base[@"ver"] = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
//
//        base[@"imei"] = [self getUUID];
//    }
//
//    [params addEntriesFromDictionary:base];
//
//    NSDate* date = [NSDate dateWithTimeIntervalSinceNow:0];
//    NSTimeInterval interval =[date timeIntervalSince1970]*1000;
//    NSString *timeString = [NSString stringWithFormat:@"%f", interval];
//    params[@"timestamp"] = timeString;
//
//
//    AFNetworkReachabilityManager *mgr = [AFNetworkReachabilityManager sharedManager];
//    AFNetworkReachabilityStatus status = mgr.networkReachabilityStatus;
//    NSString *netType = @"";
//    if (status == AFNetworkReachabilityStatusReachableViaWiFi) {
//        netType = @"wifi";
//    } else if (status == AFNetworkReachabilityStatusReachableViaWWAN) {
//        netType = @"WWAN";
//    }
//
//    params[@"netType"] = netType;
//
//    return params;
//}

//+(NSString*)getUUID{
//    KeychainItemWrapper *keychainIterm = [[KeychainItemWrapper alloc]
//                                          initWithIdentifier:@"UUID"
//                                          accessGroup:@"EMTKY45HC5.com.xindao.miaodai"];
//    NSString *uuid = [keychainIterm objectForKey:(__bridge id)kSecValueData];
//    if ([uuid isEqualToString:@""]) {
//        CFUUIDRef uuidRef = CFUUIDCreate(kCFAllocatorDefault);
//        uuid = (NSString *)CFBridgingRelease(CFUUIDCreateString(kCFAllocatorDefault, uuidRef));
////        [keychainIterm setObject:uuid forKey:(__bridge id)kSecValueData];
//        CFRelease(uuidRef);
//    }
//    return uuid;
//}


+ (NSString *)getPhoneType
{
    struct utsname systemInfo;
    uname(&systemInfo);
    
    NSString *deviceString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    
    
    NSMutableDictionary *machineKeyValue = [NSMutableDictionary dictionary];
    
    if (deviceString.length) {
        machineKeyValue[deviceString] = deviceString;
    }
    
    // Apple Watch
    machineKeyValue[@"Watch1,1"] = @"Apple Watch";
    machineKeyValue[@"Watch1,2"] = @"Apple Watch";
    
    // iPad
    machineKeyValue[@"iPad1,1"] = @"iPad";
    
    machineKeyValue[@"iPad2,1"] = @"iPad 2";
    machineKeyValue[@"iPad2,2"] = @"iPad 2";
    machineKeyValue[@"iPad2,3"] = @"iPad 2";
    machineKeyValue[@"iPad2,4"] = @"iPad 2";
    
    machineKeyValue[@"iPad3,1"] = @"iPad 3";
    machineKeyValue[@"iPad3,2"] = @"iPad 3";
    machineKeyValue[@"iPad3,3"] = @"iPad 3";
    
    machineKeyValue[@"iPad3,4"] = @"iPad 4";
    machineKeyValue[@"iPad3,5"] = @"iPad 4";
    machineKeyValue[@"iPad3,6"] = @"iPad 4";
    
    machineKeyValue[@"iPad4,1"] = @"iPad Air";
    machineKeyValue[@"iPad4,2"] = @"iPad Air";
    machineKeyValue[@"iPad4,3"] = @"iPad Air";
    
    machineKeyValue[@"iPad5,3"] = @"iPad Air 2";
    machineKeyValue[@"iPad5,4"] = @"iPad Air 2";
    
    machineKeyValue[@"iPad2,5"] = @"iPad mini 1G";
    machineKeyValue[@"iPad2,6"] = @"iPad mini 1G";
    machineKeyValue[@"iPad2,7"] = @"iPad mini 1G";
    
    machineKeyValue[@"iPad4,4"] = @"iPad mini 2";
    machineKeyValue[@"iPad4,5"] = @"iPad mini 2";
    machineKeyValue[@"iPad4,6"] = @"iPad mini 2";
    
    machineKeyValue[@"iPad4,7"] = @"iPad mini 3";
    machineKeyValue[@"iPad4,8"] = @"iPad mini 3";
    machineKeyValue[@"iPad4,9"] = @"iPad mini 3";
    
    
    // iPhone
    machineKeyValue[@"iPhone1,1"] = @"iPhone";
    
    machineKeyValue[@"iPhone1,2"] = @"iPhone 3G";
    
    machineKeyValue[@"iPhone2,1"] = @"iPhone 3GS";
    
    machineKeyValue[@"iPhone3,1"] = @"iPhone 4";
    machineKeyValue[@"iPhone3,2"] = @"iPhone 4";
    machineKeyValue[@"iPhone3,3"] = @"iPhone 4";
    
    machineKeyValue[@"iPhone4,1"] = @"iPhone 4S";
    
    machineKeyValue[@"iPhone5,1"] = @"iPhone 5";
    machineKeyValue[@"iPhone5,2"] = @"iPhone 5";
    
    machineKeyValue[@"iPhone5,3"] = @"iPhone 5C";
    machineKeyValue[@"iPhone5,4"] = @"iPhone 5C";
    
    machineKeyValue[@"iPhone6,1"] = @"iPhone 5S";
    machineKeyValue[@"iPhone6,2"] = @"iPhone 5S";
    
    machineKeyValue[@"iPhone7,2"] = @"iPhone 6";
    
    machineKeyValue[@"iPhone7,1"] = @"iPhone 6 Plus";
    
    // iPod
    machineKeyValue[@"iPod1,1"] = @"iPod touch";
    
    machineKeyValue[@"iPod2,1"] = @"iPod touch 2G";
    
    machineKeyValue[@"iPod3,1"] = @"iPod touch 3G";
    
    machineKeyValue[@"iPod4,1"] = @"iPod touch 4G";
    
    machineKeyValue[@"iPod5,1"] = @"iPod touch 5G";
    
    
    NSString *phoneType = machineKeyValue[deviceString];
    
    return phoneType.length ? phoneType : @"";
}

@end
