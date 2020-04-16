//
//  MessageViewController.h
//  LJYCProject
//
//  Created by 张晓婷 on 13-11-7.
//  Copyright (c) 2013年 longcd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessageViewController : RootViewController<UITableViewDelegate,UITableViewDataSource>
{
    UITableView * mytableView;
}
@property (nonatomic,retain) NSArray * _dataArray;

@end
