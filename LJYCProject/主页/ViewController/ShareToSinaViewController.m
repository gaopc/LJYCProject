//
//  ShareToSinaViewController.m
//  FlightProject
//
//  Created by 张晓婷 on 13-7-10.
//
//

#import "ShareToSinaViewController.h"

@interface ShareToSinaViewController ()

@end

@implementation ShareToSinaViewController
@synthesize _url;
- (void)dealloc
{
    self._url = nil;
    [super dealloc];
}
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
	// Do any additional setup after loading the view.
    self.title = @"新浪微博分享";
    webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, 320, ViewHeight - 44)];
    [webView loadRequest:[NSURLRequest requestWithURL:self._url]];
    [self.view addSubview:webView];
    [webView release];
}
-(void)backHome
{
    if (webView.canGoBack) {
        [webView goBack];
    }
    else
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
