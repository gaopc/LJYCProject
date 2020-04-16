//
//  TagMenuView.m
//  LJYCProject
//
//  Created by z1 on 13-10-25.
//  Copyright (c) 2013年 longcd. All rights reserved.
//

#import "TagMenuView.h"
#import "DataClass.h"
#import "TagButton.h"

@implementation TagMenuView
@synthesize tagArray,delegate,canyinBtn,zhusuBtn,shineiBtn,shiwaiBtn,qitaBtn,currentTag,myTableView,selectTags,serviceTagData,allBtn;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
            
	    
//	    UIImage* imgBg = [self imageWithColor:[UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:1.0] size:CGRectMake(0.0f, 0.0f, self.frame.size.width, self.frame.size.height).size];
//	    [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(0.0f, 5.5f, self.frame.size.width, self.frame.size.height) image:imgBg]];
//	    
	    self.selectTags = [NSMutableDictionary dictionary];
	    self.serviceTagData = [NSMutableDictionary dictionary];
	    [self getServiceTagData];
	   
	    self.allBtn = [UIButton buttonWithType:UIButtonTypeCustom tag:5 title:@"全部标签" backImage:[UIImage imageNamed:@"服务类型-00.png"] frame:CGRectMake(15, 15, 55, 30) font:FontSize24 color:FontColor000000 target:self action:@selector(showService:)];
	    self.canyinBtn = [UIButton buttonWithType:UIButtonTypeCustom tag:0 title:@"餐饮" backImage:[self imageWithColor:[UIColor colorWithRed:68/255.0f green:181/255.0f blue:223/255.0f alpha:1.0] size:CGRectMake(150, 0, 150, 30).size] frame:CGRectMake(15, 50, 55, 30) font:FontSize24 color:FontColor000000 target:self action:@selector(showService:)];
	    self.zhusuBtn = [UIButton buttonWithType:UIButtonTypeCustom tag:1 title:@"住宿" backImage:[UIImage imageNamed:@"服务类型-00.png"] frame:CGRectMake(15 + 59, 50, 55, 30) font:FontSize24 color:FontColor000000 target:self action:@selector(showService:)];
	    self.shineiBtn = [UIButton buttonWithType:UIButtonTypeCustom tag:2 title:@"室内娱乐" backImage:[UIImage imageNamed:@"服务类型-00.png"] frame:CGRectMake(15 + 59*2, 50, 55, 30) font:FontSize24 color:FontColor000000 target:self action:@selector(showService:)];
	    self.shiwaiBtn = [UIButton buttonWithType:UIButtonTypeCustom tag:3 title:@"室外娱乐" backImage:[UIImage imageNamed:@"服务类型-00.png"] frame:CGRectMake(15 + 59*3, 50, 55, 30) font:FontSize24 color:FontColor000000 target:self action:@selector(showService:)];
	    self.qitaBtn = [UIButton buttonWithType:UIButtonTypeCustom tag:4 title:@"其它" backImage:[UIImage imageNamed:@"服务类型-00.png"] frame:CGRectMake(15 + 59*4, 50, 55, 30) font:FontSize24 color:FontColor000000 target:self action:@selector(showService:)];
	    
	    UIImageView *lineView = [UIImageView ImageViewWithFrame:CGRectMake(15, 79, 291, 1) image:[UIImage imageNamed:@"区域分隔.png"]];
	    
	    self.currentTag = [NSString stringWithFormat:@"%@",self.canyinBtn.titleLabel.text];

	    
	    [self addSubview:self.allBtn];
	    [self addSubview:self.canyinBtn];
	    [self addSubview:self.zhusuBtn];
	    [self addSubview:self.shineiBtn];
	    [self addSubview:self.shiwaiBtn];
	    [self addSubview:self.qitaBtn];
	    [self addSubview:lineView];
	    
	    self.myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0.0f ,80.0f,self.frame.size.width,200) style:UITableViewStylePlain];
	    self.myTableView.backgroundColor = [UIColor clearColor];
	    self.myTableView.dataSource = self;
	    self.myTableView.delegate = self;
	    self.myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
	    [self addSubview:self.myTableView];
	    
	    UIImage* imgTopLine = [self imageWithColor:[UIColor colorWithRed:0/255.0f green:0/255.0f blue:0/255.0f alpha:1.0] size:CGRectMake(0.0f, 0.0f, self.frame.size.width,  0.5f).size];
	    [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(0.0f, 0.0f, self.frame.size.width, 0.5f) image:imgTopLine]];
	    
    }
    return self;
}


- (void) dealloc {
	
	self.tagArray = nil;
	self.delegate = nil;
	self.canyinBtn = nil;
	self.zhusuBtn = nil;
	self.shineiBtn = nil;
	self.shiwaiBtn = nil;
	self.qitaBtn = nil;
	self.myTableView = nil;
	self.currentTag = nil;
	self.selectTags = nil;
	self.serviceTagData = nil;
	
	[super dealloc];
}

-(void)showService:(UIButton*)sender
{
//	if([self.currentTag isEqualToString:sender.titleLabel.text])
//	{
//		return;
//	}
	self.currentTag = [NSString stringWithFormat:@"%@",sender.titleLabel.text];
	[self.allBtn setBackgroundImage:[UIImage imageNamed:@"服务类型-00.png"] forState:UIControlStateNormal];
	[self.canyinBtn setBackgroundImage:[UIImage imageNamed:@"服务类型-00.png"] forState:UIControlStateNormal];
	[self.zhusuBtn setBackgroundImage:[UIImage imageNamed:@"服务类型-00.png"] forState:UIControlStateNormal];
	[self.shineiBtn setBackgroundImage:[UIImage imageNamed:@"服务类型-00.png"] forState:UIControlStateNormal];
	[self.shiwaiBtn setBackgroundImage:[UIImage imageNamed:@"服务类型-00.png"] forState:UIControlStateNormal];
	[self.qitaBtn setBackgroundImage:[UIImage imageNamed:@"服务类型-00.png"] forState:UIControlStateNormal];
	
	switch (sender.tag) {
		case 0:
			[self.canyinBtn setBackgroundImage:[self imageWithColor:[UIColor colorWithRed:68/255.0f green:181/255.0f blue:223/255.0f alpha:1.0] size:CGRectMake(150, 0, 150, 30).size] forState:UIControlStateNormal];
			break;
		case 1:
			[self.zhusuBtn setBackgroundImage:[self imageWithColor:[UIColor colorWithRed:68/255.0f green:181/255.0f blue:223/255.0f alpha:1.0] size:CGRectMake(150, 0, 150, 30).size] forState:UIControlStateNormal];
			break;
		case 2:
			[self.shineiBtn setBackgroundImage:[self imageWithColor:[UIColor colorWithRed:68/255.0f green:181/255.0f blue:223/255.0f alpha:1.0] size:CGRectMake(150, 0, 150, 30).size] forState:UIControlStateNormal];
			break;
		case 3:
			[self.shiwaiBtn setBackgroundImage:[self imageWithColor:[UIColor colorWithRed:68/255.0f green:181/255.0f blue:223/255.0f alpha:1.0] size:CGRectMake(150, 0, 150, 30).size] forState:UIControlStateNormal];
			break;
		case 4:
			[self.qitaBtn setBackgroundImage:[self imageWithColor:[UIColor colorWithRed:68/255.0f green:181/255.0f blue:223/255.0f alpha:1.0] size:CGRectMake(150, 0, 150, 30).size] forState:UIControlStateNormal];
			break;
		case 5:
			[self.allBtn setBackgroundImage:[self imageWithColor:[UIColor colorWithRed:68/255.0f green:181/255.0f blue:223/255.0f alpha:1.0] size:CGRectMake(150, 0, 150, 30).size] forState:UIControlStateNormal];
			
			if (self.delegate)
			{
				[self.delegate tagMenu:nil];
			}
			
			break;
		default:
			break;
	}
	
	self.myTableView.tag = sender.tag;
	[self.myTableView reloadData];
	
}

-(void) getAllServiceTagData
{
	NSArray *array = [DataClass selectServiceTag];
	
	[self.serviceTagData setValue:array forKey:@"全部"];
}

-(void)getServiceTagData
{
	NSArray *array = [DataClass selectServiceTag];
	NSMutableArray *array0 = [NSMutableArray array];//其他
	NSMutableArray *array1 = [NSMutableArray array];//餐饮
	NSMutableArray *array2 = [NSMutableArray array];//住宿
	NSMutableArray *array3 = [NSMutableArray array];//室内
	NSMutableArray *array4 = [NSMutableArray array];//室外
	
	for(ServiceTag *aServiceTag in array)
	{
		int type = [aServiceTag._tag_type intValue];
		switch (type) {
			case 0:
				[array0 addObject:aServiceTag];
				break;
			case 1:
				[array1 addObject:aServiceTag];
				break;
			case 2:
				[array2 addObject:aServiceTag];
				break;
			case 3:
				[array3 addObject:aServiceTag];
				break;
			case 4:
				[array4 addObject:aServiceTag];
				break;
				
			default:
				break;
		}
		
	}
	[self.serviceTagData setValue:array0 forKey:@"其它"];
	[self.serviceTagData setValue:array1 forKey:@"餐饮"];
	[self.serviceTagData setValue:array2 forKey:@"住宿"];
	[self.serviceTagData setValue:array3 forKey:@"室内娱乐"];
	[self.serviceTagData setValue:array4 forKey:@"室外娱乐"];
	
}


//-(void)getServiceTagData
//{
//	NSArray *array = [DataClass selectServiceTag];
//	
//	NSMutableArray *array0 = [NSMutableArray array];//其他
//	NSMutableArray *array1 = [NSMutableArray array];//餐饮
//	NSMutableArray *array2 = [NSMutableArray array];//住宿
//	NSMutableArray *array3 = [NSMutableArray array];//室内
//	NSMutableArray *array4 = [NSMutableArray array];//室外
//	
//	for(ServiceTag *aServiceTag in array)
//	{
//		int type = [aServiceTag._tag_type intValue];
//		switch (type) {
//			case 0:
//				[array0 addObject:aServiceTag];
//				break;
//			case 1:
//				[array1 addObject:aServiceTag];
//				break;
//			case 2:
//				[array2 addObject:aServiceTag];
//				break;
//			case 3:
//				[array3 addObject:aServiceTag];
//				break;
//			case 4:
//				[array4 addObject:aServiceTag];
//				break;
//			
//			default:
//				break;
//		}
//		
//	}
//	[self.serviceTagData setValue:array0 forKey:@"其他"];
//	[self.serviceTagData setValue:array1 forKey:@"餐饮"];
//	[self.serviceTagData setValue:array2 forKey:@"住宿"];
//	[self.serviceTagData setValue:array3 forKey:@"室内娱乐"];
//	[self.serviceTagData setValue:array4 forKey:@"室外娱乐"];
//	
//}


#pragma mark - Table view data source

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 35.0f;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	int count = [(NSArray*)[serviceTagData objectForKey:self.currentTag] count];
	return (count%4 == 0)?(count/4):(count/4+1);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	NSString *tagIdentifier = [NSString stringWithFormat:@"tagIdentifier%d%d",tableView.tag,indexPath.row];
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tagIdentifier];
	cell.selectionStyle = UITableViewCellSelectionStyleNone;
	NSArray *array = [serviceTagData objectForKey:self.currentTag];
	int count = [array count] - indexPath.row*4;
	// Configure the cell...
	if (cell == nil)
	{
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tagIdentifier] autorelease];
		cell.backgroundColor = [UIColor clearColor];
		int tags = (count > 4)?(4):(count);
		
		for(int i=0;i<tags;i++)
		{
			
			
			ServiceTag *aServiceTag = [array objectAtIndex:([array count] - count + i)];
			
			NSString *tag = [NSString stringWithFormat:@"%d",[array count] - count + i];
			
			UIButton *tagButton = [UIButton buttonWithType:UIButtonTypeCustom tag:[tag intValue] title:nil frame:CGRectMake(76*i, 1, 71, 31) backImage:nil target:self action:@selector(tagClick:)];
			[tagButton setExclusiveTouch:YES];
			tagButton.backgroundColor = [UIColor clearColor];
			[tagButton setBackgroundImage:[self imageWithColor:[UIColor colorWithRed:7/255.0f green:150/255.0f blue:185/255.0f alpha:1.0] size:CGRectMake(150, 0, 150, 30).size] forState:UIControlStateHighlighted];
			[cell.contentView addSubview:tagButton];
			
			UISubLabel *tagLabel = [UISubLabel labelWithTitle:@"" frame:CGRectMake(76*i, 1, 71, 31) font:FontSize22 color:FontColor000000 alignment:NSTextAlignmentCenter];
			tagLabel.backgroundColor = [UIColor clearColor];
			tagLabel.text = aServiceTag._tag_name;
			[cell.contentView addSubview:tagLabel];
		}
		UIView *selectedView = [[UIView alloc] initWithFrame:cell.frame];
		selectedView.backgroundColor = [UIColor clearColor];
		cell.selectedBackgroundView = selectedView;   //设置选中后cell的背景颜色
		[selectedView release];
	}
	return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
	if (![cell selectionStyle] == UITableViewCellSelectionStyleNone) {
		
	}
}

- (void)tagClick:(UIButton *)sender
{
	NSArray *array = [serviceTagData objectForKey:self.currentTag];
	ServiceTag *aServiceTag = [array objectAtIndex:sender.tag];

	if (self.delegate)
	{
		[self.delegate tagMenu:aServiceTag];
	}
}

//-(void)tagClick:(UIButton *)sender
//{
//	NSArray *array = [serviceTagData objectForKey:self.currentTag];
//	ServiceTag *aServiceTag = [array objectAtIndex:sender.tag];
//	if (sender.isSelected)
//	{
//		[self.selectTags setObject:aServiceTag forKey:aServiceTag._tag_name];
//	}
//	else
//	{
//		[self.selectTags removeObjectForKey:aServiceTag._tag_name];
//	}
//}


//-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//	return 30;
//}
//
//-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//
//
//	int num = [self.tagArray count];
//	if (num%2 == 0) {
//		return num/2;
//	}else{
//		return num/2+1;
//	}
//}
//
//
//-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//	static NSString *flightDetailsCellIdentifier = @"flightDetailsCellIdentifier";
//	TagMenuCell *cell = [tableView dequeueReusableCellWithIdentifier:flightDetailsCellIdentifier];
//	if(cell == nil){
//		cell = [[[TagMenuCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:flightDetailsCellIdentifier] autorelease];
//		
//	}
//	
//	if((indexPath.row*2)<[self.tagArray count]){
//		
//		ServiceTag *tag=(ServiceTag *)[self.tagArray objectAtIndex:indexPath.row*2];
//		
//		cell.leftButton =[UIButton buttonWithType:UIButtonTypeCustom tag:100+indexPath.row title:@"" frame:CGRectMake(0, 0, 150, 30) backImage:nil target:self action:@selector(tagClick:)];
//		[cell.leftButton setBackgroundImage:[self imageWithColor:[UIColor colorWithRed:7/255.0f green:150/255.0f blue:185/255.0f alpha:1.0] size:CGRectMake(0, 0, 150, 30).size] forState:UIControlStateHighlighted];
//		[cell addSubview:cell.leftButton];
//		
//		cell.leftLabel.text =tag._tag_name;
//		[cell addSubview:cell.leftLabel];
//	}
//	
//	if((indexPath.row*2)+1<[self.tagArray count]){
//		ServiceTag *tag=(ServiceTag *)[self.tagArray objectAtIndex:indexPath.row*2+1];
//		
//		cell.rightButton = [UIButton buttonWithType:UIButtonTypeCustom tag:200+indexPath.row title:@"" frame:CGRectMake(150, 0, 150, 30) backImage:nil target:self action:@selector(tagClick:)];
//		[cell.rightButton setBackgroundImage:[self imageWithColor:[UIColor colorWithRed:7/255.0f green:150/255.0f blue:185/255.0f alpha:1.0] size:CGRectMake(150, 0, 150, 30).size] forState:UIControlStateHighlighted];
//		[cell addSubview:cell.rightButton];
//		//cell.rightLabel.text = [self.tagArray objectAtIndex:indexPath.row*2+1];
//		cell.rightLabel.text =tag._tag_name;
//		[cell addSubview:cell.rightLabel];
//		
//		
//	}else if (indexPath.row*2+1 == [self.tagArray count]){
//		cell.rightLabel.hidden = YES;
//		cell.rightButton.hidden = YES;
//	}
//
//	
//	
//	return cell;
//}

//- (void)tagClick:(UIButton *)sender
//{
////	UIButton *button = (UIButton*)sender;
////	int tag = button.tag;
//	
//	if (self.delegate)
//	{
//		[self.delegate tagMenu:@""];
//	}
//}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
