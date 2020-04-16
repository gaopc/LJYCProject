//
//  ShopTuanDetailsViewController.h
//  LJYCProject
//
//  Created by z1 on 14-3-7.
//  Copyright (c) 2014年 longcd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoustomScrollerView.h"
#import "GroupPurDetailData.h"
#import "TitleSectionsView.h"
@interface OneSectionsCell : UITableViewCell<CScrollerViewDelegate>

@property (nonatomic,retain) CoustomScrollerView *scroller;
- (void) initWithPicUrl:(NSArray *) picUrls;
@end


@interface ShopTuanDetailsViewController : RootViewController <UITableViewDataSource, UITableViewDelegate,TitleSectionsDelegate>
{
	
}

@property (nonatomic, retain) UITableView *h_tableView;
@property (nonatomic, retain) GroupPurDetailData *groupdata;
@property (nonatomic, retain) NSString *groupPurId;
@end
