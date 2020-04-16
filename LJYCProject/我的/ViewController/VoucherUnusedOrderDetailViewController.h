//
//  VoucherUnusedOrderDetailViewController.h
//  LJYCProject
//
//  Created by 张晓婷 on 15-5-6.
//  Copyright (c) 2015年 longcd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GroupPurDetailData.h"
#import "ShopForDataInfo.h"

@interface VoucherUnusedOrderDetailViewController : RootViewController <UIAlertViewDelegate>// 未使用
@property (nonatomic,retain) GroupPurDetailData *_dataInfo;
@property (nonatomic, assign) BOOL _isUse;
@end
