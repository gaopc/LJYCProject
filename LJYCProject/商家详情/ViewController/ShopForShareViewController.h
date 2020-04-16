//
//  ShopForShareViewController.h
//  LJYCProject
//
//  Created by gaopengcheng on 13-11-7.
//  Copyright (c) 2013年 longcd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIPlaceHolderTextView.h"
#import "KeyBoardTopBar.h"
#import "WeiboApi.h"

@interface ShopForShareViewController : RootViewController <UITextViewDelegate>
{
    UITextView *myTextView;
    UISubLabel *countLab;
    UIImageView *myImageView;
    UISubLabel *myLabel;
    
    BOOL selectX;
    BOOL selectW;
    BOOL selectQ;
    UIButton *xinlangBut;
    UIButton *qqBut;
}
@property (nonatomic, retain) NSArray *textFieldArray;
@property (nonatomic, retain) KeyBoardTopBar *keyboardbar;
@property (nonatomic, retain) WeiboApi *wbapi;
@end
