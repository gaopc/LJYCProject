//
//  ShopTuanWebViewController.h
//  LJYCProject
//
//  Created by z1 on 14-3-11.
//  Copyright (c) 2014年 longcd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GroupPurDetailData.h"
#import "TitleSectionsView.h"
@interface ShopTuanWebViewController : RootViewController <UITableViewDataSource, UITableViewDelegate,TitleSectionsDelegate>
{
}
@property (nonatomic, retain) GroupPurDetailData *groupdata;
@property (nonatomic, retain) NSString *groupPurId;
@property (nonatomic, retain) UITableView *h_tableView;
@end
