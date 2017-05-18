//
//  SpicInputView.h
//  SpicNetWork
//
//  Created by Joshua on 2017/3/23.
//  Copyright © 2017年 Spic. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SpicInputView : UIView

/**
 占位符
 */
@property (nonatomic,copy) NSString * mPlaceholder;

/**
 占位符的字体大小
 */
@property (nonatomic,strong) UIFont * placeHolderFont;
/**
 输入框的北京 默认 为白色
 */
@property (nonatomic,strong) UIColor * backGroundColor;

/**
 输入字体的大小
 */
@property (nonatomic,strong) UIFont * textFont;

/**
 发送按钮
 */
@property (nonatomic,strong) UIButton * sendButton;

@property (nonatomic,strong) UIColor * sendButtonColor;

@property (nonatomic,strong) UIFont * sendButtonFont;

@end
