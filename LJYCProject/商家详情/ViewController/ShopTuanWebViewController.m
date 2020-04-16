//
//  ShopTuanWebViewController.m
//  LJYCProject
//
//  Created by z1 on 14-3-11.
//  Copyright (c) 2014年 longcd. All rights reserved.
//

#import "ShopTuanWebViewController.h"
#import "TwoSectionsCell.h"
#import "TitleSectionsView.h"
#import "ShopForOrderViewController.h"
#import "MemberLoginViewController.h"
@interface ShopTuanWebViewController ()
-(void) pushShopOrderVC;
@end

@implementation ShopTuanWebViewController

@synthesize h_tableView;
@synthesize groupdata,groupPurId;

- (void) dealloc {
	
	self.h_tableView = nil;
	self.groupPurId = nil;
	self.groupdata = nil;
	[super dealloc];
}

- (void)loadView{
	
	[super loadView];
	self.title = @"更多详情";
	self.h_tableView = [[UITableView alloc] initWithFrame:CGRectMake(0.0f ,0.0f,ViewWidth,ViewHeight) style:UITableViewStylePlain];
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
	
	return 1;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	if (indexPath.section == 1) {
		
		switch (indexPath.row) {
			case 0:
				return ViewHeight- 80.0f;
				break;
				
			default:
				break;
		}
	}
	
	return  0.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	
	
	if (indexPath.section == 1) {
	
		NSString *identifier = [NSString stringWithFormat:@"TwoSectionCellIdentifier%d", indexPath.row];
		switch (indexPath.row) {
				
			case 0:
			{
				TwoSectionsCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
				if (cell == nil) {
					cell = [[[TwoSectionsCell alloc]  initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
					cell.selectionStyle = UITableViewCellSelectionStyleNone;
					cell.backgroundColor = [UIColor clearColor];
					
					
				}
				NSURL *rurl = [NSURL URLWithString:self.groupdata._detailUrl];
				NSURLRequest *request = [NSURLRequest requestWithURL:rurl];
				[cell.webView loadRequest:request];
				return cell;
			}
				break;
				
			
				
			default:
				break;
		}
		
	}else{
		static NSString * identifier =@"identifier";
		UITableViewCell * cell =[tableView dequeueReusableCellWithIdentifier:identifier];
		if (cell == nil) {
			cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
			cell.selectionStyle = UITableViewCellSelectionStyleNone;
			cell.backgroundColor = [UIColor clearColor];
		}
		return cell;
	}
	
	return nil;
	
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
	
	if (section==1) {
		return 70.0f;
	}
	return 0.0f;
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


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
