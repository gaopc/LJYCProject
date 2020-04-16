//
//  DistanceMenuView.m
//  LJYCProject
//
//  Created by z1 on 13-10-25.
//  Copyright (c) 2013年 longcd. All rights reserved.
//

#import "DistanceMenuView.h"

@implementation DistanceMenuView
@synthesize buttonView,selectRangeDis,delegate;



- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
	    
	   // [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(268.0f, 0.0f, 11.0f, 5.5f) image:[UIImage imageNamed:@"MenuArrow.png"]]];
	    
	    
//	    UIImage* imgBg = [self imageWithColor:[UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:1.0] size:CGRectMake(0.0f, 0.0f, self.frame.size.width, self.frame.size.height).size];
//	    [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(0.0f, 0.0f, self.frame.size.width, self.frame.size.height) image:imgBg]];
//	    
	    
	     UIImageView *imgLineView = [UIImageView ImageViewWithFrame:CGRectMake(21, 20, 278, 33) image:[UIImage imageNamed:@"筛选横条.png"]];
	    
	    [self addSubview:[UISubLabel labelWithTitle:@"1公里" frame:CGRectMake(10, 65, 60, 15) font:FontSize26 color:FontColor000000 alignment:NSTextAlignmentCenter]];
	    [self addSubview:[UISubLabel labelWithTitle:@"5公里" frame:CGRectMake(60+5, 65, 60, 15) font:FontSize26 color:FontColor000000 alignment:NSTextAlignmentCenter]];
	    [self addSubview:[UISubLabel labelWithTitle:@"10公里" frame:CGRectMake(60*2+10, 65, 60, 15) font:FontSize26 color:FontColor000000 alignment:NSTextAlignmentCenter]];
	    [self addSubview:[UISubLabel labelWithTitle:@"20公里" frame:CGRectMake(60*3+10, 65, 60, 15) font:FontSize26 color:FontColor000000 alignment:NSTextAlignmentCenter]];
	    [self addSubview:[UISubLabel labelWithTitle:@"40公里" frame:CGRectMake(60*4+10, 65, 60, 15) font:FontSize26 color:FontColor000000 alignment:NSTextAlignmentCenter]];
	    
	    
	    self.buttonView = [UIImageView ImageViewWithFrame:CGRectMake(146, 22, 28.5, 29) image:[UIImage imageNamed:@"handle-hover.png"]];
	    [self addSubview:imgLineView];
	    [self addSubview:self.buttonView];
	    
	    for (int i = 0; i < 5; i ++) {
		    [self addSubview:[UIButton buttonWithTag:i frame:CGRectMake(23 + 60*i, 22, 60, 30) target:self action:@selector(moveImage:)]];
	    }
	    
    }
    return self;
}

- (void) dealloc {
	self.delegate = nil;
	self.buttonView = nil;
	self.selectRangeDis = nil;
	
	[super dealloc];
}

- (void)moveImage:(UIButton *)sender
{
	NSLog(@"tag%d", sender.tag);
	[self setTicketOrderTime:sender.tag];
}

- (void)setTicketOrderTime:(int)index
{
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.6];
	self.buttonView.frame = CGRectMake(23 + index * 61.5, 22, 28.5, 29);
	switch (index) {
		case 0:
			distance = 1000;
			break;
		case 1:
			distance = 5000;
			break;
		case 2:
			distance = 10000;
			break;
		case 3:
			distance = 20000;
			break;
		case 4:
			distance = 40000;
			break;
		default:
			break;
	}
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDidStopSelector:@selector(animationFinished:)];
	[UIView commitAnimations];

	
}

- (void) animationFinished: (id) sender{
	
	if (self.delegate)
	{
		[self.delegate distancMenu:distance];
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


#import "DataClass.h"
@implementation CityMenuView
@synthesize delegate,citysTableView,cityDistrict,selectSection;

- (void) dealloc {
	
	self.delegate = nil;
	self.citysTableView = nil;
	self.cityDistrict = nil;
	if (c_tableView) {
		[c_tableView release];
		c_tableView = nil;
		
	}
	[super dealloc];
}



- (id)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	if (self) {
		// Initialization code
		
		//[self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(268.0f, 0.0f, 11.0f, 5.5f) image:[UIImage imageNamed:@"MenuArrow.png"]]];
		UIImage* imgBg = [self imageWithColor:[UIColor colorWithRed:255/255.0f green:255/255.0f blue:255/255.0f alpha:1.0] size:CGRectMake(0.0f, 0.0f, self.frame.size.width, self.frame.size.height).size];
		[self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(0.0f, 5.5f, self.frame.size.width, self.frame.size.height) image:imgBg]];
		
		 //[self getMyCityDistrict];
		
		c_tableView = [[UITableView alloc] initWithFrame:CGRectMake(0.0f ,0.0f,self.frame.size.width,self.frame.size.height) style:UITableViewStylePlain];
		c_tableView.backgroundColor = [UIColor clearColor];
		c_tableView.dataSource = self;
		c_tableView.delegate = self;
		c_tableView.separatorStyle = UITableViewCellAccessoryNone;
		[self addSubview:c_tableView];
		
		self.selectSection = 0;
		
		
	}
	return self;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 1;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 40;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	int count = [(NSArray*)[cityDistrict objectAtIndex:section] count]-1;
	
	if(selectSection == section)
		return ((count%4 == 0)?(count/4):(count/4+1))+1;
	else
		return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	if(indexPath.row == 0)
	{
		NSString *cityIdentifier = [NSString stringWithFormat:@"cityIdentifier%d",indexPath.section];
		UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cityIdentifier];
		
		// Configure the cell...
		if (cell == nil)
		{
			cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cityIdentifier] autorelease];
			cell.backgroundColor = [UIColor clearColor];
			
			NSArray *array = [cityDistrict objectAtIndex:indexPath.section];
			City *aCity =[array objectAtIndex:0];
			[cell addSubview:[UIImageView ImageViewWithFrame:CGRectMake(15.0f, 16.0f, 7.0f, 7.0f) image:[UIImage imageNamed:@"BlueDot.png"]]];
			UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom tag:0 title:aCity._name backImage:nil frame:CGRectMake(20, 10, 80, 20) font:FontSize28 color:[UIColor colorWithRed:18/255.0f green:188/255.0f blue:230/255.0f alpha:1.0] target:self action:@selector(getMyAddress:)];
			[cell.contentView addSubview:button];
			
			UIView *selectedView = [[UIView alloc] initWithFrame:cell.frame];
			selectedView.backgroundColor = [UIColor clearColor];
			cell.selectedBackgroundView = selectedView;   //设置选中后cell的背景颜色
			[selectedView release];
			//[cell.contentView addSubview:[UISubLabel labelWithTitle:aCity._name frame:CGRectMake(30, 10, 150, 20)  font:FontSize28 color:[UIColor colorWithRed:18/255.0f green:188/255.0f blue:230/255.0f alpha:1.0]  alignment:NSTextAlignmentLeft]];
			//[cell.contentView addSubview:[UIImageView ImageViewWithFrame:CGRectMake(5, 25, ViewWidth, 0.5) image:[UIImage imageNamed:@"横向分割线.png"]]];
		}
		
		return cell;
	}
	else
	{
		NSString *tagIdentifier = [NSString stringWithFormat:@"tagIdentifier%d%d",indexPath.section,indexPath.row];
		UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tagIdentifier];
		
		
		NSArray *array = [cityDistrict objectAtIndex:indexPath.section];
		int  count = [array count]-1 - (indexPath.row-1)*4;//还未显示的地区数
		
		// Configure the cell...
		if (cell == nil)
		{
			cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tagIdentifier] autorelease];
			cell.backgroundColor = [UIColor clearColor];
			
			int tags = (count > 4)?(4):(count);
			
			for(int i=0; i<tags; i++)
			{
				District *district = [array objectAtIndex:([array count] - count + i)];
				NSInteger tag = (indexPath.row-1)*4+i+1;
				NSString *title = district._name;
				UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom tag:tag title:title backImage:nil frame:CGRectMake(15+72*i, 10, 65, 20) font:FontSize28 color:FontColor000000 target:self action:@selector(click:)];
				[cell.contentView addSubview:button];
				
				//[cell.contentView addSubview:[UIImageView ImageViewWithFrame:CGRectMake(5, 25, ViewWidth, 0.5) image:[UIImage imageNamed:@"横向分割线.png"]]];
			}
			UIView *selectedView = [[UIView alloc] initWithFrame:cell.frame];
			selectedView.backgroundColor = [UIColor clearColor];
			cell.selectedBackgroundView = selectedView;   //设置选中后cell的背景颜色
			[selectedView release];
		}
		
		return cell;
	}
	
}

-(void)getMyAddress:(UIButton*)sender
{
	City *aCity = [[self.cityDistrict objectAtIndex:selectSection] objectAtIndex:0];
	//District *aDistrict = [[self.cityDistrict objectAtIndex:selectSection] objectAtIndex:sender.tag];
	if (self.delegate){
		
		[self.delegate cityMenu:aCity._id cityName:aCity._name district:nil];
	}
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	

}



-(void)getMyCityDistrict:(NSString*)districtId
{
	

	 NSArray *countrys = [DataClass selectFromCountry];
	//NSArray *countrys = [DataClass selectFromCountry:districtId];
	NSArray *citys = [DataClass selectFromCity];
	
	NSMutableArray *allArray = [NSMutableArray array];
	
	for(int i=0;i<[citys count];i++)
	{
		City *aCity = [citys objectAtIndex:i];
		NSString *cityID = aCity._id;
		NSLog(@"%@",aCity._id);
		
		NSMutableArray *array = [NSMutableArray array];
		for(int j=0;j<[countrys count];j++)
		{
			District *district = [countrys objectAtIndex:j];
			NSLog(@"%@",district._cityId);
			if([district._cityId isEqualToString:cityID])
				[array addObject:district];
		}
		[array insertObject:aCity atIndex:0];
		[allArray addObject:array];
	}
	self.cityDistrict = allArray;
	
	NSLog(@"%@",cityDistrict);
	
	[c_tableView reloadData];
}


-(void)click:(UIButton*)sender
{
    City *aCity = [[self.cityDistrict objectAtIndex:selectSection] objectAtIndex:0];
	District *aDistrict = [[self.cityDistrict objectAtIndex:selectSection] objectAtIndex:sender.tag];
	
	if (self.delegate){
			
		[self.delegate cityMenu:aDistrict._cityId cityName:aCity._name district:aDistrict];
	}
	
}



@end


