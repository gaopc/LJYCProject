//
//  MyOrderDetailViewController.h
//  LJYCProject
//
//  Created by 张晓婷 on 14-3-11.
//  Copyright (c) 2014年 longcd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderDetailsData.h"
@interface MyOrderDetailViewController : RootViewController<UITableViewDataSource, UITableViewDelegate>
{
    UITableView *myTable;
}

@property (nonatomic,retain) OrderDetailsData *orderDetailsData;
@property (nonatomic,retain) NSString *name;
@end
