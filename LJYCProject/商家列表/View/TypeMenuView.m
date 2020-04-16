//
//  TypeMenuView.m
//  LJYCProject
//
//  Created by z1 on 13-11-6.
//  Copyright (c) 2013年 longcd. All rights reserved.
//

#import "TypeMenuView.h"



@implementation TypeMenuView
@synthesize typeArray,delegate,menuArrow;

- (void) dealloc {
	
	self.typeArray = nil;
	self.delegate = nil;
	self.menuArrow = nil;
	[super dealloc];
}


- (id)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	if (self) {
		// Initialization code
		
		//self.menuArrow = [UIImageView ImageViewWithFrame:CGRectMake(85.0f, 0.0f, 11.0f, 5.5f) image:[UIImage imageNamed:@"MenuArrow.png"]];
		//[self addSubview:self.menuArrow];
		//self.typeArray = [NSArray arrayWithObjects:@"农家乐",@"采摘园", @"旅游景点" ,@"娱乐活动",@"其他",nil];
		UIImage* imgBg = [self imageWithColor:[UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:1.0] size:CGRectMake(0.0f, 0.0f, self.frame.size.width, self.frame.size.height).size];
		[self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(0.0f, 0.0f, self.frame.size.width, self.frame.size.height) image:imgBg]];
		
		
		UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0.0f ,0.0f,self.frame.size.width,self.frame.size.height) style:UITableViewStylePlain];
		tableView.backgroundColor = [UIColor clearColor];
		tableView.dataSource = self;
		tableView.delegate = self;
		tableView.separatorStyle = UITableViewCellAccessoryNone;
		[self addSubview:tableView];
	}
	return self;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 40;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return [self.typeArray count];
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *flightDetailsCellIdentifier = @"flightDetailsCellIdentifier";
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:flightDetailsCellIdentifier];
	
	if(cell == nil){
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:flightDetailsCellIdentifier] autorelease];
		cell.backgroundColor = [UIColor clearColor];
		
		UIImage* line = [self imageWithColor:[UIColor colorWithRed:0.0f/255.0f green:0.0f/255.0f blue:0.0f/255.0f alpha:1.0] size:CGRectMake(0.0f, 0.0f, self.frame.size.width, 0.5f).size];
		[cell addSubview:[UIImageView ImageViewWithFrame:CGRectMake(0.0f, 39.5f, self.frame.size.width, 0.5f) image:line]];
		
		
		UIView *selectedView = [[UIView alloc] initWithFrame:cell.frame];
		selectedView.backgroundColor = [UIColor colorWithRed:228/255.0f green:228/255.0f blue:228/255.0f alpha:1.0];
		cell.selectedBackgroundView = selectedView;   //设置选中后cell的背景颜色
		[selectedView release];	//cell.selectedBackgroundView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"OrderMenuCellBgClick.png"]];
		
		UISubLabel *name =  [UISubLabel labelWithTitle:@"" frame:CGRectMake(25.0f, 5.0f, 140.0f, 25.0f) font:FontSize30 color:FontColor000000 alignment:NSTextAlignmentLeft];
		ShopType *type=(ShopType *)[self.typeArray objectAtIndex:indexPath.row];
		name.text = type._Type_name;
		[cell addSubview:name];
	}
	
		
	return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	
	ShopType *type=(ShopType *)[self.typeArray objectAtIndex:indexPath.row];
	if (self.delegate)
	{
		[self.delegate typeMenu:type];
	}
}




/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */

@end

