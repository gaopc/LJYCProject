//
//  ShopForCommentCell.h
//  LJYCProject
//
//  Created by gaopengcheng on 13-11-9.
//  Copyright (c) 2013年 longcd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShopForPublicCell.h"

@interface ShopForCommentCell : ShopForPublicCell
@property (nonatomic, retain) UISubLabel *_name;
@property (nonatomic, retain) UISubLabel *_date;
@property (nonatomic, retain) UISubLabel *_content;
@property (nonatomic, retain) UIImageView *_horizontalView;
@property (nonatomic, retain) UIImageView *_verticalView;
@end


@interface ShopForReplyCell : ShopForPublicCell
@property (nonatomic, retain) UISubLabel *_shopDate;
@property (nonatomic, retain) UISubLabel *_shopContent;
@property (nonatomic, retain) UIImageView *_imageView;
@property (nonatomic, retain) UIImageView *_horizontalView;
@property (nonatomic, retain) UIImageView *_verticalView;
@end