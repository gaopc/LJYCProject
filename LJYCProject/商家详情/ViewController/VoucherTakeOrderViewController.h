//
//  VoucherTakeOrderViewController.h
//  LJYCProject
//
//  Created by 张晓婷 on 15-5-4.
//  Copyright (c) 2015年 longcd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GroupPurDetailData.h"
#import "VoucherPaySuccessfulViewController.h"
typedef enum{
    Wx,
    Card,
    Phone,
    Alix,
    Union,
    UnionPayEnd,
    AlixPayEnd,
    None
} PayMode;

@interface VoucherTakeOrderViewController : RootViewController <UITableViewDataSource, UITableViewDelegate, UIAlertViewDelegate>
{
    UITableView *myTable;
}

@property (retain, nonatomic) AppDelegate *myDelegate;
@property (nonatomic, assign) PayMode myMode;
@property (retain, nonatomic) id requestURL;
@property (retain, nonatomic)UIApplication * requestApplication;
@property (assign, nonatomic)NSInteger requestTimes;


@property (nonatomic, retain) NSString *_shopCount;
@property (nonatomic, retain) GroupPurDetailData *_orderData;
@property (nonatomic, retain) NSString *_tuanId;
@property (nonatomic, retain) NSString *_phoneNum;
@property (nonatomic, assign) BOOL _cancelOrder;

- (void)changePhoneNum:(NSString *)telephone;


@end
