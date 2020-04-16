//
//  AppDelegate.h
//  LJYCProject
//
//  Created by 张晓婷 on 13-10-23.
//  Copyright (c) 2013年 longcd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMapKit.h"
#import "HomeViewController.h"
#import "IIViewDeckController.h"
#import "WelecomViewContrller.h"
#import "FrameMenuViewController.h"

#import "WeiboSDK.h"
#import <TencentOpenAPI/TencentOAuth.h>
#import "SinaWeibo.h"
#import "SinaWeiBoExtend.h"
#import "WXApi.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate,BMKGeneralDelegate,FrameMenuControllerDelegate,WeiboSDKDelegate,WXApiDelegate>
{
    GetBasicInfoFromServer *basicInfo;
}
@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, retain)UINavigationController *navigationController;
//@property (nonatomic, retain)HomeViewController *homeVC;
@property (nonatomic , strong) IIViewDeckController  *viewDeckController;

@property (nonatomic, retain) FrameMenuViewController *_menuController;
@property (nonatomic , retain) TencentOAuth *_tencentOAuth;
@property (nonatomic, assign) id alixPayResultDelegate;

@end
