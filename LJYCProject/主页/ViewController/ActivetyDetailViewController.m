//
//  ActivetyDetailViewController.m
//  LJYCProject
//
//  Created by 张晓婷 on 15-4-21.
//  Copyright (c) 2015年 longcd. All rights reserved.
//

#import "ActivetyDetailViewController.h"

@interface ActivetyDetailViewController ()<UIWebViewDelegate>
{
    UIWebView * webView;
}
@end

@implementation ActivetyDetailViewController
@synthesize _activety;
- (void)dealloc
{
    self._activety = nil;
    [super dealloc];
}
-(void)loadView
{
    [super loadView];
    webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, ViewWidth, ViewHeight + 20)];
    [webView  setUserInteractionEnabled:YES];
    [webView  setBackgroundColor:[UIColor clearColor]];
    [webView  setOpaque:NO];//使网页透明
    webView .scalesPageToFit = YES;
    webView .autoresizesSubviews = YES;
    webView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:webView];
    [webView release];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"活动";

    // Do any additional setup after loading the view.
    
    NSURL *rurl = [NSURL URLWithString:self._activety._url];
    NSURLRequest *request = [NSURLRequest requestWithURL:rurl];
    [webView loadRequest:request];

}

- (void)loadRequest:(NSURLRequest *)request{}
- (void)loadHTMLString:(NSString *)string baseURL:(NSURL *)baseURL{}
- (void)loadData:(NSData *)data MIMEType:(NSString *)MIMEType textEncodingName:(NSString *)textEncodingName baseURL:(NSURL *)baseURL{}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
