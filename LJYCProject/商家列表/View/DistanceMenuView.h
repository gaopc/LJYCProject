//
//  DistanceMenuView.h
//  LJYCProject
//
//  Created by z1 on 13-10-25.
//  Copyright (c) 2013年 longcd. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol DistancMenuDelegate
@optional
-(void)distancMenu:(int) distanc;
@end

@interface DistanceMenuView : RootView
{
	int distance;
}
@property (nonatomic, assign) id <DistancMenuDelegate> delegate;
@property (nonatomic,retain) UIImageView * buttonView;
@property (nonatomic,retain) NSArray * selectRangeDis;
@end


@protocol CityMenuViewDelegate
@optional
-(void)cityMenu:(NSString*)cityId cityName:(NSString*)cityName district:(District*)district;
@end

@interface CityMenuView : RootView <UITableViewDataSource,UITableViewDelegate>
{
	UITableView *c_tableView;
}
@property (nonatomic, assign) id <CityMenuViewDelegate> delegate;
@property(nonatomic,retain)UITableView *citysTableView;
@property(nonatomic,retain)NSArray *cityDistrict;
@property(nonatomic,assign)NSInteger selectSection;
-(void)getMyCityDistrict:(NSString*)districtId;
@end