//
//  OrderMenuView.m
//  LJYCProject
//
//  Created by z1 on 13-10-25.
//  Copyright (c) 2013年 longcd. All rights reserved.
//

#import "OrderMenuView.h"

@implementation OrderMenuView
@synthesize orderArray,delegate,menuArrow;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
	    
//	    UIImage* imgBg = [self imageWithColor:[UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:1.0] size:CGRectMake(0.0f, 0.0f, self.frame.size.width, self.frame.size.height).size];
//	    [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(0.0f, 5.5f, self.frame.size.width, self.frame.size.height) image:imgBg]];
	    
//	    self.menuArrow = [UIImageView ImageViewWithFrame:CGRectMake(75.0f, 0.0f, 11.0f, 5.5f) image:[UIImage imageNamed:@"MenuArrow.png"]];
//	    [self addSubview:self.menuArrow];
	    self.orderArray = [NSArray arrayWithObjects:@"距离最近",@"星级", @"人气",nil];
	    
	    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0.0f ,5.0f,self.frame.size.width,self.frame.size.height-10) style:UITableViewStylePlain];
	    tableView.backgroundColor = [UIColor clearColor];
	    tableView.dataSource = self;
	    tableView.delegate = self;
	    tableView.separatorStyle = UITableViewCellAccessoryNone;
	    [self addSubview:tableView];
	    
	    UIImage* imgTopLine = [self imageWithColor:[UIColor colorWithRed:0/255.0f green:0/255.0f blue:0/255.0f alpha:1.0] size:CGRectMake(0.0f, 0.0f, self.frame.size.width,  0.5f).size];
	    [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(0.0f, 0.0f, self.frame.size.width, 0.5f) image:imgTopLine]];
	    
    }
    return self;
}

- (void) dealloc {
	
	self.orderArray = nil;
	self.delegate = nil;
	self.menuArrow = nil;
	[super dealloc];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 40;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return [self.orderArray count];
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *flightDetailsCellIdentifier = @"orderMenuCellIdentifier";
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:flightDetailsCellIdentifier];
	if(cell == nil){
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:flightDetailsCellIdentifier] autorelease];
		cell.backgroundColor = [UIColor clearColor];
		
		UIImage* line = [self imageWithColor:[UIColor colorWithRed:0.0f/255.0f green:0.0f/255.0f blue:0.0f/255.0f alpha:1.0] size:CGRectMake(0.0f, 0.0f, self.frame.size.width, 0.5f).size];
		[cell addSubview:[UIImageView ImageViewWithFrame:CGRectMake(0.0f, 39.5f, self.frame.size.width, 0.5f) image:line]];
		
		UIView *selectedView = [[UIView alloc] initWithFrame:cell.frame];
		selectedView.backgroundColor = [UIColor colorWithRed:228/255.0f green:228/255.0f blue:228/255.0f alpha:1.0];
		cell.selectedBackgroundView = selectedView;   //设置选中后cell的背景颜色
		[selectedView release];

	}
	
	if (indexPath.row ==0) {
	   [cell addSubview:[UIImageView ImageViewWithFrame:CGRectMake(20.0f, 8.0f, 14.0f, 20.0f) image:[UIImage imageNamed:@"DistanceIcon.png"]]];
	}
	if (indexPath.row ==1) {
		[cell addSubview:[UIImageView ImageViewWithFrame:CGRectMake(20.0f, 8.0f, 19.0f, 18.5f) image:[UIImage imageNamed:@"StarIcon.png"]]];
	}
	if (indexPath.row ==2) {
		[cell addSubview:[UIImageView ImageViewWithFrame:CGRectMake(20.0f, 8.0f, 18.0f, 15.5f) image:[UIImage imageNamed:@"PopularIcon.png"]]];
	}
	
	UISubLabel *name =  [UISubLabel labelWithTitle:@"" frame:CGRectMake(55.0f, 5.0f, 150.0f, 25.0f) font:FontBlodSize26 color:FontColor000000 alignment:NSTextAlignmentLeft];
	name.text = [self.orderArray objectAtIndex:indexPath.row];
	[cell addSubview:name];
	return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	if (self.delegate)
	{
		[self.delegate orderMenu:indexPath.row];
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
