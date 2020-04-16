//
//  ActivetyShopListViewController.m
//  LJYCProject
//
//  Created by 张晓婷 on 15-4-21.
//  Copyright (c) 2015年 longcd. All rights reserved.
//

#import "ActivetyShopListViewController.h"
#import "ActivetyShopCell.h"
#import "ActivetyNearListViewController.h"

//@interface ActivetyShopListViewCell : UITableViewCell
//@property (nonatomic,retain) AsyncImageView * _imageV;
//@property (nonatomic,retain) UISubLabel * _nameLab;
//@property (nonatomic,retain) UISubLabel * _addressLab;
//
//@end
//
//@implementation ActivetyShopListViewCell
//@synthesize _imageV,_nameLab,_addressLab;
//- (void)dealloc
//{
//    self._imageV = nil;
//    self._nameLab = nil;
//    self._addressLab = nil;
//    
//    [super dealloc];
//}
//
//-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
//{
//    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
//        self.backgroundColor = [UIColor clearColor];
//
//        CGFloat height = 100;
//        
//        self._imageV = [[AsyncImageView alloc] initWithFrame:CGRectMake(0, 0, ViewWidth, height)];
//        self._imageV.defaultImage = 3;
//        
//        self._nameLab = [UISubLabel labelWithTitle:@"怀柔采摘园" frame:CGRectMake(10,height - 30,(ViewWidth - 20)/2,30) font:[UIFont systemFontOfSize:14] color:[UIColor whiteColor] alignment:NSTextAlignmentLeft autoSize:NO];
//        self._addressLab = [UISubLabel labelWithTitle:@"怀柔区怀柔镇军庄村北100米" frame:CGRectMake(10+(ViewWidth - 20)/2,height - 30,(ViewWidth - 20)/2,30) font:[UIFont systemFontOfSize:12] color:[UIColor whiteColor] alignment:NSTextAlignmentLeft autoSize:NO];
//
//        [self addSubview:self._imageV];
//        [self addSubview:self._nameLab];
//        [self addSubview:self._addressLab];
//        
//    }
//    return self;
//}
//
//@end

@interface ActivetyShopListViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,retain) Shops * _shop;
@end

@implementation ActivetyShopListViewController
@synthesize _activety;
@synthesize _shop;
- (void)dealloc
{
    self._activety = nil;
    self._shop = nil;
    [super dealloc];
}
-(void)loadView
{
    [super loadView];
    UITableView *aTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ViewWidth, ViewHeight-44) style:UITableViewStylePlain];

    aTableView.delegate = self;
    aTableView.dataSource = self;
    aTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [aTableView setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:aTableView];
    [aTableView release];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self._activety._title;
    // Do any additional setup after loading the view.
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row ==0) {
        return 30;
    }
    else if (indexPath.row == 1) {
        return 155;
    }
    return 105;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self._activety._shops count]+2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row ==0) {
        NSString *identifier1 = @"identifier1";
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier1];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier1];
            
            UILabel *titleLab = [UILabel labelWithTitle:@"辣郊游为您搜索周边商家" frame:CGRectMake(0, 0, ViewWidth, 30) font:FontSize24 color:FontColor767676 alignment:NSTextAlignmentCenter];
            UIButton *clickBtn = [UIButton buttonWithTag:0 frame:CGRectMake(0, 0, ViewWidth, 30) target:self action:@selector(showShopList:)];
            UIImageView *pointView = [UIImageView ImageViewWithFrame:CGRectMake(300, 11, 5, 8) image:[UIImage imageNamed:@"箭头-向右.png"]];
            
            [cell addSubview:titleLab];
            [cell addSubview:clickBtn];
            [cell addSubview:pointView];
        }
        return cell;
    }
    else if (indexPath.row == 1) {
        static NSString * identifier0 = @"identifier0";
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier0];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier0];
            AsyncImageView * imageV = [[AsyncImageView alloc] initWithFrame:CGRectMake(0, 0, ViewWidth, 150)];
            imageV.defaultImage = 4;
            [cell addSubview:imageV];
            [imageV release];
            imageV.urlString = self._activety._picUrl;

            [imageV addTarget:self action:@selector(showActivetyDetail:) forControlEvents:UIControlEventTouchUpInside];
        }
        return cell;
    }
    else
    {
        static NSString * identifier = @"identifier";
        ActivetyShopCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil) {
            cell = [[ActivetyShopCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            [cell._imageV addTarget:self action:@selector(showShopDetailDetail:) forControlEvents:UIControlEventTouchUpInside];
        }
        Shops * shop = [self._activety._shops objectAtIndex:indexPath.row-2];
        cell._imageV.tag = indexPath.row-2;
        cell._imageV.urlString = shop._picUrl;
        cell._nameLab.text = shop._name;
        cell._addressLab.text = shop._district;
        return cell;
    }
}

-(void)showShopDetailDetail:(AsyncImageView *)sender
{
    self._shop = [self._activety._shops objectAtIndex:sender.tag];

    ASIFormDataRequest * theRequest = [InterfaceClass getShopDetail:[UserLogin sharedUserInfo].userID withShopId:self._shop._id withLongitude:[UserLogin sharedUserInfo]._longitude withLatitude:[UserLogin sharedUserInfo]._latitude];
    [[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onPaseredShopDetailResult:) Delegate:self needUserType:Default];
}
- (void)onPaseredShopDetailResult:(NSDictionary *)dic
{
    if ([ShopForDataInfo setShopForDataInfo:dic]) {
        ShopForDetailsViewController *shopForDetailsVC = [[ShopForDetailsViewController alloc]init];
        shopForDetailsVC.shops = self._shop;
        shopForDetailsVC.shopListVC = nil;
        shopForDetailsVC._detailData = [ShopForDataInfo setShopForDataInfo:dic];
        [self.navigationController pushViewController:shopForDetailsVC animated:YES];
        [shopForDetailsVC release];
    }
}

-(void)showActivetyDetail:(AsyncImageView *)sender
{
    ASIFormDataRequest * theRequest = [InterfaceClass actives_detail:self._activety._activetyId];
    [[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onactives_detail:) Delegate:self needUserType:Default];
}

-(void) onactives_detail:(NSDictionary *) dic
{
    self._activety._url = [NSString stringWithFormat:@"%@",[dic objectForKey:@"activesUrl"]];
    ActivetyDetailViewController * detailVC = [[ActivetyDetailViewController alloc] init];
    detailVC._activety = self._activety;
    [self.navigationController pushViewController: detailVC animated:YES];
    [detailVC release];
}

- (void)showShopList:(id)sender
{
    ASIFormDataRequest * theRequest = [InterfaceClass actives_findShop:self._activety._activetyId distance:self._activety._distance longitude:self._activety._longitude latitude:self._activety._latitude];
    [[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onactives_List:) Delegate:self needUserType:Default];
}

- (void)onactives_List:(NSDictionary *)dic
{
    NSString *statusCode = [NSString stringWithFormat:@"%@", [dic objectForKey:@"statusCode"]];
    NSString *statusMessage = [NSString stringWithFormat:@"%@", [dic objectForKey:@"message"]];
    
    if (![statusCode isEqualToString:@"0"]) {
        [UIAlertView alertViewWithMessage:statusMessage];
        return;
    }
    
    ActivetyNearListViewController *nearListVC = [[ActivetyNearListViewController alloc] init];
    nearListVC._shopListData = [ActivetyItem getShopsArrayWithDic:dic];
    [self.navigationController pushViewController:nearListVC animated:YES];
    [nearListVC release];
}
@end
