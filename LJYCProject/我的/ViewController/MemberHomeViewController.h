//
//  MemberHomeViewController.h
//  LJYCProject
//
//  Created by z1 on 13-11-6.
//  Copyright (c) 2013年 longcd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserInfoDataResponse.h"
@class ShopCollectDataResponse;
@interface MemberHomeViewController : RootViewController<UITableViewDelegate,UITableViewDataSource>
{
	UserInfoDataResponse *userInfoDataResponse;
	
}
@property (nonatomic, retain) ShopCollectDataResponse *shopCollectDataResponse;
@property (nonatomic,retain) UITableView *u_tableView;
@property (nonatomic,retain) NSArray * _dataArray;
@property (nonatomic,retain) UIView * heartValueView; //心形
@property (nonatomic,retain) UIView *centerView;


@property (nonatomic,retain) UISubLabel *userName; //名称
@property (nonatomic,retain) UISubLabel *address; //地址

@property (nonatomic,retain) UISubLabel *integral; //积分
@property (nonatomic,retain) UISubLabel *pepperCur; //辣椒币

@property (nonatomic,retain) UISubLabel *review; //点评
@property (nonatomic,retain) UISubLabel *regist; //签到
@property (nonatomic,retain) UISubLabel *photo; //照片
@property (nonatomic,retain) UISubLabel *question; //问答


@property (nonatomic,retain) UIButton *reviewButton; //点评
@property (nonatomic,retain) UIButton *registButton; //签到
@property (nonatomic,retain) UIButton *photoButton; //照片
@property (nonatomic,retain) UIButton *questionButton; //问答

@property (nonatomic,retain)  UserInfo *userInfo;
@property (nonatomic, retain) CollectProperty *collectProperty;

@end
