//
//  ShopOrderBoundPhoneViewController.h
//  LJYCProject
//
//  Created by xiemengyue on 14-3-11.
//  Copyright (c) 2014年 longcd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KeyBoardTopBar.h"
#import "VoucherTakeOrderViewController.h"
@interface ShopOrderBoundPhoneViewController : RootViewController<UITextFieldDelegate>
{
    NSTimer *_timer;
}
@property(nonatomic,retain)UISubTextField *phoneNumTF;
@property(nonatomic,retain)UISubTextField *verificationNumTF;
@property(nonatomic,retain)UIButton *getVerificationBtn;
@property(nonatomic,retain)UISubLabel *showSecond;
@property (nonatomic,assign) int times;

@property (nonatomic,retain)NSArray *textFieldArray;
@property (nonatomic,retain)KeyBoardTopBar *keyboardbar;
@property (nonatomic,retain)id shopForOrderVC;
@end
