//
//  UserForCommentData.h
//  LJYCProject
//
//  Created by xiemengyue on 13-11-12.
//  Copyright (c) 2013年 longcd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserForCommentData : NSObject
@property (nonatomic, retain) NSString *_totalPage;
@property (nonatomic, retain) NSString *_count;
@property (nonatomic, retain) NSMutableArray *_commentArr;

+ (UserForCommentData *)setUserForCommentData:(NSDictionary *)dic;
@end

@interface UserForCommentInfo : NSObject
@property (nonatomic, retain) NSString *_shopId;//店铺id
@property (nonatomic, retain) NSString *_shopName;//店铺名称
@property (nonatomic, retain) NSString *_shopStar;//用户对店铺的点评星级
@property (nonatomic, retain) NSString *_id;//点评Id
@property (nonatomic, retain) NSString *_star;//点评星级
@property (nonatomic, retain) NSString *_time;//点评时间
@property (nonatomic, retain) NSString *_content;//点评内容
@property (nonatomic, retain) NSString *_replyTime;//商家回复时间
@property (nonatomic, retain) NSString *_replyContent;//商家回复内容

+ (UserForCommentInfo *)setUserForCommentInfo:(NSDictionary *)dic;
@end
