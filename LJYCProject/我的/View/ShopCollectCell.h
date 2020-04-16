//
//  ShopCollectCell.h
//  LJYCProject
//
//  Created by z1 on 13-11-13.
//  Copyright (c) 2013年 longcd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AsyncImageView.h"




@protocol ShopCollectDelegate
@optional

-(void)phoneClick:(id)sender;//点击电话按钮


@end
@interface ShopCollectCell : UITableViewCell
@property (nonatomic, assign) id <ShopCollectDelegate> delegate;
@property (nonatomic,retain) AsyncImageView *shopImageView;
@property (nonatomic,retain) UIImageView *shopRest; //休业
@property (nonatomic,retain) UIImageView *shopClose; //停业
@property (nonatomic,retain) UISubLabel *name; //名称
@property (nonatomic,retain) UISubLabel *rating; //星级
@property (nonatomic,retain) UISubLabel *serviceTags; // 服务标签
@property (nonatomic,retain) UISubLabel *area; // 店铺所属区域
@property (nonatomic,retain) UISubLabel *distance;// 距离
@property (nonatomic,retain) UIView * markValueView; //星级
@property (nonatomic,retain) UIImageView *locate;
@property (nonatomic,retain) UIImageView *check;
@property (nonatomic,retain) UIImageView *bgImageView;
@property (nonatomic, retain) UIButton* phoneButton;
@property (nonatomic, retain) UIImageView* phoneNoButton;
@property (nonatomic, retain) UIImageView* notice;
-(void)drawStarCodeView:(float) markValue;

@end
