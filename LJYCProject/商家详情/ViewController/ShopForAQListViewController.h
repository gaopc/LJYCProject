//
//  ShopForAQListViewController.h
//  LJYCProject
//
//  Created by gaopengcheng on 13-11-9.
//  Copyright (c) 2013年 longcd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGORefreshTableHeaderView.h"
#import "ShopForQuestionData.h"

@interface ShopForAQListViewController : RootViewController <UITableViewDelegate, UITableViewDataSource, EGORefreshTableHeaderDelegate>
{
    UITableView *myTable;
    BOOL reloading;
    EGORefreshTableHeaderView *_refreshHeaderView;
    NSInteger pageIndex;
    UIView *emptyView;
}
@property (nonatomic,retain) ShopForQuestionData *_shopQuestData;
@property (nonatomic,assign) BOOL isfromRecomend;
@property (nonatomic, retain) NSString *_shopId;
@property (nonatomic, assign) BOOL _butHiden;
@end
