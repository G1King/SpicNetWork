//
//  SpicInputView.m
//  SpicNetWork
//
//  Created by Joshua on 2017/3/23.
//  Copyright © 2017年 Spic. All rights reserved.
//

#import "SpicInputView.h"
#define KSCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define KSCREEN_HEIGH [UIScreen mainScreen].bounds.size.height
@interface SpicInputView () <UITextFieldDelegate>
@property (nonatomic,strong) UITextField * textField;
@end
@implementation SpicInputView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = self.backGroundColor == nil ? [UIColor whiteColor] : self.backGroundColor;
        self.userInteractionEnabled = YES;
        [self setUI];
    }
    
    return  self;
}
#pragma mark - 初始化视图
-(void)setUI{
    [self addSubview:self.textField];
    [self addSubview:self.sendButton];
    self.textField.inputAccessoryView = self.sendButton;
    self.sendButton.frame = CGRectMake(0, 0, 60, 14);
    //http://blog.sina.com.cn/s/blog_4ef749ad0102v5xg.html
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeContentViewPoint:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hiddenKeyBoard:) name:UIKeyboardDidHideNotification object:nil];
}
-(void)changeContentViewPoint:(NSNotification *)notice{
    NSDictionary * info = [notice userInfo];
    NSValue * vulae = [info objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGFloat y = vulae.CGRectValue.origin.y;
    NSNumber *duration = [info objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSNumber *curve = [info objectForKey:UIKeyboardAnimationCurveUserInfoKey];
    [UIView animateWithDuration:duration.doubleValue animations:^{
        [UIView setAnimationBeginsFromCurrentState:YES];
        [UIView setAnimationCurve:[curve intValue]];
        self.center = CGPointMake(self.center.x, y - 20 ); // keyBoardEndY的坐标包括了状态栏的高度，要减去
    }];
}
-(void)hiddenKeyBoard:(NSNotification *)notice{
    NSDictionary * info = [notice userInfo];
    NSValue * vulae = [info objectForKey:UIKeyboardFrameEndUserInfoKey];
    NSNumber * dur = [info objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSNumber *curve = [info objectForKey:UIKeyboardAnimationCurveUserInfoKey];
    [UIView animateWithDuration:0.5 animations:^{
        [UIView setAnimationBeginsFromCurrentState:YES];
        
        [self setFrame:CGRectMake(self.frame.origin.x, KSCREEN_HEIGH-50-64, self.frame.size.width, self.frame.size.height)];
    }];
}
-(UITextField*)textField{
    if (!_textField) {
        _textField = [[UITextField alloc]initWithFrame:self.bounds];
        _textField.delegate = self;
        
    }
    return _textField;
}
-(void)setMPlaceholder:(NSString *)mPlaceholder{
    _mPlaceholder = mPlaceholder;
    self.textField.placeholder = mPlaceholder;
}
-(void)setPlaceHolderFont:(UIFont *)placeHolderFont{
    _placeHolderFont = placeHolderFont;
    NSDictionary * info = @{NSFontAttributeName:placeHolderFont};
    self.textField.attributedPlaceholder = [[NSAttributedString alloc]initWithString:self.mPlaceholder attributes:info];;
}
-(void)setSendButton:(UIButton *)sendButton
{
    
    _sendButton.titleLabel.font = self.sendButtonFont;
    [_sendButton setTitle:@"发送" forState:UIControlStateNormal];
    [_sendButton setTitleColor:self.sendButtonColor forState:UIControlStateNormal];
    [_sendButton addTarget:self action:@selector(inputContent:) forControlEvents:UIControlEventTouchUpInside];
    _sendButton = sendButton;
}
-(void)inputContent:(UIButton *)button{


}
@end
