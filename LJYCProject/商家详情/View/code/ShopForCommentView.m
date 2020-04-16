//
//  ShopForCommentView.m
//  LJYCProject
//
//  Created by gaopengcheng on 13-11-9.
//  Copyright (c) 2013年 longcd. All rights reserved.
//

#import "ShopForCommentView.h"
#import "ShopForCommentCell.h"

@implementation ShopForCommentView
@synthesize _commentData;
@synthesize _shopId, _starLv;

- (void)dealloc
{
    self._commentData = nil;
    self._starLv = nil;
    self._shopId = nil;
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        pageIndex = 1;
        
        [self addSubview:[UIImageView ImageViewWithFrame:self.bounds image:[UIImage imageNamed:@"背景-中.png"]]];
        
        emptyView = [[UIView alloc] initWithFrame:self.bounds];
        UIImageView *emptyImg = [UIImageView ImageViewWithFrame:CGRectMake(40, 100, 50, 50) image:[UIImage imageNamed:@"空白页.png"]];
        UISubLabel *emptyLab = [UISubLabel labelWithTitle:@"没有点评，可点击右上角点评" frame:CGRectMake(95, 100, 200, 50) font:FontSize24 color:FontColor000000 alignment:NSTextAlignmentLeft];
        
        [emptyView addSubview:emptyImg];
        [emptyView addSubview:emptyLab];
        [self addSubview:emptyView];
        
        UISubLabel *lable = [UISubLabel labelWithTitle:@"评      价：" frame:CGRectMake(5, 5, 60, 30) font:FontSize24 alignment:NSTextAlignmentLeft];
        
        commentNum = [UISubLabel labelWithTitle:nil frame:CGRectMake(60, 5, 50, 30) font:FontSize22 alignment:NSTextAlignmentLeft];
        commentNum.text = @"共0条";
        commentNum.textColor = FontColor454545;
        
        myView = [[UITableView alloc] initWithFrame:self.bounds];
        CGRect tableframe = self.bounds;
        tableframe.origin.y = 35;
        tableframe.size.height = self.frame.size.height - 40;
        myView.frame = tableframe;
        
        myView.separatorStyle = UITableViewCellSeparatorStyleNone;
        myView.backgroundColor = [UIColor clearColor];
        myView.allowsSelection = YES;
        myView.dataSource = self;
        myView.delegate = self;
        
        [self addSubview:lable];
        [self addSubview:commentNum];
        [self addSubview:myView];
        [myView release];
        
        [self isrefreshHeaderView];
        [self loadFitstDataSource];
    }
    return self;
}

- (void)show
{
    
    ASIFormDataRequest * theRequest = [InterfaceClass getShopCommentList:nil withShopId:self._shopId withStar:self._starLv withFilter:@"0" withPageIndex:@"1" withPageSize:@"20"];
    [[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onPaseredCommentResult:) Delegate:self needUserType:Default];
}

- (void)onPaseredCommentResult:(NSDictionary *)dic
{
    if (![[NSString stringWithFormat:@"%@",[dic objectForKey:@"statusCode"]] isEqualToString:@"0"]) {
        
        [UIAlertView alertViewWithMessage:[NSString stringWithFormat:@"%@",[dic objectForKey:@"message"]]];
        return;
    }
    
    self._commentData = [ShopForCommentData setShopForCommentData:dic];
    
    commentNum.text = [NSString stringWithFormat:@"共%@条", self._commentData._count];
    
    if ([self._commentData._count intValue] != 0) {

        emptyView.hidden = YES;
    }
    
    if ([self._commentData._totalPage intValue] < 2) {
        
        self.isfromRecomend = YES;
        [self isrefreshHeaderView];
    }
    
    [myView reloadData];
    [self setHeaderView];
}

#pragma mark - Table view dataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self._commentData._commentArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    ShopForCommentInfo *shopCommentInfo = [self._commentData._commentArr objectAtIndex:section];
    if ([shopCommentInfo._comReplyTime isEqualToString:@"0"]) {
        return 1;
    }
    
    return 2;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
        {
            ShopForCommentInfo *shopCommentInfo = [self._commentData._commentArr objectAtIndex:indexPath.section];
            CGSize contentSize = [shopCommentInfo._comContent sizeWithFont:FontSize20 constrainedToSize:CGSizeMake(220, 1000) lineBreakMode:NSLineBreakByWordWrapping];
            
            return contentSize.height + 60;
            break;
        }
        case 1:
        {
            ShopForCommentInfo *shopCommentInfo = [self._commentData._commentArr objectAtIndex:indexPath.section];
            CGSize contentSize = [shopCommentInfo._comReplyContent sizeWithFont:FontSize20 constrainedToSize:CGSizeMake(220, 1000) lineBreakMode:NSLineBreakByWordWrapping];
            
            return contentSize.height + 50;
            break;
        }
            
        default:
            return 85;
            break;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier = [NSString stringWithFormat: @"identifier%d%d", indexPath.section, indexPath.row];
    ShopForCommentInfo *shopCommentInfo = [self._commentData._commentArr objectAtIndex:indexPath.section];
    
    if (indexPath.row == 0) {
        ShopForCommentCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil)
        {
            cell = [[[ShopForCommentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor = [UIColor clearColor];
        }
        
        CGSize contentSize = [shopCommentInfo._comContent sizeWithFont:FontSize20 constrainedToSize:CGSizeMake(220, 1000) lineBreakMode:NSLineBreakByWordWrapping];
        
        CGRect serFrame = cell._content.frame;
        serFrame.size.height = contentSize.height;
        cell._content.frame = serFrame;
        
        CGRect horFrame = cell._horizontalView.frame;
        horFrame.origin.y = contentSize.height + 59;
        cell._horizontalView.frame = horFrame;
        
        CGRect verFrame = cell._verticalView.frame;
        verFrame.size.height = contentSize.height + 60;
        cell._verticalView.frame = verFrame;
        
        if (![shopCommentInfo._comReplyTime isEqualToString:@"0"]) {
            cell._horizontalView.hidden = YES;
        }
        
        [cell setStar:[shopCommentInfo._comStar floatValue]];
        [cell setHeartCount:[shopCommentInfo._comLevel intValue]];
        cell._name.text = shopCommentInfo._comName;
        cell._date.text = shopCommentInfo._comTime;
        cell._content.text = shopCommentInfo._comContent;
        
        return cell;
    }
    else {
        
        ShopForReplyCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil)
        {
            cell = [[[ShopForReplyCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor = [UIColor clearColor];
        }
        
        long long dataLong = [shopCommentInfo._comReplyTime longLongValue];
        double dateDou = dataLong/1000;
        NSDate* date = [NSDate dateWithTimeIntervalSince1970: dateDou];
        NSDateFormatter* formatter = [[[NSDateFormatter alloc] init] autorelease];
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSString* str = [formatter stringFromDate:date];
        
        CGSize contentSize = [shopCommentInfo._comReplyContent sizeWithFont:FontSize20 constrainedToSize:CGSizeMake(220, 1000) lineBreakMode:NSLineBreakByWordWrapping];
        
        CGRect serFrame = cell._shopContent.frame;
        serFrame.size.height = contentSize.height;
        cell._shopContent.frame = serFrame;
        
        CGRect horFrame = cell._horizontalView.frame;
        horFrame.origin.y = contentSize.height + 49;
        cell._horizontalView.frame = horFrame;
        
        CGRect verFrame = cell._verticalView.frame;
        verFrame.size.height = contentSize.height + 50;
        cell._verticalView.frame = verFrame;
        
        CGRect backFrame = cell._imageView.frame;
        backFrame.size.height = contentSize.height + 40;
        cell._imageView.frame = backFrame;

        cell._shopDate.text = str;
        cell._shopContent.text = shopCommentInfo._comReplyContent;
        return cell;
    }
}

- (void)isrefreshHeaderView
{
	if (self.isfromRecomend) {
		if (_refreshHeaderView) {
//			myView.contentSize = CGSizeMake(myView.frame.size.width, myView.contentSize.height-65.0f);
			[_refreshHeaderView removeFromSuperview];
			_refreshHeaderView = nil;
		}
		
	}
	else {
		if (!_refreshHeaderView) {
			_refreshHeaderView = [[EGORefreshTableHeaderView alloc] init];
			_refreshHeaderView.delegate = self;
			_refreshHeaderView.backgroundColor= [UIColor clearColor];
			[myView addSubview:_refreshHeaderView];
			[_refreshHeaderView refreshLastUpdatedDate];
		}
	}
}

- (void)loadFitstDataSource
{
	[myView reloadData];
	
	_refreshHeaderView.frame=CGRectMake(0.0f, myView.contentSize.height, myView.frame.size.width, 80);
	[self doneLoadingTableViewData];
	
}

-(void)setHeaderView
{
    if(pageIndex == [self._commentData._totalPage intValue])
    {
        self.isfromRecomend = YES;
        [self isrefreshHeaderView];
//        myView.contentSize = CGSizeMake(myView.frame.size.width, myView.contentSize.height-65.0f);
        return;
    }
    _refreshHeaderView.frame=CGRectMake(0.0f, myView.contentSize.height, myView.frame.size.width, 80);
    [self doneLoadingTableViewData];
}

-(void)loadDataSource
{
    ASIFormDataRequest * theRequest = [InterfaceClass getShopCommentList:nil withShopId:self._shopId withStar:self._starLv withFilter:@"0" withPageIndex:[NSString stringWithFormat:@"%d",pageIndex] withPageSize:@"20"];
    [[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onPaseredShopCommentResult:) Delegate:self needUserType:Default];
}

-(void)onPaseredShopCommentResult:(NSDictionary*)dic
{
    if([[dic objectForKey:@"statusCode"] isEqualToString:@"0"])
    {
        if(pageIndex == 1) {
            
            self._commentData = [ShopForCommentData setShopForCommentData:dic];
            
            if ([self._commentData._totalPage intValue] < 2) {
             
                self.isfromRecomend = YES;
                [self isrefreshHeaderView];
            }
        }
        else {
            ShopForCommentData *shopCommentData = [ShopForCommentData setShopForCommentData:dic];
            [self._commentData._commentArr addObjectsFromArray:shopCommentData._commentArr];
        }
        
        [myView reloadData];
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
    if (pageIndex == self._commentData._commentArr.count)
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
	[_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:myView];
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
