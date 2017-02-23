//
//  SpicDataModel.h
//  SpicNetWork
//
//  Created by Sunshinking on 2017/2/23.
//  Copyright © 2017年 Spic. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
  二进制文件模型
 */
@interface SpicDataModel : NSObject


@property (nonatomic,copy) NSString * headName;

@property (nonatomic,strong) NSData * data;

@end
