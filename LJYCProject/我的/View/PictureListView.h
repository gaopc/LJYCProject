//
//  PictureListView.h
//  LJYCProject
//
//  Created by gaopengcheng on 13-11-22.
//  Copyright (c) 2013年 longcd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGORefreshTableHeaderView.h"
#import "PicModel.h"

@interface PictureListView : UIView <UITableViewDataSource, UITableViewDelegate, EGORefreshTableHeaderDelegate>
{
    UITableView *myTable;
    BOOL reloading;
    EGORefreshTableHeaderView *_refreshHeaderView;
    NSInteger pageIndex;
    UIView *emptyView;
}
@property (nonatomic, assign) BOOL isfromRecomend;
@property (nonatomic, assign) id _delegate;
@property (nonatomic, retain) NSString *_shopId;
@property (nonatomic, retain) NSString *_picType;
@property (nonatomic ,retain) PicListModel *_listData;

- (void)showView;
@end
