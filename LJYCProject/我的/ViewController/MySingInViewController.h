//
//  MySingInViewController.h
//  LJYCProject
//
//  Created by xiemengyue on 13-11-14.
//  Copyright (c) 2013年 longcd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGORefreshTableHeaderView.h"
#import "UserSignInData.h"

@interface MySingInViewController :RootViewController<UITableViewDataSource,UITableViewDelegate,EGORefreshTableHeaderDelegate>
{
    BOOL reloading;
    EGORefreshTableHeaderView *_refreshHeaderView;
    NSInteger pageIndex;
}
@property (nonatomic,retain) UserSignInData *myUserSignInData;
@property (nonatomic,retain) UITableView *myTableView;
@property (nonatomic,assign) BOOL isfromRecomend;
@end
