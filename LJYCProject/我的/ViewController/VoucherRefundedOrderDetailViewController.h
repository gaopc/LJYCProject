//
//  VoucherRefundedOrderDetailViewController.h
//  LJYCProject
//
//  Created by 张晓婷 on 15-5-6.
//  Copyright (c) 2015年 longcd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VoucherUnusedOrderDetailViewController.h"

@interface VoucherRefundedOrderDetailViewController : RootViewController <UIAlertViewDelegate>//已退款
@property (nonatomic,retain) GroupPurDetailData *_orderDataInfo;
@end
