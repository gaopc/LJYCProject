//
//  AddTagsViewController.m
//  LJYCProject
//
//  Created by xiemengyue on 13-10-29.
//  Copyright (c) 2013年 longcd. All rights reserved.
//

#import "AddTagsViewController.h"
#import "CoustomButton.h"
#import "InterfaceClass.h"
#import "TagButton.h"
#import "MemberLoginViewController.h"
#import "DataClass.h"
#import "InterfaceClass.h"
@interface AddTagsViewController ()

@end

@implementation AddTagsViewController

@synthesize serviceTagData,canyinBtn,zhusuBtn,shineiBtn,shiwaiBtn,qitaBtn,myTableView,currentTag,selectTags,homeVC;
@synthesize _selectTagsKey;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    self._selectTagsKey = nil;
    self.serviceTagData = nil;
    self.canyinBtn = nil;
    self.zhusuBtn = nil;
    self.shineiBtn = nil;
    self.shiwaiBtn = nil;
    self.qitaBtn = nil;
    self.myTableView = nil;
    self.currentTag = nil;
    self.selectTags = nil;
    self.homeVC = nil;
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

	// Do any additional setup after loading the view.
   //导航
    self.title = @"添加分类";
    self.selectTags = [NSMutableDictionary dictionary];
    self.serviceTagData = [NSMutableDictionary dictionary];
    self._selectTagsKey = [NSMutableArray array];
    [self getServiceTagData];
    
    UIButton  * rightButton = [CoustomButton buttonWithBlueBorder:CGRectMake(0, 0, 53, 22) target:self action:@selector(submit:) title:@"完成"];
	UIBarButtonItem * rightBar = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = rightBar;
    [rightBar release];
    
    self.canyinBtn = [UIButton buttonWithType:UIButtonTypeCustom tag:0 title:@"餐饮" backImage:nil frame:CGRectMake(5, 15, 62, 25) font:FontSize26 color:FontColorFFFFFF target:self action:@selector(showService:)];
    self.zhusuBtn = [UIButton buttonWithType:UIButtonTypeCustom tag:1 title:@"住宿" backImage:nil frame:CGRectMake(67, 15, 62, 25) font:FontSize26 color:FontColorFFFFFF target:self action:@selector(showService:)];
    self.shineiBtn = [UIButton buttonWithType:UIButtonTypeCustom tag:2 title:@"室内娱乐" backImage:nil frame:CGRectMake(129, 15, 62, 25) font:FontSize26 color:FontColorFFFFFF target:self action:@selector(showService:)];
    self.shiwaiBtn = [UIButton buttonWithType:UIButtonTypeCustom tag:3 title:@"室外娱乐" backImage:nil frame:CGRectMake(191, 15, 62, 25) font:FontSize26 color:FontColorFFFFFF target:self action:@selector(showService:)];
    self.qitaBtn = [UIButton buttonWithType:UIButtonTypeCustom tag:4 title:@"其他" backImage:nil frame:CGRectMake(253, 15, 62, 25) font:FontSize26 color:FontColorFFFFFF target:self action:@selector(showService:)];
    
    self.currentTag = [NSString stringWithFormat:@"%@",self.canyinBtn.titleLabel.text];
    [self.canyinBtn setBackgroundColor:[UIColor colorWithRed:0x29/255.0 green:0xA7/255.0 blue:0xD5/255.0 alpha:1]];
    [self.zhusuBtn setBackgroundColor:[UIColor colorWithRed:0x7C/255.0 green:0xD0/255.0 blue:0xEF/255.0 alpha:1]];
    [self.shineiBtn setBackgroundColor:[UIColor colorWithRed:0x7C/255.0 green:0xD0/255.0 blue:0xEF/255.0 alpha:1]];
    [self.shiwaiBtn setBackgroundColor:[UIColor colorWithRed:0x7C/255.0 green:0xD0/255.0 blue:0xEF/255.0 alpha:1]];
    [self.qitaBtn setBackgroundColor:[UIColor colorWithRed:0x7C/255.0 green:0xD0/255.0 blue:0xEF/255.0 alpha:1]];
    
    [self.view_IOS7 addSubview:self.canyinBtn];
    [self.view_IOS7 addSubview:self.zhusuBtn];
    [self.view_IOS7 addSubview:self.shineiBtn];
    [self.view_IOS7 addSubview:self.shiwaiBtn];
    [self.view_IOS7 addSubview:self.qitaBtn];
    
    [self.view_IOS7 addSubview:[UIImageView ImageViewWithFrame:CGRectMake(5, 45, ViewWidth-10, 0.5) image:[UIImage imageNamed:@"横向分割线.png"]]];
    
    UITableView *aTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 45, ViewWidth, ViewHeight-46-45) style:UITableViewStylePlain];
    aTableView.tag =0;
    self.myTableView = aTableView;
    self.myTableView.allowsSelection = NO;
    self.myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.myTableView.backgroundColor = [UIColor clearColor];
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    [self.view_IOS7 addSubview:self.myTableView];
    [aTableView release];


}

-(void)showService:(UIButton*)sender
{
    if([self.currentTag isEqualToString:sender.titleLabel.text])
    {
        return;
    }
    self.currentTag = [NSString stringWithFormat:@"%@",sender.titleLabel.text];
    [self.canyinBtn setBackgroundColor:[UIColor colorWithRed:0x7C/255.0 green:0xD0/255.0 blue:0xEF/255.0 alpha:1]];
    [self.zhusuBtn setBackgroundColor:[UIColor colorWithRed:0x7C/255.0 green:0xD0/255.0 blue:0xEF/255.0 alpha:1]];
    [self.shineiBtn setBackgroundColor:[UIColor colorWithRed:0x7C/255.0 green:0xD0/255.0 blue:0xEF/255.0 alpha:1]];
    [self.shiwaiBtn setBackgroundColor:[UIColor colorWithRed:0x7C/255.0 green:0xD0/255.0 blue:0xEF/255.0 alpha:1]];
    [self.qitaBtn setBackgroundColor:[UIColor colorWithRed:0x7C/255.0 green:0xD0/255.0 blue:0xEF/255.0 alpha:1]];
    switch (sender.tag) {
        case 0:
            [self.canyinBtn setBackgroundColor:[UIColor colorWithRed:0x29/255.0 green:0xA7/255.0 blue:0xD5/255.0 alpha:1]];
            break;
        case 1:
            [self.zhusuBtn setBackgroundColor:[UIColor colorWithRed:0x29/255.0 green:0xA7/255.0 blue:0xD5/255.0 alpha:1]];
            break;
        case 2:
            [self.shineiBtn setBackgroundColor:[UIColor colorWithRed:0x29/255.0 green:0xA7/255.0 blue:0xD5/255.0 alpha:1]];
            break;
        case 3:
            [self.shiwaiBtn setBackgroundColor:[UIColor colorWithRed:0x29/255.0 green:0xA7/255.0 blue:0xD5/255.0 alpha:1]];
            break;
        case 4:
            [self.qitaBtn setBackgroundColor:[UIColor colorWithRed:0x29/255.0 green:0xA7/255.0 blue:0xD5/255.0 alpha:1]];
            break;
        default:
            break;
    }
    
    self.myTableView.tag = sender.tag;
    [self.myTableView reloadData];

}

-(void)getServiceTagData
{
    NSArray *array = [DataClass selectServiceTag];
    NSMutableArray *array0 = [NSMutableArray array];//其他
    NSMutableArray *array1 = [NSMutableArray array];//餐饮
    NSMutableArray *array2 = [NSMutableArray array];//住宿
    NSMutableArray *array3 = [NSMutableArray array];//室内
    NSMutableArray *array4 = [NSMutableArray array];//室外

    for(int i = 0; i<[self.homeVC.tagsArray count]-1; i++)
    {
        ServiceTag *myServiceTag = [self.homeVC.tagsArray objectAtIndex:i];
        
        for(ServiceTag *aServiceTag in array) {
            if([aServiceTag._tag_id isEqualToString:myServiceTag._tag_id])
            {
                [self._selectTagsKey addObject:aServiceTag._tag_name];
                [self.selectTags setObject:aServiceTag forKey:aServiceTag._tag_name];
            }
        }
    }
    
    for(ServiceTag *aServiceTag in array)
    {
        
//        for(int j = 0;j<[self.homeVC.tagsArray count]-1;j++)
//        {
//            ServiceTag *myServiceTag = [self.homeVC.tagsArray objectAtIndex:j];
//            if([aServiceTag._tag_id isEqualToString:myServiceTag._tag_id])
//            {
//                [self.selectTags setObject:aServiceTag forKey:aServiceTag._tag_name];
//                [self._selectTagsKey addObject:aServiceTag._tag_name];
//
//            }
//        }
        
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
    [self.serviceTagData setValue:array0 forKey:@"其他"];
    [self.serviceTagData setValue:array1 forKey:@"餐饮"];
    [self.serviceTagData setValue:array2 forKey:@"住宿"];
    [self.serviceTagData setValue:array3 forKey:@"室内娱乐"];
    [self.serviceTagData setValue:array4 forKey:@"室外娱乐"];
    
}


#pragma mark - Table view data source

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 75.0f;
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
    
    NSArray *array = [serviceTagData objectForKey:self.currentTag];
    int count = [array count] - indexPath.row*4;
    // Configure the cell...
    if (cell == nil)
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:tagIdentifier] autorelease];
        int tags = (count > 4)?(4):(count);
        
        for(int i=0;i<tags;i++)
        {
            ServiceTag *aServiceTag = [array objectAtIndex:([array count] - count + i)];
            
            NSString *tag = [NSString stringWithFormat:@"%d",[array count] - count + i];
            
            TagButton *tagButton = [TagButton setTagButton:aServiceTag._tag_picUrl frame:CGRectMake(5+80*i, 5, 71, 71) tag:[tag intValue] showImageView:YES title:aServiceTag._tag_name isShowRightLine:NO isShowBelowLine:NO isAddButton:NO];
            tagButton.delegate = self;
            [cell.contentView addSubview:tagButton];
            for(int j = 0;j<[self.homeVC.tagsArray count]-1;j++)
            {
                ServiceTag *myServiceTag = [self.homeVC.tagsArray objectAtIndex:j];
                if([aServiceTag._tag_id isEqualToString:myServiceTag._tag_id])
                {
                    tagButton.selectedImageView.hidden = NO;
                    [self.selectTags setObject:aServiceTag forKey:aServiceTag._tag_name];
                }
            }
        }
    }
    return cell;
}

-(void)click:(TagButton *)sender
{
    NSArray *array = [serviceTagData objectForKey:self.currentTag];
    ServiceTag *aServiceTag = [array objectAtIndex:sender.tag];
    if (sender.isSelected) {
        [self.selectTags setObject:aServiceTag forKey:aServiceTag._tag_name];
        [self._selectTagsKey addObject:aServiceTag._tag_name];
    }
    else {
        [self.selectTags removeObjectForKey:aServiceTag._tag_name];
        [self._selectTagsKey removeObject:aServiceTag._tag_name];
    }
}


-(void)submit:(UIButton*)sender
{
    NSString *serviceTagId = [NSString string];
    if([selectTags count] != 0)
    {
        for (NSString * key in [self.selectTags allKeys]) {
            
            NSString *_id = ((ServiceTag*)[selectTags objectForKey:key])._tag_id;
            
            if(serviceTagId.length == 0)
                serviceTagId = [serviceTagId stringByAppendingFormat:@"%@",_id];
            else
                serviceTagId = [serviceTagId stringByAppendingFormat:@"&%@",_id];
        }
        ASIFormDataRequest * theRequest = [InterfaceClass setServiceTag:[UserLogin sharedUserInfo].userID serviceTagId:serviceTagId];
        [[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onSetServiceTagResult:) Delegate:self needUserType:Default];
    }
    else
    {
        [UIAlertView alertViewWithMessage:@"您必须至少选择一个服务标签"];
        return;
    }
}

-(void)onSetServiceTagResult:(NSDictionary*)dic
{
    if([[NSString stringWithFormat:@"%@",[dic objectForKey:@"statusCode"]] isEqualToString:@"0"])
    {
        self.homeVC.tagsArray = [NSMutableArray array];
        
        if([selectTags count] != 0)
        {
            for (NSString * key in self._selectTagsKey) {
                
                ServiceTag *aServiceTag = (ServiceTag*)[selectTags objectForKey:key];
                [self.homeVC.tagsArray addObject:aServiceTag];
            }
            
        }
        ServiceTag *serviceTag = [[ServiceTag alloc] init];
        serviceTag._tag_name = @"选择标签";
        [self.homeVC.tagsArray  addObject:serviceTag];
        [self.homeVC setMyScrollViewContent];
        [serviceTag release];
    }
    else
    {
        NSString *message = @"超时";
        
        if([NSString stringWithFormat:@"%@",[dic objectForKey:@"message"]].length != 0)
        {
            message = [NSString stringWithFormat:@"%@",[dic objectForKey:@"message"]];
        }
        [UIAlertView alertViewWithMessage:message];
        
    }
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
