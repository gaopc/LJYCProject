//
//  VerifyUserNameViewController.h
//  LJYCProject
//
//  Created by xiemengyue on 13-11-5.
//  Copyright (c) 2013年 longcd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KeyBoardTopBar.h"
#import "CoustomTextField.h"

@interface VerifyUserNameViewController : RootViewController<UITextFieldDelegate>
@property(nonatomic,retain)CoustomTextField *userNameTF;
@property (nonatomic,retain)NSString *userName;
@property (nonatomic,retain)NSArray *textFieldArray;
@property (nonatomic,retain)KeyBoardTopBar *keyboardbar;

@property (nonatomic,retain) NSString *token;
@property (nonatomic,retain) NSString *account;

@property (nonatomic,assign) id delegate;
@end
