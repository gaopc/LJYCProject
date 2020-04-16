//
//  SelectServiceItemViewController.h
//  LJYCProject
//
//  Created by gaopengcheng on 13-11-5.
//  Copyright (c) 2013年 longcd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KeyBoardTopBar.h"

@interface SelectServiceItemViewController : RootViewController <UITextFieldDelegate>
{
    UIScrollView *myScrollView;
    UISubTextField *myTextField;
    int topViewHeight;
    
    NSArray *itemArr1;
    NSArray *itemArr2;
    NSArray *itemArr3;
    NSArray *itemArr4;
    NSArray *itemArr5;
    
    UIScrollView *view1;
    UIScrollView *view2;
    UIScrollView *view3;
    UIScrollView *view4;
    UIScrollView *view5;
    
    UIView *topView;
    UIView *midView;
    
    UIButton *changeBut1;
    UIButton *changeBut2;
    UIButton *changeBut3;
    UIButton *changeBut4;
    UIButton *changeBut5;
    
    NSMutableArray *saveServiceArr;
}
@property (nonatomic, retain) NSArray *textFieldArray;
@property (nonatomic, retain) KeyBoardTopBar *keyboardbar;
@property (nonatomic, retain) NSMutableArray *_selectItemArr;
@property (nonatomic, retain) NSArray *_currentArr;
@property (nonatomic, retain) id _delegate;
@end
