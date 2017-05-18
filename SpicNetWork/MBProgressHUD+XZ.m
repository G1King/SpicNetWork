//
//  MBProgressHUD+XZ.m
//  MiaoKa
//
//  Created by lixiangzhou on 15/6/12.
//  Copyright (c) 2015年 lxz. All rights reserved.
//

#import "MBProgressHUD+XZ.h"

// 默认的显示时间
static const CGFloat defaultShowDuration = 1.5;

@implementation MBProgressHUD (XZ)

#pragma mark - 显示 progress
+ (MBProgressHUD *)showProgress
{
    return [self showProgressFromView:nil minShowTime:0];
}

+ (MBProgressHUD *)showProgressFromView:(UIView *)view
{
    return [self showProgressFromView:view minShowTime:0];
}
/*
 *  @param view         hud 要添加到的View，若为nil，则添加到keyWindow
 *  @param minShowTime  hud最短显示的时间
 */
+ (MBProgressHUD *)showProgressFromView:(UIView *)view minShowTime:(CGFloat)minShowTime
{
    
#warning 加载图片
    MBProgressHUD *hud = [self getHudFromView:view];
    

    
    hud.mode = MBProgressHUDModeCustomView;
    hud.minShowTime = minShowTime;
    hud.opacity = 0.05;
    hud.removeFromSuperViewOnHide = YES;
    
    NSString *loadingPath = [[NSBundle mainBundle] pathForResource:@"loading" ofType:nil];
    NSFileManager *fm = [NSFileManager defaultManager];
    NSArray *imgNames = [fm contentsOfDirectoryAtPath:loadingPath error:nil];
    
    UIImageView *loadingView = [UIImageView new];
//    loadingView.center = CGPointMake([UIScreen width]/2, [UIScreen height]/2);
    loadingView.contentMode = UIViewContentModeCenter;
    loadingView.backgroundColor = [UIColor clearColor];
    
    NSMutableArray *imgs = [NSMutableArray arrayWithCapacity:imgNames.count];
    for (NSInteger i = 0; i < imgNames.count/2; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"loading/%zd", i + 1]];
        [imgs addObject:image];
    }
    loadingView.animationImages = imgs;
    loadingView.animationDuration = 0.075 * imgs.count;
    [loadingView startAnimating];
    
    hud.customView = loadingView;
    hud.margin = 0;
    
    __weak typeof(loadingView) weakLoadingView = loadingView;
    hud.completionBlock = ^{
        [weakLoadingView stopAnimating];
        weakLoadingView.animationImages = nil;
    };
    
    [hud show:YES];

    
    [hud show:YES];
    return hud;
}

#pragma mark - 显示文本
+ (MBProgressHUD *)showText:(NSString *)text
{
    return [self showText:text fromView:nil duration:0 complete:nil];
}

+ (MBProgressHUD *)showText:(NSString *)text fromView:(UIView *)view
{
    return [self showText:text fromView:view duration:0 complete:nil];
}
+ (MBProgressHUD *)showText:(NSString *)text fromView:(UIView *)view complete:(MBProgressHUDCompletionBlock)complete
{
    return [self showText:text fromView:view duration:0 complete:complete];
}
+ (MBProgressHUD *)showText:(NSString *)text fromView:(UIView *)view duration:(CGFloat)duration
{
    return [self showText:text fromView:view duration:duration complete:nil];
}

+ (MBProgressHUD *)showText:(NSString *)text fromView:(UIView *)view duration:(CGFloat)duration complete:(MBProgressHUDCompletionBlock)complete
{
    if (![text isKindOfClass:[NSString class]] || text.length == 0) {
        return nil;
    }
    
    MBProgressHUD *hud = [self getHudFromView:view];
    
    hud.mode = MBProgressHUDModeText;
    hud.detailsLabelText = text;
    hud.completionBlock = complete;
    hud.removeFromSuperViewOnHide = YES;
    hud.cornerRadius = 0;
    
    [hud show:YES];
    if (duration == 0) {
        duration = defaultShowDuration;
    }
    [hud hide:YES afterDelay:duration];
    return hud;
}

#pragma mark - 显示自定义的View
+ (MBProgressHUD *)showCustomView:(UIView *)customView fromView:(UIView *)view duration:(CGFloat)duration complete:(MBProgressHUDCompletionBlock)complete
{
    MBProgressHUD *hud = [self getHudFromView:view];
    
    hud.mode = MBProgressHUDModeCustomView;
    hud.completionBlock = complete;
    hud.removeFromSuperViewOnHide = YES;
    hud.cornerRadius = 0;
    hud.customView = customView;
    hud.margin = 0;
    
    [hud show:YES];
    if (duration == 0) {
        duration = defaultShowDuration;
    }
    
    [hud hide:YES afterDelay:duration];
    return hud;
}

#pragma mark - 私有方法
+ (MBProgressHUD *)getHudFromView:(UIView *)view
{
    UIView *superView = view;
    if (!view) {
        superView = [UIApplication sharedApplication].keyWindow;
    }
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:superView];
    [superView addSubview:hud];
    
    return hud;
}

@end
