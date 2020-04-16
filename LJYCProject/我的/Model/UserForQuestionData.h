//
//  UserForQuestionData.h
//  LJYCProject
//
//  Created by xiemengyue on 13-11-12.
//  Copyright (c) 2013年 longcd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserForQuestionData : NSObject
@property (nonatomic, retain) NSString *_totalPage;
@property (nonatomic, retain) NSString *_count;
@property (nonatomic, retain) NSMutableArray *_questionArr;

+ (UserForQuestionData *)setUserForQuestionData:(NSDictionary *)dic;
@end


@interface UserForQuestionInfo : NSObject
@property (nonatomic, retain) NSString *_shopId;
@property (nonatomic, retain) NSString *_shopName;
@property (nonatomic, retain) NSString *_shopStar;
@property (nonatomic, retain) NSString *_id;
@property (nonatomic, retain) NSString *_time;
@property (nonatomic, retain) NSString *_content;
@property (nonatomic, retain) NSString *_replyTime;
@property (nonatomic, retain) NSString *_replyContent;

+ (UserForQuestionInfo *)setUserForQuestionInfo:(NSDictionary *)dic;
@end