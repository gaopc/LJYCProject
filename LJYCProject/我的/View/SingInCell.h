//
//  SingInCell.h
//  LJYCProject
//
//  Created by xiemengyue on 13-11-14.
//  Copyright (c) 2013年 longcd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SingInCell : UITableViewCell
@property(nonatomic,retain) UIView*leftView;
@property(nonatomic,retain) UISubLabel *leftName;
@property(nonatomic,retain) UISubLabel *leftDate;
@property(nonatomic,retain) UIButton *leftBtn;

@property(nonatomic,retain) UIView*rightView;
@property(nonatomic,retain) UISubLabel *rightName;
@property(nonatomic,retain) UISubLabel *rightDate;
@property(nonatomic,retain) UIButton *rightBtn;

@property(nonatomic,assign) id delegate;
@end
