//
//  MessageListViewController.h
//  LJYCProject
//
//  Created by 张晓婷 on 13-11-7.
//  Copyright (c) 2013年 longcd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyMessageData.h"
#import "EGORefreshTableHeaderView.h"

@interface MessageListViewController : RootViewController<UITableViewDelegate,UITableViewDataSource,EGORefreshTableHeaderDelegate>
{
    UITableView * myTableView;
    NSInteger pageIndex;
    
    BOOL reloading;
    EGORefreshTableHeaderView *_refreshHeaderView;
}
@property (nonatomic,retain) MyMessageData * myMessageData;
@property (nonatomic,assign) BOOL isfromRecomend;

@end
