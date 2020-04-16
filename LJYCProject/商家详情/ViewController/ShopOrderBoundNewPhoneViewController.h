//
//  ShopOrderBoundNewPhoneViewController.h
//  LJYCProject
//
//  Created by xiemengyue on 14-3-12.
//  Copyright (c) 2014年 longcd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KeyBoardTopBar.h"
#import "ShopForOrderViewController.h"
@interface ShopOrderBoundNewPhoneViewController : RootViewController<UITextFieldDelegate>
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
@property (nonatomic,retain)ShopForOrderViewController *shopForOrderVC;
@end
