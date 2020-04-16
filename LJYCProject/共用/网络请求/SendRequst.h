//
//  SendRequst.h
//  FlightProject
//
//  Created by longcd on 12-6-6.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

/* 本类用于向服务器发送请求 */
#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"

#define ShowNetErrorMessage 0

@protocol SendRequstDelegate;

@interface SendRequst : NSObject <NSXMLParserDelegate,NSURLConnectionDelegate,NSURLConnectionDataDelegate,ASIHTTPRequestDelegate>

@property (nonatomic,retain) id <SendRequstDelegate> delegate;
@property (nonatomic,retain) ASIFormDataRequest * myRequest;
@property (nonatomic,assign) SEL  aSelector;
@property (nonatomic,retain) id aDelegate;

-(void)sendRequstAsiFormHttp:(ASIFormDataRequest *)theRequest;
-(void)sendRequstAsiFormHttps:(ASIFormDataRequest *)theRequest;

@end

@protocol SendRequstDelegate <NSObject>
-(void)requestResultFinished:(SendRequst *)sendR resultDic:(NSDictionary *)dic;
-(void)requestResultFailed:(SendRequst *)sendR;
@end