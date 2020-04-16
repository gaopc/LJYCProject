//
//  ShopForSignInViewController.h
//  LJYCProject
//
//  Created by gaopengcheng on 13-11-15.
//  Copyright (c) 2013年 longcd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGORefreshTableHeaderView.h"
#import "ShopForSignInData.h"

@interface ShopForSignInViewController : RootViewController<UITableViewDataSource,UITableViewDelegate,EGORefreshTableHeaderDelegate, UIAlertViewDelegate>
{
    BOOL reloading;
    EGORefreshTableHeaderView *_refreshHeaderView;
    NSInteger pageIndex;
    UIView *emptyView;
}
@property (nonatomic,retain) ShopForSignData *_signInData;
@property (nonatomic, retain) NSString *_shopId;
@property (nonatomic,retain) UITableView *myTableView;
@property (nonatomic,assign) BOOL isfromRecomend;
@property (nonatomic, assign) BOOL _butHiden;
@property (nonatomic, assign) id _delegate;
@end
