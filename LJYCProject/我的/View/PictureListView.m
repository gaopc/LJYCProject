//
//  PictureListView.m
//  LJYCProject
//
//  Created by gaopengcheng on 13-11-22.
//  Copyright (c) 2013年 longcd. All rights reserved.
//

#import "PictureListView.h"
#import "PictureListCell.h"
#import "MemberPhotoDetailViewController.h"

@implementation PictureListView
@synthesize _delegate;
@synthesize _shopId, _picType;
@synthesize _listData;

- (void)dealloc
{
    self._delegate = nil;
    self._shopId = nil;
    self._picType = nil;
    self._listData = nil;
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        pageIndex = 1;
    }
    return self;
}

- (void)showView
{
    [self loadDataSource];
    
    emptyView = [[UIView alloc] initWithFrame:self.bounds];
    emptyView.hidden = YES;
    
    UIImageView *emptyImg = [UIImageView ImageViewWithFrame:CGRectMake(40, 100, 50, 50) image:[UIImage imageNamed:@"空白页.png"]];
    UISubLabel *emptyLab = [UISubLabel labelWithTitle:@"没有图片，可点击右上角上传" frame:CGRectMake(95, 100, 200, 50) font:FontSize24 color:FontColor000000 alignment:NSTextAlignmentLeft];
    
    [emptyView addSubview:emptyImg];
    [emptyView addSubview:emptyLab];
    [self addSubview:emptyView];
    
    
    myTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 3, 320, ViewHeight-44-5-55) style:UITableViewStylePlain];
    myTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    myTable.backgroundColor = [UIColor clearColor];
    myTable.allowsSelection = YES;
    myTable.dataSource = self;
    myTable.delegate = self;
    [self addSubview:myTable];
    [myTable release];
    
    [self isrefreshHeaderView];
    [self loadFitstDataSource];
}

#pragma mark - Table view dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return (self._listData._picArray.count + 1)/2;
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
    
    PicModel *model1 = [self._listData._picArray objectAtIndex:indexPath.row*2];
    [cell._shopImageLeftView setUrlString:model1._smallUrl];
    
    if ([model1._isTrader boolValue]) {
        cell._leftView.hidden = NO;
    }
    
    
    if (self._listData._picArray.count/2 == indexPath.row && self._listData._picArray.count%2 == 1) {
        
        cell._rightBut.hidden = YES;
        cell._rightLab.hidden = YES;
        cell._rightView.hidden = YES;
    }
    else {
        PicModel *model2 = [self._listData._picArray objectAtIndex:indexPath.row*2 + 1];
        [cell._shopImageRightView setUrlString:model2._smallUrl];
        
        if ([model2._isTrader boolValue]) {
            cell._rightView.hidden = NO;
        }
    }
    return cell;
}

- (void)clickImage:(UIButton *)sender
{
//    PicModel *model = [self._listData._picArray objectAtIndex:sender.tag];
    if (self._delegate && [self._delegate respondsToSelector:@selector(selectedPic::)]) {
        [self._delegate performSelector:@selector(selectedPic::) withObject:self._listData._picArray withObject:[NSString stringWithFormat:@"%d", sender.tag]];
    }
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
    if(pageIndex == [self._listData._totalPage intValue] && [self._listData._totalPage intValue] != 1)
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
    ASIFormDataRequest * theRequest = [InterfaceClass shopPhotoList:self._shopId withType:self._picType withIndex:[NSString stringWithFormat:@"%d",pageIndex]];
    [[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onPaseredShopPicResult:) Delegate:self needUserType:Default];
}

-(void)onPaseredShopPicResult:(NSDictionary*)dic
{
    if([[dic objectForKey:@"statusCode"] isEqualToString:@"0"])
    {
        PicListModel *shopPicData = [PicListModel shopPicListData:dic];
        
        if(pageIndex == 1) {
            self._listData = shopPicData;
            
            if ([shopPicData._count intValue] == 0) {
                
                emptyView.hidden = NO;
            }
            
            if ([self._listData._totalPage intValue] < 2) {
                self.isfromRecomend = YES;
                [self isrefreshHeaderView];
            }
        } else
        {
            [self._listData._picArray addObjectsFromArray:shopPicData._picArray];
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
    if (pageIndex == self._listData._picArray.count)
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
@end
