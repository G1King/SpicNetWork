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
#define System_V ([[[UIDevice currentDevice]systemVersion ]floatValue])
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSLog(@"111");
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    btn.frame = CGRectMake(100, 100, 100, 100);
    
    btn.backgroundColor = [UIColor redColor];
    
    [btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:btn];
}

-(void) click:(UIButton *)button{
//    [self openWiFi];
   
    UIDocumentInteractionController * document = [UIDocumentInteractionController interactionControllerWithURL: [[NSBundle mainBundle]URLForResource:@"test" withExtension:@"pdf"]];
    [document presentOpenInMenuFromRect:self.view.bounds inView:self.view animated:YES];
}
-(void)openWiFi{
    
    NSURL * utl ;
    if (System_V >= 10.0) {
        utl = [NSURL URLWithString:@"Prefs:root=Privacy&path=WIFI"];
        Class LSApplicationWorkspace = NSClassFromString(@"LSApplicationWorkspace");
        
        [[LSApplicationWorkspace performSelector:@selector(defaultWorkspace)] performSelector:@selector(openSensitiveURL:withOptions:) withObject:utl withObject:nil];
        
        
    }else{
        utl = [NSURL URLWithString:@"prefs:root=Privacy&path=WIFI"];

        [[UIApplication sharedApplication] openURL:utl options:nil completionHandler:nil];
    }
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
