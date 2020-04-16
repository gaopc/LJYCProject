//
//  AddTagsViewController.h
//  LJYCProject
//
//  Created by xiemengyue on 13-10-29.
//  Copyright (c) 2013年 longcd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ServiceTagData.h"
#import "HomeViewController.h"
@interface AddTagsViewController : RootViewController<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,retain)NSDictionary *serviceTagData;
@property(nonatomic,retain)UIButton *canyinBtn;
@property(nonatomic,retain)UIButton *zhusuBtn;
@property(nonatomic,retain)UIButton *shineiBtn;
@property(nonatomic,retain)UIButton *shiwaiBtn;
@property(nonatomic,retain)UIButton *qitaBtn;
@property(nonatomic,retain)UITableView *myTableView;
@property(nonatomic,retain)NSString * currentTag;

@property(nonatomic,retain)NSMutableDictionary *selectTags;
@property (nonatomic, retain) NSMutableArray *_selectTagsKey;
@property(nonatomic,retain)HomeViewController *homeVC;
@end
