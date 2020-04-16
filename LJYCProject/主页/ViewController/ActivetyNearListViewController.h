//
//  ActivetyNearListViewController.h
//  LJYCProject
//
//  Created by gaopengcheng on 15-6-16.
//  Copyright (c) 2015年 longcd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShopFindProperty.h"

@interface ActivetyNearListViewController : RootViewController <UITableViewDataSource, UITableViewDelegate>
{
    UITableView *myTable;
}
@property (nonatomic, retain) NSMutableArray *_shopListData;
@end
