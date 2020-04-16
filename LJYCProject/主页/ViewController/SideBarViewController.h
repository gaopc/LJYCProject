//
//  SideBarViewController.h
//  LJYCProject
//
//  Created by xiemengyue on 13-11-1.
//  Copyright (c) 2013年 longcd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeiXinExport.h"
#import "WeiboSDK.h"
#import <Social/Social.h>

@interface SideBarViewController : RootViewController<UITableViewDataSource,UITableViewDelegate,UIActionSheetDelegate,UIAlertViewDelegate>
@property(nonatomic,retain) NSArray *titlesArray;
@property(nonatomic,retain) UITableView *myTableView;

@end
