//
//  MemberRegisterViewController.h
//  LJYCProject
//
//  Created by xiemengyue on 13-10-24.
//  Copyright (c) 2013年 longcd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoustomTextField.h"
#import "KeyBoardTopBar.h"
#import "WeiboSDK.h"
#import <TencentOpenAPI/TencentOAuth.h>

@interface MemberRegisterViewController : RootViewController<TencentSessionDelegate>
{
    TencentOAuth *_tencentOAuth;
}
@property(nonatomic,retain)CoustomTextField *userNameTF;
@property(nonatomic,retain)CoustomTextField *passWordTF;
@property(nonatomic,retain)UIButton *swichBtn;

@property(nonatomic,assign)BOOL showPWD;
@property(nonatomic,retain)NSString *userID;
@property(nonatomic,retain)NSString *userName;

@property (nonatomic,retain)NSArray *textFieldArray;
@property (nonatomic,retain)KeyBoardTopBar *keyboardbar;

@property (nonatomic,assign) id delegate;


@end
