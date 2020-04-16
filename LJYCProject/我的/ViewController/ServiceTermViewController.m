//
//  ServiceTermViewController.m
//  FlightProject
//
//  Created by green kevin on 13-1-5.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import "ServiceTermViewController.h"

@interface ServiceTermViewController ()

@end

@implementation ServiceTermViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	self.title = @"服务协议";
	activityIV = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
	activityIV.center = self.view.center;
	activityIV.hidden = YES;
	
	myWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, 320, ViewHeight - 44)];
	myWebView.delegate = self;
	myWebView.backgroundColor = [UIColor clearColor];
	// Do any additional setup after loading the view.
	
	NSString *path = [[NSBundle mainBundle] pathForResource:@"serviceterm" ofType:@"html"];
	[myWebView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:path]]];
        
	[self.view addSubview:myWebView];
	[myWebView release];
	
	[self.view addSubview:activityIV];
	[activityIV release];
}

-(void)webViewDidStartLoad:(UIWebView *)webView
{
	activityIV.hidden = NO;
	[activityIV startAnimating];
}
-(void)webViewDidFinishLoad:(UIWebView *)webView
{
	[webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitUserSelect='none';"];
	activityIV.hidden = YES;
	[activityIV stopAnimating];
}
-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
	activityIV.hidden = YES;
	[activityIV stopAnimating];
}

-(void)backHome
{
	if (myWebView.canGoBack) {
		[myWebView goBack];
	}
	else
	{
		[self.navigationController popViewControllerAnimated:YES];
	}
}

- (void)viewDidUnload
{
	[super viewDidUnload];
	// Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
