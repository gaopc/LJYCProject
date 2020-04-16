//
//  TagButton.h
//  LJYCProject
//
//  Created by xiemengyue on 13-10-28.
//  Copyright (c) 2013年 longcd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RootView.h"

@interface TagButton : RootView
@property(nonatomic,retain)UIImageView *selectedImageView;
@property(nonatomic,assign)NSInteger tag;
@property(nonatomic,assign) id delegate;
@property(nonatomic,assign) BOOL isSelected;

@property(nonatomic,retain)NSString * shopType; // zxt
@property(nonatomic,retain)NSString * serviceTag; // zxt
@property(nonatomic,retain)NSString * titleName; // zxt
@property(nonatomic,retain)NSString * tagName; // zxt



+(TagButton*)setTagButton:(NSString*)imageURL  frame:(CGRect)frame tag:(NSInteger)tag showImageView:(BOOL)showImageView title:(NSString *)title isShowRightLine:(BOOL)isShowRightLine isShowBelowLine:(BOOL)isShowBelowLine isAddButton:(BOOL)isAddButton;
@end
