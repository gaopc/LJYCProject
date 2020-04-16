//
//  HomeViewController.h
//  LJYCProject
//
//  Created by xiemengyue on 13-10-24.
//  Copyright (c) 2013年 longcd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProjectView.h"
#import "BaiduMKMapView.h"
#import "KeyBoardTopBar.h"
#import "ActivetyShopListViewController.h"
#import "ActivetyModel.h"


@class ShopFindProperty;
@class ShopFindDataResponse;


@interface HomeViewController : RootViewController<UIScrollViewDelegate,UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate,BaiduMKMapViewDelegate>
{
	ShopFindDataResponse *shopFindDataResponse;
    UIScrollView * shopTypeView;
}
@property(nonatomic,retain)UIScrollView *myScrollView;
@property(nonatomic,retain)UIScrollView *tagScrollView;
@property(nonatomic,retain)UIPageControl *tagControl;

@property(nonatomic,retain)ProjectView *projectView1;
@property(nonatomic,retain)ProjectView *projectView2;
@property(nonatomic,retain)UISubLabel *addressLabel;

@property(nonatomic,retain)UIView *searchView;
@property(nonatomic,retain)UISubTextField *searchTF;
@property(nonatomic,retain)UIButton *cancelSearchBtn;
@property(nonatomic,retain)UITableView *historySearchTB;
@property(nonatomic,retain)UIView * grayBackGroundView;

@property(nonatomic,retain)NSMutableArray *tagsArray;//分类标签数组
@property(nonatomic,retain)NSString *address;//定位地址
@property(nonatomic,retain)NSMutableArray *historySearchAry;//关键字搜索历史数组
@property (nonatomic,retain) BaiduMKMapView *bMKMapView;
@property (nonatomic, retain) ShopFindProperty *shopFindProperty;
@property (nonatomic,retain) UIActivityIndicatorView * activityIV;
@property (nonatomic, retain) District* district;
@property (nonatomic, retain) NSString *titleName;
@property (nonatomic, retain) NSString *tagName;
@property (nonatomic,assign) BOOL pushIntoMember;//登陆成功后是否进入个人中心页面
@property (nonatomic,retain) UIView *inputView;
@property (nonatomic,assign) BOOL isCityLoad;//是否是从城市定位中返回
@property (nonatomic, retain) NSArray *textFieldArray;
@property (nonatomic, retain) KeyBoardTopBar *keyboardbar;

@property (nonatomic, retain) NSString *selectCity;

-(void)setMyScrollViewContent;
//-(void)showShopType;
-(void)showServiceTags;
@end
