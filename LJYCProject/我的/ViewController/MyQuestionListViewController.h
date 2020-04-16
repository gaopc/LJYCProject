//
//  MyQuestionListViewController.h
//  LJYCProject
//
//  Created by xiemengyue on 13-11-12.
//  Copyright (c) 2013年 longcd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserForQuestionData.h"
#import "EGORefreshTableHeaderView.h"

#define NUMBER_PAGE 10

@interface MyQuestionListViewController : RootViewController<UITableViewDataSource,UITableViewDelegate,EGORefreshTableHeaderDelegate>
{
    BOOL reloading;
    EGORefreshTableHeaderView *_refreshHeaderView;
    NSInteger pageIndex;
}
@property(nonatomic,retain)UserForQuestionData *userForQuestionData;
@property(nonatomic,retain)UITableView *myTableView;
@property (nonatomic,assign) BOOL isfromRecomend;
@end
