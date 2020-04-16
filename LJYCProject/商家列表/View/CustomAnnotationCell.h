//
//  CustomAnnotationCell.h
//  LJYCProject
//
//  Created by z1 on 13-10-30.
//  Copyright (c) 2013年 longcd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AsyncImageView.h"
@interface CustomAnnotationCell : UIView


@property (nonatomic,retain) AsyncImageView* imgeView;
@property (nonatomic,retain) UISubLabel* titleLabel;
@property (nonatomic,retain) UIView * markValueView; //星级
@property (nonatomic, retain) UIButton* shopButton;
-(void)drawStarCodeView:(float) markValue;




@end
