//
//  ShopForCommentView.h
//  LJYCProject
//
//  Created by gaopengcheng on 13-11-9.
//  Copyright (c) 2013年 longcd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShopForCommentData.h"
#import "EGORefreshTableHeaderView.h"

@interface ShopForCommentView : UIView <UITableViewDataSource, UITableViewDelegate, EGORefreshTableHeaderDelegate>
{
    UITableView *myView;
    BOOL reloading;
    EGORefreshTableHeaderView *_refreshHeaderView;
    NSInteger pageIndex;
    UIView *emptyView;
    UISubLabel *commentNum;
}
@property (nonatomic, retain) ShopForCommentData *_commentData;
@property (nonatomic, assign) BOOL isfromRecomend;
@property (nonatomic, retain) NSString *_shopId;
@property (nonatomic, retain) NSString *_starLv;

- (void)show;
@end
