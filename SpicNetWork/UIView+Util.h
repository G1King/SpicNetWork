//
//  UIView+Util.h
//  FreeTravel
//
//  Created by 刘志达 on 16/1/13.
//  Copyright © 2016年 刘志达(沈阳). All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Util)

@property (nonatomic,assign) CGFloat x;
@property (nonatomic,assign) CGFloat y;
@property (nonatomic) CGFloat left;        ///< Shortcut for frame.origin.x.
@property (nonatomic) CGFloat top;         ///< Shortcut for frame.origin.y
@property (nonatomic) CGFloat right;       ///< Shortcut for frame.origin.x + frame.size.width
@property (nonatomic) CGFloat bottom;      ///< Shortcut for frame.origin.y + frame.size.height
@property (nonatomic) CGFloat width;       ///< Shortcut for frame.size.width.
@property (nonatomic) CGFloat height;      ///< Shortcut for frame.size.height.
@property (nonatomic) CGFloat centerX;     ///< Shortcut for center.x
@property (nonatomic) CGFloat centerY;     ///< Shortcut for center.y
@property (nonatomic) CGPoint origin;      ///< Shortcut for frame.origin.
@property (nonatomic) CGSize  size;        ///< Shortcut for frame.size.

@property (nonatomic, readonly) UIViewController *viewControllers;

- (void)setCornerRadius:(CGFloat)cornerRadius;

- (void)setBorderWidth:(CGFloat)width borderColor:(UIColor *)color;

- (UIImage *)snapshotImage;
- (UIImage *)snapshotImageAfterScreenUpdates:(BOOL)afterUpdates;

/**
 *  仅设置圆角
 *
 *  @param radius 圆角半径
 */
- (void)addCorner:(CGFloat)radius;
/**
 *  设置圆角
 *
 *  @param radius          圆角半径
 *  @param borderWidth     边框宽度
 *  @param backgroundColor 视图背景颜色
 *  @param borderColor     边框颜色
 */
- (void)addCorner:(CGFloat)radius borderWidth:(CGFloat)borderWidth backgroundColor:(UIColor *)backgroundColor borderColor:(UIColor *)borderColor;

@end

@interface UIImageView (Util)

// 设置图片等比例显示
- (void)setAspectScale;

// 图片圆角
- (void)img_addCorner:(CGFloat)radius;

@end

@interface UIImage (Util)

// 改变图片颜色
- (UIImage *)imageWithColor:(UIColor *)color;

// 设置图片圆角
- (UIImage*)imageAddCornerWithRadius:(CGFloat)radius andSize:(CGSize)size;

//返回某种颜色的图片
+ (UIImage *)imageWithColor:(UIColor *)color;

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size ;

- (UIImage *)imageByBlurDark;

- (UIImage *)imageByBlurRadius:(CGFloat)blurRadius
                     tintColor:(UIColor *)tintColor
                      tintMode:(CGBlendMode)tintBlendMode
                    saturation:(CGFloat)saturation
                     maskImage:(UIImage *)maskImage;

@end

@interface UIButton (UIButtonExt)

- (void)verticalImageAndTitle:(CGFloat)spacing;

@end

@interface UIScrollView (YYAdd)

- (void)scrollToTopAnimated:(BOOL)animated;

@end

@interface UIView (HUD)
- (void)showHudInView:(UIView *)view hint:(NSString *)hint;

- (void)hideHud;

- (void)showHint:(NSString *)hint;

// 从默认(showHint:)显示的位置再往上(下)yOffset
- (void)showHint:(NSString *)hint yOffset:(float)yOffset;

- (void)showIndeterminate;
@end
