//
//  RecommendationViewController.h
//  LJYCProject
//
//  Created by 张晓婷 on 13-11-5.
//  Copyright (c) 2013年 longcd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KeyBoardTopBar.h"
#import "CoustomTextField.h"

@interface RecommendationViewController : RootViewController<UITextViewDelegate,UITextFieldDelegate>
@property(nonatomic,retain)UIImageView *myImageView;
@property(nonatomic,retain)UISubLabel *myLabel;
@property(nonatomic,retain)UISubTextView *myTextView;
@property(nonatomic,retain)CoustomTextField *emailTF;
@property(nonatomic,retain)UISubLabel *ziCount;

@property (nonatomic,retain)NSArray *textFieldArray;
@property (nonatomic,retain)KeyBoardTopBar *keyboardbar;
@end
