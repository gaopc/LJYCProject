//
//  ShopForQuestionData.h
//  LJYCProject
//
//  Created by gaopengcheng on 13-11-8.
//  Copyright (c) 2013年 longcd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShopForQuestionData : NSObject
@property (nonatomic, retain) NSString *_totalPage;
@property (nonatomic, retain) NSString *_count;
@property (nonatomic, retain) NSMutableArray *_questionArr;

+ (ShopForQuestionData *)setShopForQuestionData:(NSDictionary *)dic;
@end


@interface ShopForQuestionInfo : NSObject
@property (nonatomic, retain) NSString *_comId;
@property (nonatomic, retain) NSString *_comName;
@property (nonatomic, retain) NSString *_comTime;
@property (nonatomic, retain) NSString *_comContent;
@property (nonatomic, retain) NSString *_comReplyTime;
@property (nonatomic, retain) NSString *_comReplyContent;

+ (ShopForQuestionInfo *)setShopForQuestionInfo:(NSDictionary *)dic;
@end
