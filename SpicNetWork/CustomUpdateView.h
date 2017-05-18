//
//  CustomUpdateView.h
//  SpicNetWork
//
//  Created by Joshua on 2017/4/5.
//  Copyright © 2017年 Spic. All rights reserved.
//


#import <UIKit/UIKit.h>

typedef void(^AlertResult)(NSInteger index);

@interface CustomUpdateView : UIView

@property (nonatomic,copy) AlertResult resultIndex;

- (instancetype)initWithimage:(UIImage *)image message:(NSString*)message sureBtn:(NSString *)sureTitle cancleBtn:(NSString *)cancleTitle;

- (void)showAlertView;

@end
