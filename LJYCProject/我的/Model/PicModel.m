//
//  PicModel.m
//  LJYCProject
//
//  Created by gaopengcheng on 13-11-20.
//  Copyright (c) 2013年 longcd. All rights reserved.
//

#import "PicModel.h"

@implementation PicModel
@synthesize _image, _imgName, _imgType, _imgId, _imgTypeName;
@synthesize _largeUrl, _shopId, _shopName, _smallUrl, _uploader, _uploadTime, _isTrader;

- (void)dealloc
{
    self._imgType = nil;
    self._imgName = nil;
    self._image = nil;
    self._imgTypeName = nil;
    self._imgId = nil;
    self._uploader = nil;
    self._smallUrl = nil;
    self._largeUrl = nil;
    self._shopName = nil;
    self._shopId = nil;
    self._uploadTime = nil;
    self._isTrader = nil;
    [super dealloc];
}

+ (NSMutableArray *)memberPhotoData:(NSDictionary *)dic
{
    if (![dic isKindOfClass:[NSDictionary class]]) {
		return nil;
	}
    
    
    NSMutableArray *returnArr = [NSMutableArray array];
    NSArray *dataArr = [dic objectForKey:@"pictures"];
    
    
    for (NSDictionary *picDic in dataArr) {
        
        PicModel *model = [[PicModel alloc] init];
        model._imgId = [NSString stringWithFormat:@"%@", [picDic objectForKey:@"id"]];
        model._imgName = [NSString stringWithFormat:@"%@", [picDic objectForKey:@"name"]];
        model._shopId = [NSString stringWithFormat:@"%@", [picDic objectForKey:@"shopId"]];
        model._shopName = [NSString stringWithFormat:@"%@", [picDic objectForKey:@"shopName"]];
        model._smallUrl = [NSString stringWithFormat:@"%@", [picDic objectForKey:@"urlSmall"]];
        model._largeUrl = [NSString stringWithFormat:@"%@", [picDic objectForKey:@"urlLarge"]];
        model._uploader = [NSString stringWithFormat:@"%@", [picDic objectForKey:@"uploader"]];
        model._imgType = [NSString stringWithFormat:@"%@", [picDic objectForKey:@"type"]];
        model._uploadTime = [NSString stringWithFormat:@"%@", [picDic objectForKey:@"time"]];
        
        [returnArr addObject:model];
        [model release];
    }
    
    return returnArr;
}

+ (NSMutableArray *)shopPhotoData:(NSDictionary *)dic
{
    if (![dic isKindOfClass:[NSDictionary class]]) {
		return nil;
	}
    
    
    NSMutableArray *returnArr = [NSMutableArray array];
    NSArray *dataArr = [dic objectForKey:@"pictures"];
    
    
    for (NSDictionary *picDic in dataArr) {
        
        PicModel *model = [[PicModel alloc] init];
        model._imgName = [NSString stringWithFormat:@"%@", [picDic objectForKey:@"name"]];
        model._smallUrl = [NSString stringWithFormat:@"%@", [picDic objectForKey:@"urlSmall"]];
        model._largeUrl = [NSString stringWithFormat:@"%@", [picDic objectForKey:@"urlLarge"]];
        model._uploader = [NSString stringWithFormat:@"%@", [picDic objectForKey:@"uploader"]];
        model._imgType = [NSString stringWithFormat:@"%@", [picDic objectForKey:@"type"]];
        model._uploadTime = [NSString stringWithFormat:@"%@", [picDic objectForKey:@"time"]];
        model._isTrader = [NSString stringWithFormat:@"%@", [picDic objectForKey:@"isTrader"]];
        
        [returnArr addObject:model];
        [model release];
    }
    
    return returnArr;
}
@end


@implementation PicListModel
@synthesize _count, _picArray, _totalPage;

- (void)dealloc
{
    self._totalPage = nil;
    self._count = nil;
    self._picArray = nil;
    [super dealloc];
}

+ (PicListModel *)shopPicListData:(NSDictionary *)dic
{
    if (![dic isKindOfClass:[NSDictionary class]]) {
		return nil;
	}
    PicListModel *listModel = [[[PicListModel alloc] init] autorelease];
    listModel._totalPage = [NSString stringWithFormat:@"%@", [dic objectForKey:@"totalPage"]];
    listModel._count = [NSString stringWithFormat:@"%@", [dic objectForKey:@"count"]];
    listModel._picArray = [PicModel shopPhotoData:dic];
    
    return listModel;
}

+ (PicListModel *)memberPicListData:(NSDictionary *)dic
{
    if (![dic isKindOfClass:[NSDictionary class]]) {
		return nil;
	}
    PicListModel *listModel = [[[PicListModel alloc] init] autorelease];
    listModel._totalPage = [NSString stringWithFormat:@"%@", [dic objectForKey:@"totalPage"]];
    listModel._count = [NSString stringWithFormat:@"%@", [dic objectForKey:@"count"]];
    listModel._picArray = [PicModel memberPhotoData:dic];
    
    return listModel;
}
@end