//
//  PicModel.h
//  LJYCProject
//
//  Created by gaopengcheng on 13-11-20.
//  Copyright (c) 2013年 longcd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PicModel : NSObject
@property (nonatomic, retain) UIImage *_image;
@property (nonatomic ,retain) NSString *_imgName;
@property (nonatomic ,retain) NSString *_imgType;
@property (nonatomic ,retain) NSString *_imgTypeName;
@property (nonatomic ,retain) NSString *_imgId;
@property (nonatomic, retain) NSString *_shopName;
@property (nonatomic, retain) NSString *_shopId;
@property (nonatomic, retain) NSString *_smallUrl;
@property (nonatomic, retain) NSString *_largeUrl;
@property (nonatomic, retain) NSString *_uploader;
@property (nonatomic, retain) NSString *_uploadTime;
@property (nonatomic, retain) NSString *_isTrader;

+ (NSMutableArray *)memberPhotoData:(NSDictionary *)dic;
+ (NSMutableArray *)shopPhotoData:(NSDictionary *)dic;
@end

@interface PicListModel : NSObject
@property (nonatomic, retain) NSString *_totalPage;
@property (nonatomic ,retain) NSString *_count;
@property (nonatomic ,retain) NSMutableArray *_picArray;

+ (PicListModel *)shopPicListData:(NSDictionary *)dic;
+ (PicListModel *)memberPicListData:(NSDictionary *)dic;
@end