//
//  VerificationViewController.h
//  LJYCProject
//
//  Created by xiemengyue on 13-10-31.
//  Copyright (c) 2013年 longcd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoustomTextField.h"
#import "KeyBoardTopBar.h"

@interface VerificationViewController : RootViewController<UITextFieldDelegate>
{
    NSTimer *_timer;
}
@property (nonatomic,assign) int times;

@property(nonatomic,retain)CoustomTextField *phoneNumTF;//手机号
@property(nonatomic,retain)CoustomTextField *verificationNumTF;//验证码
@property(nonatomic,retain)CoustomTextField *referrerTF;//推荐人
@property(nonatomic,retain)UIButton *getVerificationBtn;//获取验证码
@property(nonatomic,retain)UIButton *jumpBtn;//获取验证码

@property (nonatomic,retain)NSArray *textFieldArray;
@property (nonatomic,retain)KeyBoardTopBar *keyboardbar;
@property (nonatomic,assign)id delegate;
@property (nonatomic,retain) UISubLabel *showSecond;
@end
