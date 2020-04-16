//
//  MemberPhotoListViewController.h
//  LJYCProject
//
//  Created by gaopengcheng on 13-11-22.
//  Copyright (c) 2013年 longcd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGORefreshTableHeaderView.h"
#import "PicModel.h"

@interface MemberPhotoListViewController : RootViewController <UITableViewDataSource, UITableViewDelegate, EGORefreshTableHeaderDelegate>
{
    UITableView *myTable;
    BOOL reloading;
    EGORefreshTableHeaderView *_refreshHeaderView;
    NSInteger pageIndex;
    UIView *emptyView;
}
@property (nonatomic, retain) PicListModel *_picListData;
@property (nonatomic, assign) BOOL isfromRecomend;
@property (nonatomic, retain) NSString *_saveImgTag;
@end
