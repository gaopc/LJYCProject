//
//  ShopForSignViewController.h
//  LJYCProject
//
//  Created by gaopengcheng on 13-11-7.
//  Copyright (c) 2013年 longcd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIPlaceHolderTextView.h"
#import "KeyBoardTopBar.h"

@interface ShopForSignViewController : RootViewController <UITextViewDelegate>
{
    UITextView *myTextView;
    UISubLabel *countLab;
    UIImageView *myImageView;
    UISubLabel *myLabel;
}
@property (nonatomic,retain) NSArray *textFieldArray;
@property (nonatomic,retain) KeyBoardTopBar *keyboardbar;
@end