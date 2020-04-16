//
//  TypeMenuView.h
//  LJYCProject
//
//  Created by z1 on 13-11-6.
//  Copyright (c) 2013年 longcd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ServiceTag.h"
@protocol TypeMenuDelegate
@optional
-(void)typeMenu:(ShopType*) type;
@end
@interface TypeMenuView : RootView <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, assign) id <TypeMenuDelegate> delegate;
@property (nonatomic, retain) NSArray *typeArray;
@property (nonatomic, retain) UIImageView *menuArrow;
@end
