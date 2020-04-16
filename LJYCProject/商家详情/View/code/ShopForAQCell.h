//
//  ShopForAQCell.h
//  LJYCProject
//
//  Created by gaopengcheng on 13-11-9.
//  Copyright (c) 2013年 longcd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShopForPublicCell.h"
@interface ShopForQCell : UITableViewCell
@property (nonatomic, retain) UISubLabel *_name;
@property (nonatomic, retain) UISubLabel *_date;
@property (nonatomic, retain) UISubLabel *_content;
@property (nonatomic, retain) UIImageView *_imageView;

@end

@interface ShopForACell : UITableViewCell
@property (nonatomic, retain) UISubLabel *_name;
@property (nonatomic, retain) UISubLabel *_date;
@property (nonatomic, retain) UISubLabel *_content;
@property (nonatomic, retain) UIImageView *_imageView;
@end

@interface ShopStarCell : ShopForPublicCell

@property (nonatomic, retain) UISubLabel *_name;

@end
