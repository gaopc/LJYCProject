//
//  OrderMenuView.h
//  LJYCProject
//
//  Created by z1 on 13-10-25.
//  Copyright (c) 2013年 longcd. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol OrderMenuDelegate
@optional
-(void)orderMenu:(int) orderBy;
@end


@interface OrderMenuView : RootView <UITableViewDelegate, UITableViewDataSource>
{
}
@property (nonatomic, assign) id <OrderMenuDelegate> delegate;
@property (nonatomic, retain) NSArray *orderArray;
@property (nonatomic, retain) UIImageView *menuArrow;
@end
