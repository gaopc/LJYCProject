//
//  OtherForErrorViewController.h
//  LJYCProject
//
//  Created by gaopengcheng on 13-11-7.
//  Copyright (c) 2013年 longcd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIPlaceHolderTextView.h"
#import "KeyBoardTopBar.h"
#import "ShopForErrorData.h"

@interface OtherForErrorViewController : RootViewController <UITextViewDelegate, UITextFieldDelegate>
{
    UITextView *myTextView;
    UISubLabel *countLab;
    UISubTextField *emailField;
    UISubTextField *phoneField;
    UIImageView *myImageView;
    UISubLabel *myLabel;
    ShopForErrorData *errorData;
}
@property (nonatomic,retain) NSArray *textFieldArray;
@property (nonatomic,retain) KeyBoardTopBar *keyboardbar;
@property (nonatomic, retain) NSString *_shopId;
@end