//
//  ShopForOrderCell.h
//  LJYCProject
//
//  Created by gaopengcheng on 14-3-10.
//  Copyright (c) 2014年 longcd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShopForOrderCell : UITableViewCell
@property (nonatomic, retain) UISubLabel *_contentLab;
@property (nonatomic, retain) UISubLabel *_priceLab;
@property (nonatomic, retain) UISubLabel *_countLab;
@property (nonatomic, retain) UISubLabel *_totalPriceLab;

@property (nonatomic, retain) UIButton *_reduceBut;
@property (nonatomic, retain) UIButton *_addBut;
@property (nonatomic, assign) NSInteger _orderCount;
@property (nonatomic, assign) id _delegate;
@property (nonatomic, assign) int _maxCount;

- (void)set_noticeView:(BOOL)firstBool with:(BOOL)secondBool;
- (void)setMaxCount:(int)temp withNewTag:(int)tag;
@end

@interface ShopForPhoneCell : UITableViewCell
@property (nonatomic, retain) UISubLabel *_phoneLab;
@property (nonatomic, retain) UISubLabel *_noticeLab;

@property (nonatomic, retain) UIButton *_phoneBut;
@property (nonatomic, retain) UIButton *_submitBut;
@end


@protocol ShopForSubmitCellDelegate <NSObject>

-(void)aliPay;
-(void)wxPay;

@end

@interface ShopForSubmitCell : UITableViewCell

@property (nonatomic, retain) UIButton *_submitBut;
@property (nonatomic,assign) id<ShopForSubmitCellDelegate> delegate;

@end

















