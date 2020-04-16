//
//  CalendarView.h
//  日历控件
//
//  Created by 崔立东 on 12-9-10.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "UIColor+expanded.h"





@protocol CalendarViewDelegate;
@interface CalendarView : UIView {
	id <CalendarViewDelegate> delegate;
	
@private
	NSDate *currentMonth;
	UISubLabel *labelCurrentMonth;
	UIImageView *animationView_A;
	UIImageView *animationView_B;
	NSArray *markedDates;
	NSArray *markedColors;
	
	
	
	BOOL isAnimating;
	BOOL prepAnimationPreviousMonth;
	BOOL prepAnimationNextMonth;
	BOOL leftArrows;  //左边三角
	BOOL rightArrows; //右边三角
	
        UIImageView *leftArrowsImageView; //左三角背景图片
	UIImageView *rightArrowsImageView;//右三角背景图片
	
	UIImageView *weekImageView; //周背景图片
	UIImageView *holidayView; //放假图片
	
	
	UIImageView *workView; //放假时应该上班的日期图片
	
	
	BOOL multitouch;
	BOOL finished;
	
	CGPoint startPoint;
	NSUInteger touchtype;
	NSUInteger pointCount;
	
	int afterYear;
	int afterMonth;
	int afterDay;
	int year;
	int month;
	int day;
	int targetDate;
	int targetDate1;
	BOOL firstDraw;
	BOOL workfirstDraw;
	
	NSInteger allowShowdays;
	NSInteger allowShowMonths;
}

@property (nonatomic, retain) id <CalendarViewDelegate> delegate;
@property (nonatomic, retain) NSDate *currentMonth;
@property (nonatomic, retain) UISubLabel *labelCurrentMonth;
@property (nonatomic, retain) UIImageView *animationView_A;
@property (nonatomic, retain) UIImageView *animationView_B;
@property (nonatomic, retain) NSArray *markedDates;
@property (nonatomic, retain) NSArray *markedColors;
@property (nonatomic, getter = calendarHeight) float calendarHeight;
@property (nonatomic, retain, getter = selectedDate) NSDate *selectedDate;

@property (nonatomic,retain) NSMutableArray * holidayImageViewArray;
@property (nonatomic,retain) NSMutableArray * workImageViewArray;
@property (nonatomic,retain) NSMutableDictionary * gregorianDict;
@property (nonatomic, assign) int backDay;
-(void)markDates:(NSArray *)dates;
-(void)markDates:(NSArray *)dates withColors:(NSArray *)colors;
-(id)initWithNSDate:(NSDate *)adate allowShowMonths:(NSInteger)monthCount withDayCount:(NSInteger)dayCount withPushBackDay:(NSInteger)pushBackDay;
//返回当前月方法
-(void)returnsCurrentMonth;
@end

@protocol CalendarViewDelegate <NSObject>
//代理方法 点击按钮后颜色改变
-(void)calendarView:(CalendarView *)calendarView switchedToMonth:(int)month targetHeight:(float)targetHeight animated:(BOOL)animated;
//代理方法 点击按钮后获取日期
-(void)calendarView:(CalendarView *)calendarView dateSelected:(NSDate *)date;
@end
