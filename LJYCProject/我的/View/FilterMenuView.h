//
//  FilterMenuView.h
//  LJYCProject
//
//  Created by z1 on 13-11-14.
//  Copyright (c) 2013年 longcd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ServiceTag.h"

@protocol FilterMenuDelegate
@optional
-(void)filterMenu:(NSString*)cityId type:(NSString*)type;
@end

@interface FilterCell : UITableViewCell
@property(nonatomic,retain) UISubLabel *filterName;
@end

@interface FilterMenuView : RootView <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, assign) id <FilterMenuDelegate> delegate;
@property(nonatomic,retain)UITableView *fTableView;
@property (nonatomic, retain) NSMutableArray *typeArray;
@property (nonatomic, retain) NSMutableArray *cityArray;
@property(nonatomic,retain)UIButton *cityBtn;
@property(nonatomic,retain)UIButton *typeBtn;
@property(nonatomic,retain) UISubLabel *cityName;
@property(nonatomic,retain) UISubLabel *typeName;
@property(nonatomic,assign)int currentTag;
@property(nonatomic,retain)NSMutableDictionary *selectTags;

-(void)getCityDictionary;
@end
