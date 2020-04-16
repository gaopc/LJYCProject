//
//  MyMessageData.h
//  LJYCProject
//
//  Created by xiemengyue on 13-11-13.
//  Copyright (c) 2013年 longcd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyMessageData : NSObject
@property(nonatomic,retain)NSString *totalPage;
@property(nonatomic,retain)NSString *count;
@property(nonatomic,retain)NSMutableArray *messagesAry;

+(MyMessageData*)getMyMessageData:(NSDictionary*)dic;
@end

@interface Message : NSObject
@property(nonatomic,retain)NSString *_id;
@property(nonatomic,retain)NSString *_title;
@property(nonatomic,retain)NSString *_time;
@property(nonatomic,retain)NSString *_content;
@property(nonatomic,retain)NSString *_picUrl;
@end