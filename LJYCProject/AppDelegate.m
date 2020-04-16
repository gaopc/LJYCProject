//
//  AppDelegate.m
//  LJYCProject
//
//  Created by 张晓婷 on 13-10-23.
//  Copyright (c) 2013年 longcd. All rights reserved.
//

#import "AppDelegate.h"
#import "CoustomObject.h"
#import "SideBarViewController.h"
#import "ZXT_NavigationController.h"
#import "JASidePanelController.h"
#import "MobClick.h"
#import <AlipaySDK/AlipaySDK.h>

#define WeChatId  @"wxf2919f1eaac6a3bc" //微信id
#define WeChatAppKey @"07f8f4e7dd06c37005f1bb6feb9c444a" //微信Key

BMKMapManager* _mapManager;
@implementation AppDelegate

@synthesize viewDeckController;
@synthesize navigationController,_menuController,_tencentOAuth;
@synthesize alixPayResultDelegate;

- (void)dealloc
{
    [_window release];
    [_mapManager release];
    self.viewDeckController = nil;
    self._menuController = nil;
    self._tencentOAuth = nil;
    self.alixPayResultDelegate = nil;

    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{

    [WeiboSDK enableDebugMode:YES];
    [WeiboSDK registerApp:kAppKey];
    
    [WXApi registerApp:WeChatId];
    
    //友盟
//    [MobClick setLogEnabled:YES];
    [MobClick setAppVersion:[NSString stringWithFormat:@"%@",MyVersion]];
    [MobClick startWithAppkey:UMENG_APPKEY reportPolicy:REALTIME channelId:channelNo];
    [MobClick updateOnlineConfig];
    [MobClick setCrashReportEnabled:YES];
    
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    // Override point for customization after application launch.
    
//    HomeViewController *root = [[HomeViewController alloc]init];
//    ZXT_NavigationController *nav = [[ZXT_NavigationController alloc]initWithRootViewController:root];
//    [root release];
////    [nav.navigationBar setNeedsDisplay1];
//    self.navigationController = nav;
//    self._menuController = [[[FrameMenuViewController alloc] initWithRootViewController:nav] autorelease];
//    [nav release];
//    _menuController.delegate = self;
//    [self._menuController.viewControllers addObject:NSStringFromClass([root class])];
//     [self._menuController.rootNavControllers addObject:nav];
//    
//    SideBarViewController *leftvc = [[SideBarViewController alloc]init];
//    _menuController.leftViewController = leftvc;
//    [leftvc release];
//    
//    self.window.rootViewController = _menuController;
    
    HomeViewController *root = [[HomeViewController alloc]init];
    ZXT_NavigationController *nav = [[ZXT_NavigationController alloc]initWithRootViewController:root];
    [root release];
    SideBarViewController *leftvc = [[SideBarViewController alloc]init];
    JASidePanelController * jaside = [[JASidePanelController alloc] init];
    jaside.shouldDelegateAutorotateToVisiblePanel = NO;
    jaside.leftPanel = leftvc;
    jaside.centerPanel = nav;
    self.window.rootViewController = jaside;
    
    //E6a7345d9e9ccba8f984854f202ef216 隆畅达key
    //46ee30c41d46522379ca1bbc82581785 辣椒游C端key
	//68E931a2e8eab182278ac86a63eca381 辣椒游B端key
    /*
     辣郊游-个人版	hHvE4T5hFgLc3YYU7LWt0taH
     辣郊游-商家版	PZOlXtZzvGCF16dz2lmc9Hv4
     */
    self.window.backgroundColor = [UIColor whiteColor];
	_mapManager = [[BMKMapManager alloc]init];
	BOOL ret = [_mapManager start:@"hHvE4T5hFgLc3YYU7LWt0taH" generalDelegate:self];
	//    注意：为了给用户提供更安全的服务，iOS SDK自V2.0.2版本开始采用全新的key验证体系。
	//    因此当你选择使用，V2.0.2及以后版本的SDK时，需要到新的key申请页面进行全新key的申请，申请及配置流程请参考开发指南的对应章节。
	if (!ret) {
		NSLog(@"manager start failed!");
	}
    
    [self.window makeKeyAndVisible];
    return YES;
}


- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    NSLog(@"------1:%@", [deviceToken description]);
    NSString * tokenStr  = [deviceToken description];
    tokenStr = [tokenStr stringByReplacingOccurrencesOfString:@"<" withString:@""];
    tokenStr = [tokenStr stringByReplacingOccurrencesOfString:@">" withString:@""];
    [UserLogin sharedUserInfo].deviceToken = tokenStr;
    basicInfo = [[GetBasicInfoFromServer alloc] init];
    [basicInfo getConfiguration];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo NS_AVAILABLE_IOS(3_0)
{
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
}
    



- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
//    [[UIApplication sharedApplication]beginBackgroundTaskWithExpirationHandler:^(){
//        //程序在10分钟内未被系统关闭或者强制关闭，则程序会调用此代码块，可以在这里做一些保存或者清理工作
//
//    }];
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
//    [UIApplication sharedApplication].applicationIconBadgeNumber ++;
}
//- (void)parseURL:(NSURL *)url application:(UIApplication *)application {
//    
//    if (self.alixPayResultDelegate && [self.alixPayResultDelegate respondsToSelector:@selector(parseURL:application:)]) {
//        [self.alixPayResultDelegate performSelector:@selector(parseURL:application:) withObject:url withObject:application];
//    }
//}
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url{
    return [TencentOAuth HandleOpenURL:url];
}
- (void)parseURL:(NSDictionary *)resultDic application:(UIApplication *)application {
    
    if (self.alixPayResultDelegate && [self.alixPayResultDelegate respondsToSelector:@selector(parseURL:application:)]) {
        [self.alixPayResultDelegate performSelector:@selector(parseURL:application:) withObject:resultDic withObject:application];
    }
}
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{

    NSString *str = [NSString stringWithFormat:@"%@",url];
    if([[[str componentsSeparatedByString:@"://"] objectAtIndex:0] isEqualToString:@"sinaweibosso.2114242333"])
    {
        return  [[SinaWeiboDelegateClass sharedSinaWeiboDelegateClass]._sinaweibo handleOpenURL:url ];
    }
    else if([[[str componentsSeparatedByString:@"://"] objectAtIndex:0] isEqualToString:@"wb2114242333"])
    {
        [WaitView hiddenWaitView];
        return  [WeiboSDK handleOpenURL:url delegate:self];
    }
    else if([[str substringToIndex:2] isEqualToString:@"wx"])
    {
        return  [WXApi handleOpenURL:url delegate:self];
    }
//    else if ([[str substringToIndex:13] isEqualToString:@"LJYCProject"]) {
//        [self parseURL:url application:application];
//        return YES;
//    }
    //如果极简 SDK 不可用,会跳转支付宝钱包进行支付,需要将支付宝钱包的支付结果回传给 SDK
    else if ([url.host isEqualToString:@"safepay"]) {
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
            [self parseURL:resultDic application:application];
        }];
        return YES;
    }
    else if ([url.host isEqualToString:@"platformapi"]){//支付宝钱包快登授权返回 authCode
        [[AlipaySDK defaultService] processAuthResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
            [self parseURL:resultDic application:application];
        }];
        return YES;
    }

    else
    {
        return [TencentOAuth HandleOpenURL:url];
    }
}

#pragma mark-QQ

#pragma mark-WeiBo

- (void)didReceiveWeiboRequest:(WBBaseRequest *)request
{
    if ([request isKindOfClass:WBProvideMessageForWeiboRequest.class])
    {
        //        ProvideMessageForWeiboViewController *controller = [[[ProvideMessageForWeiboViewController alloc] init] autorelease];
        //        [self.viewController presentModalViewController:controller animated:YES];
    }
}

- (void)didReceiveWeiboResponse:(WBBaseResponse *)response
{
    if ([response isKindOfClass:WBSendMessageToWeiboResponse.class])
    {
        if (response.statusCode == 0) {
            [UIAlertView alertViewWithMessage:@"分享成功"];
        }
        else if (response.statusCode == -1)
        {
            [UIAlertView alertViewWithMessage:@"您取消了分享"];
        }
        else{
            [UIAlertView alertViewWithMessage:@"分享失败"];
        }
    }
    else if ([response isKindOfClass:WBAuthorizeResponse.class])
    {
        NSString *title = @"认证结果";
        NSString *message = [NSString stringWithFormat:@"响应状态: %d\nresponse.userId: %@\nresponse.accessToken: %@\nresponse.expirationDate: %@\n响应UserInfo数据: %@\n原请求UserInfo数据: %@",
                             response.statusCode, [(WBAuthorizeResponse *)response userID], [(WBAuthorizeResponse *)response accessToken],  [(WBAuthorizeResponse *)response expirationDate],  response.userInfo, response.requestUserInfo];
        NSLog(@"%@,%@,%@",title,message,[NSDate date]);
        if (response.statusCode == 0)
        {
            [SinaWeiboDelegateClass sharedSinaWeiboDelegateClass]._sinaweibo.accessToken = [(WBAuthorizeResponse *)response accessToken];
            [SinaWeiboDelegateClass sharedSinaWeiboDelegateClass]._sinaweibo.expirationDate = [(WBAuthorizeResponse *)response expirationDate];
            [SinaWeiboDelegateClass sharedSinaWeiboDelegateClass]._sinaweibo.userID = [(WBAuthorizeResponse *)response userID];
            
            NSDictionary *authData = [NSDictionary dictionaryWithObjectsAndKeys:
                                      [(WBAuthorizeResponse *)response accessToken], @"AccessTokenKey",
                                      [(WBAuthorizeResponse *)response expirationDate], @"ExpirationDateKey",
                                      [(WBAuthorizeResponse *)response userID], @"UserIDKey",
                                      @"", @"refresh_token", nil];
            [[NSUserDefaults standardUserDefaults] setObject:authData forKey:SinaWeiboAuthData];
            [[NSUserDefaults standardUserDefaults] synchronize];
            NSDictionary * requestDic = response.requestUserInfo;
            id delegate = [requestDic objectForKey:@"delegate"];
            SEL selector = NSSelectorFromString([NSString stringWithFormat:@"%@",[requestDic objectForKey:@"selector"]]);
            if (delegate && [delegate respondsToSelector:selector]) {
                [delegate performSelector:selector withObject:[SinaWeiboDelegateClass sharedSinaWeiboDelegateClass]._sinaweibo];
            }
        }
    }
}

#pragma mark-WeiXin
-(void) onResp:(BaseResp*)resp
{
    if([resp isKindOfClass:[SendMessageToWXResp class]])
    {
        NSString *strMsg = @"";
        NSString *strTitle = [NSString stringWithFormat:@"分享结果"];
        if (resp.errCode == 0) {
            strMsg = @"分享成功";
        }
        else if (resp.errCode == -2) {
            strMsg = @"您取消了分享";
        }
        else {
            strMsg = @"分享失败";
        }
        
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strTitle message:strMsg delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
    }
}
@end
