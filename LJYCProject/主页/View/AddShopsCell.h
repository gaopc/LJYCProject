//
//  AddShopsCell.h
//  LJYCProject
//
//  Created by gaopengcheng on 13-10-29.
//  Copyright (c) 2013年 longcd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIPlaceHolderTextView.h"

@interface AddShopsCell : UITableViewCell
@property (nonatomic, retain) UITextField *_shopNameField;
@end


@interface AddShopAddressCell : UITableViewCell
@property (nonatomic, retain) UISubLabel *_shopLocationLab;
@property (nonatomic, retain) UIButton *_locationBut;
@property (nonatomic,retain) UIActivityIndicatorView * activityIV;
@end

@interface AddShopPhotoCell : UITableViewCell
{
    UIScrollView * scrollView;
}
@property (nonatomic, retain) NSArray *_imgArray;
@property (nonatomic, retain) UIButton *_addImgBut1;
@property (nonatomic, retain) UIButton *_addImgBut0;
@end

@interface AddShopTypeCell : UITableViewCell
@property (nonatomic, assign) id delegate;
@property (nonatomic, retain) UIButton *_preBtn;
@property (nonatomic, retain) NSArray * _btnArr;

- (void)selectType:(NSInteger)index;
@end


@interface AddShopServiceCell : UITableViewCell
{
    UIScrollView * scrollView;
}
@property (nonatomic, retain) NSArray *_serviceArr;
@end


@interface AddShopScaleCell : UITableViewCell
@property (nonatomic, retain) UISubLabel *_shopScaleLab;
@property (nonatomic, retain) UIButton *_unwindBut;
@end


@interface AddShopDateCell : UITableViewCell
@property (nonatomic, retain) UISubLabel *_shopDateLab;
@property (nonatomic, retain) UIButton *_unwindBut;
@end


@interface AddShopPhoneCell : UITableViewCell
@property (nonatomic, retain) UITextField *_phoneField;
@end


@interface AddShopIntroduceCell : UITableViewCell
@property (nonatomic, retain) UITextView *_textView;
@property (nonatomic, retain) UISubLabel *_endLab;
@end

@interface AddShopNoticeCell : UITableViewCell
@property (nonatomic, retain) UIPlaceHolderTextView *_textView;
@property (nonatomic, retain) UISubLabel *_endLab;
@end