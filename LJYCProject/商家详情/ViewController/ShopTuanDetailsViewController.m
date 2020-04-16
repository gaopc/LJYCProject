//
//  ShopTuanDetailsViewController.m
//  LJYCProject
//
//  Created by z1 on 14-3-7.
//  Copyright (c) 2014年 longcd. All rights reserved.
//

#import "ShopTuanDetailsViewController.h"
#import "TwoSectionsCell.h"
#import "ShopForOrderViewController.h"
#import "ShopTuanWebViewController.h"
#import "TitleSectionsView.h"
#import "ShopForOrderViewController.h"
#import "MemberLoginViewController.h"
#import "AsyncImageView.h"
@implementation OneSectionsCell
@synthesize scroller;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
	self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
	if (self) {
		self.backgroundColor = [UIColor clearColor];
		
	}
	return self;
}

- (void) initWithPicUrl:(NSArray *) picUrls
{
//	AsyncImageView *imgView = [[AsyncImageView alloc]initWithFrame:CGRectMake(10, 0, 300, 200)];
//	imgView.defaultImage = 2;
//	imgView._cutImage = YES;
//	[imgView setUrlString:@""];
//	NSLog(@"%@ ",imgView.imageView.image);
//	[self addSubview:imgView];
	
	self.scroller=[[[CoustomScrollerView alloc] initWithFrameRect:CGRectMake(10, 0, 300, 200)
							   ImageArray:picUrls TitleArray:nil] autorelease];
	
	self.scroller.delegate=self;
	self.scroller.backgroundColor = [UIColor clearColor];
	[self addSubview:self.scroller];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
	[super setSelected:selected animated:animated];
}


-(void)CScrollerViewDidClicked:(NSUInteger)index
{
	NSLog(@"index--%d",index);
}


- (void) dealloc {
	self.scroller = nil;
	[super dealloc];
	
}

@end




@interface ShopTuanDetailsViewController ()
-(void) pushShopOrderVC;
@end

@implementation ShopTuanDetailsViewController

@synthesize h_tableView,groupdata,groupPurId;


- (void) dealloc {
	
	self.h_tableView = nil;
	
	self.groupdata = nil;
	self.groupPurId = nil;
	[super dealloc];
}


- (void)loadView{
	
	[super loadView];
	
	self.h_tableView = [[UITableView alloc] initWithFrame:CGRectMake(0.0f ,0.0f,ViewWidth,ViewHeight-44) style:UITableViewStylePlain];
	self.h_tableView.backgroundColor = [UIColor clearColor];
	self.h_tableView.dataSource = self;
	self.h_tableView.delegate = self;
	self.h_tableView.separatorStyle = UITableViewCellAccessoryNone;
	
	[self.view_IOS7 addSubview:self.h_tableView];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	
	// Do any additional setup after loading the view.
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	// Hard coded here for demo purpose
	return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	// Hard coded here for demo purpose
	
	if (section==1) {
		return 4;
	}
	return 1;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	if (indexPath.section == 0) {
		return 200.0f;
	}else{
		
		switch (indexPath.row) {
			case 0:
				return 140.0f;
				break;
			case 1:
				return [TSectionsTwoCell height:self.groupdata._detailInfo];
				break;
			case 2:
				return [TSectionsThreeCell height:self.groupdata._introduce];
				break;
			case 3:
				return 70;
				break;
			default:
				break;
		}
		
		
		
	}
	
	return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	if (indexPath.section == 0) {
		NSString *identifier = [NSString stringWithFormat:@"OneSectionCellIdentifier%d", indexPath.row];
		switch (indexPath.row) {
			case 0:
			{
				OneSectionsCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
				if (cell == nil) {
					cell = [[[OneSectionsCell alloc]  initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
					cell.selectionStyle = UITableViewCellSelectionStyleNone;
					cell.backgroundColor = [UIColor clearColor];
					[cell initWithPicUrl:self.groupdata._picUrls];
					
				}
				return cell;
			}
				break;
			
			default:
				break;
		}
		
	}else{
		
		NSString *identifier = [NSString stringWithFormat:@"TwoSectionCellIdentifier%d", indexPath.row];
		switch (indexPath.row) {
				
			case 0:
			{
				TSectionsOneCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
				if (cell == nil) {
					cell = [[[TSectionsOneCell alloc]  initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
					cell.selectionStyle = UITableViewCellSelectionStyleNone;
					cell.backgroundColor = [UIColor clearColor];
					
				}
				cell.title.text = self.groupdata._name;
				cell.simpleDesc.text = self.groupdata._content;
				if ([self.groupdata._isAnyTimeRefund boolValue]==NO){
					
					cell.anyTimeGView.hidden = YES;
				        cell.anyTimeRView.hidden = NO;
					cell.anyTimeL.text = @"不支持随时退";
					
				}else{
					cell.anyTimeGView.hidden = NO;
				        cell.anyTimeRView.hidden = YES;
					cell.anyTimeL.text = @"支持随时退";
					
				}
				
				if ([self.groupdata._isExpiryRefund boolValue]==NO){
					
					cell.expTimeGView.hidden = YES;
				        cell.expTimeRView.hidden = NO;
					cell.expTimeL.text = @"不支持过期退";
				}else{
					cell.expTimeGView.hidden = NO;
				        cell.expTimeRView.hidden = YES;
					cell.expTimeL.text = @"支持过期退";
					
				}
				cell.buyCount.text = [NSString stringWithFormat:@"%@人购买",self.groupdata._sellCount];
				cell.time.text = self.groupdata._time;
				
				return cell;
			}
				break;
				
			case 1:
			{
				TSectionsTwoCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
				if (cell == nil) {
					cell = [[[TSectionsTwoCell alloc]  initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
					cell.selectionStyle = UITableViewCellSelectionStyleNone;
					cell.backgroundColor = [UIColor clearColor];
					[cell initWithContent:self.groupdata._detailInfo];
				}
				
				return cell;
			}
				break;
				
			case 2:
			{
				TSectionsThreeCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
				if (cell == nil) {
					cell = [[[TSectionsThreeCell alloc]  initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
					cell.selectionStyle = UITableViewCellSelectionStyleNone;
					cell.backgroundColor = [UIColor clearColor];
					[cell initWithContent:self.groupdata._introduce];
				}
				
				return cell;
			}
				break;
				
			case 3:
			{
				TSectionsFourCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
				if (cell == nil) {
					cell = [[[TSectionsFourCell alloc]  initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
					cell.selectionStyle = UITableViewCellSelectionStyleNone;
					cell.backgroundColor = [UIColor clearColor];
					
				}
				
				return cell;
			}
				break;
				
			default:
				break;
		}

	}

	return nil;
	
}




- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
	
	if (section==1) {
		return 70;
	}
	return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
	
	TitleSectionsView * titleView  = [[[TitleSectionsView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 80)] autorelease];
	
	float price = [self.groupdata._price floatValue];
	float oldPrice = [self.groupdata._oldPrice floatValue];
	titleView.nprice.text = [NSString stringWithFormat:@"¥%.2f" ,price];
	titleView.oprice.text = [NSString stringWithFormat:@"%.2f" ,oldPrice];
	titleView.delegate = self;
	[titleView carState:[self.groupdata._state intValue]];
	[titleView setContentSize];
	return titleView;
}

- (void)carClick:(UIButton *)sender
{
	if (![UserLogin sharedUserInfo].userID)
	{
		MemberLoginViewController *memberLoginVC = [[MemberLoginViewController alloc] init];
		memberLoginVC.delegate = self;
		memberLoginVC._clickType = ShopForTuan;
		[self.navigationController pushViewController:memberLoginVC animated:YES];
		[memberLoginVC release];
		
	}else{
		[self pushShopOrderVC];
	
	}
	
}



-(void) loginSuccessFul:(ShopClickType)type
{
	if (type == ShopForTuan) {
		
		[self pushShopOrderVC];
	}
	
}

-(void) pushShopOrderVC
{
	ShopForOrderViewController *orderVC = [[ShopForOrderViewController alloc]init];
	orderVC._orderData = self.groupdata;
	orderVC._tuanId = self.groupPurId;
	[self.navigationController pushViewController:orderVC animated:YES];
	[orderVC release];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	if (indexPath.section==1) {
		if (indexPath.row==3) {
			ShopTuanWebViewController *tuanWebVC = [[ShopTuanWebViewController alloc]init];
			tuanWebVC.groupdata = self.groupdata;
			 [self.navigationController pushViewController:tuanWebVC animated:YES];
			[tuanWebVC release];
		}
	}
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
