//
//  ShopForPayViewController.h
//  LJYCProject
//
//  Created by 张晓婷 on 14-3-12.
//  Copyright (c) 2014年 longcd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShopFordataInfo.h"

#import "PayDataClass.h"

#import <AlipaySDK/AlipaySDK.h>

#import "DataSigner.h"
#import "JSON.h"
#import "VoucherTakeOrderViewController.h"

//@class AppDelegate;

//typedef enum{
//    Card,
//    Phone,
//    Alix,
//    Union,
//    UnionPayEnd,
//    AlixPayEnd,
//    None
//} PayMode;

@interface ShopForPayViewController : RootViewController<UITableViewDataSource, UITableViewDelegate, UIAlertViewDelegate>
{
    UITableView *myTable;
}
@property (nonatomic, retain) ShopForReturn *_orderData;
@property (retain, nonatomic) AppDelegate *myDelegate;
@property (nonatomic, assign) PayMode myMode;
@property (retain, nonatomic)NSURL * requestURL;
@property (retain, nonatomic)UIApplication * requestApplication;
@property (assign, nonatomic)NSInteger requestTimes;
@end
