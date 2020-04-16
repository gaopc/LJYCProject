//
//  RootViewController.m
//  FlightProject
//
//  Created by longcd on 12-6-4.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "RootViewController.h"
#import "NSDate+convenience.h"
#import "UIViewController+JASidePanel.h"
#import "MobClick.h"
@interface RootViewController ()
@property (nonatomic,retain) NSArray * rootVCArray;
@end

@implementation RootViewController
@synthesize view_IOS7,rootVCArray;
- (void)dealloc
{
    self.view_IOS7 = Nil;
    self.rootVCArray = nil;
    [super dealloc];
}


-(void)showHome
{
    [self.navigationController popViewControllerAnimated:NO];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void) backHome
{
    [self.navigationController  popViewControllerAnimated:YES];
}
-(void)goHome
{
	[self.navigationController  popToRootViewControllerAnimated:YES];
}
//友盟添加事件  [MobClick event:@"AlixPay"];
//-(void)viewWillAppear:(BOOL)animated
//{
//    [super viewWillAppear:animated];
//}
//-(void)viewWillDisappear:(BOOL)animated
//{
//    [super viewWillDisappear:animated];
//}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:[NSString stringWithFormat:@"%@",[self class]]];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:[NSString stringWithFormat:@"%@",[self class]]];
}

-(void)loadView
{
    [super loadView];
    showSideBar = NO;
    float height = ViewHeight;
    float y = ViewStartY;
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, y, ViewWidth, height -y )];
    self.view_IOS7 = view;
    [view release];
    [self.view addSubview:self.view_IOS7];
//    self.view_IOS7.backgroundColor = [UIColor whiteColor];
    
//    self.view.backgroundColor = [UIColor whiteColor];
    self.view_IOS7.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background.png"]];
    
//    UIImageView * imageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, ViewHeight+20)];
//    imageV.image = [UIImage imageNamed:@"background.png"];
//    [self.view_IOS7 insertSubview:imageV atIndex:0];
//    [imageV release];
    
    UIButton  * leftButton = [UIButton buttonWithType:UIButtonTypeCustom tag:0 title:nil frame:CGRectMake(0, 0, 24, 19) backImage:[UIImage imageNamed:@"返回.png"] target:self action:@selector(backHome)];
    UIBarButtonItem * leftBar = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = leftBar;
    [leftBar release];
    
//    UIButton  * rightButton = [CoustomButton buttonWithBlueBorder:CGRectMake(10, 7, 52, 30) target:self action:@selector(goHome) title:@"默认"];
//    //[UIButton buttonWithType:UIButtonTypeCustom tag:0 title:nil frame:CGRectMake(10, 7, 52, 30) backImage:[UIImage imageNamed:@"backHome.png"] target:self action:@selector(goHome)];
//    UIBarButtonItem * rightBar = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
//    self.navigationItem.rightBarButtonItem = rightBar;
//    [rightBar release];

}
-(void)sideBar:(UIButton*)sender//侧栏
{
    if (showSideBar) {
        [self.sidePanelController showCenterPanelAnimated:YES];
    }
    else
    {
        [self.sidePanelController showLeftPanelAnimated:YES];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"closeKeyBoard" object:nil];
    }

//    static const ZXT_UISideMenu * menu = nil;
//    if (!menu) {
//        NSArray * titleArray = [NSArray arrayWithObjects:@"首页",@"上传商家",@"告诉朋友",@"使用帮助",@"投诉建议",@"打分鼓励",@"版本更新",@"关于我们", nil];
//        self.rootVCArray = [NSArray arrayWithObjects:@"HomeViewController",@"AddShopsViewController",@"",@"HelpViewController",@"RecommendationViewController",@"",@"",@"AboutViewController", nil];
//        NSMutableArray * itemArray = [NSMutableArray array];
//        for (int i = 0;i < [titleArray count];i++) {
//            NSString * titleStr = [titleArray objectAtIndex:i];
//            ZXT_UISideMenuItem * item =[[ZXT_UISideMenuItem alloc] initWithTitle:titleStr image:[UIImage imageNamed:titleStr] highlightedImage:[UIImage imageNamed:titleStr] action:^(ZXT_UISideMenu * menu ,ZXT_UISideMenuItem * item){
//                if (i == 2) {
//                    UIActionSheet *sheet = [[UIActionSheet alloc]initWithTitle:@"告诉朋友" delegate:self
//                                                             cancelButtonTitle:@"取消" destructiveButtonTitle:Nil otherButtonTitles:@"短信",@"微博" ,@"QQ" ,nil];
//                    [sheet showInView:menu];
//                    [sheet release];
//                }
//                else if (i == 5)
//                {
//                    [UIAlertView alertViewWithMessage:@"打分鼓励"];
//                }
//                else if (i == 6)
//                {
//                    [UIAlertView alertViewWithMessage:@"版本更新"];
//                }
//                else
//                {
//                    NSString * rootVCStr =  [rootVCArray objectAtIndex:i];
//                    id  class = NSClassFromString(rootVCStr);
//                    BOOL tag = 0;
//                    NSLog(@"%@",NavigationController.viewControllers);
//                    for (UIViewController * vc in NavigationController.viewControllers) {
//                        if ([vc isKindOfClass:class]) {
//                            NSMutableArray * array = [NSMutableArray array];
//                            [array addObjectsFromArray:NavigationController.viewControllers];
//                            [array removeObject:vc];
//                            [array addObject:vc];
//                            NavigationController.viewControllers = array;
//                            tag = 1;
//                            break;
//                        }
//                    }
//                    if (tag == 0) {
//                        UIViewController * rootVC = [ [class alloc] init];
//                        [NavigationController pushViewController:rootVC animated:YES];
//                        [rootVC release];
//                    }
//                    [menu hide];
//                }
//            }];
//            [itemArray addObject:item];
//            [item release];
//        }
//        menu  = [[ZXT_UISideMenu alloc]  initWithItems:itemArray];
//    }
//    [menu show];
}
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:
            [UIAlertView alertViewWithMessage:@"短信"];
            break;
        case 1:
            [UIAlertView alertViewWithMessage:@"微博"];
            break;
        case 2:
            [UIAlertView alertViewWithMessage:@"QQ"];
            break;
        default:
            break;
    }
}
-(void)callTel:(NSString *)telNum
{
	BOOL isPhone=[self isPhone];
	if(isPhone){
		NSString *telephoneStr = [[NSString alloc] initWithFormat:@"tel://%@", telNum];
		UIWebView*callWebview =[[UIWebView alloc] init];
		NSURL *telURL =[NSURL URLWithString:telephoneStr];// 貌似tel:// 或者 tel: 都行
		[callWebview loadRequest:[NSURLRequest requestWithURL:telURL]];
		
		[self.view addSubview:callWebview];
		[telephoneStr release];
		[callWebview release];
	}else{
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"当前设备不支持电话功能！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
		[alert show];
		[alert release];
	}
}


- (BOOL)isPhone{
	NSString *deviceModel = [NSString stringWithString:[UIDevice currentDevice].model];
	//if(DEBUG) NSLog(@"device model = %@", deviceModel);
	if ([deviceModel rangeOfString:@"iPhone"].location != NSNotFound) {
		if ([deviceModel rangeOfString:@"Simulator"].location == NSNotFound) {
			return YES;
		}
	}
	return NO;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

	// Do any additional setup after loading the view.
}

@end
