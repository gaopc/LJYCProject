//
//  FilterMenuView.m
//  LJYCProject
//
//  Created by z1 on 13-11-14.
//  Copyright (c) 2013年 longcd. All rights reserved.
//

#import "FilterMenuView.h"
#import "DataClass.h"

@implementation FilterCell

@synthesize filterName;
- (void) dealloc {
	
	self.filterName = nil;
	[super dealloc];
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
	self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
	if (self) {
		// Initialization code
		self.filterName =  [UISubLabel labelWithTitle:@"" frame:CGRectMake(25.0f, 5.0f, 140.0f, 25.0f) font:FontSize30 color:FontColor000000 alignment:NSTextAlignmentLeft];
		[self addSubview:self.filterName];
	}
	return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
	[super setSelected:selected animated:animated];
}

@end

@implementation FilterMenuView
@synthesize fTableView,typeArray,cityBtn,typeBtn,currentTag,selectTags,cityName,typeName,cityArray,delegate;

- (void) dealloc {
	
	self.fTableView = nil;
	self.typeArray = nil;
	self.cityBtn = nil;
	self.typeBtn = nil;
	self.selectTags = nil;
	self.cityName =nil;
	self.typeName =nil;
	self.cityArray = nil;
	self.delegate = nil;
	[super dealloc];
}


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
	
	    self.typeArray = [[NSMutableArray alloc] init];
	    self.currentTag = 0;
	    [self getCityDictionary];
	    self.cityBtn = [UIButton buttonWithType:UIButtonTypeCustom tag:0 title:@"城市" backImage:[self imageWithColor:[UIColor colorWithRed:228/255.0f green:228/255.0f blue:228/255.0f alpha:1.0] size:CGRectMake(0, 30, 100, 30).size] frame:CGRectMake(0, 30, 100, 30) font:FontSize24 color:FontColor000000 target:self action:@selector(filter:)];
	    self.typeBtn = [UIButton buttonWithType:UIButtonTypeCustom tag:1 title:@"类型" backImage:[self imageWithColor:[UIColor colorWithRed:255/255.0f green:255/255.0f blue:255/255.0f alpha:1.0] size:CGRectMake(0, 60, 100, 30).size] frame:CGRectMake(0, 60, 100, 30) font:FontSize24 color:FontColor000000 target:self action:@selector(filter:)];
	    [self addSubview:self.cityBtn];
	    [self addSubview: self.typeBtn];
	    
	    UIImage* imgLine = [self imageWithColor:[UIColor colorWithRed:0/255.0f green:0/255.0f blue:0/255.0f alpha:1.0] size:CGRectMake(100.0f, 0.0f,  0.5f, self.frame.size.height).size];
	    [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(100.0f, 0.0f,  0.5f, self.frame.size.height) image:imgLine]];
	    
	    
	    self.fTableView = [[UITableView alloc] initWithFrame:CGRectMake(101.0f ,10.0f, 200 ,self.frame.size.height-20) style:UITableViewStylePlain];
	    self.fTableView.backgroundColor = [UIColor clearColor];
	    self.fTableView.dataSource = self;
	    self.fTableView.delegate = self;
	    self.fTableView.separatorStyle = UITableViewCellAccessoryNone;
	    [self addSubview:self.fTableView];
	    
	    UIImage* imgTopLine = [self imageWithColor:[UIColor colorWithRed:0/255.0f green:0/255.0f blue:0/255.0f alpha:1.0] size:CGRectMake(0.0f, 0.0f, self.frame.size.width,  0.5f).size];
	    [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(0.0f, 0.0f, self.frame.size.width, 0.5f) image:imgTopLine]];
	    
	    
    }
    return self;
}

- (void)filter:(UIButton *)sender
{
	switch (sender.tag) {
		case 0:
			[self.cityBtn setBackgroundImage:[self imageWithColor:[UIColor colorWithRed:228/255.0f green:228/255.0f blue:228/255.0f alpha:1.0] size:CGRectMake(0, 30, 100, 30).size] forState:UIControlStateNormal];
			[self.typeBtn setBackgroundImage:[self imageWithColor:[UIColor colorWithRed:255/255.0f green:255/255.0f blue:255/255.0f alpha:1.0] size:CGRectMake(0, 30, 100, 30).size] forState:UIControlStateNormal];
			self.currentTag = 0;
			[self getCityDictionary];
			break;
		case 1:
			[self.cityBtn setBackgroundImage:[self imageWithColor:[UIColor colorWithRed:255/255.0f green:255/255.0f blue:255/255.0f alpha:1.0] size:CGRectMake(0, 30, 100, 30).size] forState:UIControlStateNormal];
			[self.typeBtn setBackgroundImage:[self imageWithColor:[UIColor colorWithRed:228/255.0f green:228/255.0f blue:228/255.0f alpha:1.0] size:CGRectMake(0, 30, 100, 30).size] forState:UIControlStateNormal];
			self.currentTag = 1;
			[self getShopTypeDictionary];
			
			
			break;
		default:
			break;
	}
	
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
	static NSString * identifier = @"identifier";
	FilterCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
	if (cell == nil) {
		cell = [[[FilterCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
		cell.backgroundColor = [UIColor clearColor];
		UIView *selectedView = [[UIView alloc] initWithFrame:cell.frame];
		selectedView.backgroundColor = [UIColor colorWithRed:228/255.0f green:228/255.0f blue:228/255.0f alpha:1.0];
		cell.selectedBackgroundView = selectedView;   //设置选中后cell的背景颜色
		[selectedView release];
		//cell.delegate = self;
		
		
	}
	
	if (self.currentTag== 0) {
		City *city = nil;
		city = (City *)[self.typeArray objectAtIndex:indexPath.row];
		cell.filterName.text = city._name;
		
	}
	if (self.currentTag== 1) {
		ShopType *type  = nil;
		type  = (ShopType *)[self.typeArray objectAtIndex:indexPath.row];
		cell.filterName.text = type._Type_name;
		
	}
	return cell;

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	if (self.currentTag== 0) {
		City *city = nil;
		city = (City *)[self.typeArray objectAtIndex:indexPath.row];
		if (self.delegate){
			[self.delegate filterMenu:city._id type:nil];
		}
		
	}
	if (self.currentTag== 1) {
		ShopType *shopType  = nil;
		shopType  = (ShopType *)[self.typeArray objectAtIndex:indexPath.row];
		if (self.delegate){
			[self.delegate filterMenu:nil type:shopType._Type_id];
		}
		
		
	}
	
}

-(void)getCityDictionary
{
	
	NSArray *citys = [DataClass selectFromCity];
	
	if (self.typeArray.count>0)
	[self.typeArray removeAllObjects];
	self.typeArray = [NSMutableArray arrayWithArray:citys];
	
//	for(int i=0;i<[self.cityArray count];i++)
//	{
//		City *aCity = [self.cityArray objectAtIndex:i];
//		[self.typeArray addObject:aCity];
//	}
	[self.fTableView reloadData];

}

-(void)getShopTypeDictionary
{
	ShopType *shopType = [[ShopType alloc] init];
	shopType._Type_id = @"";
	shopType._Type_name = @"全部商家";
	NSMutableArray *shopTypes = [NSMutableArray arrayWithArray:[DataClass selectShopType]];
	[shopTypes insertObject:shopType atIndex:0];
	[shopType release];
	//NSArray *shopTypes = [DataClass selectShopType];
	if (self.typeArray.count>0)
		[self.typeArray removeAllObjects];
	for(int i=0;i<[shopTypes count];i++)
	{
		ShopType *type = [shopTypes objectAtIndex:i];
		[self.typeArray addObject:type];
	}
	[self.fTableView reloadData];
		
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