//
//  ShopForDetailsCell.h
//  LJYCProject
//
//  Created by gaopengcheng on 13-10-24.
//  Copyright (c) 2013年 longcd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShopForPublicCell.h"
#import "AsyncImageView.h"

@interface ShopForDetailsCell : ShopForPublicCell
@property (nonatomic, retain) AsyncImageView *_shopImageView;
@property (nonatomic, retain) UIButton *_shopImageBut;
@property (nonatomic, retain) UISubLabel *_titleLab;
@property (nonatomic, retain) UISubLabel *_distanceLab;
@property (nonatomic, retain) UIButton *_submibBut;
@property (nonatomic, retain) UIImageView *_certificationView;
@property (nonatomic, retain) UIImageView *_shopStateView;
@end


@interface ShopForButtonsCell : UITableViewCell
@property (nonatomic, retain) UIButton *_signInBut;
@property (nonatomic, retain) UIButton *_collectionBut;
@property (nonatomic, retain) UIButton *_telphoneBut;
@property (nonatomic, retain) UISubLabel *_signNumLab;
@property (nonatomic, retain) UISubLabel *_collectNumLab;
@end

@interface ShopForAddressCell : UITableViewCell
@property (nonatomic, retain) UISubLabel *_addressLab;
@end

@interface ShopForTypeCell : UITableViewCell
@property (nonatomic, retain) UISubLabel *_shopTypeLab;
@end

@interface ShopForServiceCell : UITableViewCell
@property (nonatomic, retain) UISubLabel *_serviceLab;
@property (nonatomic, retain) UIImageView *_backView;
@end

@interface ShopForScaleCell : UITableViewCell
@property (nonatomic, retain) UISubLabel *_scaleLab;
@end

@interface ShopForDateCell : UITableViewCell
@property (nonatomic, retain) UISubLabel *_dateLab;
@end

@interface ShopForIntroduceCell : UITableViewCell
@property (nonatomic, retain) UISubLabel *_introduceLab;
@property (nonatomic, retain) UIImageView *_backView;
@end

@interface ShopForNoticeCell : UITableViewCell
@property (nonatomic, retain) UISubLabel *_noticeLab;
@end

@interface ShopForEvaluationCell : ShopForPublicCell
@property (nonatomic, retain) UISubLabel *_numLab;
@end

@interface ShopForEvaluationInfoCell : ShopForPublicCell
@property (nonatomic, retain) UISubLabel *_dateLab;
@property (nonatomic, retain) UISubLabel *_nameLab;
@property (nonatomic, retain) UISubLabel *_detailLab;
@end

@interface ShopForQuestionCell : UITableViewCell
@property (nonatomic, retain) UISubLabel *_numLab;
@property (nonatomic, retain) UIButton *_questBut;
@end

@interface ShopForQuestionInfoCell : UITableViewCell
{
    UIImageView *selectView;
}
@property (nonatomic, retain) UISubLabel *_nameLab;
@property (nonatomic, retain) UISubLabel *_detailLab;
@property (nonatomic, retain) UISubLabel *_dateLab;

- (void)isSelectedImg:(BOOL)boolean;
@end

@interface ShopForRecommendCell : UITableViewCell
@property (nonatomic, retain) UIButton *_but1;
@property (nonatomic, retain) UIButton *_but2;
@property (nonatomic, retain) UIButton *_but3;
@property (nonatomic, retain) UIButton *_but4;
@end

@interface ShopForOnlineCell : UITableViewCell
@property (nonatomic, retain) UIImageView *_iconView;
@property (nonatomic, retain) UISubLabel *_priceLab;
@property (nonatomic, retain) UISubLabel *_contentLab;
@property (nonatomic, retain) UISubLabel *_subContentLab;

@property (nonatomic, retain) UIButton *_enterBut;
@end