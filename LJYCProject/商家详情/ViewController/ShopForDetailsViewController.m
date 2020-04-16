//
//  ShopForDetailsViewController.m
//  LJYCProject
//
//  Created by gaopengcheng on 13-10-24.
//  Copyright (c) 2013年 longcd. All rights reserved.
//

#import "ShopForDetailsViewController.h"
#import "ShopForDetailsCell.h"
#import "ShopForErrorViewController.h"
#import "OtherForErrorViewController.h"
#import "ShopForSignInViewController.h"
#import "ShopForEvaluationViewController.h"
#import "ShopForShareViewController.h"
#import "ShopForQuestionViewController.h"
#import "ShopMapViewController.h"
#import "ShopForCommentViewController.h"
#import "ShopForAQListViewController.h"
#import "ShopCollectDataResponse.h"
#import "ShopFindViewController.h"
#import "ShopFindProperty.h"
#import "ShopFindDataResponse.h"
#import "UploadPhotoViewController.h"
#import "ShopForPhotoListViewController.h"
#import "DataClass.h"
#import "WeiboSDK.h"
#import "WeiXinExport.h"
#import <Social/Social.h>
#import "ShareToSinaViewController.h"
#import "MemberLoginViewController.h"
#import "ALAssetsLibrary+CustomPhotoAlbum.h"
#import "ShopTuanDetailsViewController.h"
#import "GroupPurDetailData.h"
#import "VoucherSaleViewController.h"

@interface ShopForDetailsViewController ()

- (void)loadShopListDataSource;
@end

@implementation ShopForDetailsViewController
@synthesize _detailData, shops,shopFindProperty,shopListVC;
@synthesize _isSign;
@synthesize library;
@synthesize _orderId;

- (void)dealloc
{
    self._orderId = nil;
	self.shops = nil;
	self._detailData = nil;
	self.shopFindProperty = nil;
	self.shopListVC = nil;
    
    [library release];
    self.library = nil;
	
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = self._detailData._name;
    isOrder = NO;
    if ([self._detailData._groupVouchers count] > 0) {
        isOrder = YES;
    }
    
    self.library = [[ALAssetsLibrary alloc] init];
    
    myTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 3, 320, ViewHeight-44-5-55) style:UITableViewStylePlain];
    myTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    myTable.backgroundColor = [UIColor clearColor];
    myTable.allowsSelection = YES;
    myTable.dataSource = self;
    myTable.delegate = self;
    [self.view_IOS7 addSubview:myTable];
    [myTable release];
    
    bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, ViewHeight- 44 - 55, 320, 55)];
    bottomView.backgroundColor = FontColorFFFFFF;
    
    UIButton *signBut = [UIButton buttonWithTag:0 frame:CGRectMake(30, 7, 40, 40) target:self action:@selector(share)];
    [signBut setImage:[UIImage imageNamed:@"签到-00.png"] forState:UIControlStateNormal];
    [signBut setImage:[UIImage imageNamed:@"签到-01.png"] forState:UIControlStateHighlighted];
    
    UIButton *uploadBut = [UIButton buttonWithTag:1 frame:CGRectMake(100, 7, 40, 40) target:self action:@selector(uploadClick)];
    [uploadBut setImage:[UIImage imageNamed:@"上传照片00.png"] forState:UIControlStateNormal];
    [uploadBut setImage:[UIImage imageNamed:@"上传照片01.png"] forState:UIControlStateHighlighted];
    
    UIButton *commentBut = [UIButton buttonWithTag:2 frame:CGRectMake(180, 7, 40, 40) target:self action:@selector(commentClick)];
    [commentBut setImage:[UIImage imageNamed:@"添加点评00.png"] forState:UIControlStateNormal];
    [commentBut setImage:[UIImage imageNamed:@"添加点评01.png"] forState:UIControlStateHighlighted];
    
    UIButton *errorBut = [UIButton buttonWithTag:3 frame:CGRectMake(250, 7, 40, 40) target:self action:@selector(errorClick)];
    [errorBut setImage:[UIImage imageNamed:@"报错-00.png"] forState:UIControlStateNormal];
    [errorBut setImage:[UIImage imageNamed:@"报错-01.png"] forState:UIControlStateHighlighted];
    
    [bottomView addSubview:signBut];
    [bottomView addSubview:uploadBut];
    [bottomView addSubview:commentBut];
    [bottomView addSubview:errorBut];
    [self.view_IOS7 addSubview:bottomView];
    [bottomView release];
    
    rightBut = [UIButton buttonWithTag:0 frame:CGRectMake(0, 0, 27, 24) target:self action:@selector(clickCollect)];
    
    if ([self._detailData._isCollect boolValue]) {
        [rightBut setImage:[UIImage imageNamed:@"收藏A.png"] forState:UIControlStateNormal];
    }
    else {
        [rightBut setImage:[UIImage imageNamed:@"收藏B.png"] forState:UIControlStateNormal];
    }
    
	UIBarButtonItem * rightBar = [[UIBarButtonItem alloc] initWithCustomView:rightBut];
    self.navigationItem.rightBarButtonItem = rightBar;
    [rightBar release];
    
    if ([self._detailData._state intValue] > 0) {
        
        self.navigationItem.rightBarButtonItem = nil;
        myTable.frame = CGRectMake(0, 3, 320, ViewHeight-44-5);
        bottomView.hidden = YES;
    }
	
	if (!self.shopFindProperty) {
		
		self.shopFindProperty = [[ShopFindProperty alloc] init];
		self.shopFindProperty._type =@"";
		self.shopFindProperty._orderBy =@"0";
		self.shopFindProperty._serviceTagId = @"";
		self.shopFindProperty._distance = @"0";
		self.shopFindProperty._latitude = @"";
		self.shopFindProperty._longitude = @"";
		self.shopFindProperty._pageIndex = @"1";
		self.shopFindProperty._keyword = @"";
		//self.shopFindProperty._telephone = @"";
		self.shopFindProperty._filter = @"0";
		self.shopFindProperty._cityId = @"";
		self.shopFindProperty._districtId = @"";
	}
    introSize = [self._detailData._introduce sizeWithFont:FontSize24 constrainedToSize:CGSizeMake(220, 1000) lineBreakMode:NSLineBreakByWordWrapping];
    serviceSize = [self._detailData._allService sizeWithFont:FontSize24 constrainedToSize:CGSizeMake(220, 1000) lineBreakMode:NSLineBreakByWordWrapping];
    
    [self loadCommentData];
}

#pragma mark - Table view dataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    int sectionCount = 6;
    
    if (self._isSign) {                             //是否店铺列表进入
        sectionCount --;
    }
    
    if (![self._detailData._isClaim boolValue]) {   //是否已认领
        sectionCount --;
    }
    
    if (!isOrder) {                                 //是否有代金券
        sectionCount --;
    }
    
    return sectionCount;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (![self._detailData._isClaim boolValue]) {           //店铺未认领
        switch (section) {
            case 0:
                return 1;
                break;
            case 1:
                return 6;
                break;
            case 2:
            {
                if ([commentData._count intValue] == 0) {
                    return 1;
                }
                else
                {
                    return 2;
                }
                break;
            }
            case 3:
                return 1;
                break;
        }
    }
    else {
        
        NSInteger sectionAdd = 0;                     //存在代金券时 sectionAdd 加1
        if (isOrder) {
            sectionAdd = 1;
        }
        
        if (section == 0) {
            return 1;
        }
        else if (section == sectionAdd + 1) {
            return 6;
        }
        else if (section == sectionAdd + 2) {
            
            if ([commentData._count intValue] == 0) {
                return 1;
            }
            else {
                return 2;
            }
        }
        else if (section == sectionAdd + 3) {
            
            if ([questData._count intValue] == 0) {
                return 1;
            }
            else {
                return 2;
            }
        }
        else if (section == sectionAdd + 4) {
            return 1;
        }
        else if (sectionAdd == 1) {
            if (!isOpen) {
                return 2;
            }
            else {
                return [self._detailData._groupVouchers count] + 1;
            }
        }
    }
    
    
//    if (isOrder) {
//        switch (section) {
//            case 0:
//                return 8;
//                break;
//            case 1:
//                return [self._detailData._groupVouchers count];
//                break;
//            case 2:
//            {
//                if ([commentData._count intValue] == 0) {
//                    return 1;
//                }
//                else
//                {
//                    return 2;
//                }
//                break;
//            }
//            case 3:
//            {
//                if (![self._detailData._isClaim boolValue]) {
//                    return 1;
//                }
//                if ([questData._count intValue] == 0) {
//                    return 1;
//                }
//                else {
//                    return 2;
//                }
//                break;
//            }
//            case 4:
//                return 1;
//                break;
//        }
//    }
//    else {
//            switch (section) {
//                case 0:
//                    return 8;
//                    break;
//                case 1:
//                {
//                    if ([commentData._count intValue] == 0) {
//                        return 1;
//                    }
//                    else
//                    {
//                        return 2;
//                    }
//                    break;
//                }
//                case 2:
//                {
//                    if (![self._detailData._isClaim boolValue]) {
//                        return 1;
//                    }
//                    if ([questData._count intValue] == 0) {
//                        return 1;
//                    }
//                    else {
//                        return 2;
//                    }
//                    break;
//                }
//                case 3:
//                    return 1;
//                    break;
//            }
//    }
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (![self._detailData._isClaim boolValue]) {           //店铺未认领
        switch (indexPath.section) {
            case 0:
            {
                return 130;
                break;
            }
            case 1:
            {
                if (indexPath.row == 0) {
                    return 32;
                }
                else if (indexPath.row == 1) {
                    return 32;
                }
                else if (indexPath.row == 2) {
                    return serviceSize.height + 17 < 32 ? 32 : serviceSize.height + 17;
                }
                else if (indexPath.row == 3) {
                    return 32;
                }
                else if (indexPath.row == 4) {
                    return 32;
                }
                else if (indexPath.row == 5) {
                    
                    if (isMoreRow) {
                        return introSize.height + 17;
                    }
                    return 47;
                }
                else {
                    return 32;
                }
                break;
            }
            case 2:
            {
                if (indexPath.row == 0) {
                    return 30;
                }
                else if (indexPath.row == 1) {
                    return 80;
                }
                break;
            }
            case 3:
            {
                return 55;
                break;
            }
        }
    }
    else {
        
        NSInteger sectionAdd = 0;                     //存在代金券时 sectionAdd 加1
        if (isOrder) {
            sectionAdd = 1;
        }
        
        if (indexPath.section == 0) {
            return 130;
        }
        else if (indexPath.section == sectionAdd + 1) {
            
            if (indexPath.row == 0) {
                return 32;
            }
            else if (indexPath.row == 1) {
                return 32;
            }
            else if (indexPath.row == 2) {
                return serviceSize.height + 17 < 32 ? 32 : serviceSize.height + 17;
            }
            else if (indexPath.row == 3) {
                return 32;
            }
            else if (indexPath.row == 4) {
                return 32;
            }
            else if (indexPath.row == 5) {
                
                if (isMoreRow) {
                    return introSize.height + 17;
                }
                return 47;
            }
            else {
                return 32;
            }
        }
        else if (indexPath.section == sectionAdd + 2) {
            if (indexPath.row == 0) {
                return 30;
            }
            else if (indexPath.row == 1) {
                return 80;
            }
        }
        else if (indexPath.section == sectionAdd + 3) {
            if (indexPath.row == 0) {
                return 30;
            }
            else if (indexPath.row == 1) {
                return 80;
            }
        }
        else if (indexPath.section == sectionAdd + 4) {
            return 55;
        }
        else if (indexPath.section == 1) {
            return 50;
        }
    }
    
    
//    if (isOrder) {
//        switch (indexPath.section) {
//            case 0:
//            {
//                if (indexPath.row == 0) {
//                    return 130;
//                }
//                else if (indexPath.row == 1) {
//                    return 52;
//                }
//                else if (indexPath.row == 2) {
//                    return 32;
//                }
//                else if (indexPath.row == 3) {
//                    return 32;
//                }
//                else if (indexPath.row == 4) {
//                    return serviceSize.height + 17 < 32 ? 32 : serviceSize.height + 17;
//                }
//                else if (indexPath.row == 5) {
//                    return 32;
//                }
//                else if (indexPath.row == 6) {
//                    return 32;
//                }
//                else if (indexPath.row == 7) {
//                    
//                    if (isMoreRow) {
//                        return introSize.height + 17;
//                    }
//                    return 47;
//                }
//                else if (indexPath.row == 8) {
//                    return 32;
//                }
//                
//                break;
//            }
//            case 1:
//            {
//                return 50;
//                break;
//            }
//            case 2:
//            {
//                if (indexPath.row == 0) {
//                    return 30;
//                }
//                else if (indexPath.row == 1) {
//                    return 80;
//                }
//                
//                break;
//            }
//            case 3:
//            {
//                if (![self._detailData._isClaim boolValue]) {
//                    return 55;
//                }
//                if (indexPath.row == 0) {
//                    return 30;
//                }
//                else if (indexPath.row == 1) {
//                    return 52;
//                }
//                
//                break;
//            }
//            case 4:
//            {
//                return 55;
//                break;
//            }
//        }
//        
//    }
//    else {
//
//            switch (indexPath.section) {
//                case 0:
//                {
//                    if (indexPath.row == 0) {
//                        return 130;
//                    }
//                    else if (indexPath.row == 1) {
//                        return 52;
//                    }
//                    else if (indexPath.row == 2) {
//                        return 32;
//                    }
//                    else if (indexPath.row == 3) {
//                        return 32;
//                    }
//                    else if (indexPath.row == 4) {
//                        return serviceSize.height + 17 < 32 ? 32 : serviceSize.height + 17;
//                    }
//                    else if (indexPath.row == 5) {
//                        return 32;
//                    }
//                    else if (indexPath.row == 6) {
//                        return 32;
//                    }
//                    else if (indexPath.row == 7) {
//                        
//                        if (isMoreRow) {
//                            return introSize.height + 17;
//                        }
//                        return 47;
//                    }
//                    else if (indexPath.row == 8) {
//                        return 32;
//                    }
//
//                    break;
//                }
//                case 1:
//                {
//                    if (indexPath.row == 0) {
//                        return 30;
//                    }
//                    else if (indexPath.row == 1) {
//                        return 80;
//                    }
//
//                    break;
//                }
//                case 2:
//                {
//                    if (![self._detailData._isClaim boolValue]) {
//                        return 55;
//                    }
//                    if (indexPath.row == 0) {
//                        return 30;
//                    }
//                    else if (indexPath.row == 1) {
//                        return 52;
//                    }
//
//                    break;
//                }
//                case 3:
//                {
//                    return 55;
//                    break;
//                }
//            }
//    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * identifier = [NSString stringWithFormat:@"identifier11%d%d", indexPath.row, indexPath.section];
    
    ShopForCommentInfo *commentInfo = nil;
    ShopForQuestionInfo *questionInfo = nil;
    if ([commentData._commentArr count] > 0) {
        commentInfo = [commentData._commentArr objectAtIndex:0];
    }
    if ([questData._questionArr count] > 0) {
        questionInfo = [questData._questionArr objectAtIndex:0];
    }
    
    
    
    if (![self._detailData._isClaim boolValue]) {
        if (indexPath.section == 0) {
            ShopForDetailsCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
            if (cell == nil)
            {
                cell = [[[ShopForDetailsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.backgroundColor = [UIColor clearColor];
                
                [cell._shopImageBut addTarget:self action:@selector(clickImage) forControlEvents:UIControlEventTouchUpInside];
                [cell._submibBut addTarget:self action:@selector(clickPhone) forControlEvents:UIControlEventTouchUpInside];
                
            }
            if (![self._detailData._isClaim boolValue]) {
                cell._certificationView.hidden = YES;
            }
            else {
                cell._certificationView.hidden = NO;
            }
            
            if ([self._detailData._state intValue] == 1) {
                cell._shopStateView.image = [UIImage imageNamed:@"停业.png"];
            }
            else if ([self._detailData._state intValue] == 2) {
                cell._shopStateView.image = [UIImage imageNamed:@"休业.png"];
            }
            [cell setStar:[self._detailData._star floatValue]];
            cell._titleLab.text = self._detailData._district;
            
            if ([self._detailData._distance isEqualToString:@"0m"]) {
                cell._distanceLab.hidden = YES;
            }else{
                cell._distanceLab.hidden = NO;
            }
            cell._distanceLab.text = self._detailData._distance;
            
            if ([self._detailData._picUrl length] > 10) {
                [cell._shopImageView setUrlString:self._detailData._picUrl];
            }
            return cell;
        }
        else if (indexPath.section == 1) {
            if (indexPath.row == 0) {
                
                ShopForAddressCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
                if (cell == nil)
                {
                    cell = [[[ShopForAddressCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    cell.backgroundColor = [UIColor clearColor];
                }
                cell._addressLab.text = self._detailData._address;
                return cell;
            }
            else if (indexPath.row == 1) {
                
                ShopForTypeCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
                if (cell == nil)
                {
                    cell = [[[ShopForTypeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    cell.backgroundColor = [UIColor clearColor];
                }
                cell._shopTypeLab.text = self._detailData._type;
                return cell;
            }
            else if (indexPath.row == 2) {
                
                ShopForServiceCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
                if (cell == nil)
                {
                    cell = [[[ShopForServiceCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    cell.backgroundColor = [UIColor clearColor];
                    
                }
                CGRect serFrame = cell._serviceLab.frame;
                serFrame.size.height = serviceSize.height;
                cell._serviceLab.frame = serFrame;
                
                CGRect backFrame = cell._backView.frame;
                backFrame.size.height = serviceSize.height + 15 < 30 ? 30 : serviceSize.height + 15;
                cell._backView.frame = backFrame;
                
                cell._serviceLab.text = self._detailData._allService;
                return cell;
            }
            else if (indexPath.row == 3) {
                
                ShopForScaleCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
                if (cell == nil)
                {
                    cell = [[[ShopForScaleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    cell.backgroundColor = [UIColor clearColor];
                }
                cell._scaleLab.text = self._detailData._scale;
                return cell;
            }
            else if (indexPath.row == 4) {
                
                ShopForDateCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
                if (cell == nil)
                {
                    cell = [[[ShopForDateCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    cell.backgroundColor = [UIColor clearColor];
                }
                
                if ([self._detailData._cycleStart intValue] == [self._detailData._cycleEnd intValue]) {
                    cell._dateLab.text = [NSString stringWithFormat:@"%@月份", self._detailData._cycleStart];
                }
                else if ([self._detailData._cycleStart intValue] > [self._detailData._cycleEnd intValue]) {
                    cell._dateLab.text = [NSString stringWithFormat:@"%@月至次年%@月", self._detailData._cycleStart, self._detailData._cycleEnd];
                }
                else {
                    cell._dateLab.text = self._detailData._cycle;
                }
                return cell;
            }
            else if (indexPath.row == 5) {
                
                ShopForIntroduceCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
                if (cell == nil)
                {
                    cell = [[[ShopForIntroduceCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    cell.backgroundColor = [UIColor clearColor];
                }
                cell._introduceLab.text = self._detailData._introduce;
                
                if (isMoreRow) {
                    
                    CGRect labFrame = cell._introduceLab.frame;
                    labFrame.size.height = introSize.height;
                    cell._introduceLab.frame = labFrame;
                    
                    CGRect backFrame = cell._backView.frame;
                    backFrame.size.height = introSize.height + 15;
                    cell._backView.frame = backFrame;
                }
                else {
                    CGRect labFrame = cell._introduceLab.frame;
                    labFrame.size.height = introSize.height >= 30 ? 30 : introSize.height;
                    cell._introduceLab.frame = labFrame;
                }
                return cell;
            }
            else if (indexPath.row == 6) {
                
                ShopForNoticeCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
                if (cell == nil)
                {
                    cell = [[[ShopForNoticeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    cell.backgroundColor = [UIColor clearColor];
                    
                }
                cell._noticeLab.text = self._detailData._notice;
                return cell;
            }
        }
        else if (indexPath.section == 2) {
            if (indexPath.row == 0) {
                
                ShopForEvaluationCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
                if (cell == nil)
                {
                    cell = [[[ShopForEvaluationCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    cell.backgroundColor = [UIColor clearColor];
                }
                cell._numLab.text = [NSString stringWithFormat:@"共%@条", commentData._count];
                return cell;
            }
            else if (indexPath.row == 1) {
                
                ShopForEvaluationInfoCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
                if (cell == nil)
                {
                    cell = [[[ShopForEvaluationInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    cell.backgroundColor = [UIColor clearColor];
                }
                
                [cell setHeartCount:[commentInfo._comLevel intValue]];
                [cell setStar:[commentInfo._comStar floatValue]];
                cell._nameLab.text = commentInfo._comName;
                cell._detailLab.text = commentInfo._comContent;
                cell._dateLab.text = commentInfo._comTime;
                
                return cell;
            }
        }
        else if (indexPath.section == 3) {
            ShopForRecommendCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
            if (cell == nil)
            {
                cell = [[[ShopForRecommendCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.backgroundColor = [UIColor clearColor];
                [cell._but1 addTarget:self action:@selector(clickType:) forControlEvents:UIControlEventTouchUpInside];
                [cell._but2 addTarget:self action:@selector(clickType:) forControlEvents:UIControlEventTouchUpInside];
                [cell._but3 addTarget:self action:@selector(clickType:) forControlEvents:UIControlEventTouchUpInside];
                [cell._but4 addTarget:self action:@selector(clickType:) forControlEvents:UIControlEventTouchUpInside];
            }
            return cell;
        }
    }
    else {
        
        NSInteger sectionAdd = 0;                     //存在代金券时 sectionAdd 加1
        if (isOrder) {
            sectionAdd = 1;
        }
        
        if (indexPath.section == 0) {
            ShopForDetailsCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
            if (cell == nil)
            {
                cell = [[[ShopForDetailsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.backgroundColor = [UIColor clearColor];
                
                [cell._shopImageBut addTarget:self action:@selector(clickImage) forControlEvents:UIControlEventTouchUpInside];
                [cell._submibBut addTarget:self action:@selector(clickPhone) forControlEvents:UIControlEventTouchUpInside];
                
            }
            if (![self._detailData._isClaim boolValue]) {
                cell._certificationView.hidden = YES;
            }
            else {
                cell._certificationView.hidden = NO;
            }
            
            if ([self._detailData._state intValue] == 1) {
                cell._shopStateView.image = [UIImage imageNamed:@"停业.png"];
            }
            else if ([self._detailData._state intValue] == 2) {
                cell._shopStateView.image = [UIImage imageNamed:@"休业.png"];
            }
            [cell setStar:[self._detailData._star floatValue]];
            cell._titleLab.text = self._detailData._district;
            
            if ([self._detailData._distance isEqualToString:@"0m"]) {
                cell._distanceLab.hidden = YES;
            }else{
                cell._distanceLab.hidden = NO;
            }
            cell._distanceLab.text = self._detailData._distance;
            
            if ([self._detailData._picUrl length] > 10) {
                [cell._shopImageView setUrlString:self._detailData._picUrl];
            }
            return cell;
        }
        else if (indexPath.section == sectionAdd + 1) {
            if (indexPath.row == 0) {
                
                ShopForAddressCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
                if (cell == nil)
                {
                    cell = [[[ShopForAddressCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    cell.backgroundColor = [UIColor clearColor];
                }
                cell._addressLab.text = self._detailData._address;
                return cell;
            }
            else if (indexPath.row == 1) {
                
                ShopForTypeCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
                if (cell == nil)
                {
                    cell = [[[ShopForTypeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    cell.backgroundColor = [UIColor clearColor];
                }
                cell._shopTypeLab.text = self._detailData._type;
                return cell;
            }
            else if (indexPath.row == 2) {
                
                ShopForServiceCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
                if (cell == nil)
                {
                    cell = [[[ShopForServiceCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    cell.backgroundColor = [UIColor clearColor];
                    
                }
                CGRect serFrame = cell._serviceLab.frame;
                serFrame.size.height = serviceSize.height;
                cell._serviceLab.frame = serFrame;
                
                CGRect backFrame = cell._backView.frame;
                backFrame.size.height = serviceSize.height + 15 < 30 ? 30 : serviceSize.height + 15;
                cell._backView.frame = backFrame;
                
                cell._serviceLab.text = self._detailData._allService;
                return cell;
            }
            else if (indexPath.row == 3) {
                
                ShopForScaleCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
                if (cell == nil)
                {
                    cell = [[[ShopForScaleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    cell.backgroundColor = [UIColor clearColor];
                }
                cell._scaleLab.text = self._detailData._scale;
                return cell;
            }
            else if (indexPath.row == 4) {
                
                ShopForDateCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
                if (cell == nil)
                {
                    cell = [[[ShopForDateCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    cell.backgroundColor = [UIColor clearColor];
                }
                
                if ([self._detailData._cycleStart intValue] == [self._detailData._cycleEnd intValue]) {
                    cell._dateLab.text = [NSString stringWithFormat:@"%@月份", self._detailData._cycleStart];
                }
                else if ([self._detailData._cycleStart intValue] > [self._detailData._cycleEnd intValue]) {
                    cell._dateLab.text = [NSString stringWithFormat:@"%@月至次年%@月", self._detailData._cycleStart, self._detailData._cycleEnd];
                }
                else {
                    cell._dateLab.text = self._detailData._cycle;
                }
                return cell;
            }
            else if (indexPath.row == 5) {
                
                ShopForIntroduceCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
                if (cell == nil)
                {
                    cell = [[[ShopForIntroduceCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    cell.backgroundColor = [UIColor clearColor];
                }
                cell._introduceLab.text = self._detailData._introduce;
                
                if (isMoreRow) {
                    
                    CGRect labFrame = cell._introduceLab.frame;
                    labFrame.size.height = introSize.height;
                    cell._introduceLab.frame = labFrame;
                    
                    CGRect backFrame = cell._backView.frame;
                    backFrame.size.height = introSize.height + 15;
                    cell._backView.frame = backFrame;
                }
                else {
                    CGRect labFrame = cell._introduceLab.frame;
                    labFrame.size.height = introSize.height >= 30 ? 30 : introSize.height;
                    cell._introduceLab.frame = labFrame;
                }
                return cell;
            }
            else if (indexPath.row == 6) {
                
                ShopForNoticeCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
                if (cell == nil)
                {
                    cell = [[[ShopForNoticeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    cell.backgroundColor = [UIColor clearColor];
                    
                }
                cell._noticeLab.text = self._detailData._notice;
                return cell;
            }
        }
        else if (indexPath.section == sectionAdd + 2) {
            if (indexPath.row == 0) {
                
                ShopForEvaluationCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
                if (cell == nil)
                {
                    cell = [[[ShopForEvaluationCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    cell.backgroundColor = [UIColor clearColor];
                }
                cell._numLab.text = [NSString stringWithFormat:@"共%@条", commentData._count];
                return cell;
            }
            else if (indexPath.row == 1) {
                
                ShopForEvaluationInfoCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
                if (cell == nil)
                {
                    cell = [[[ShopForEvaluationInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    cell.backgroundColor = [UIColor clearColor];
                }
                
                [cell setHeartCount:[commentInfo._comLevel intValue]];
                [cell setStar:[commentInfo._comStar floatValue]];
                cell._nameLab.text = commentInfo._comName;
                cell._detailLab.text = commentInfo._comContent;
                cell._dateLab.text = commentInfo._comTime;
                
                return cell;
            }
        }
        else if (indexPath.section == sectionAdd + 3) {
            
            ShopForQuestionCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
            if (cell == nil)
            {
                cell = [[[ShopForQuestionCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.backgroundColor = [UIColor clearColor];
                
                [cell._questBut addTarget:self action:@selector(clickQuest) forControlEvents:UIControlEventTouchUpInside];
                
                if ([self._detailData._state intValue] > 0) {
                    cell._questBut.hidden = YES;
                }
            }
            cell._numLab.text = [NSString stringWithFormat:@"共%@条", questData._count];
            return cell;
        }
        else if (indexPath.section == sectionAdd + 4) {
            
            ShopForRecommendCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
            if (cell == nil)
            {
                cell = [[[ShopForRecommendCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.backgroundColor = [UIColor clearColor];
                [cell._but1 addTarget:self action:@selector(clickType:) forControlEvents:UIControlEventTouchUpInside];
                [cell._but2 addTarget:self action:@selector(clickType:) forControlEvents:UIControlEventTouchUpInside];
                [cell._but3 addTarget:self action:@selector(clickType:) forControlEvents:UIControlEventTouchUpInside];
                [cell._but4 addTarget:self action:@selector(clickType:) forControlEvents:UIControlEventTouchUpInside];
            }
            return cell;
        }
        else if (indexPath.section == 1) {
            
            if ((indexPath.row == [self._detailData._groupVouchers count] && isOpen) || (!isOpen && indexPath.row == 1)) {
                identifier = @"identifierMore";
                UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
                if (cell == nil)
                {
                    cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    cell.backgroundColor = [UIColor clearColor];
                    
                    UIImageView *cellBack = [UIImageView ImageViewWithFrame:CGRectMake(13, 0, ViewWidth - 26, 49) image:[[UIImage imageNamed:@"白条.png"] stretchableImageWithLeftCapWidth:5 topCapHeight:5]];
                    UILabel *cellLab = [UILabel labelWithTitle:@"更多代金券" frame:CGRectMake(0, 0, ViewWidth, 50) font:FontSize20 color:FontColor454545 alignment:NSTextAlignmentCenter];
                    cellLab.tag = 5;
                    [cell addSubview:cellBack];
                    [cell addSubview:cellLab];
                }
                return cell;
            }
            else {
                identifier = @"identifierList";
                ShopForOnlineCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
                if (cell == nil)
                {
                    cell = [[[ShopForOnlineCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    cell.backgroundColor = [UIColor clearColor];
                    
                    [cell._enterBut addTarget:self action:@selector(enter:) forControlEvents:UIControlEventTouchUpInside];
                }
                cell._enterBut.tag = indexPath.row;
                if (indexPath.row != 0) {
                    cell._iconView.hidden = YES;
                }
                
                VoucherInfo *info = [self._detailData._groupVouchers objectAtIndex:indexPath.row];
                cell._contentLab.text = [NSString stringWithFormat:@"%@元代金券", info._thePrice];
                cell._subContentLab.text = info._note;
                cell._priceLab.text = info._price;
                return cell;
            }
        }
    }
    
    
    
    
    
//    if (indexPath.section == 0) {
//        
//        if (indexPath.row == 0) {
//            ShopForDetailsCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
//            if (cell == nil)
//            {
//                cell = [[[ShopForDetailsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
//                cell.selectionStyle = UITableViewCellSelectionStyleNone;
//                cell.backgroundColor = [UIColor clearColor];
//                
//                [cell._shopImageBut addTarget:self action:@selector(clickImage) forControlEvents:UIControlEventTouchUpInside];
//                [cell._submibBut addTarget:self action:@selector(clickPhone) forControlEvents:UIControlEventTouchUpInside];
//                
//            }
//            if (![self._detailData._isClaim boolValue]) {
//                cell._certificationView.hidden = YES;
//            }
//            else {
//                cell._certificationView.hidden = NO;
//            }
//            
//            if ([self._detailData._state intValue] == 1) {
//                cell._shopStateView.image = [UIImage imageNamed:@"停业.png"];
//            }
//            else if ([self._detailData._state intValue] == 2) {
//                cell._shopStateView.image = [UIImage imageNamed:@"休业.png"];
//            }
//            [cell setStar:[self._detailData._star floatValue]];
//            cell._titleLab.text = self._detailData._district;
//            
//            if ([self._detailData._distance isEqualToString:@"0m"]) {
//				cell._distanceLab.hidden = YES;
//			}else{
//				cell._distanceLab.hidden = NO;
//			}
//            cell._distanceLab.text = self._detailData._distance;
//            
//            if ([self._detailData._picUrl length] > 10) {
//                [cell._shopImageView setUrlString:self._detailData._picUrl];
//            }
//            return cell;
//        }
//        else if (indexPath.row == 1) {
//            
//            ShopForButtonsCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
//            if (cell == nil)
//            {
//                cell = [[[ShopForButtonsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
//                cell.selectionStyle = UITableViewCellSelectionStyleNone;
//                cell.backgroundColor = [UIColor clearColor];
//                
//                [cell._signInBut addTarget:self action:@selector(clickSign) forControlEvents:UIControlEventTouchUpInside];
//                [cell._collectionBut addTarget:self action:@selector(clickCollect) forControlEvents:UIControlEventTouchUpInside];
//                [cell._telphoneBut addTarget:self action:@selector(clickPhone) forControlEvents:UIControlEventTouchUpInside];
//            }
//            
//            if ([self._detailData._isCollect boolValue]) {
//                [cell._collectionBut setTitle:@"已收藏" forState:UIControlStateNormal];
//            }
//            cell._signNumLab.text = self._detailData._signInCount;
//            cell._collectNumLab.text = self._detailData._collectCount;
//            return cell;
//        }
//        else if (indexPath.row == 2) {
//            
//            ShopForAddressCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
//            if (cell == nil)
//            {
//                cell = [[[ShopForAddressCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
//                cell.selectionStyle = UITableViewCellSelectionStyleNone;
//                cell.backgroundColor = [UIColor clearColor];
//            }
//            cell._addressLab.text = self._detailData._address;
//            return cell;
//        }
//        else if (indexPath.row == 3) {
//            
//            ShopForTypeCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
//            if (cell == nil)
//            {
//                cell = [[[ShopForTypeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
//                cell.selectionStyle = UITableViewCellSelectionStyleNone;
//                cell.backgroundColor = [UIColor clearColor];
//            }
//            cell._shopTypeLab.text = self._detailData._type;
//            return cell;
//        }
//        else if (indexPath.row == 4) {
//            
//            ShopForServiceCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
//            if (cell == nil)
//            {
//                cell = [[[ShopForServiceCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
//                cell.selectionStyle = UITableViewCellSelectionStyleNone;
//                cell.backgroundColor = [UIColor clearColor];
//                
//            }
//            CGRect serFrame = cell._serviceLab.frame;
//            serFrame.size.height = serviceSize.height;
//            cell._serviceLab.frame = serFrame;
//            
//            CGRect backFrame = cell._backView.frame;
//            backFrame.size.height = serviceSize.height + 15 < 30 ? 30 : serviceSize.height + 15;
//            cell._backView.frame = backFrame;
//            
//            cell._serviceLab.text = self._detailData._allService;
//            return cell;
//        }
//        else if (indexPath.row == 5) {
//            
//            ShopForScaleCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
//            if (cell == nil)
//            {
//                cell = [[[ShopForScaleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
//                cell.selectionStyle = UITableViewCellSelectionStyleNone;
//                cell.backgroundColor = [UIColor clearColor];
//            }
//            cell._scaleLab.text = self._detailData._scale;
//            return cell;
//        }
//        else if (indexPath.row == 6) {
//            
//            ShopForDateCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
//            if (cell == nil)
//            {
//                cell = [[[ShopForDateCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
//                cell.selectionStyle = UITableViewCellSelectionStyleNone;
//                cell.backgroundColor = [UIColor clearColor];
//            }
//            
//            if ([self._detailData._cycleStart intValue] == [self._detailData._cycleEnd intValue]) {
//                cell._dateLab.text = [NSString stringWithFormat:@"%@月份", self._detailData._cycleStart];
//            }
//            else if ([self._detailData._cycleStart intValue] > [self._detailData._cycleEnd intValue]) {
//                cell._dateLab.text = [NSString stringWithFormat:@"%@月至次年%@月", self._detailData._cycleStart, self._detailData._cycleEnd];
//            }
//            else {
//                cell._dateLab.text = self._detailData._cycle;
//            }
//            return cell;
//        }
//        else if (indexPath.row == 7) {
//            
//            ShopForIntroduceCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
//            if (cell == nil)
//            {
//                cell = [[[ShopForIntroduceCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
//                cell.selectionStyle = UITableViewCellSelectionStyleNone;
//                cell.backgroundColor = [UIColor clearColor];
//            }
//            cell._introduceLab.text = self._detailData._introduce;
//            
//            if (isMoreRow) {
//                
//                CGRect labFrame = cell._introduceLab.frame;
//                labFrame.size.height = introSize.height;
//                cell._introduceLab.frame = labFrame;
//                
//                CGRect backFrame = cell._backView.frame;
//                backFrame.size.height = introSize.height + 15;
//                cell._backView.frame = backFrame;
//            }
//            else {
//                CGRect labFrame = cell._introduceLab.frame;
//                labFrame.size.height = introSize.height >= 30 ? 30 : introSize.height;
//                cell._introduceLab.frame = labFrame;
//            }
//            return cell;
//        }
//        else if (indexPath.row == 8) {
//            
//            ShopForNoticeCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
//            if (cell == nil)
//            {
//                cell = [[[ShopForNoticeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
//                cell.selectionStyle = UITableViewCellSelectionStyleNone;
//                cell.backgroundColor = [UIColor clearColor];
//                
//            }
//            cell._noticeLab.text = self._detailData._notice;
//            return cell;
//        }
//    }
//    else if (indexPath.section == 1 && isOrder) {
//        
//        ShopForOnlineCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
//        if (cell == nil)
//        {
//            cell = [[[ShopForOnlineCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
//            cell.selectionStyle = UITableViewCellSelectionStyleNone;
//            cell.backgroundColor = [UIColor clearColor];
//            
//            [cell._enterBut addTarget:self action:@selector(enter:) forControlEvents:UIControlEventTouchUpInside];
//        }
//         cell._enterBut.tag = indexPath.row;
//        if (indexPath.row != 0) {
//            cell._iconView.hidden = YES;
//        }
//        
//        VoucherInfo *info = [self._detailData._groupVouchers objectAtIndex:indexPath.row];
//        cell._contentLab.text = [NSString stringWithFormat:@"%@元代金券", info._thePrice];
//        cell._subContentLab.text = info._note;
//        cell._priceLab.text = info._price;
//        
////        ShopForTuanInfo *tuanData = [self._detailData._groupPurs objectAtIndex:indexPath.row];
////
////        NSString *priceStr = [NSString stringWithFormat:@"¥ %@", tuanData._tuanPrice];
////        CGSize priceSize = [priceStr sizeWithFont:FontSize24 constrainedToSize:CGSizeMake(320, 100) lineBreakMode:NSLineBreakByWordWrapping];
////        
////        CGRect contentFrame = cell._contentLab.frame;
////        contentFrame.origin.x = priceSize.width + cell._priceLab.frame.origin.x + 10;
////        contentFrame.size.width = 270 - contentFrame.origin.x;
////        cell._contentLab.frame = contentFrame;
////        
////        cell._priceLab.text = priceStr;
////        cell._contentLab.text = tuanData._tuanName;
//        return cell;
//    }
//    else if (indexPath.section == sectionNum) {
//        
//        if (indexPath.row == 0) {
//            
//            ShopForEvaluationCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
//            if (cell == nil)
//            {
//                cell = [[[ShopForEvaluationCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
//                cell.selectionStyle = UITableViewCellSelectionStyleNone;
//                cell.backgroundColor = [UIColor clearColor];
//            }
//            cell._numLab.text = [NSString stringWithFormat:@"共%@条", commentData._count];
//            return cell;
//        }
//        else if (indexPath.row == 1) {
//            
//            ShopForEvaluationInfoCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
//            if (cell == nil)
//            {
//                cell = [[[ShopForEvaluationInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
//                cell.selectionStyle = UITableViewCellSelectionStyleNone;
//                cell.backgroundColor = [UIColor clearColor];
//            }
//            
//            [cell setHeartCount:[commentInfo._comLevel intValue]];
//            [cell setStar:[commentInfo._comStar floatValue]];
//            cell._nameLab.text = commentInfo._comName;
//            cell._detailLab.text = commentInfo._comContent;
//            cell._dateLab.text = commentInfo._comTime;
//    
//            return cell;
//        }
//    }
//    else if (indexPath.section == sectionNum +1) {
//        
//        if (![self._detailData._isClaim boolValue]) {
//            
//            ShopForRecommendCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
//            if (cell == nil)
//            {
//                cell = [[[ShopForRecommendCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
//                cell.selectionStyle = UITableViewCellSelectionStyleNone;
//                cell.backgroundColor = [UIColor clearColor];
//                [cell._but1 addTarget:self action:@selector(clickType:) forControlEvents:UIControlEventTouchUpInside];
//                [cell._but2 addTarget:self action:@selector(clickType:) forControlEvents:UIControlEventTouchUpInside];
//                [cell._but3 addTarget:self action:@selector(clickType:) forControlEvents:UIControlEventTouchUpInside];
//                [cell._but4 addTarget:self action:@selector(clickType:) forControlEvents:UIControlEventTouchUpInside];
//            }
//            return cell;
//        }
//        
//        if (indexPath.row == 0) {
//            
//            ShopForQuestionCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
//            if (cell == nil)
//            {
//                cell = [[[ShopForQuestionCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
//                cell.selectionStyle = UITableViewCellSelectionStyleNone;
//                cell.backgroundColor = [UIColor clearColor];
//                
//                [cell._questBut addTarget:self action:@selector(clickQuest) forControlEvents:UIControlEventTouchUpInside];
//                
//                if ([self._detailData._state intValue] > 0) {
//                    cell._questBut.hidden = YES;
//                }
//            }
//            cell._numLab.text = [NSString stringWithFormat:@"共%@条", questData._count];
//            return cell;
//        }
//        else if (indexPath.row == 1) {
//            
//            ShopForQuestionInfoCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
//            if (cell == nil)
//            {
//                cell = [[[ShopForQuestionInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
//                cell.selectionStyle = UITableViewCellSelectionStyleNone;
//                cell.backgroundColor = [UIColor clearColor];
//            }
//            cell._nameLab.text = questionInfo._comName;
//            cell._detailLab.text = questionInfo._comContent;
//            cell._dateLab.text = questionInfo._comTime;
//            return cell;
//        }
//    }
//    else if (indexPath.section == sectionNum + 2) {
//        
//        ShopForRecommendCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
//        if (cell == nil)
//        {
//            cell = [[[ShopForRecommendCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
//            cell.selectionStyle = UITableViewCellSelectionStyleNone;
//            cell.backgroundColor = [UIColor clearColor];
//            [cell._but1 addTarget:self action:@selector(clickType:) forControlEvents:UIControlEventTouchUpInside];
//            [cell._but2 addTarget:self action:@selector(clickType:) forControlEvents:UIControlEventTouchUpInside];
//            [cell._but3 addTarget:self action:@selector(clickType:) forControlEvents:UIControlEventTouchUpInside];
//            [cell._but4 addTarget:self action:@selector(clickType:) forControlEvents:UIControlEventTouchUpInside];
//        }
//        return cell;
//    }

    return nil;
}

#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    int sectionNum = 1;
    if (isOrder) {
        sectionNum = 2;
    }
    
    if (![self._detailData._isClaim boolValue]) {
        if (indexPath.section == 1) {
            if (indexPath.row == 0) {
                NSMutableArray *tempArray = [[NSMutableArray alloc]init];
                [tempArray addObject:self._detailData];
                ShopMapViewController *shopMapVC = [[ShopMapViewController alloc]init];
                shopMapVC.mapArray = tempArray;
                [tempArray release];
                shopMapVC.title = self._detailData._name;
                [self.navigationController pushViewController:shopMapVC animated:YES];
                [shopMapVC release];
            }
            else if (indexPath.row == 5) {
                
                isMoreRow = !isMoreRow;
                if (introSize.height > 28) {
                    
                    [myTable reloadRowsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:5 inSection:1], nil] withRowAnimation:UITableViewRowAnimationFade];
                }
            }
        }
        else if (indexPath.section == 2) {
            ShopForCommentViewController *commentVC = [[ShopForCommentViewController alloc] init];
            commentVC._shopName = self._detailData._name;
            commentVC._shopId = self._detailData._shopId;
            if ([self._detailData._state intValue] != 0) {
                commentVC._butHiden = YES;
            }
            [self.navigationController pushViewController:commentVC animated:YES];
            [commentVC release];
        }
    }
    else {
        
        NSInteger sectionAdd = 0;                     //存在代金券时 sectionAdd 加1
        if (isOrder) {
            sectionAdd = 1;
        }
        
        if (indexPath.section == sectionAdd + 1) {
            if (indexPath.row == 0) {
                NSMutableArray *tempArray = [[NSMutableArray alloc]init];
                [tempArray addObject:self._detailData];
                ShopMapViewController *shopMapVC = [[ShopMapViewController alloc]init];
                shopMapVC.mapArray = tempArray;
                [tempArray release];
                shopMapVC.title = self._detailData._name;
                [self.navigationController pushViewController:shopMapVC animated:YES];
                [shopMapVC release];
            }
            else if (indexPath.row == 5) {
                
                isMoreRow = !isMoreRow;
                if (introSize.height > 28) {
                    
                    [myTable reloadRowsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:5 inSection:sectionAdd + 1], nil] withRowAnimation:UITableViewRowAnimationFade];
                }
            }
        }
        else if (indexPath.section == sectionAdd + 2) {
            ShopForCommentViewController *commentVC = [[ShopForCommentViewController alloc] init];
            commentVC._shopName = self._detailData._name;
            commentVC._shopId = self._detailData._shopId;
            if ([self._detailData._state intValue] != 0) {
                commentVC._butHiden = YES;
            }
            [self.navigationController pushViewController:commentVC animated:YES];
            [commentVC release];
        }
        else if (indexPath.section == sectionAdd + 3) {
            ShopForAQListViewController *AQVC = [[ShopForAQListViewController alloc] init];
            AQVC._shopId = self._detailData._shopId;
            if ([self._detailData._state intValue] != 0) {
                AQVC._butHiden = YES;
            }
            [self.navigationController pushViewController:AQVC animated:YES];
            [AQVC release];
        }
        else if (indexPath.section == 1) {
            
            if (!isOpen && indexPath.row == 1) {
                UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
                UILabel *cellLab = (UILabel *)[cell viewWithTag:5];
                cellLab.text = @"收起";
                isOpen = !isOpen;
                [myTable reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationFade];
            }
            else if (indexPath.row == [self._detailData._groupVouchers count]) {
                UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
                UILabel *cellLab = (UILabel *)[cell viewWithTag:5];
                cellLab.text = @"更多代金券";
                isOpen = !isOpen;
                [myTable reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationFade];
            }
        }
    }
    

//    if (indexPath.section == 0) {
//        
//        if (indexPath.row == 2) {
//            NSMutableArray *tempArray = [[NSMutableArray alloc]init];
//	    [tempArray addObject:self._detailData];
//            ShopMapViewController *shopMapVC = [[ShopMapViewController alloc]init];
//	    shopMapVC.mapArray = tempArray;
//	    [tempArray release];
//            shopMapVC.title = self._detailData._name;
//            [self.navigationController pushViewController:shopMapVC animated:YES];
//            [shopMapVC release];
//        }
//        else if (indexPath.row == 7) {
//            
//            isMoreRow = !isMoreRow;
//            if (introSize.height > 28) {
//                
//                [myTable reloadRowsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:7 inSection:0], nil] withRowAnimation:UITableViewRowAnimationFade];
//            }
//        }
//    }
//    else if (indexPath.section == sectionNum) {
//        
//        ShopForCommentViewController *commentVC = [[ShopForCommentViewController alloc] init];
//        commentVC._shopName = self._detailData._name;
//        commentVC._shopId = self._detailData._shopId;
//        if ([self._detailData._state intValue] != 0) {
//            commentVC._butHiden = YES;
//        }
//        [self.navigationController pushViewController:commentVC animated:YES];
//        [commentVC release];
//    }
//    else if (indexPath.section == sectionNum + 1) {
//        
//        if (![self._detailData._isClaim boolValue]) {
//            return;
//        }
//        
//        ShopForAQListViewController *AQVC = [[ShopForAQListViewController alloc] init];
//        AQVC._shopId = self._detailData._shopId;
//        if ([self._detailData._state intValue] != 0) {
//            AQVC._butHiden = YES;
//        }
//        [self.navigationController pushViewController:AQVC animated:YES];
//        [AQVC release];
//    }
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 123) {
        if (buttonIndex == 1) {
            
            NSString *weChatUrl = [WXApi getWXAppInstallUrl];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:weChatUrl]];
        }
    }
    else if (alertView.tag == 0) {
        if (buttonIndex == 0)
        {
            NSArray *telphontArr = [self._detailData._telephone componentsSeparatedByString:@"&"];
            [self callTel:telphontArr[0]];
        }
    }
}

#pragma mark - UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (actionSheet.tag == 0) {
        if (buttonIndex == 0)
        {
            [self startCamera];
        }
        else if (buttonIndex == 1) {
            
            [self showImagePickerForPhotoPicker];
        }
    }
    else if (actionSheet.tag == 1)
    {
        switch (buttonIndex) {
            case 0:
            {
                ASIFormDataRequest * theRequest = [InterfaceClass shopError:[UserLogin sharedUserInfo].userID withShopId:self._detailData._shopId withErrorType:@"0"];
                [[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onPaseredShopErrorResult:) Delegate:self needUserType:Default];
                break;
            }
            case 1:
            {
                ASIFormDataRequest * theRequest = [InterfaceClass shopError:[UserLogin sharedUserInfo].userID withShopId:self._detailData._shopId withErrorType:@"1"];
                [[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onPaseredShopErrorResult:) Delegate:self needUserType:Default];
                break;
            }
            case 2:
            {
                ShopForErrorViewController *errorVC = [[ShopForErrorViewController alloc] init];
                errorVC._errorData = self._detailData;
                [self.navigationController pushViewController:errorVC animated:YES];
                [errorVC release];
                break;
            }
            case 3:
            {
                OtherForErrorViewController *otherVC = [[OtherForErrorViewController alloc] init];
                otherVC._shopId = self._detailData._shopId;
                [self.navigationController pushViewController:otherVC animated:YES];
                [otherVC release];
                break;
            }
            default:
                break;
        }
    }
    else if (actionSheet.tag == 2) {
        NSLog(@"%d", buttonIndex);
        NSArray *telphontArr = [self._detailData._telephone componentsSeparatedByString:@"&"];
        if (buttonIndex < [telphontArr count]) {
            NSString *telNum = [telphontArr objectAtIndex:buttonIndex];
            [self callTel:telNum];
        }
    }
    else if (actionSheet.tag == 3) {
        
        NSString *wxTitle = @"店铺分享";
        NSString *wxDesc = [NSString stringWithFormat:@"我在辣椒游发现一家不错的店，快来看看吧:%@", self._detailData._name];
//        NSString *wxUrl = @"http://www.lajiaou.com/customer/collect/downApk";
        NSString *wxUrl = @"https://itunes.apple.com/us/app/la-jiao-you/id932263889?l=zh&ls=1&mt=8";       
//        NSString *destDateString = @"大家去郊游";
        
        switch (buttonIndex) {
//            case 0:
//            {
//                ShopForShareViewController *shareVC = [[ShopForShareViewController alloc] init];
//                [self.navigationController pushViewController:shareVC animated:YES];
//                [shareVC release];
//                break;
//            }
            case 0:
            {
                if ([self isWeChatHave]) {
                    [WeiXinExport sendAppContent:wxTitle withDes:wxDesc withImg:[UIImage imageNamed:@"57.png"] withUrl:wxUrl];
                }
                break;
            }
            case 1:
            {
                if ([self isWeChatHave]) {
                    [WeiXinExport sendAppContentTo:wxTitle withDes:wxDesc withImg:[UIImage imageNamed:@"57.png"] withUrl:wxUrl];
                }
                break;
            }
//            case 2:
//            {
//                double version = [[UIDevice currentDevice].systemVersion doubleValue];//判定系统版本。
//                if(version >=6.0f)
//                {
//                    SLComposeViewController *slComposerSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeSinaWeibo];
//                    [slComposerSheet setInitialText:[NSString stringWithFormat:@"%@#%@#农家乐 @辣郊游",destDateString,wxDesc]];
//                    [slComposerSheet addImage:nil];
//                    [slComposerSheet addURL:[NSURL URLWithString:@"http://www.itkt.com/jsp/phone.jsp"]];
//                    
//                    SLComposeViewControllerCompletionHandler myBlock = ^(SLComposeViewControllerResult result) {
//                        NSLog(@"start completion block");
//                        NSString *output;
//                        switch (result) {
//                            case SLComposeViewControllerResultCancelled:
//                                output = @"取消分享";
//                                break;
//                            case SLComposeViewControllerResultDone:
//                                output = @"分享成功";
//                                break;
//                            default:
//                                break;
//                        }
//                        if (result != SLComposeViewControllerResultCancelled)
//                        {
//                            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:output delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
//                            [alert show];
//                            [alert release];
//                        }
//                        [slComposerSheet dismissViewControllerAnimated:YES completion:Nil];
//                    };
//                    slComposerSheet.completionHandler = myBlock;
//                    [self presentViewController:slComposerSheet animated:YES completion:nil];
//                }
//                else
//                {
//                    
//                    if ([WeiboSDK isWeiboAppInstalled] ) {
//                        WBMessageObject *message = [WBMessageObject message];
//                        message.text = [NSString stringWithFormat:@"%@#%@#农家乐 @辣郊游",destDateString,wxDesc];
//                        WBSendMessageToWeiboRequest *sendMessageRequest = [WBSendMessageToWeiboRequest requestWithMessage:message];
//                        sendMessageRequest.userInfo = @{@"ShareMessageFrom": @"FlightTrendsDetailViewController",
//                                                        @"Other_Info_1": [NSNumber numberWithInt:123],
//                                                        @"Other_Info_2": @[@"obj1", @"obj2"],
//                                                        @"Other_Info_3": @{@"key1": @"obj1", @"key2": @"obj2"}};
//                        
//                        [WeiboSDK sendRequest:sendMessageRequest];
//                    }
//                    else{
//                        NSString * urlStr = [NSString stringWithFormat:@"http://v.t.sina.com.cn/share/share.php?title#%@#农家乐，%@ @辣郊游",destDateString,wxDesc];
//                        ShareToSinaViewController * shareVC  = [[ShareToSinaViewController alloc] init];
//                        shareVC._url = [NSURL URLWithString:[urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
//                        [self.navigationController pushViewController:shareVC animated:YES];
//                        [shareVC release];
//                    }
//                    
//                }
//                break;
//            }
            default:
                break;
        }
    }
}

- (void)onPaseredShopErrorResult:(NSDictionary *)dic
{
    [UIAlertView alertViewWithMessage:[dic objectForKey:@"message"]];
}

#pragma mark Camera View Delegate Methods
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    [picker dismissModalViewControllerAnimated:YES];
//    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    if (picker.sourceType == UIImagePickerControllerSourceTypeCamera)
    {
        [self.library saveImage:image toAlbum:@"辣郊游" withCompletionBlock:^(NSError *error) {
            if (error!=nil) {
                NSLog(@"保存图片失败: %@", [error description]);
            }
        }];
    }
    
    UploadPhotoViewController *uploadVC = [[UploadPhotoViewController alloc] init];
    uploadVC._uploadDelegate = self;
    [self.navigationController pushViewController:uploadVC animated:YES];
    uploadVC._imgModelArr = [NSMutableArray array];
    uploadVC._selfImage = image;
    uploadVC._imgArray = [NSMutableArray array];
    uploadVC._shopId = self._detailData._shopId;
    uploadVC._maxPicSelect = 10;
    uploadVC._minPicSelect = 0;
    
    [uploadVC release];
}

#pragma mark - ZYQAssetPickerController Delegate
-(void)assetPickerController:(ZYQAssetPickerController *)picker didFinishPickingAssets:(NSArray *)assets{
    
    UploadPhotoViewController *uploadVC = [[UploadPhotoViewController alloc] init];
    uploadVC._uploadDelegate = self;
    [self.navigationController pushViewController:uploadVC animated:YES];
    uploadVC._imgModelArr = [NSMutableArray array];
    uploadVC._imgArray = [NSMutableArray array];
    uploadVC._shopId = self._detailData._shopId;
    uploadVC._minPicSelect = 0;
    uploadVC._maxPicSelect = 10;
    
    for (int i=0; i<assets.count; i++) {
        
        ALAsset *asset=assets[i];
        UIImage *tempImg=[UIImage imageWithCGImage:asset.defaultRepresentation.fullScreenImage];
        dispatch_async(dispatch_get_main_queue(), ^{
            uploadVC._selfImage = tempImg;
        });
    }
    [uploadVC release];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissModalViewControllerAnimated:YES];
}

- (void)saveImage:(UIImage *)image {
    
    NSLog(@"保存");
    [UIAlertView alertViewWithMessage:@"上传成功"];
}

- (void)submitShop:(id)sender
{
    NSLog(@"预定商铺事件！");
}

- (void)signClick
{
    if (NO == [self setUserLogin:ShopForSign]) {
        return;
    }
    ASIFormDataRequest * theRequest = [InterfaceClass signIn:[UserLogin sharedUserInfo].userID withShopId:self._detailData._shopId];
	[[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onSignResult:) Delegate:self needUserType:Member];
}

- (void)onSignResult:(NSDictionary *)dic
{
    if (![[dic objectForKey:@"statusCode"] isEqualToString:@"0" ]) {
        [UIAlertView alertViewWithMessage:[dic objectForKey:@"message"]];
        return;
    }
    
    self._detailData._signInCount = [NSString stringWithFormat:@"%d", [self._detailData._signInCount intValue] + 1];
    
//    [myTable reloadRowsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:1 inSection:0], nil] withRowAnimation:UITableViewRowAnimationNone];
    
    [UIAlertView alertViewWithMessage:[dic objectForKey:@"message"]];
}

- (void)uploadClick
{
    if (NO == [self setUserLogin:ShopForUpload]) {
        return;
    }
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"拍照上传" otherButtonTitles:@"上传手机中的相片", nil];
    actionSheet.tag = 0;
    actionSheet.actionSheetStyle = UIActionSheetStyleDefault;
    [actionSheet showInView:self.view];
    [actionSheet release];
}

-(void)startCamera {
    
    UIImagePickerController *camera = [[UIImagePickerController alloc] init];
	
	camera.delegate = self;
	camera.allowsEditing = NO;
	
	//检查摄像头是否支持摄像机模式
	if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
	{
		//UI 显示样式，显示的格式确定
		camera.sourceType = UIImagePickerControllerSourceTypeCamera;
		camera.cameraFlashMode = UIImagePickerControllerCameraFlashModeAuto;
		//mediaTypes用来确定再picker里显示那些类型的多媒体文件，图片？视频？
		//camera.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeCamera];
	}
	else
	{
		NSLog(@"Camera not exist");
		return;
	}
	//拍摄照片的清晰度，只有在照相机模式下可用
	camera.videoQuality = UIImagePickerControllerQualityTypeHigh;
	[self presentViewController:camera animated:YES completion:nil];
	[camera release];
}

- (void)showImagePickerForPhotoPicker
{
//    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
//    imagePicker.delegate = self;
//    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
//    imagePicker.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
//    imagePicker.allowsEditing = NO;
//    [self presentModalViewController:imagePicker animated:YES];
    
    ZYQAssetPickerController *picker = [[ZYQAssetPickerController alloc] init];
    picker.maximumNumberOfSelection = 10;
    picker.assetsFilter = [ALAssetsFilter allPhotos];
    picker.showEmptyGroups=NO;
    picker.delegate=self;
    picker.selectionFilter = [NSPredicate predicateWithBlock:^BOOL(id evaluatedObject, NSDictionary *bindings) {
        if ([[(ALAsset*)evaluatedObject valueForProperty:ALAssetPropertyType] isEqual:ALAssetTypeVideo]) {
            NSTimeInterval duration = [[(ALAsset*)evaluatedObject valueForProperty:ALAssetPropertyDuration] doubleValue];
            return duration >= 5;
        } else {
            return YES;
        }
    }];
    
    [self presentViewController:picker animated:YES completion:NULL];
}

- (void)commentClick
{
    if (NO == [self setUserLogin:ShopForComment]) {
        return;
    }
    ShopForEvaluationViewController *evaluationVC = [[ShopForEvaluationViewController alloc] init];
    evaluationVC._shopId = self._detailData._shopId;
    evaluationVC._delegate = self;
    [self.navigationController pushViewController:evaluationVC animated:YES];
    [evaluationVC release];
}

- (void)errorClick
{
    if (NO == [self setUserLogin:ShopForError]) {
        return;
    }
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"农家乐" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"商户已关", @"地图位置错误", @"商户信息错误", @"其它错误", nil];
    actionSheet.tag = 1;
    actionSheet.actionSheetStyle = UIActionSheetStyleDefault;
    [actionSheet showInView:self.view_IOS7];
    [actionSheet release];
}

- (void)share
{
    UIActionSheet *action = [[UIActionSheet alloc] initWithTitle:@"分享到" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles: @"微信", @"朋友圈",  nil]; //@"社交网站",@"新浪微博",
    action.tag = 3;
    [action showInView:self.view_IOS7];
    [action release];
}

- (void)clickPhone
{
    NSArray *telphontArr = [self._detailData._telephone componentsSeparatedByString:@"&"];
    
    if ([telphontArr count] == 1) {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:nil message:[NSString stringWithFormat:@"拨打电话：%@", [telphontArr objectAtIndex:0]] delegate:self cancelButtonTitle:@"确认"
                                            otherButtonTitles:@"取消", nil];
        
        alert.tag = 0;
        [alert show];
        [alert release];
    }
    else if ([telphontArr count] > 1)
    {
//        UIActionSheet *action = [[UIActionSheet alloc] initWithTitle:@"店铺电话" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:nil, nil];
        
        UIActionSheet *action = [[UIActionSheet alloc] init];
        action.title = @"拨打电话";
        
        for (int i = 0; i < [telphontArr count]; i ++) {
            [action addButtonWithTitle:[telphontArr objectAtIndex:i]];
        }
        [action addButtonWithTitle:@"取消"];
        
        action.delegate = self;
        action.tag = 2;
        [action showInView:self.view_IOS7];
        [action release];
    }
}

//- (void)clickCollect
//{
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"收藏店铺" message:@"该店铺添加到我的收藏中，可以通过我的收藏查看该店铺信息" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确认", nil];
//    alert.tag = 1;
//    [alert show];
//    [alert release];
//}

- (void)clickCollect
{
    if (NO == [self setUserLogin:ShopForCollect]) {
        return;
    }
    
    if ([self._detailData._isCollect boolValue]) {
        
        ASIFormDataRequest * theRequest = [InterfaceClass userDelCollect:[UserLogin sharedUserInfo].userID shopId:self._detailData._shopId];
        [[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onDelPaseredResult:) Delegate:self needUserType:Member];
    }
    else {
        
        if ([self._detailData._state intValue] == 1) {
            [UIAlertView alertViewWithMessage:@"已停业！店铺无法收藏"];
            return;
        }
        ASIFormDataRequest * theRequest = [InterfaceClass userAddCollect:[UserLogin sharedUserInfo].userID shopId:self._detailData._shopId];
        [[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onAddCollectResult:) Delegate:self needUserType:Member];
    }
}

- (void)onAddCollectResult:(NSDictionary *)dic
{
//    if (![[dic objectForKey:@"statusCode"] isEqualToString:@"0" ]) {
//        [UIAlertView alertViewWithMessage:[dic objectForKey:@"message"]];
//        return;
//    }
    
    if ([[dic objectForKey:@"statusCode"] isEqualToString:@"10" ]) {
        [UIAlertView alertViewWithMessage:[dic objectForKey:@"message"]];
        
        self._detailData._isCollect = @"YES";
        [rightBut setImage:[UIImage imageNamed:@"收藏A.png"] forState:UIControlStateNormal];
//        [myTable reloadRowsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:1 inSection:0], nil] withRowAnimation:UITableViewRowAnimationNone];
        return;
    }
    else if (![[dic objectForKey:@"statusCode"] isEqualToString:@"0" ]) {
        [UIAlertView alertViewWithMessage:[dic objectForKey:@"message"]];
        return;
    }
    
    [rightBut setImage:[UIImage imageNamed:@"收藏A.png"] forState:UIControlStateNormal];
	self._detailData._isCollect = @"YES";
    self._detailData._collectCount = [NSString stringWithFormat:@"%d", [self._detailData._collectCount intValue] + 1];
    
//    [myTable reloadRowsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:1 inSection:0], nil] withRowAnimation:UITableViewRowAnimationNone];
    
    [UIAlertView alertViewWithMessage:[dic objectForKey:@"message"]];
}

- (void)onDelPaseredResult:(NSDictionary *)dic
{
    if (![[dic objectForKey:@"statusCode"] isEqualToString:@"0" ]) {
        [UIAlertView alertViewWithMessage:[dic objectForKey:@"message"]];
        return;
    }
    [rightBut setImage:[UIImage imageNamed:@"收藏B.png"] forState:UIControlStateNormal];
    self._detailData._isCollect = @"NO";
    self._detailData._collectCount = [NSString stringWithFormat:@"%d", [self._detailData._collectCount intValue] - 1];
    
//    [myTable reloadRowsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:1 inSection:0], nil] withRowAnimation:UITableViewRowAnimationNone];
    [UIAlertView alertViewWithMessage:[dic objectForKey:@"message"]];
}

- (void)clickSign
{
    ASIFormDataRequest * theRequest = [InterfaceClass shopSingIn:self._detailData._shopId withPageIndex:@"1"];
    [[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onShopSingInPaseredResult:) Delegate:self needUserType:Default];
}

- (void)onShopSingInPaseredResult:(NSDictionary *)dic
{
    NSString *statusCode = [NSString stringWithFormat:@"%@", [dic objectForKey:@"statusCode"]];
    NSString *message = [NSString stringWithFormat:@"%@", [dic objectForKey:@"message"]];
    
    if (![statusCode isEqualToString:@"0"]) {

        [UIAlertView alertViewWithMessage:message];
        return;
    }
    ShopForSignInViewController *signVC = [[ShopForSignInViewController alloc] init];
    signVC._delegate = self;
    signVC._shopId = self._detailData._shopId;
    signVC._signInData = [ShopForSignData setShopForSignData:dic];
    if ([signVC._signInData._totalPage intValue] < 2) {
        
        signVC.isfromRecomend = YES;
    }
    if ([self._detailData._state intValue] != 0) {
        
        signVC._butHiden = YES;
    }
    [self.navigationController pushViewController:signVC animated:YES];
    [signVC release];
}

- (void)clickQuest
{
    if (NO == [self setUserLogin:ShopForQuestion]) {
        return;
    }
    ShopForQuestionViewController *questVC = [[ShopForQuestionViewController alloc] init];
    questVC._shopId = self._detailData._shopId;
    questVC._delegate = self;
    [self.navigationController pushViewController:questVC animated:YES];
    [questVC release];
}

- (void)clickType:(UIButton *)sender
{
    //农家乐  采摘园 娱乐 其它
    NSString *typeId = nil;
    NSArray *typeArr = [DataClass selectShopType] ;
    NSArray *nameArr = [NSArray arrayWithObjects:@"农家乐", @"采摘园", @"娱乐", @"其他", nil];
    for(int i=0;i<[typeArr count];i++)
	{
		ShopType *type = [typeArr objectAtIndex:i];
        if ([[nameArr objectAtIndex:sender.tag] isEqualToString:type._Type_name]) {
            typeId = type._Type_id;
            break;
        }
	}
    
    self.shopFindProperty._type = typeId;
    self.shopFindProperty._serviceTagId = @"";
	self.shopFindProperty._keyword = @"";
    shopListVC.titleName = [nameArr objectAtIndex:sender.tag];
    shopListVC.tagName = @"服务标签";
    [self loadShopListDataSource];
	
}

- (void)loadShopListDataSource
{
	ASIFormDataRequest * theRequest = [InterfaceClass getShopList:self.shopFindProperty];
	[[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onPaseredShopListResult:) Delegate:self needUserType:Default];
	
}


//加载成功
- (void)onPaseredShopListResult:(NSDictionary *)dic
{
    if ([[dic objectForKey:@"statusCode"] intValue] != 0) {
        [UIAlertView alertViewWithMessage:[dic objectForKey:@"message"]];
		return;
    }
    
	shopFindDataResponse = [ShopFindDataResponse findShop:dic];
	
	if (shopFindDataResponse.shops.count>0) {
		
		
		int totalPage = [shopFindDataResponse.totalPage intValue];
		if (totalPage <= 1) {
			shopListVC.isfromRecomend = TRUE;
			[shopListVC isrefreshHeaderView];
			shopListVC.isLastPage = TRUE;
		}else{
			if(shopListVC.isfromRecomend)
			{
				shopListVC.isfromRecomend = FALSE;
				[shopListVC isrefreshHeaderView];
				shopListVC.isLastPage = FALSE;
			}
		}
		shopListVC.shopListArray = shopFindDataResponse.shops;
		shopListVC.shopFindProperty = self.shopFindProperty;
		shopListVC.pageIndex = 1;
		shopListVC.serviceBView.hidden = YES;
		shopListVC.serviceButton.enabled = YES;
		shopListVC.typeBView.hidden = YES;
		shopListVC.typeButton.enabled = YES;
		[shopListVC loadFitstDataSource];
		[self.navigationController popViewControllerAnimated:YES];
		
		//[list release];
	}
    else {
        [UIAlertView alertViewWithMessage:[dic objectForKey:@"message"]];
    }
	
}

- (void)clickImage
{
    NSLog(@"进入店铺图片列表");
    
    if ([self._detailData._picUrl length] > 10)
    {

        ShopForPhotoListViewController *photoVC = [[ShopForPhotoListViewController alloc] init];
        photoVC._shopId = self._detailData._shopId;
        photoVC._shopName = self._detailData._name;
        [self.navigationController pushViewController:photoVC animated:YES];
        [photoVC release];
    }
}

- (BOOL)isWeChatHave
{
    if (![WXApi isWXAppInstalled]) {
        UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"提示"
                                                             message:@"您还没有安装微信客户端，请安装后进行分享。点击确定，立即安装。"
                                                            delegate:self
                                                   cancelButtonTitle:@"取消"
                                                   otherButtonTitles:@"确定",nil];
        [alertView setTag:123];
        [alertView show];
        [alertView release];
        return NO;
    }
    return YES;
}

- (BOOL)setUserLogin:(ShopClickType)type
{
    if (![UserLogin sharedUserInfo].userID)
    {
        MemberLoginViewController *memberLoginVC = [[MemberLoginViewController alloc] init];
        memberLoginVC.delegate = self;
        memberLoginVC._clickType = type;
        [self.navigationController pushViewController:memberLoginVC animated:YES];
        [memberLoginVC release];
        return NO;
    }
    return YES;
}

-(void) loginSuccessFul:(ShopClickType)type
{
    NSLog(@"type:%d", type);
    if (type == ShopForCollect) {
        
        [self clickCollect];
    }
    else if (type == ShopForSign) {
        
        [self signClick];
    }
    else if (type == ShopForUpload) {
     
        [self performSelector:@selector(uploadClick)
               withObject:nil
               afterDelay:0.1];
    }
    else if (type == ShopForComment) {
        
        [self commentClick];
    }
    else if (type == ShopForError) {
        
        [self performSelector:@selector(errorClick)
                   withObject:nil
                   afterDelay:0.1];
    }
    else if (type == ShopForQuestion) {
     
        [self clickQuest];
    }
}

- (void)loadCommentData
{
    ASIFormDataRequest * theRequest = [InterfaceClass getShopCommentList:nil withShopId:self._detailData._shopId withStar:@"0" withFilter:@"0" withPageIndex:@"1" withPageSize:@"10"];
    [[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onPaseredShopCommentResult:) Delegate:self needUserType:Default];
}

- (void)loadQuestionData
{
    ASIFormDataRequest * theRequest = [InterfaceClass getQuestionList:nil withShopId:self._detailData._shopId withFilter:@"0" withPageIndex:@"1" withPageSize:@"20"];
    [[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onPaseredShopQuestionResult:) Delegate:self needUserType:Default];
}

- (void)onPaseredShopCommentResult:(NSDictionary *)dic
{
    NSInteger sectionAdd = 0;                     //存在代金券时 sectionAdd 加1
    if (isOrder) {
        sectionAdd = 1;
    }
    commentData = [ShopForCommentData setShopForCommentData:dic];
    [myTable reloadSections:[NSIndexSet indexSetWithIndex:sectionAdd + 2] withRowAnimation:UITableViewRowAnimationFade];
    
    if ([self._detailData._isClaim boolValue] && !notLoadQusetion) {
        [self loadQuestionData];
    }
}

- (void)onPaseredShopQuestionResult:(NSDictionary *)dic
{
    NSInteger sectionAdd = 0;                     //存在代金券时 sectionAdd 加1
    if (isOrder) {
        sectionAdd = 1;
    }
    questData = [ShopForQuestionData setShopForQuestionData:dic];
    [myTable reloadSections:[NSIndexSet indexSetWithIndex:sectionAdd + 3] withRowAnimation:UITableViewRowAnimationFade];
}

- (void)reloadTableView:(id)sender
{
    notLoadQusetion = YES;
    [self loadCommentData];
}

- (void)reloadQuestionData:(id)sender
{
    [self loadQuestionData];
}


#pragma mark - ShopForSignVC
- (void)setSignCount
{
    self._detailData._signInCount = [NSString stringWithFormat:@"%d", [self._detailData._signInCount intValue] + 1];
    
//    [myTable reloadRowsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:1 inSection:0], nil] withRowAnimation:UITableViewRowAnimationNone];
}

- (void)enter:(UIButton *)sender
{
    NSLog(@"进入团购页面");
    
    VoucherInfo *tuanData = [self._detailData._groupVouchers objectAtIndex:sender.tag];
    self._orderId = tuanData._Id;
    
    ASIFormDataRequest * theRequest = [InterfaceClass groupPurDetail:self._orderId];
    [[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onGroupPurDetailResult:) Delegate:self needUserType:Default];
    
//    //假流程
//    VoucherSaleViewController *orderVC = [[VoucherSaleViewController alloc] init];
//    orderVC._detailData = self._detailData;
//    orderVC._groupdata = [GroupPurDetailData groupPurDetailDataInfo:nil];
//     orderVC._groupdata._id = self._orderId;
//    [self.navigationController pushViewController:orderVC animated:YES];
//    [orderVC release];
    
//    ASIFormDataRequest * theRequest = [InterfaceClass groupPurDetail:self._orderId];
//    [[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onGroupPurDetailResult:) Delegate:self needUserType:Default];
    
//    //假流程
//        ShopTuanDetailsViewController *orderVC = [[ShopTuanDetailsViewController alloc] init];
//        orderVC.groupdata = [GroupPurDetailData groupPurDetailDataInfo:nil];
//        orderVC.groupPurId = self._orderId;
//        [self.navigationController pushViewController:orderVC animated:YES];
//        [orderVC release];
}

- (void)onGroupPurDetailResult:(NSDictionary *)dic
{
//    NSString *statusCode = [NSString stringWithFormat:@"%@", [dic objectForKey:@"statusCode"]];
//    NSString *message = [NSString stringWithFormat:@"%@", [dic objectForKey:@"message"]];
//    if (![statusCode isEqualToString:@"0"]) {
//        [UIAlertView alertViewWithMessage:message];
//        return;
//    }
    
    VoucherSaleViewController *orderVC = [[VoucherSaleViewController alloc] init];
    orderVC.title = self._detailData._name;
    orderVC._groupdata = [GroupPurDetailData vouchersDetailDataInfo:dic];
    orderVC._groupdata._id = self._orderId;
    orderVC._shopAddress = self._detailData._address;
    [self.navigationController pushViewController:orderVC animated:YES];
    [orderVC release];
    
//    ShopTuanDetailsViewController *orderVC = [[ShopTuanDetailsViewController alloc] init];
//    orderVC.groupdata = [GroupPurDetailData groupPurDetailDataInfo:dic];
//    orderVC.groupPurId = self._orderId;
//    [self.navigationController pushViewController:orderVC animated:YES];
//    [orderVC release];
}

@end
