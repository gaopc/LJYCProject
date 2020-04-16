//
//  HelpViewController.h
//  LJYCProject
//
//  Created by 张晓婷 on 13-11-5.
//  Copyright (c) 2013年 longcd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HelpViewController : RootViewController<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,retain)NSArray*titlesArray;
@property(nonatomic,assign)NSInteger selectSection;
@property(nonatomic,retain)UITableView *myTableview;
@end
