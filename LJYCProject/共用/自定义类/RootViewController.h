//
//  RootViewController.h
//  FlightProject
//
//  Created by longcd on 12-6-4.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

/* 本类是所有试图控制器的基类，用于处理公共情况，例如navagation的样式，软件支持的硬件方向*/
#import <UIKit/UIKit.h>
#import "SendRequstCatchQueue.h"
#import "CoustomObject.h"
#import "InterfaceClass.h"

@interface RootViewController : UIViewController<UIActionSheetDelegate>
{
    BOOL showSideBar;
}
@property (nonatomic,retain) UIView * view_IOS7;
-(void)goHome;
-(void) backHome;
- (void)callTel:(NSString *)telNum;
@end
