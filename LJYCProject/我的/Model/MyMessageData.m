//
//  MyMessageData.m
//  LJYCProject
//
//  Created by xiemengyue on 13-11-13.
//  Copyright (c) 2013年 longcd. All rights reserved.
//

#import "MyMessageData.h"

@implementation MyMessageData
@synthesize totalPage,count,messagesAry;

- (void)dealloc
{
    self.totalPage = nil;
    self.count = nil;
    self.messagesAry = nil;
    
    [super dealloc];
}

+(MyMessageData*)getMyMessageData:(NSDictionary*)dic
{
    if (![dic isKindOfClass:[NSDictionary class]]) {
		return nil;
	}
    
    MyMessageData *myMessageData = [[[MyMessageData alloc] init] autorelease];
    myMessageData.totalPage = [dic objectForKey:@"totalPage"];
    myMessageData.count = [dic objectForKey:@"count"];
    
    NSArray *messagesArray = [dic objectForKey:@"messages"];
    if([messagesArray isKindOfClass:[NSArray class]] && ![messagesArray isEqual:@""])
    {
        NSMutableArray *myMessagesArray = [[NSMutableArray alloc] init];
        for(NSDictionary *aDic in messagesArray)
        {
            Message *aMessage = [[Message alloc] init];
            aMessage._id = [NSString stringWithFormat:@"%@",[aDic objectForKey:@"id"]];
            aMessage._title = [NSString stringWithFormat:@"%@",[aDic objectForKey:@"title"]];
            aMessage._time = [NSString stringWithFormat:@"%@",[aDic objectForKey:@"time"]];
            aMessage._content = [NSString stringWithFormat:@"%@",[aDic objectForKey:@"content"]];
            aMessage._picUrl = [NSString stringWithFormat:@"%@",[aDic objectForKey:@"picUrl"]];
            
            [myMessagesArray addObject:aMessage];
            [aMessage release];
        }
        myMessageData.messagesAry = myMessagesArray;
    }
    
    if ([myMessageData.messagesAry count] == 0) {
		myMessageData.messagesAry = nil;
	}
    
    return myMessageData;
}
@end


@implementation Message
@synthesize _id,_content,_picUrl,_time,_title;
- (void)dealloc
{
    self._title = nil;
    self._id = nil;
    self._content = nil;
    self._picUrl = nil;
    self._time = nil;
    
    [super dealloc];
}

@end