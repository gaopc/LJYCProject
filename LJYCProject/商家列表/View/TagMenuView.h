//
//  TagMenuView.h
//  LJYCProject
//
//  Created by z1 on 13-10-25.
//  Copyright (c) 2013年 longcd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ServiceTag.h"
@protocol TagMenuDelegate
@optional
-(void)tagMenu:(ServiceTag*) tag;
@end

@interface TagMenuView : RootView <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, assign) id <TagMenuDelegate> delegate;
@property (nonatomic, retain) NSArray *tagArray;


@property(nonatomic,retain)NSMutableDictionary *selectTags;
@property(nonatomic,retain)NSDictionary *serviceTagData;
@property(nonatomic,retain)UIButton *allBtn;
@property(nonatomic,retain)UIButton *canyinBtn;
@property(nonatomic,retain)UIButton *zhusuBtn;
@property(nonatomic,retain)UIButton *shineiBtn;
@property(nonatomic,retain)UIButton *shiwaiBtn;
@property(nonatomic,retain)UIButton *qitaBtn;
@property(nonatomic,retain)UITableView *myTableView;
@property(nonatomic,retain)NSString * currentTag;

@end
