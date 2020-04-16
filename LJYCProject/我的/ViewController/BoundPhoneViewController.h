//
//  BoundPhoneViewController.h
//  LJYCProject
//
//  Created by 张晓婷 on 13-11-7.
//  Copyright (c) 2013年 longcd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KeyBoardTopBar.h"
#import "VoucherTakeOrderViewController.h"

@interface BoundPhoneViewController : RootViewController<UITextFieldDelegate>
{
    NSTimer *_timer;
}
@property (nonatomic,assign) int times;
@property (nonatomic,retain) UISubLabel *showSecond;

@property(nonatomic,retain)CoustomTextField *phoneNumTF;//手机号
@property(nonatomic,retain)CoustomTextField *verificationNumTF;//验证码
@property(nonatomic,retain)UIButton *getVerificationBtn;//获取验证码
@property(nonatomic,retain)UIButton *jumpBtn;//获取验证码

@property (nonatomic,retain)NSArray *textFieldArray;
@property (nonatomic,retain)KeyBoardTopBar *keyboardbar;
@property (nonatomic, retain) id shopForOrderVC;

@end
