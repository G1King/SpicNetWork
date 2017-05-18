//
//  ViewController.m
//  SpicNetWork
//
//  Created by Sunshinking on 2017/2/23.
//  Copyright © 2017年 Spic. All rights reserved.
//

#import "ViewController.h"
#import "SpicNetTool.h"
#import <objc/runtime.h>
#import <ImageIO/ImageIO.h>
#import <WebKit/WebKit.h>
#import "SpicInputView.h"
#import "UIImageView+WebCache.h"
#import "UIView+Util.h"
#import "CustomUpdateView.h"
#import <WebKit/WebKit.h>
#define KSCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define KSCREEN_HEIGH [UIScreen mainScreen].bounds.size.height
#define System_V ([[[UIDevice currentDevice]systemVersion ]floatValue])
@interface ViewController ()<UIAlertViewDelegate,UIDocumentInteractionControllerDelegate,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) WKWebView * webView;
@property (nonatomic,strong) UIView *rankImageBgView;
@property (nonatomic,strong) UIImageView * imageView;
@end
#define kGetImage(imageName) [UIImage imageNamed:[NSString stringWithFormat:@"%@",imageName]]
@implementation ViewController
{
    NSMutableArray * _titleArray;
    UITableView * _tableView;
}
static const NSString * APP_ID = @"1149757723";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSLog(@"%@====",@"s");
    NSURL *url=[NSURL URLWithString: @"http://127.0.0.1/001.png"];
    NSURLRequest * req = [NSURLRequest requestWithURL:url];
    NSURLSession * session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    [[session dataTaskWithRequest:req completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        self.imageView = [[UIImageView alloc]initWithFrame:self.view.bounds];
        self.imageView.image=[UIImage imageWithData:data];
        [self.view addSubview:self.imageView];
        NSLog(@"%@",error);
        
    }]resume];
  
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    if ([[UIApplication sharedApplication]canOpenURL:[NSURL URLWithString:@"https://itunes.apple.com/cn/app/id1149757723?ls=1&mt=8"]]) {
//        [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"https://itunes.apple.com/cn/app/id1149757723?ls=1&mt=8"] options:nil completionHandler:nil];
//    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
