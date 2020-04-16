//
//  ActivetyShopCell.h
//  LJYCProject
//
//  Created by gaopengcheng on 15-6-16.
//  Copyright (c) 2015年 longcd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AsyncImageView.h"

@interface ActivetyShopCell : UITableViewCell
@property (nonatomic,retain) AsyncImageView * _imageV;
@property (nonatomic,retain) UISubLabel * _nameLab;
@property (nonatomic,retain) UISubLabel * _addressLab;
@end
