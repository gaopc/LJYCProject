//
//  ActivetyNearListViewController.m
//  LJYCProject
//
//  Created by gaopengcheng on 15-6-16.
//  Copyright (c) 2015年 longcd. All rights reserved.
//

#import "ActivetyNearListViewController.h"
#import "ActivetyShopCell.h"
#import "ShopForDetailsViewController.h"

@interface ActivetyNearListViewController ()

@end

@implementation ActivetyNearListViewController
@synthesize _shopListData;

- (void)dealloc
{
    self._shopListData = nil;
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"周边商家";
    
    myTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ViewWidth, ViewHeight-44) style:UITableViewStylePlain];
    
    myTable.delegate = self;
    myTable.dataSource = self;
    myTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [myTable setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:myTable];
    [myTable release];
}

#pragma mark - UITableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 105;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self._shopListData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * identifier = @"identifier";
    ActivetyShopCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[ActivetyShopCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        [cell._imageV addTarget:self action:@selector(showShopDetailDetail:) forControlEvents:UIControlEventTouchUpInside];
    }
    Shops * shop = [self._shopListData objectAtIndex:indexPath.row];
    cell._imageV.tag = indexPath.row;
    cell._imageV.urlString = shop._picUrl;
    cell._nameLab.text = shop._name;
    cell._addressLab.text = shop._district;
    return cell;
}

- (void)showShopDetailDetail:(AsyncImageView *)sender
{
    Shops * shopData = [self._shopListData objectAtIndex:sender.tag];
    
    ASIFormDataRequest * theRequest = [InterfaceClass getShopDetail:[UserLogin sharedUserInfo].userID withShopId:shopData._id withLongitude:[UserLogin sharedUserInfo]._longitude withLatitude:[UserLogin sharedUserInfo]._latitude];
    [[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onPaseredShopDetailResult:) Delegate:self needUserType:Default];
}

- (void)onPaseredShopDetailResult:(NSDictionary *)dic
{
    NSString *statusCode = [NSString stringWithFormat:@"%@", [dic objectForKey:@"statusCode"]];
    NSString *statusMessage = [NSString stringWithFormat:@"%@", [dic objectForKey:@"message"]];
    
    if (![statusCode isEqualToString:@"0"]) {
        [UIAlertView alertViewWithMessage:statusMessage];
        return;
    }
    
    ShopForDetailsViewController *shopForDetailsVC = [[ShopForDetailsViewController alloc]init];
    shopForDetailsVC._detailData = [ShopForDataInfo setShopForDataInfo:dic];
    shopForDetailsVC._isSign = YES;
    [self.navigationController pushViewController:shopForDetailsVC animated:YES];
    [shopForDetailsVC release];
}
@end
