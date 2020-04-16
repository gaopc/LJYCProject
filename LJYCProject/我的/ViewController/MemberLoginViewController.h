//
//  MemberLoginViewController.h
//  LJYCProject
//
//  Created by xiemengyue on 13-10-24.
//  Copyright (c) 2013年 longcd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserLogin.h"
#import "KeyBoardTopBar.h"
#import <TencentOpenAPI/TencentOAuth.h>

typedef enum {
    ShopForCollect,
    ShopForSign,
    ShopForUpload,
    ShopForComment,
    ShopForError,
    ShopForQuestion,
    ShopForTuan,
} ShopClickType;

@interface MemberLoginViewController : RootViewController<UITextFieldDelegate,TencentSessionDelegate>
{
    TencentOAuth *_tencentOAuth;
}
@property(nonatomic,retain)UIButton *swichBtn;
@property(nonatomic,retain)CoustomTextField *userNameTF;
@property(nonatomic,retain)CoustomTextField *passWordTF;
@property(nonatomic,assign)BOOL rememberPWD;
@property(nonatomic,retain)UserLogin *myUserLogin;

@property (nonatomic,retain)NSArray *textFieldArray;
@property (nonatomic,retain)KeyBoardTopBar *keyboardbar;

@property (nonatomic,assign) id delegate;
@property (nonatomic ,assign) BOOL _isAddShop;
@property (nonatomic, assign) ShopClickType _clickType;

@property(nonatomic,retain)NSString *userName;
@end
