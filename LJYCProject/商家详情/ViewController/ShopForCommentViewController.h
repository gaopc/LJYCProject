//
//  ShopForCommentViewController.h
//  LJYCProject
//
//  Created by gaopengcheng on 13-11-9.
//  Copyright (c) 2013年 longcd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShopForCommentView.h"
#import "ShopForCommentData.h"

@interface ShopForCommentViewController : RootViewController
{
    UIButton *but0;
    UIButton *but1;
    UIButton *but2;
    UIButton *but3;
    UIButton *but4;
    UIButton *but5;
    
    ShopForCommentView *view0;
    ShopForCommentView *view1;
    ShopForCommentView *view2;
    ShopForCommentView *view3;
    ShopForCommentView *view4;
    ShopForCommentView *view5;
    
    ShopForCommentData *commentData;
}

@property (nonatomic, retain) NSString *_shopId;
@property (nonatomic, retain) NSString *_shopName;
@property (nonatomic, assign) BOOL _butHiden;
@property (nonatomic, retain) UIView *nvBarView;
@end
