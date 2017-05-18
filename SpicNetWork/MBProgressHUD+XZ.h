//
//  MBProgressHUD+XZ.h
//  MiaoKa
//
//  Created by lixiangzhou on 15/6/12.
//  Copyright (c) 2015年 lxz. All rights reserved.
//

#import "MBProgressHUD.h"

@interface MBProgressHUD (XZ)

#pragma mark - 显示 progress
+ (MBProgressHUD *)showProgress;
+ (MBProgressHUD *)showProgressFromView:(UIView *)view;
/*
 *  @param view         hud 要添加到的View，若为空，则添加到keyWindow
 *  @param minShowTime  hud最短显示的时间
 */
+ (MBProgressHUD *)showProgressFromView:(UIView *)view minShowTime:(CGFloat)minShowTime;

#pragma mark - 显示文本
+ (MBProgressHUD *)showText:(NSString *)text;
+ (MBProgressHUD *)showText:(NSString *)text fromView:(UIView *)view;
+ (MBProgressHUD *)showText:(NSString *)text fromView:(UIView *)view complete:(MBProgressHUDCompletionBlock)complete;
+ (MBProgressHUD *)showText:(NSString *)text fromView:(UIView *)view duration:(CGFloat)duration;
/**
 *  @param text     需要显示的文字
 *  @param view     文字显示的super View
 *  @param duration 文字显示时间
 *  @param complete 显示完后的block
 */
+ (MBProgressHUD *)showText:(NSString *)text fromView:(UIView *)view duration:(CGFloat)duration complete:(MBProgressHUDCompletionBlock)complete;

#pragma mark - 显示自定义的View
/**
 *  @param customView 显示的View
 *  @param view       父类View
 *  @param duration   显示时间
 *  @param complete   显示完后的block
 */
+ (MBProgressHUD *)showCustomView:(UIView *)customView fromView:(UIView *)view duration:(CGFloat)duration complete:(MBProgressHUDCompletionBlock)complete;

@end
