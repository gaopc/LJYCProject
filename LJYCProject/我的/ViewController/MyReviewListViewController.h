//
//  MyReviewListViewController.h
//  LJYCProject
//
//  Created by xiemengyue on 13-11-12.
//  Copyright (c) 2013年 longcd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserForCommentData.h"
#import "EGORefreshTableHeaderView.h"

#define NUMBER_PAGE 10

@interface MyReviewListViewController : RootViewController<UITableViewDataSource,UITableViewDelegate,EGORefreshTableHeaderDelegate>
{
    BOOL reloading;
    EGORefreshTableHeaderView *_refreshHeaderView;
    
    NSInteger pageIndex;
}
@property (nonatomic,retain) UserForCommentData *userForCommentData;
@property (nonatomic,retain) UITableView *myTableView;
@property (nonatomic,assign) BOOL isfromRecomend;
@end
