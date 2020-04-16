//
//  ShopForOrderViewController.h
//  LJYCProject
//
//  Created by gaopengcheng on 14-3-10.
//  Copyright (c) 2014年 longcd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GroupPurDetailData.h"

@interface ShopForOrderViewController : RootViewController <UITableViewDataSource, UITableViewDelegate, UIAlertViewDelegate>
{
    UITableView *myTable;
}

@property (nonatomic, retain) NSString *_shopCount;
@property (nonatomic, retain) GroupPurDetailData *_orderData;
@property (nonatomic, retain) NSString *_tuanId;
@property (nonatomic, retain) NSString *_phoneNum;
@property (nonatomic, assign) BOOL _cancelOrder;

- (void)changePhoneNum:(NSString *)telephone;
@end
