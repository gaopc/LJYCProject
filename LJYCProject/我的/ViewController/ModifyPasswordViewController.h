//
//  ModifyPasswordViewController.h
//  LJYCProject
//
//  Created by 张晓婷 on 13-11-7.
//  Copyright (c) 2013年 longcd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KeyBoardTopBar.h"
@interface ModifyPasswordViewController : RootViewController<UITextFieldDelegate,UIAlertViewDelegate>
@property(nonatomic,retain)UIButton *swichBtn;
@property(nonatomic,retain)CoustomTextField *newPassWordTF;
@property(nonatomic,retain)CoustomTextField *oldPassWordTF;
@property(nonatomic,assign)BOOL showPWD;
@property(nonatomic,retain)UserLogin *myUserLogin;

@property (nonatomic,retain)NSArray *textFieldArray;
@property (nonatomic,retain)KeyBoardTopBar *keyboardbar;

@end
