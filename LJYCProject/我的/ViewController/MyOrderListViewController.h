//
//  MyOrderListViewController.h
//  LJYCProject
//
//  Created by 张晓婷 on 14-3-11.
//  Copyright (c) 2014年 longcd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGORefreshTableHeaderView.h"
#import "FindOrders.h"
@interface MyOrderListViewController : RootViewController<UITableViewDataSource,UITableViewDelegate,EGORefreshTableHeaderDelegate>
{
    UIView * btnSelectedView;
    UITableView * myTableView;
    UIButton * notSaleBtn;
    UIButton * didSaleBtn;
    NSInteger  selectedTypeNow;
	
	EGORefreshTableHeaderView *_refreshHeaderView;
	
	BOOL reloading;
	int pageIndex;
	

}
//@property (nonatomic ,retain) NSArray * notSaleArray;
//@property (nonatomic ,retain) NSArray * didSaleArray;
@property (nonatomic ,retain) NSMutableArray * saleArray;
@property (nonatomic ,retain)  UITableView * myTableView;
@property (nonatomic ,assign) BOOL _dataIsFull;
@property (nonatomic ,assign) int totalPage; 
@property (nonatomic ,assign) BOOL isfromRecomend;
@property (nonatomic ,retain) Orders *orders;
-(void) reloadTableViewDataSource;
-(void) doneLoadingTableViewData;
-(void)cancelOrder;
@end
