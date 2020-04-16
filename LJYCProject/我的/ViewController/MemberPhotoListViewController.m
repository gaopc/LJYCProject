//
//  MemberPhotoListViewController.m
//  LJYCProject
//
//  Created by gaopengcheng on 13-11-22.
//  Copyright (c) 2013年 longcd. All rights reserved.
//

#import "MemberPhotoListViewController.h"
#import "MemberPhotoDetailViewController.h"
#import "PictureListCell.h"

#define selectColor [UIColor colorWithRed:0x7C/255.0 green:0xD0/255.0 blue:0xEF/255.0 alpha:1];
#define unSelectColor [UIColor colorWithRed:0x29/255.0 green:0xA7/255.0 blue:0xD5/255.0 alpha:1];

@interface MemberPhotoListViewController ()

@end

@implementation MemberPhotoListViewController
@synthesize _picListData;
@synthesize _saveImgTag;

- (void)dealloc
{
    self._picListData = nil;
    self._saveImgTag = nil;
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    self.title = @"我的照片";
    pageIndex = 1;
    
    emptyView = [[UIView alloc] initWithFrame:self.view.bounds];
    if ([self._picListData._count intValue] != 0) {
        emptyView.hidden = YES;
    }
    UIImageView *emptyImg = [UIImageView ImageViewWithFrame:CGRectMake(40, 100, 50, 50) image:[UIImage imageNamed:@"空白页.png"]];
    UISubLabel *emptyLab = [UISubLabel labelWithTitle:@"还没有上传店铺照片？店铺详情页点击“上传照片”按钮试试吧！" frame:CGRectMake(95, 100, 200, 50) font:FontSize24 color:FontColor000000 alignment:NSTextAlignmentLeft];
    
    [emptyView addSubview:emptyImg];
    [emptyView addSubview:emptyLab];
    [self.view addSubview:emptyView];
    
    myTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 5, 320, ViewHeight-44-10) style:UITableViewStylePlain];
    myTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    myTable.backgroundColor = [UIColor clearColor];
    myTable.allowsSelection = YES;
    myTable.dataSource = self;
    myTable.delegate = self;
    [self.view_IOS7 addSubview:myTable];
    [myTable release];
    
    [self isrefreshHeaderView];
    [self loadFitstDataSource];
}

#pragma mark - Table view dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return (self._picListData._picArray.count + 1)/2;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 147;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier = [NSString stringWithFormat: @"identifier%d%d", indexPath.section, indexPath.row];
    PictureListCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil)
    {
        cell = [[[PictureListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor clearColor];
        [cell._leftBut addTarget:self action:@selector(clickImage:) forControlEvents:UIControlEventTouchUpInside];
        [cell._rightBut addTarget:self action:@selector(clickImage:) forControlEvents:UIControlEventTouchUpInside];
        
        cell._leftBut.tag = indexPath.row*2;
        cell._rightBut.tag = indexPath.row*2 + 1;
    }
    
    PicModel *model1 = [self._picListData._picArray objectAtIndex:indexPath.row*2];
    [cell._shopImageLeftView setUrlString:model1._smallUrl];
    
    if (self._picListData._picArray.count/2 == indexPath.row && self._picListData._picArray.count%2 == 1) {
        
        cell._rightBut.hidden = YES;
        cell._rightLab.hidden = YES;
        cell._shopImageRightView.imageView.image = nil;
    }
    else {
        PicModel *model2 = [self._picListData._picArray objectAtIndex:indexPath.row*2 + 1];
        [cell._shopImageRightView setUrlString:model2._smallUrl];
    }
    
    return cell;
}

- (void)clickImage:(UIButton *)sender
{
    NSLog(@"点击的图片：%d", sender.tag);
    self._saveImgTag = [NSString stringWithFormat:@"%d", sender.tag];
    MemberPhotoDetailViewController *detailVC = [[MemberPhotoDetailViewController alloc] init];
    detailVC._delegate = self;
    detailVC._picArray = self._picListData._picArray;
    detailVC._picIndex = [NSString stringWithFormat:@"%d", sender.tag];
    detailVC._detailData = [self._picListData._picArray objectAtIndex:sender.tag];
    detailVC._isMember = YES;
    [self.navigationController pushViewController:detailVC animated:YES];
    [detailVC release];
}

- (void)isrefreshHeaderView
{
	if (self.isfromRecomend) {
		if (_refreshHeaderView) {
//			myTable.contentSize = CGSizeMake(ViewWidth, myTable.contentSize.height-65.0f);
			[_refreshHeaderView removeFromSuperview];
			_refreshHeaderView = nil;
		}
		
	}
	else {
		if (!_refreshHeaderView) {
			_refreshHeaderView = [[EGORefreshTableHeaderView alloc] init];
			_refreshHeaderView.delegate = self;
			_refreshHeaderView.backgroundColor= [UIColor clearColor];
			[myTable addSubview:_refreshHeaderView];
			[_refreshHeaderView refreshLastUpdatedDate];
		}
	}
}

- (void)loadFitstDataSource
{
	[myTable reloadData];
	
	_refreshHeaderView.frame=CGRectMake(0.0f, myTable.contentSize.height, myTable.frame.size.width, 80);
	[self doneLoadingTableViewData];
	
}

-(void)setHeaderView
{
    if(pageIndex == [self._picListData._totalPage intValue] && [self._picListData._totalPage intValue] != 1)
    {
        self.isfromRecomend = YES;
        [self isrefreshHeaderView];
        myTable.contentSize = CGSizeMake(ViewWidth, myTable.contentSize.height-65.0f);
        return;
    }
    _refreshHeaderView.frame=CGRectMake(0.0f, myTable.contentSize.height, myTable.frame.size.width, 80);
    [self doneLoadingTableViewData];
}

-(void)loadDataSource
{
    ASIFormDataRequest * theRequest = [InterfaceClass userPhotoList:[UserLogin sharedUserInfo].userID withPageIndex:[NSString stringWithFormat:@"%d", pageIndex]];
    [[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onUserPhotoListPaseredResult:) Delegate:self needUserType:Default];
}

-(void)onUserPhotoListPaseredResult:(NSDictionary*)dic
{
    if([[dic objectForKey:@"statusCode"] isEqualToString:@"0"])
    {
        if(pageIndex == 1)
            self._picListData = [PicListModel memberPicListData:dic];
        else
        {
            PicListModel *memberData = [PicListModel memberPicListData:dic];
            [self._picListData._picArray addObjectsFromArray:memberData._picArray];
        }

        [myTable reloadData];
        [self setHeaderView];
    }
}

#pragma mark -
#pragma mark EGORefreshTableHeaderDelegate －－上拉涮新委托方法

- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view{
	[self reloadTableViewDataSource];
	[self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:4.0];
}

- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view{
	return reloading; // should return if data source model is reloading
}

- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view{
	return [NSDate date]; // should return date data source was last changed
}

#pragma mark -
#pragma mark Data Source Loading / Reloading －－上拉涮新相关

//实现上拖的方法
- (void)reloadTableViewDataSource
{
    if (pageIndex == self._picListData._picArray.count)
    {
        return;
    }
    pageIndex++;
    [self loadDataSource];
    reloading = YES;
}



//还原方法
- (void)doneLoadingTableViewData{
	reloading = NO;
	[_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:myTable];
}

#pragma mark -
#pragma mark UIScrollViewDelegate －－上拉涮新相关

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
	[_refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
	
	[_refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
}

- (void)editPic:(PicModel *)model
{
    [self._picListData._picArray replaceObjectAtIndex:[self._saveImgTag intValue] withObject:model];
    [myTable reloadData];
}

- (void)deletePic
{
    [self._picListData._picArray removeObjectAtIndex:[self._saveImgTag intValue]];
    if (self._picListData._picArray.count == 0) {
        emptyView.hidden = NO;
    }
    [myTable reloadData];
}
@end
