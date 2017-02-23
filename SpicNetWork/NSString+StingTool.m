//
//  NSString+StingTool.m
//  FantasyCloud
//
//  Created by 奇幻云 on 16/2/26.
//  Copyright © 2016年 奇幻云. All rights reserved.
//

#import "NSString+StingTool.h"
#import <CommonCrypto/CommonDigest.h>
@implementation NSString (StingTool)

+(CGSize)sizeWithString:(NSString*)sting Font:(float)font stringWith:(float)stringWith stringHight:(float)stringHight
{
    
    CGSize stringSize = [sting boundingRectWithSize:CGSizeMake(stringWith==0?MAXFLOAT:stringWith,stringHight==0?MAXFLOAT:stringHight) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]} context:nil].size;
    return stringSize;
}

+ (NSString *)whatismyipdotcom
{
    NSError *error;
    NSURL *ipURL = [NSURL URLWithString:@"http://www.whatismyip.com/automation/n09230945.asp"];
    NSString *ip = [NSString stringWithContentsOfURL:ipURL encoding:1 error:&error];
    return ip ? ip : [error localizedDescription];
    //    return @"127.0.0.1";
}
+ (NSString *)md5String:(NSString *)string
{
    const char *cStr = [string UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, (uint)strlen(cStr), result ); // This is the md5 call
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}
@end
