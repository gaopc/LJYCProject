//
//  ResetPasswordViewController.h
//  LJYCProject
//
//  Created by xiemengyue on 13-10-25.
//  Copyright (c) 2013年 longcd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoustomTextField.h"
#import "KeyBoardTopBar.h"

@interface ResetPasswordViewController : RootViewController<UITextFieldDelegate,UIAlertViewDelegate>
{
  NSTimer *_timer;
}
@property (nonatomic,assign) int times;
@property (nonatomic,retain) UISubLabel *showSecond;

@property(nonatomic,retain)CoustomTextField *phoneNumTF;
@property(nonatomic,retain)CoustomTextField *verificationNumTF;
@property(nonatomic,retain)CoustomTextField *passwordNumTF;

@property(nonatomic,assign)BOOL showPWD;
@property(nonatomic,retain)UIButton *swichBtn;
@property(nonatomic,retain)UIButton *getVerificationBtn;

@property (nonatomic,retain)NSArray *textFieldArray;
@property (nonatomic,retain)KeyBoardTopBar *keyboardbar;
@end
