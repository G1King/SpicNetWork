//
//  NSString+StingTool.h
//  FantasyCloud
//
//  Created by 奇幻云 on 16/2/26.
//  Copyright © 2016年 奇幻云. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface NSString (StingTool)
+(NSString*)stringWithImageString:(NSString *)string;
+ (NSString *)whatismyipdotcom;
+(CGSize)sizeWithString:(NSString*)sting Font:(float)font stringWith:(float)stringWith stringHight:(float)stringHight;
+(NSString *)md5String:(NSString *)string;
@end
