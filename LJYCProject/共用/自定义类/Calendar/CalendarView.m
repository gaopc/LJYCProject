//
//  VRGCalendarView.m
//  Vurig
//
//  Created by 崔立东 on 12-9-10.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "CalendarView.h"
#import <QuartzCore/QuartzCore.h>
#import "NSDate+convenience.h"
#import "NSMutableArray+convenience.h"
#import "UIView+convenience.h"


@interface CalendarView (Private)

-(NSDate *)tranDate:(int)date;
-(void)selectDate:(int)date;
-(void)reset;

-(void)showNextMonth;
-(void)showPreviousMonth;

-(int)numRows;
-(void)updateSize;
-(UIImage *)drawCurrentState;

@end

@implementation CalendarView
@synthesize currentMonth,delegate,labelCurrentMonth, animationView_A,animationView_B;
@synthesize markedDates,markedColors,calendarHeight,selectedDate;
@synthesize holidayImageViewArray,workImageViewArray;
@synthesize gregorianDict = _gregorianDict;
@synthesize backDay;

// Return distance between two points
float distance (CGPoint p1, CGPoint p2)
{
	float dx = p2.x - p1.x;
	float dy = p2.y - p1.y;
	
	return sqrt(dx*dx + dy*dy);
}

//- (BOOL) isMultipleTouchEnabled {return YES;} //触摸倍数是否激活

#pragma mark - Select Date 点击日历的日期触发事件
-(void)selectDate:(int)date {
	
	NSCalendar *gregorian = [[[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar]autorelease];
	NSDateComponents *comps = [gregorian components:NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit fromDate:self.currentMonth];
	[comps setDay:date];
	self.selectedDate = [gregorian dateFromComponents:comps];
	
	//选择的年份与系统年份相等 (限制日历开始页面小于当前日期被点击包括当前日)
	//选择的年份与系统年份相等 (限制日历第二个页面的上一个月小于系统当前日期的日期 如今天是29号下一个月会显示上一个月的几个数字 如果 27 28 29 30 31 这时 27月28是不允许点击的)
	
	if ([self.selectedDate year] < year) {
		return;
	}
	
	if ([self.selectedDate year] == year) {
		if ([self.selectedDate month]< month){
			return;
		}
		if ([self.selectedDate month]==month){
			if (self.backDay ==1) {
				if ([self.selectedDate day] <= day)
					return;
			}else{
				
				if ([self.selectedDate day] < day)
					return;
			}
		}
		
		
	}
	
	//选择的年份与延后年份相等  (限制选择月份大于延后月份的情况)
	//选择的年份与延后年份相等  (限制选择月份等于延后月份时 选择日期大于延后日期)
	if ([self.selectedDate year] == afterYear) {
		
		if([self.selectedDate month] > afterMonth) {
			
			if ([self.selectedDate month] > [self.currentMonth month]) {
				return;
			}
			if ([self.selectedDate month] == [self.currentMonth month]) {
				if ([self.selectedDate day] > [self.currentMonth day]) {
					return;
				}
				
			}
			
		}
		
		if ([self.selectedDate month] == afterMonth){
			if ([self.selectedDate day] > afterDay)
				return;
		}
		
	}
	
	if ([self.selectedDate year] > afterYear) {
		if([self.selectedDate month] < afterMonth) {
			return;
			
		}
	}
	
	[self setNeedsDisplay];
	if ([delegate respondsToSelector:@selector(calendarView:dateSelected:)]) [delegate calendarView:self dateSelected:self.selectedDate];
}


#pragma mark - Transform Date
//int天转换成日期格式
-(NSDate *) tranDate:(int)date {
	
	NSCalendar *gregorian = [[[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar]autorelease];
	NSDateComponents *comps = [gregorian components:NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit fromDate:self.currentMonth];
	[comps setDay:date];
	return [gregorian dateFromComponents:comps];
}

#pragma mark - Mark Dates
//NSArray can either contain NSDate objects or NSNumber objects with an int of the day.
-(void)markDates:(NSArray *)dates {
	self.markedDates = dates;
	NSMutableArray *colors = [[NSMutableArray alloc] init];
	
	for (int i = 0; i<[dates count]; i++) {
		[colors addObject:[UIColor colorWithHexString:@"0x383838"]];
	}
	
	self.markedColors = [NSArray arrayWithArray:colors];
	[colors release];
	
	[self setNeedsDisplay];
}

//NSArray can either contain NSDate objects or NSNumber objects with an int of the day.
-(void)markDates:(NSArray *)dates withColors:(NSArray *)colors {
	self.markedDates = dates;
	self.markedColors = colors;
	
	[self setNeedsDisplay];
}

#pragma mark - Set date to now
-(void)reset {
	//    NSCalendar *gregorian = [[[NSCalendar alloc]
	//                              initWithCalendarIdentifier:NSGregorianCalendar]autorelease];
	//    NSDateComponents *components =
	//    [gregorian components:(NSYearCalendarUnit | NSMonthCalendarUnit |
	//                           NSDayCalendarUnit) fromDate: [NSDate date]];
	//    self.currentMonth = [gregorian dateFromComponents:components]; //clean month
	
	[self updateSize];
	[self setNeedsDisplay];
	[delegate calendarView:self switchedToMonth:[currentMonth month] targetHeight:self.calendarHeight animated:NO];
}





#pragma mark - Next & Previous
-(void)showNextMonth {
	firstDraw = NO;
	workfirstDraw = NO;
	if (isAnimating) return;
	self.markedDates=nil;
	isAnimating=YES;
	prepAnimationNextMonth=YES;
	
	[self setNeedsDisplay];
	
	int lastBlock = [currentMonth firstWeekDayInMonth]+[currentMonth numDaysInMonth]-1;
	int numBlocks = [self numRows]*7;
	BOOL hasNextMonthDays = lastBlock<numBlocks;
	
	//Old month
	float oldSize = self.calendarHeight;
	UIImage *imageCurrentMonth = [self drawCurrentState];
	
	//New month
	self.currentMonth = [currentMonth offsetMonth:1];
	if ([delegate respondsToSelector:@selector(calendarView:switchedToMonth:targetHeight: animated:)]) [delegate calendarView:self switchedToMonth:[currentMonth month] targetHeight:self.calendarHeight animated:YES];
	prepAnimationNextMonth=NO;
	[self setNeedsDisplay];
	
	for (UIImageView *imageView in self.holidayImageViewArray) {
		
		[imageView removeFromSuperview];
	}
	[self.holidayImageViewArray removeAllObjects];
	
	for (UIImageView *imageView in self.workImageViewArray) {
		
		[imageView removeFromSuperview];
	}
	[self.workImageViewArray removeAllObjects];
	
	UIImage *imageNextMonth = [self drawCurrentState];
	float targetSize = fmaxf(oldSize, self.calendarHeight);
	UIView *animationHolder = [[UIView alloc] initWithFrame:CGRectMake(0, CalendarViewTopBarHeight, CalendarViewWidth, targetSize-CalendarViewTopBarHeight)];
	[animationHolder setClipsToBounds:YES];
	[self addSubview:animationHolder];
	[animationHolder release];
	
	//Animate
	self.animationView_A = [[[UIImageView alloc] initWithImage:imageCurrentMonth]autorelease];
	self.animationView_B = [[[UIImageView alloc] initWithImage:imageNextMonth]autorelease];
	[animationHolder addSubview:animationView_A];
	[animationHolder addSubview:animationView_B];
	
	if (hasNextMonthDays) {
		animationView_B.frameY = animationView_A.frameY + animationView_A.frameHeight - (CalendarViewDayHeight+3);
	} else {
		animationView_B.frameY = animationView_A.frameY + animationView_A.frameHeight -3;
	}
	
	//Animation
	__block CalendarView *blockSafeSelf = self;
	[UIView animateWithDuration:.35
			 animations:^{
				 [self updateSize];
				 //blockSafeSelf.frameHeight = 100;
				 if (hasNextMonthDays) {
					 animationView_A.frameY = -animationView_A.frameHeight + CalendarViewDayHeight+3;
				 } else {
					 animationView_A.frameY = -animationView_A.frameHeight + 3;
				 }
				 animationView_B.frameY = 0;
			 }
			 completion:^(BOOL finished) {
				 [animationView_A removeFromSuperview];
				 [animationView_B removeFromSuperview];
				 blockSafeSelf.animationView_A=nil;
				 blockSafeSelf.animationView_B=nil;
				 isAnimating=NO;
				 [animationHolder removeFromSuperview];
				 for (UIImageView *imageView in self.holidayImageViewArray) {
					 
					 [self addSubview:imageView];				
				 }
				 for (UIImageView *imageView in self.workImageViewArray) {
					 
					 [self addSubview:imageView];				
				 }
				 
				 
			 }
	 ];
	
}

-(void)showPreviousMonth {
	firstDraw = NO;
	workfirstDraw = NO;
	if (isAnimating) return;
	isAnimating=YES;
	self.markedDates=nil;
	//Prepare current screen
	prepAnimationPreviousMonth = YES;
	
	[self setNeedsDisplay];
	BOOL hasPreviousDays = [currentMonth firstWeekDayInMonth]>1;
	float oldSize = self.calendarHeight;
	UIImage *imageCurrentMonth = [self drawCurrentState];
	
	//Prepare next screen
	self.currentMonth = [currentMonth offsetMonth:-1];
	if ([delegate respondsToSelector:@selector(calendarView:switchedToMonth:targetHeight:animated:)]) [delegate calendarView:self switchedToMonth:[currentMonth month] targetHeight:self.calendarHeight animated:YES];
	prepAnimationPreviousMonth=NO;
	[self setNeedsDisplay];
	for (UIImageView *imageView in self.holidayImageViewArray) {
		
		[imageView removeFromSuperview];
	}
	[self.holidayImageViewArray removeAllObjects];
	for (UIImageView *imageView in self.workImageViewArray) {
		
		[imageView removeFromSuperview];
	}
	[self.workImageViewArray removeAllObjects];
	
	UIImage *imagePreviousMonth = [self drawCurrentState];
	
	float targetSize = fmaxf(oldSize, self.calendarHeight);
	UIView *animationHolder = [[UIView alloc] initWithFrame:CGRectMake(0, CalendarViewTopBarHeight, CalendarViewWidth, targetSize-CalendarViewTopBarHeight)];
	
	[animationHolder setClipsToBounds:YES];
	[self addSubview:animationHolder];
	[animationHolder release];
	
	self.animationView_A = [[[UIImageView alloc] initWithImage:imageCurrentMonth]autorelease];
	self.animationView_B = [[[UIImageView alloc] initWithImage:imagePreviousMonth]autorelease];
	[animationHolder addSubview:animationView_A];
	[animationHolder addSubview:animationView_B];
	
	if (hasPreviousDays) {
		animationView_B.frameY = animationView_A.frameY - (animationView_B.frameHeight-CalendarViewDayHeight) + 3;
	} else {
		animationView_B.frameY = animationView_A.frameY - animationView_B.frameHeight + 3;
	}
	
	__block CalendarView *blockSafeSelf = self;
	[UIView animateWithDuration:.35
			 animations:^{
				 [self updateSize];
				 
				 if (hasPreviousDays) {
					 animationView_A.frameY = animationView_B.frameHeight-(CalendarViewDayHeight+3); 
					 
				 } else {
					 animationView_A.frameY = animationView_B.frameHeight-3;
				 }
				 
				 animationView_B.frameY = 0;
			 }
			 completion:^(BOOL finished) {
				 [animationView_A removeFromSuperview];
				 [animationView_B removeFromSuperview];
				 blockSafeSelf.animationView_A=nil;
				 blockSafeSelf.animationView_B=nil;
				 isAnimating=NO;
				 [animationHolder removeFromSuperview];
				 
				 for (UIImageView *imageView in self.holidayImageViewArray) {
					 
					 [self addSubview:imageView];				
				 }
				 for (UIImageView *imageView in self.workImageViewArray) {
					 
					 [self addSubview:imageView];				
				 }
			 }
	 ];
	
}


#pragma mark - update size & row count
-(void)updateSize {
	self.frameHeight = self.calendarHeight;
	[self setNeedsDisplay];
}

-(float)calendarHeight {
	return CalendarViewTopBarHeight + [self numRows]*(CalendarViewDayHeight+2)+1;
}

-(int)numRows {
	float lastBlock = [self.currentMonth numDaysInMonth]+([self.currentMonth firstWeekDayInMonth]);
	return ceilf(lastBlock/7);
}

#pragma mark - Touches
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event 
{       
	finished = NO;
	startPoint = [[touches anyObject] locationInView:self];
	multitouch = (touches.count > 1);
	pointCount = 1;
	
	self.selectedDate=nil;
	self.markedDates=nil;
	self.markedColors=nil;  
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event      
{      
	
	pointCount++;
	if (finished) return;
	// Check single touch for swipe
	CGPoint cpoint = [[touches anyObject] locationInView:self];
	float dx = DX(cpoint, startPoint);
	float dy = DY(cpoint, startPoint);
	multitouch = NO;
	finished = YES;
	if ((dx > SWIPE_DRAG_MIN) && (ABS(dy) < DRAGLIMIT_MAX)){ // 右往左滑
		touchtype = UITouchSwipeLeft;
		//if (rightArrows)[self showNextMonth];
	}
	// 12 4
	else if((dx > SWIPE_DRAG_MIN) && (dy > DRAGLIMIT_MAX)){ // 右上滑
		
		touchtype = UITouchSwipeLeft;
		//if (rightArrows)[self showNextMonth];
	}
	else if((dx > SWIPE_DRAG_MIN) && (dy < DRAGLIMIT_MAX)){ //右下滑
		
		
		touchtype = UITouchSwipeLeft;
		//if (leftArrows)[self showPreviousMonth];
	}
	else if ((-dx > SWIPE_DRAG_MIN) && (ABS(dy) < DRAGLIMIT_MAX)){ // 左往右滑
		touchtype = UITouchSwipeRight;
		//if (leftArrows)[self showPreviousMonth];
	}
	else if ((-dx > SWIPE_DRAG_MIN) && (dy > DRAGLIMIT_MAX)){  //  左上滑
		touchtype = UITouchSwipeRight;
		//if (rightArrows)[self showNextMonth];
	}
	else if ((-dx > SWIPE_DRAG_MIN) && (dy < DRAGLIMIT_MAX)){  // 左下滑
		touchtype = UITouchSwipeRight;
		//if (leftArrows)[self showPreviousMonth];
	}
	else if ((dy > SWIPE_DRAG_MIN) && (ABS(dx) < DRAGLIMIT_MAX)){  // 下往上滑
		
		touchtype = UITouchSwipeUp;
		//if (rightArrows)[self showNextMonth];
	}else if ((-dy > SWIPE_DRAG_MIN) && (ABS(dx) < DRAGLIMIT_MAX)){ // 上往下滑
		
		touchtype = UITouchSwipeDown;
		//if (leftArrows)[self showPreviousMonth];
	}else{
		finished = NO;
	}
	
}   

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{  
	
	//左箭头区域
	CGRect rectArrowLeft = CGRectMake(0, 0, 100, 40);
	//右箭头区域
	CGRect rectArrowRight = CGRectMake(self.frame.size.width-100, 0, 100, 40);
	
	// was not detected as a swipe
	if (!finished && !multitouch) 
	{
		// tap or double tap
		if (pointCount < 3) 
		{
			if ([[touches anyObject] tapCount] == 1) {
				
				touchtype = UITouchTap;
			}else{
				
				touchtype = UITouchDoubleTap;
			}
			
			if (startPoint.y > CalendarViewTopBarHeight) {
				
				float xLocation = startPoint.x;
				float yLocation = startPoint.y-CalendarViewTopBarHeight;
				
				int column = floorf(xLocation/(CalendarViewDayWidth+2));
				int row = floorf(yLocation/(CalendarViewDayHeight+2));
				
				int blockNr = (column+1)+row*7;
				int firstWeekDay = [self.currentMonth firstWeekDayInMonth]; 
				//-1 because weekdays begin at 1, not 0
				int date = (blockNr-firstWeekDay)+1;
				
				
				[self selectDate:date];
				
				
				
			}			
			if(CGRectContainsPoint(rectArrowLeft, startPoint)) {
				if (leftArrows)[self showPreviousMonth];
			} else if (CGRectContainsPoint(rectArrowRight, startPoint)) {
				if (rightArrows)[self showNextMonth];
			} else if (CGRectContainsPoint(self.labelCurrentMonth.frame, startPoint)) {
				//Detect touch in current month
				int currentMonthIndex = [self.currentMonth month];
				int todayMonth = [[NSDate date] month];
				[self reset];
				if ((todayMonth!=currentMonthIndex) && [delegate respondsToSelector:@selector(calendarView:switchedToMonth:targetHeight:animated:)]) [delegate calendarView:self switchedToMonth:[currentMonth month] targetHeight:self.calendarHeight animated:NO];
			}
			
		}
		else{
			touchtype = UITouchDrag;
		}
		
	}
	
}


-(void)handleSwipeFrom:(UISwipeGestureRecognizer *)recognizer{
	
	if(recognizer.direction==UISwipeGestureRecognizerDirectionDown) {
		if (leftArrows)[self showPreviousMonth];
	}
	
	if(recognizer.direction==UISwipeGestureRecognizerDirectionUp) {
		if (rightArrows)[self showNextMonth];
	}
	
	if(recognizer.direction==UISwipeGestureRecognizerDirectionLeft) {
		if (rightArrows)[self showNextMonth];
	}
	
	if(recognizer.direction==UISwipeGestureRecognizerDirectionRight) {
		if (leftArrows)[self showPreviousMonth];
	}
	
}

#pragma mark - Drawing
- (void)drawRect:(CGRect)rect
{
	//int firstWeekDay = [self.currentMonth firstWeekDayInMonth]; //-1 because weekdays begin at 1, not 0
	//让日期重新排序 正常是 周日到周六 加上此处是 周一到周日
	int firstWeekDay = [self.currentMonth firstWeekDayInMonth]-1; //-1 because weekdays begin at 1, not 0
	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
	//[formatter setDateFormat:@"MMMM yyyy"];
	[formatter setDateFormat:@"yyyy年MM月"];
	//上一年
	int beforeYear = [currentMonth year:self.currentMonth];
	//上一月
	int beforeMonth = [currentMonth month:self.currentMonth];
	labelCurrentMonth.text = [formatter stringFromDate:self.currentMonth];
	[labelCurrentMonth sizeToFit];
	labelCurrentMonth.frameX = roundf(self.frame.size.width/2 - labelCurrentMonth.frameWidth/2);
	labelCurrentMonth.frameY = 10;
	[formatter release];
	[currentMonth firstWeekDayInMonth];
	//这里去除了页面的所有背景
	CGContextClearRect(UIGraphicsGetCurrentContext(),rect);
	CGContextRef context = UIGraphicsGetCurrentContext();
	
	CGRect rectangle = CGRectMake(0,0,self.frame.size.width,CalendarViewTopBarHeight);
	CGContextAddRect(context, rectangle);
	CGContextSetFillColorWithColor(context, FontColorF2F6F7.CGColor);
	CGContextFillPath(context);
	
	//Arrows
	
	if (year == beforeYear){
		
		if (month>=beforeMonth) {
			
			leftArrows = NO;
			leftArrowsImageView.image=[UIImage imageNamed:@"TicketListBottomLeft2.png"];
			
		}else{
			
			leftArrows = YES;
			
			leftArrowsImageView.image=[UIImage imageNamed:@"TicketListBottomLeft1.png"];
		}
	}else{
		
		leftArrows = YES;
		
		leftArrowsImageView.image=[UIImage imageNamed:@"TicketListBottomLeft1.png"];
	}
	
	if (afterYear == beforeYear) {
		if(beforeMonth>=afterMonth){
			rightArrows = NO;
			
			
			rightArrowsImageView.image=[UIImage imageNamed:@"TicketListBottomRight2.png"];
			
		}else{
			//Arrow right 右边箭头(黑色)
			rightArrows = YES;
			
			rightArrowsImageView.image=[UIImage imageNamed:@"TicketListBottomRight1.png"];
		}
	}else{
		//Arrow right 右边箭头(黑色)
		rightArrows = YES;
		
		rightArrowsImageView.image=[UIImage imageNamed:@"TicketListBottomRight1.png"];
	}
	
	//Weekdays
	int numRows = [self numRows];
	int numBlocks = numRows*7;
	
	CGContextSetAllowsAntialiasing(context, NO);
	
	//Grid background 画网格背景
	float gridHeight = numRows*(CalendarViewDayHeight+2)+1;
	CGRect rectangleGridLeft = CGRectMake(0,CalendarViewTopBarHeight,self.frame.size.width-88,gridHeight);
	CGContextAddRect(context, rectangleGridLeft);
	//CGContextSetFillColorWithColor(context, FontColorF2F6F7.CGColor);
	CGContextSetFillColorWithColor(context, [UIColor colorWithHexString:@"0xffffff"].CGColor);
	CGContextFillPath(context);
	//新加入
	CGRect rectangleRight = CGRectMake(self.frame.size.width-88,CalendarViewTopBarHeight,88,gridHeight);
	CGContextAddRect(context, rectangleRight);
	CGContextSetFillColorWithColor(context, FontColorE7F6FF.CGColor);
	CGContextFillPath(context);
	
	//Grid white lines 
	CGContextSetStrokeColorWithColor(context, [UIColor whiteColor].CGColor);
	CGContextBeginPath(context);
	CGContextMoveToPoint(context, 0, CalendarViewTopBarHeight+1);
	CGContextAddLineToPoint(context, CalendarViewWidth, CalendarViewTopBarHeight+1);
	for (int i = 1; i<7; i++) {
		CGContextMoveToPoint(context, i*(CalendarViewDayWidth+1)+i*1-1, CalendarViewTopBarHeight);
		CGContextAddLineToPoint(context, i*(CalendarViewDayWidth+1)+i*1-1, CalendarViewTopBarHeight+gridHeight);
		
		if (i>numRows-1) continue;
		//rows
		CGContextMoveToPoint(context, 0, CalendarViewTopBarHeight+i*(CalendarViewDayHeight+1)+i*1+1);
		CGContextAddLineToPoint(context, CalendarViewWidth, CalendarViewTopBarHeight+i*(CalendarViewDayHeight+1)+i*1+1);
	}
	
	CGContextStrokePath(context);
	
	//Grid dark lines
	CGContextSetStrokeColorWithColor(context, FontColorDADADA.CGColor);
	CGContextBeginPath(context);
	CGContextMoveToPoint(context, 0, CalendarViewTopBarHeight);
	CGContextAddLineToPoint(context, CalendarViewWidth, CalendarViewTopBarHeight);
	for (int i = 1; i<7; i++) {
		//columns
		CGContextMoveToPoint(context, i*(CalendarViewDayWidth+1)+i*1, CalendarViewTopBarHeight);
		CGContextAddLineToPoint(context, i*(CalendarViewDayWidth+1)+i*1, CalendarViewTopBarHeight+gridHeight);
		
		if (i>numRows-1) continue;
		//rows
		CGContextMoveToPoint(context, 0, CalendarViewTopBarHeight+i*(CalendarViewDayHeight+1)+i*1);
		CGContextAddLineToPoint(context, CalendarViewWidth, CalendarViewTopBarHeight+i*(CalendarViewDayHeight+1)+i*1);
	}
	CGContextMoveToPoint(context, 0, gridHeight+CalendarViewTopBarHeight);
	CGContextAddLineToPoint(context, CalendarViewWidth, gridHeight+CalendarViewTopBarHeight);
	
	CGContextStrokePath(context);
	
	CGContextSetAllowsAntialiasing(context, YES);
	
	//Draw days
	//    CGContextSetFillColorWithColor(context, 
	//                                   [UIColor colorWithHexString:@"0x383838"].CGColor);
	
	
	//NSLog(@"currentMonth month = %i, first weekday in month = %i",[self.currentMonth month],[self.currentMonth firstWeekDayInMonth]);
	
	
	NSDate *previousMonth = [self.currentMonth offsetMonth:-1];
	int currentMonthNumDays = [currentMonth numDaysInMonth];
	int prevMonthNumDays = [previousMonth numDaysInMonth];
	
	int selectedDateBlock = ([selectedDate day]-1)+firstWeekDay;
	
	
	//prepAnimationPreviousMonth nog wat mee doen
	
	//prev next month
	BOOL isSelectedDatePreviousMonth = prepAnimationPreviousMonth;
	BOOL isSelectedDateNextMonth = prepAnimationNextMonth;
	
	if (self.selectedDate!=nil) {
		isSelectedDatePreviousMonth = ([selectedDate year]==[currentMonth year] && [selectedDate month]<[currentMonth month]) || [selectedDate year] < [currentMonth year];
		
		if (!isSelectedDatePreviousMonth) {
			isSelectedDateNextMonth = ([selectedDate year]==[currentMonth year] && [selectedDate month]>[currentMonth month]) || [selectedDate year] > [currentMonth year];
		}
	}
	
	if (isSelectedDatePreviousMonth) {
		int lastPositionPreviousMonth = firstWeekDay-1;
		selectedDateBlock=lastPositionPreviousMonth-([selectedDate numDaysInMonth]-[selectedDate day]);
	} else if (isSelectedDateNextMonth) {
		selectedDateBlock = [currentMonth numDaysInMonth] + (firstWeekDay-1) + [selectedDate day];
	}
	
	NSDate *todayDate = [NSDate date];
	int todayBlock = -1;
	
	//  NSLog(@"currentMonth month = %i day = %i, todaydate day = %i",[currentMonth month],[currentMonth day],[todayDate month]);
	
	
	
	if ([todayDate month] == [currentMonth month] && [todayDate year] == [currentMonth year]) {
		todayBlock = [todayDate day] + firstWeekDay - 1;
	}
	
	for (int i=0; i<numBlocks; i++) {
		
		targetDate = i;
		targetDate1 = i;
		int targetColumn = i%7;
		int targetRow = i/7;
		int targetX = targetColumn * (CalendarViewDayWidth+2);
		int targetY = CalendarViewTopBarHeight + targetRow * (CalendarViewDayHeight+2);
		
		
		NSString *date = nil;
		NSString *gregorianDate = nil;
		NSString *gregorianBanDate = nil;
		
		
		targetDate1 = (i-firstWeekDay)+1;
		NSDate *aDate = [self tranDate:targetDate1];
		self.gregorianDict = [currentMonth getGregorianDict:aDate];
		int startYear = [[[[self.gregorianDict objectForKey:@"year"] componentsSeparatedByString:@"-"] objectAtIndex:0] intValue];
		int endYear = [[[[self.gregorianDict objectForKey:@"year"] componentsSeparatedByString:@"-"] objectAtIndex:1] intValue];
		// 假日 上班
		if ([currentMonth year:self.currentMonth]>=startYear && [currentMonth year:self.currentMonth]<=endYear) {
			if ([currentMonth year:self.currentMonth] ==endYear) {
				
				if ([currentMonth month:self.currentMonth]<=10) {
					gregorianDate = [self.gregorianDict objectForKey:@"nextHoliday"];
				}
			}else {
				if ([currentMonth month:self.currentMonth]==12) {
					gregorianDate = [self.gregorianDict objectForKey:@"nextHoliday"];
				}else {
					gregorianDate =  [self.gregorianDict objectForKey:@"holiday"];
					gregorianBanDate =  [self.gregorianDict objectForKey:@"work"];
				}
				
			}
			
		}else {
			gregorianDate = nil;
			gregorianBanDate = nil;
		}
		
		// BOOL isCurrentMonth = NO;
		if (i<firstWeekDay) { //previous month 上一月
			
			targetDate = (prevMonthNumDays-firstWeekDay)+(i+1);
			date = [NSString stringWithFormat:@"%i",targetDate];
			NSString *hex = @"0x383838";
			if ([aDate year] < year) {
				hex = @"0xaaaaaa";
			}
			//选择的年份与系统年份相等 (日历开始页面上一个月全部置灰)
			//选择的年份与系统年份相等 (日历第二个页面的上一个月小于系统当前日期的日期 如今天是29号下一个月会显示上一个月的几个数字 如果 27 28 29 30 31 这时 27和28全部置灰)
			if ([currentMonth year] == year) {
				if ([aDate month]< month){
					hex = @"0xaaaaaa";
				}
				if ((month+1) == [currentMonth month]){
					if ([date intValue] < day)
						hex = @"0xaaaaaa";
				}
			}
			//选择的年份与延后年份相等  (选择月份等于延后月份时如果日期大于延后日期全部置灰)
			if ([currentMonth year] == afterYear) {
				if ([currentMonth month]-1 == afterMonth){
					if ([date intValue] > afterDay)
						hex = @"0xaaaaaa";
				}
				
			}
			
			CGContextSetFillColorWithColor(context, 
						       [UIColor colorWithHexString:hex].CGColor);
			
			
		}else if (i>=(firstWeekDay+currentMonthNumDays)) { //next month 下一月
			
			
			targetDate = (i+1) - (firstWeekDay+currentMonthNumDays);
			date = [NSString stringWithFormat:@"%i",targetDate];
			//NSString *hex = (isSelectedDateNextMonth) ? @"0x383838" : @"aaaaaa";
			
			NSString *hex = @"0x383838";
			//选择的年份与延后年份相等  (选择月份是延后月份前一个月时下个月的日期大于延后日期全部置灰)
			//选择的年份与延后年份相等  (选择月份与延后月份相等下个月全部置灰)
			if ([currentMonth year] == afterYear) {
				if ([currentMonth month] == (afterMonth-1)){
					if ([date intValue] > afterDay)
						hex = @"0xaaaaaa";					
				}
				
				if ([currentMonth month] >= afterMonth){
					hex = @"0xaaaaaa";					
				}
				
			}
			
			CGContextSetFillColorWithColor(context, 
						       [UIColor colorWithHexString:hex].CGColor);
			
			
			
			
		}else { //current month
			// isCurrentMonth = YES; 当前月 
			
			targetDate = (i-firstWeekDay)+1;
			date = [NSString stringWithFormat:@"%i",targetDate];
			NSString  *hex = @"0x383838";
			if (month==[[NSDate date] month]) {
				isSelectedDateNextMonth = false;
			}
			//选择的年份与系统年份相等 (日历开始页面小于当前日期的全部置灰)
			
			if ([currentMonth year] == year) {
				if ([currentMonth month]==month){
					if ([date intValue] < day)
						hex = @"0xaaaaaa";
				}
			}
			//选择的年份与延后年份相等  (限制选择月份等于延后月份时 日期大于延后日期的全部置灰)
			if ([currentMonth year] == afterYear) {
				if ([currentMonth month] == afterMonth){
					if ([date intValue] > afterDay)
						hex = @"0xaaaaaa";
				}
				
				
				if ([currentMonth month] > afterMonth){
					if ([date intValue] > [self.selectedDate day])
						hex = @"0xaaaaaa";
				}
			}
			
			CGContextSetFillColorWithColor(context, 
						       [UIColor colorWithHexString:hex].CGColor);
		}
		
		//draw selected date //画点击背景
		
		if (selectedDate && i==selectedDateBlock) {
			
			
			CGRect rectangleGrid = CGRectMake(targetX,targetY,CalendarViewDayWidth+2,CalendarViewDayHeight+2);
			CGContextAddRect(context, rectangleGrid);
			//CGContextSetFillColorWithColor(context, [UIColor colorWithPatternImage:[UIImage imageNamed:@"CalendarSelect.png"]].CGColor);
			CGContextSetFillColorWithColor(context, FontColor89CDFF.CGColor);
			CGContextFillPath(context);
			CGContextSetFillColorWithColor(context, 
						       FontColor333333.CGColor);
			
			
		}
		
		if(gregorianDate.length>0)
		{
			
			[gregorianDate drawInRect:CGRectMake(targetX+2, targetY+14.0f, CalendarViewDayWidth, CalendarViewDayHeight) withFont:FontBlodSize32 lineBreakMode:NSLineBreakByClipping alignment:NSTextAlignmentCenter];
			
			holidayView=[UIImageView ImageViewWithFrame:CGRectMake(targetX, targetY, 44.0f, 44.0f)];
			holidayView.image=[UIImage imageNamed:@"HolidayIcon.png"];
			[self.holidayImageViewArray addObject:holidayView];
			if (firstDraw) {
				[self addSubview:holidayView];
			}
			
			
		}
		else if(gregorianBanDate.length>0)
		{
			[gregorianBanDate drawInRect:CGRectMake(targetX+2, targetY+14.0f, CalendarViewDayWidth, CalendarViewDayHeight) withFont:FontBlodSize32 lineBreakMode:NSLineBreakByClipping alignment:NSTextAlignmentCenter];
			
			workView=[UIImageView ImageViewWithFrame:CGRectMake(targetX, targetY, 44.0f, 44.0f)];
			workView.image=[UIImage imageNamed:@"WorkIcon.png"];
			[self.workImageViewArray addObject:workView];
			if (workfirstDraw) {
				[self addSubview:workView];
			}
			
			
		}
		else if (todayBlock==i) //画当前日期背景
		{ 
			
			[@"今天" drawInRect:CGRectMake(targetX+2, targetY+14.0f, CalendarViewDayWidth, CalendarViewDayHeight) withFont:FontBlodSize32 lineBreakMode:NSLineBreakByClipping alignment:NSTextAlignmentCenter];
			
			
			
		}else
		{
			[date drawInRect:CGRectMake(targetX+2, targetY+14.0f, CalendarViewDayWidth, CalendarViewDayHeight) withFont:FontBlodSize32 lineBreakMode:NSLineBreakByClipping alignment:NSTextAlignmentCenter];
		}
		
	}
	
	//    CGContextClosePath(context);
	
	
	
	//Draw markings
	if (!self.markedDates || isSelectedDatePreviousMonth || isSelectedDateNextMonth) return;
	
}

#pragma mark - Draw image for animation
-(UIImage *)drawCurrentState {
	float targetHeight = CalendarViewTopBarHeight + [self numRows]*(CalendarViewDayHeight+2)+1;
	
	UIGraphicsBeginImageContext(CGSizeMake(CalendarViewWidth, targetHeight-CalendarViewTopBarHeight));
	CGContextRef c = UIGraphicsGetCurrentContext();
	CGContextTranslateCTM(c, 0, -CalendarViewTopBarHeight);    // <-- shift everything up by 40px when drawing.
	[self.layer renderInContext:c];
	UIImage* viewImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	return viewImage;
}

#pragma mark - Init
-(id)initWithNSDate:(NSDate *)adate allowShowMonths:(NSInteger)monthCount withDayCount:(NSInteger)dayCount withPushBackDay:(NSInteger)pushBackDay{
	
	self = [super initWithFrame:CGRectMake(0.0f, 0.0f, CalendarViewWidth, 0.0f)];
	
	if (self) {
		
		
		UISwipeGestureRecognizer *recognizer; 
		
		recognizer = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipeFrom:)];
		
		[recognizer setDirection:(UISwipeGestureRecognizerDirectionRight)];
		
		[self addGestureRecognizer:recognizer];
		
		[recognizer release];
		
		recognizer = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipeFrom:)];
		
		[recognizer setDirection:(UISwipeGestureRecognizerDirectionLeft)];
		
		[self addGestureRecognizer:recognizer];
		
		[recognizer release];
		
		recognizer = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipeFrom:)];
		
		[recognizer setDirection:(UISwipeGestureRecognizerDirectionUp)];
		
		[self addGestureRecognizer:recognizer];
		
		[recognizer release];
		
		recognizer = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipeFrom:)];
		
		[recognizer setDirection:(UISwipeGestureRecognizerDirectionDown)];
		
		[self  addGestureRecognizer:recognizer];
		
		[recognizer release];
		
		allowShowMonths = monthCount;
		allowShowdays = dayCount;
		self.holidayImageViewArray = [NSMutableArray array];
		self.workImageViewArray = [NSMutableArray array];
		_gregorianDict = [[NSMutableDictionary alloc] init];
		firstDraw = YES;
		workfirstDraw = YES;
		//UIImageView *imageBg = [UIImageView ImageViewWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 300.0f)];
		//imageBg.image=[UIImage imageNamed:@"CalendarBg.png"];
		//[self insertSubview:imageBg atIndex:0];
		
		//        self.contentMode = UIViewContentModeTop;
		//        self.clipsToBounds=YES;

		//判断adate 传入对象是否为空 4月7日添加
		NSDate *date = [NSDate date];
		if (adate == nil) {
			adate = date;
		}
		self.currentMonth = adate;
		NSString *stringNextDate = [NSDate dateafterDay:date day:pushBackDay type:1];
		NSDate *nextDate = [NSDate dateFromString:stringNextDate];
		
		//当前日
		day = [currentMonth day:date];
		//当期月
		month = [currentMonth month:date];
		// 当前月 小于点前日时候不允许点击
		if (([currentMonth month:adate] == month) && ([currentMonth day:adate]<day)){
		}else{
			[self selectDate:[currentMonth day:adate]];
		}
		isAnimating= NO;
		leftArrows = NO;   //左箭头是否显示
		rightArrows = YES; //右箭头是否显示
		
		self.labelCurrentMonth = [[[UISubLabel alloc] initWithFrame:CGRectMake(34, 0, CalendarViewWidth-68, 40)]autorelease];
		[self addSubview:labelCurrentMonth];
		labelCurrentMonth.backgroundColor=[UIColor clearColor];
		labelCurrentMonth.font = FontSize40;
		labelCurrentMonth.textColor = FontColor333333;
		labelCurrentMonth.textAlignment = UITextAlignmentCenter;
		
		[self performSelector:@selector(reset) withObject:nil afterDelay:0.1]; //so delegate can be set after init and still get called on init
		[self reset];
		//self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"CalendarBg.png"]];
                self.backgroundColor = [UIColor clearColor];
		
		//当期年
		year = [currentMonth year:date];
		//获取半年后的日期
		//NSDate *dateafterMonth=[date dateafterMonth:DATEAFTERMONTH];
		if (allowShowdays == 0) {
			NSDate *dateafterMonth=[nextDate dateafterMonth:allowShowMonths];
			//允许访问的年
			afterYear = [currentMonth year:dateafterMonth];
			//允许访问的月
			afterMonth = [currentMonth month:dateafterMonth];
			//允许访问的日
			afterDay = [currentMonth day:dateafterMonth];
		}else {
			NSDate *dateafterDay=[NSDate dateafterDay:[NSDate date] day:allowShowdays];
			//允许访问的年
			afterYear = [currentMonth year:dateafterDay];
			//允许访问的月
			afterMonth = [currentMonth month:dateafterDay];
			//允许访问的日
			afterDay = [currentMonth day:dateafterDay];
		}
		
		
		
		leftArrowsImageView=[UIImageView ImageViewWithFrame:CGRectMake(15.0f, 10.0f, 22.0f, 22.0f)];
		leftArrowsImageView.image=[UIImage imageNamed:@"TicketListBottomLeft1.png"];
		[self addSubview:leftArrowsImageView];
		
		rightArrowsImageView=[UIImageView ImageViewWithFrame:CGRectMake(280.0f, 10.0f, 22.0f, 22.0f)];
		rightArrowsImageView.image=[UIImage imageNamed:@"TicketListBottomRight1.png"];
		[self addSubview:rightArrowsImageView];
		
		weekImageView=[UIImageView ImageViewWithFrame:CGRectMake(0.0f, 40.0f, 320.0f, 21.0f)];
		weekImageView.image=[UIImage imageNamed:@"CalendarBar.png"];
		[self addSubview:weekImageView];
		
		
	}
	return self;
}

//返回当前月方法
-(void)returnsCurrentMonth
{
	firstDraw = YES;
	workfirstDraw = YES;
	int currentMonthIndex = [self.currentMonth month];
	int todayMonth = [[NSDate date] month];
	NSCalendar *gregorian = [[[NSCalendar alloc]
				  initWithCalendarIdentifier:NSGregorianCalendar]autorelease ];
	NSDateComponents *components =
	[gregorian components:(NSYearCalendarUnit | NSMonthCalendarUnit |
			       NSDayCalendarUnit) fromDate: [NSDate date]];
	self.currentMonth = [gregorian dateFromComponents:components]; //clean month
	
	[self updateSize];
	[self setNeedsDisplay];
	for (UIImageView *imageView in self.holidayImageViewArray) {
		
		[imageView removeFromSuperview];
	}
	[self.holidayImageViewArray removeAllObjects];
	for (UIImageView *imageView in self.workImageViewArray) {
		
		[imageView removeFromSuperview];
	}
	[self.workImageViewArray removeAllObjects];
	[delegate calendarView:self switchedToMonth:[currentMonth month] targetHeight:self.calendarHeight animated:NO];
	
	if ((todayMonth!=currentMonthIndex) && [delegate respondsToSelector:@selector(calendarView:switchedToMonth:targetHeight:animated:)]) [delegate calendarView:self switchedToMonth:[currentMonth month] targetHeight:self.calendarHeight animated:NO];
	
}

-(void)dealloc {
	
	
	self.delegate=nil;
	self.gregorianDict = nil;
	[_gregorianDict release];
	self.currentMonth=nil;
	self.labelCurrentMonth=nil;
	self.workImageViewArray = nil;
	self.markedDates=nil;
	self.markedColors=nil;
	self.holidayImageViewArray = nil;
	self.workImageViewArray = nil;
	self.selectedDate = nil;
	self.animationView_A = nil;
	self.animationView_B = nil;
	[super dealloc];
}
@end
