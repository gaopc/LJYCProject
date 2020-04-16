//
//  ShopForErrorViewController.h
//  LJYCProject
//
//  Created by gaopengcheng on 13-11-7.
//  Copyright (c) 2013年 longcd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KeyBoardTopBar.h"
#import "ShopForErrorData.h"
#import "ShopForDataInfo.h"

@interface ShopForErrorViewController : RootViewController <UITextFieldDelegate, UIAlertViewDelegate>
{
    UIScrollView *myScroll;
    UISubTextField *nameField;
    UISubTextField *phoneField1;
    UISubTextField *phoneField2;
    UISubTextField *phoneField3;
    UISubTextField *emailField;
    UISubTextField *phoneField;
    UISubTextField *addressField;
    
    UIButton *selectImgBut1;
    UIButton *selectImgBut2;
    UIButton *selectImgBut3;
    UIButton *selectImgBut4;
    UIButton *selectImgBut5;
    
    UIView *titleView;
    UIView *typeView;
    UIView *addressView;
    UIView *phoneVIew;
    UIView *bottomView;
    
    UIView *phone1View;
    UIView *phone2View;
    int viewhight;
    
    ShopForErrorData *shopData;
    int typeSelect;
    
    int phoneViewNum;
}
@property (nonatomic, retain) UISubLabel *_cityLab;
@property (nonatomic, retain) NSArray *textFieldArray;
@property (nonatomic, retain) KeyBoardTopBar *keyboardbar;
@property (nonatomic, retain) ShopForDataInfo *_errorData;
@property (nonatomic, retain) NSArray *_btnArr;
@property (nonatomic, retain) UIButton *_preBtn;
@end
