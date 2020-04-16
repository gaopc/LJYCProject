//
//  ShopCollectViewController.h
//  LJYCProject
//
//  Created by z1 on 13-11-6.
//  Copyright (c) 2013年 longcd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGORefreshTableHeaderView.h"
#import "ShopFindProperty.h"
#import "ShopCollectCell.h"
#import "OrderMenuView.h"
#import "FilterMenuView.h"

@class ShopCollectDataResponse;
@interface ShopCollectViewController : RootViewController<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate,FilterMenuDelegate,ShopCollectDelegate,OrderMenuDelegate,EGORefreshTableHeaderDelegate>
{
	EGORefreshTableHeaderView *_refreshHeaderView;
	BOOL isSelectMap;
	BOOL reloading;
	int pageIndex;

}

@property (nonatomic, retain) ShopCollectDataResponse *shopCollectDataResponse;
@property (nonatomic, retain) OrderMenuView *orderMenu;
@property (nonatomic, retain) FilterMenuView *typeMenu;

@property (nonatomic, retain) UIImageView *arrowUp1;
@property (nonatomic, retain) UIImageView *arrowDown1;

@property (nonatomic, retain) UIImageView *arrowUp2;
@property (nonatomic, retain) UIImageView *arrowDown2;

@property (nonatomic, retain) UIButton* orderButton;
@property (nonatomic, retain) UIButton* typeButton;

@property (nonatomic, retain) UITableView *h_tableView;
@property (nonatomic, retain) NSMutableArray *shopListArray;
@property (nonatomic, retain) NSMutableArray *cityListArray;
@property (nonatomic, retain) Shops *shops;
@property (nonatomic, retain) ShopCollect *shopCollect;
@property (assign) BOOL _dataIsFull;
@property (nonatomic,retain) UISubLabel *promptlable;
@property (nonatomic,assign)int pageIndex;

@property (nonatomic, retain) CollectProperty *collectProperty;
@property (nonatomic,assign) BOOL isfromRecomend;
@property (nonatomic,retain) UIView *inputView;

@property (nonatomic,assign)  BOOL arrow1;
@property (nonatomic,assign)  BOOL arrow2;

@property (nonatomic,retain) UISubLabel* orderLabel;
@property (nonatomic,retain) UISubLabel* filterLabel;

@property (nonatomic, retain) UIBarButtonItem * rightBar;
@property (nonatomic, retain) UIButton* editButton;

-(void) reloadTableViewDataSource;
-(void) doneLoadingTableViewData;

@end
