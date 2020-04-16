//
//  SideBarViewController.m
//  LJYCProject
//
//  Created by xiemengyue on 13-11-1.
//  Copyright (c) 2013年 longcd. All rights reserved.
//

#import "SideBarViewController.h"
#import "AddShopsViewController.h"
#import "HomeViewController.h"
#import "AppDelegate.h"
#import "ShareToSinaViewController.h"
#import "MemberLoginViewController.h"
#import "UIViewController+JASidePanel.h"
@interface SideBarViewController ()

@end

@implementation SideBarViewController
@synthesize titlesArray,myTableView;

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
    self.titlesArray = nil;
    self.myTableView = nil;
    [super dealloc];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.titlesArray = [NSArray arrayWithObjects:@"首页",@"上传商家",@"告诉朋友",@"投诉建议",@"版本更新",@"关于我们", nil]; //@"打分鼓励",,@"使用帮助"
    // Initialization code

    
    UITableView *atableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 20, self.view_IOS7.frame.size.width, self.view_IOS7.frame.size.height) style:UITableViewStylePlain];
    self.myTableView = atableView;
    [atableView release];
    self.myTableView.backgroundColor = [UIColor clearColor];
    [self.myTableView setSeparatorColor:[UIColor clearColor]];
    [self.myTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.myTableView.dataSource = self;
    self.myTableView.delegate = self;
    [self.view_IOS7 addSubview:self.myTableView];
    
}

#pragma mark - Table view data source

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 50.0f;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.titlesArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *sideBarIdentifier = [NSString stringWithFormat:@"sideBarIdentifier%d",indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:sideBarIdentifier];
    
    // Configure the cell...
    if (cell == nil)
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:sideBarIdentifier] autorelease];
        cell.tag = indexPath.row;
        
        UIView *cellView = [[UIView alloc] initWithFrame:cell.contentView.frame];
        [cellView setBackgroundColor:[UIColor clearColor]];
        [cellView addSubview:[UIImageView ImageViewWithFrame:CGRectMake(15, 9, 32, 32) image:[UIImage imageNamed:[self.titlesArray objectAtIndex:indexPath.row]]]];
        [cellView addSubview:[UISubLabel labelWithTitle:[self.titlesArray objectAtIndex:indexPath.row] frame:CGRectMake(60, 10, 110, 30) font:FontBlodSize26 color:FontColor000000 alignment:NSTextAlignmentLeft]];
        [cellView addSubview:[UIImageView ImageViewWithFrame:CGRectMake(200, 22, 12, 16) image:[UIImage imageNamed:@"侧栏箭头.png"]]];
        
        [cell.contentView setBackgroundColor:[UIColor clearColor]];
        [cell.contentView addSubview:cellView];
        [cell setSelectedBackgroundView:[UIImageView ImageViewWithFrame:CGRectMake(0, 0, ViewWidth, 60) image:[UIImage imageNamed:@"cell背景.png"]]];
        [cellView release];
        
        cell.backgroundColor = [UIColor clearColor];

    }
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AppDelegate * app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    NSArray * rootVCArray = [NSArray arrayWithObjects:@"HomeViewController",@"AddShopsViewController",@"",@"RecommendationViewController",@"",@"AboutViewController", nil];//@"HelpViewController",
    
    if (indexPath.row == 1) {
        
        if (![UserLogin sharedUserInfo].userID)
        {
            MemberLoginViewController *memberLoginVC = [[MemberLoginViewController alloc] init];
            memberLoginVC.delegate = self;
            memberLoginVC._isAddShop = NO;
            UINavigationController * nav = (UINavigationController * )self.sidePanelController.centerPanel;
            [nav pushViewController:memberLoginVC animated:YES];
            [memberLoginVC release];
            [self.sidePanelController showCenterPanelAnimated:YES];
            return;
        }
    }
    
    if (indexPath.row == 2) {
        UIActionSheet *sheet = [[UIActionSheet alloc]initWithTitle:@"告诉朋友" delegate:self
                                                 cancelButtonTitle:@"取消" destructiveButtonTitle:Nil otherButtonTitles:@"微信",@"朋友圈"  ,nil];//,@"新浪微博"
        [sheet showInView:app.window];
        [sheet release];
    }
//    else if (indexPath.row == 5)
//    {
//        [UIAlertView alertViewWithMessage:@"打分鼓励"];
//    }
    else if (indexPath.row == 4)
    {
        ASIFormDataRequest * theRequest = [InterfaceClass getConfiguration];
        [[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onSoftUpdatePaseredResult:) Delegate:self needUserType:Default];
    }
    else
    {
        NSString * rootVCStr =  [rootVCArray objectAtIndex:indexPath.row];
        id  class = NSClassFromString(rootVCStr);
        if ([self.sidePanelController.viewControllers containsObject:rootVCStr]) {
            
            NSUInteger index =[self.sidePanelController.viewControllers indexOfObject:rootVCStr];
            ZXT_NavigationController *class = [self.sidePanelController.rootNavControllers objectAtIndex:index];
            self.sidePanelController.centerPanel = class;
            if (indexPath.row == 1) {
                AddShopsViewController *addClass = (AddShopsViewController *)[class topViewController];
                [addClass clearViews];
            }
        }
        else
        {
            UIViewController *root = [[class alloc]init];
            ZXT_NavigationController *nav = [[ZXT_NavigationController alloc]initWithRootViewController:root];
            [root release];
            self.sidePanelController.centerPanel = nav;
        }
        [self.sidePanelController showCenterPanelAnimated:YES];
    }
}
- (void) onSoftUpdatePaseredResult:(NSDictionary *) resultDic
{
    NSDictionary * version = [resultDic objectForKey:@"version"];
    if ([version isKindOfClass:[NSDictionary class]]) {
        NSString * code = [NSString stringWithFormat:@"%@",[version objectForKey:@"code"]];
        if ([code intValue] > MyVersionCode)
        {
            [VersionView shareVersionView].versionView.text=[NSString stringWithFormat:@"%@",[version objectForKey:@"desc"]];
            [[VersionView shareVersionView] showVersionView];
        }else {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"没有检测到新版本" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alert show];
            [alert release];
        }
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"没有检测到新版本" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
        [alert release];
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

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *wxTitle = @"辣郊游 分享";
    NSString *wxDesc = @"我正在使用辣椒游客户端，查看郊区店铺，周末去郊区游玩、采摘，吃农家饭时查找店铺信息挺有用的，快来试试吧";
//    NSString *wxUrl = @"http://www.lajiaou.com/customer/collect/downApk";
    NSString *wxUrl = @"https://itunes.apple.com/us/app/la-jiao-you/id932263889?l=zh&ls=1&mt=8";
//    https://itunes.apple.com/us/app/la-jiao-you/id932263889?l=zh&ls=1&mt=8
//    NSString *destDateString = @"郊游对身心好处大大的";
    switch (buttonIndex) {
        case 0://微信
        {
            if ([self isWeChatHave]) {
                [WeiXinExport sendAppContent:wxTitle withDes:wxDesc withImg:[UIImage imageNamed:@"57.png"] withUrl:wxUrl];
            }
        }
            break;
        case 1://朋友圈
            if ([self isWeChatHave]) {
                
                [WeiXinExport sendAppContentTo:wxTitle withDes:wxDesc withImg:[UIImage imageNamed:@"57.png"] withUrl:wxUrl];
            }
            break;
//        case 2://新浪微博
//        {
//            double version = [[UIDevice currentDevice].systemVersion doubleValue];//判定系统版本。
//            if(version >=6.0f)
//            {
//                SLComposeViewController *slComposerSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeSinaWeibo];
//                [slComposerSheet setInitialText:[NSString stringWithFormat:@"%@#%@#航班 @掌上航旅",destDateString,wxDesc]];
//                [slComposerSheet addImage:nil];
//                [slComposerSheet addURL:[NSURL URLWithString:@"http://www.itkt.com/jsp/phone.jsp"]];
//                
//                SLComposeViewControllerCompletionHandler myBlock = ^(SLComposeViewControllerResult result) {
//                    NSLog(@"start completion block");
//                    NSString *output;
//                    switch (result) {
//                        case SLComposeViewControllerResultCancelled:
//                            output = @"取消分享";
//                            break;
//                        case SLComposeViewControllerResultDone:
//                            output = @"分享成功";
//                            break;
//                        default:
//                            break;
//                    }
//                    if (result != SLComposeViewControllerResultCancelled)
//                    {
//                        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:output delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
//                        [alert show];
//                        [alert release];
//                    }
//                    [slComposerSheet dismissViewControllerAnimated:YES completion:Nil];
//                };
//                slComposerSheet.completionHandler = myBlock;
//                [self presentViewController:slComposerSheet animated:YES completion:nil];
//            }
//            else
//            {
//                
//                if ([WeiboSDK isWeiboAppInstalled] ) {
//                    WBMessageObject *message = [WBMessageObject message];
//                    message.text = [NSString stringWithFormat:@"%@#%@#航班 @掌上航旅",destDateString,wxDesc];
//                    WBSendMessageToWeiboRequest *sendMessageRequest = [WBSendMessageToWeiboRequest requestWithMessage:message];
//                    sendMessageRequest.userInfo = @{@"ShareMessageFrom": @"FlightTrendsDetailViewController",
//                                                    @"Other_Info_1": [NSNumber numberWithInt:123],
//                                                    @"Other_Info_2": @[@"obj1", @"obj2"],
//                                                    @"Other_Info_3": @{@"key1": @"obj1", @"key2": @"obj2"}};
//                    
//                    [WeiboSDK sendRequest:sendMessageRequest];
//                }
//                else{
//                    NSString * urlStr = [NSString stringWithFormat:@"http://v.t.sina.com.cn/share/share.php?title#%@#航班，%@ @掌上航旅",destDateString,wxDesc];
//                    ShareToSinaViewController * shareVC  = [[ShareToSinaViewController alloc] init];
//                    shareVC._url = [NSURL URLWithString:[urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
//                    [self.navigationController pushViewController:shareVC animated:YES];
//                    [shareVC release];
//                }
//                
//            }
//        }
//            break;
        default:
            break;
    }
}

-(void)selectCell:(id)sender{
    [self.myTableView deselectRowAtIndexPath:[self.myTableView indexPathForSelectedRow] animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) loginSuccessFul:(id)type
{
    NSLog(@"登陆充公");
    
    [self tableView:(UITableView *)self.myTableView didSelectRowAtIndexPath:(NSIndexPath *)[NSIndexPath indexPathForRow:1 inSection:0]];
}

#pragma UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 123) {//微信
        if (buttonIndex == 1) {
            
            NSString *weChatUrl = [WXApi getWXAppInstallUrl];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:weChatUrl]];
        }
    }
}
@end
