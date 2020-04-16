//
//  MemberPhotoEditViewController.h
//  LJYCProject
//
//  Created by gaopengcheng on 13-11-14.
//  Copyright (c) 2013年 longcd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KeyBoardTopBar.h"
#import "PicModel.h"

@interface MemberPhotoEditViewController : RootViewController <UITextFieldDelegate, UIAlertViewDelegate>
{
    UISubTextField *nameField;
    CoustormPullDownMenuView *downView;
}
@property (nonatomic, retain) UIImage *_editImage;
@property (nonatomic, retain) NSArray *textFieldArray;
@property (nonatomic, retain) KeyBoardTopBar *keyboardbar;
@property (nonatomic ,retain) PicModel *_picData;
@property (nonatomic, assign) id _delegate;
@end
