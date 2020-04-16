//
//  ShopFindCell.h
//  SystemArchitecture
//
//  Created by z1 on 13-10-23.
//  Copyright (c) 2013年 longcd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AsyncImageView.h"




@protocol ShopFindDelegate
@optional

-(void)phoneClick:(id)sender;//点击电话按钮

-(void)bgClick:(id)sender;//
@end

@interface ShopFindCell : UITableViewCell

@property (nonatomic, assign) id <ShopFindDelegate> delegate;
@property (nonatomic,retain) AsyncImageView *shopImageView;
@property (nonatomic,retain) UISubLabel *name; //名称
@property (nonatomic,retain) UISubLabel *rating; //星级
@property (nonatomic,retain) UISubLabel *serviceTags; // 服务标签
@property (nonatomic,retain) UISubLabel *area; // 店铺所属区域
@property (nonatomic,retain) UISubLabel *distance;// 距离
@property (nonatomic,retain) UIView * markValueView; //星级
@property (nonatomic,retain) UIImageView *locate;
@property (nonatomic,retain) UIImageView *check;
@property (nonatomic,retain) UIImageView *bgImageView;
@property (nonatomic,retain) UIImageView *shopRest; //休业
@property (nonatomic,retain) UIImageView *isVouchers; //是否有代金券

@property (nonatomic, retain) UIButton* phoneButton;
@property (nonatomic, retain) UIButton* bgButton;
@property (nonatomic, retain) UIImageView* notice;
-(void)drawStarCodeView:(float) markValue;


@end

