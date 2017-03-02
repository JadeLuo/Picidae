//
//  PICViewController.m
//  Picidae
//
//  Created by 394570610@qq.com on 02/27/2017.
//  Copyright (c) 2017 394570610@qq.com. All rights reserved.
//

#import "PICViewController.h"
#import <Picidae/Picidae.h>
@interface PICViewController ()<UIWebViewDelegate>
@property (strong, nonatomic) IBOutlet UIWebView *webView;
@property(strong,nonatomic)JSContext * context;
@property(nonatomic,strong)PICBridge * bridge;
@end

@implementation PICViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSURL *baseURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]];
    NSString * path = [[NSBundle mainBundle]pathForResource:@"Test" ofType:@"html"];
    NSData * data = [[NSData alloc]initWithContentsOfFile:path];
    NSString * string = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(captureJSContext) name:@"DidCreateContextNotification" object:nil];
    self.webView.delegate = self;
    [self.webView loadHTMLString:string baseURL:baseURL];
}
-(void)captureJSContext{
    self.context = [self.webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    self.bridge =[[PICBridge alloc]init];
    self.context[@"bridge"] = self.bridge;
    [self.context setExceptionHandler:^(JSContext * context, JSValue * value) {
        NSLog(@"%@",[value toObject]);
    }];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
@implementation NSObject (pic_uiwebViewDelegator)

- (void)webView:(id)unuse didCreateJavaScriptContext:(JSContext *)ctx forFrame:(id)frame {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"DidCreateContextNotification" object:ctx];
}
@end
