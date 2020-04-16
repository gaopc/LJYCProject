//
//  ShopForEvaluationViewController.h
//  LJYCProject
//
//  Created by gaopengcheng on 13-11-7.
//  Copyright (c) 2013年 longcd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIPlaceHolderTextView.h"
#import "KeyBoardTopBar.h"

@interface ShopForEvaluationViewController : RootViewController <UITextViewDelegate>
{
    UITextView *myTextView;
    UISubLabel *countLab;
    UIImageView *myImageView;
    UISubLabel *myLabel;
    UIButton *starBut1;
    UIButton *starBut2;
    UIButton *starBut3;
    UIButton *starBut4;
    UIButton *starBut5;
    int selectStar;
}
@property (nonatomic,retain) NSArray *textFieldArray;
@property (nonatomic,retain) KeyBoardTopBar *keyboardbar;
@property (nonatomic, retain) NSString *_shopId;
@property (nonatomic, assign) id _delegate;
@end
