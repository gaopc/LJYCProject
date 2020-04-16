//
//  SelectCityViewController.h
//  LJYCProject
//
//  Created by xiemengyue on 13-10-30.
//  Copyright (c) 2013年 longcd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeViewController.h"
#import "KeyBoardTopBar.h"
#import "BaiduMKMapView.h"
@interface SelectCityViewController : RootViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,BaiduMKMapViewDelegate>
@property(nonatomic,retain)UISubTextField *searchCityTF;
@property(nonatomic,retain)UITableView *citysTableView;
@property(nonatomic,retain)NSArray *cityDistrict;
@property(nonatomic,assign)NSInteger selectSection;
@property(nonatomic,retain)HomeViewController *homeVC;

@property (nonatomic,retain)NSArray *textFieldArray;
@property (nonatomic,retain)KeyBoardTopBar *keyboardbar;
@property (nonatomic,retain) BaiduMKMapView *bMKMapView;

@property (nonatomic,retain) UIActivityIndicatorView * activityIV;

@end
