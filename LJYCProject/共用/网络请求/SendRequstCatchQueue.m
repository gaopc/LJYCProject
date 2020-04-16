//
//  SendRequstCatchQueue.m
//  FlightProject
//
//  Created by longcd on 12-6-6.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "SendRequstCatchQueue.h"
#import "NSDate+convenience.h"
#import "Header.h"
#import "RootViewController.h"
@implementation SendRequstCatchQueue
@synthesize aDelegate,aSelector;
@synthesize catchArray;
-(void)dealloc
{
    self.catchArray = nil;
    self.aDelegate = nil;
    self.aSelector = nil;
    [super dealloc];
}
+(SendRequstCatchQueue *)shareSendRequstCatchQueue
{
    static SendRequstCatchQueue * instance = nil;
    if (instance == nil) {
        instance = [[SendRequstCatchQueue alloc] init];
    }
    return instance;
}
-(id)init
{
    if (self = [super init]) {
        self.catchArray = [NSMutableArray array] ;
    }
    return self;
}
// 三期
-(void)sendRequstCatchQueue:(ASIFormDataRequest *)_theRequest Selector:(SEL)_aselector Delegate :(id)_adelegate needUserType:(UserType)_needUserType
{
    if (![_adelegate isKindOfClass:NSClassFromString(@"GetBasicInfoFromServer")]) {
        [WaitView showWaitView];
        [WaitView shareWaitView].delegate = self;
    }
    self.aSelector = _aselector;
    self.aDelegate = _adelegate;
    SendRequst * sendRequst = [[SendRequst alloc] init];
    sendRequst.aSelector = _aselector;
    sendRequst.aDelegate = _adelegate;
    sendRequst.delegate = self;
    [self.catchArray addObject:sendRequst];
    [sendRequst release];
    NSString * requestUrl = [NSString stringWithFormat:@"%@",_theRequest.url];
    NSLog(@"%@",requestUrl);
    if ([[[requestUrl componentsSeparatedByString:@":"] objectAtIndex:0] isEqualToString:@"http"]) {
        [sendRequst sendRequstAsiFormHttp:_theRequest];
    }
    else {
        [sendRequst sendRequstAsiFormHttps:_theRequest];
    }
}

-(void)requestResultFinished:(SendRequst *)sendR resultDic:(NSDictionary *)dic
{
    if(sendR.aDelegate && [sendR.aDelegate respondsToSelector:sendR.aSelector]) {
        [sendR.aDelegate performSelector:sendR.aSelector withObject:dic];
    }
    [self.catchArray removeObject:sendR];
    if ([self.catchArray count]==0) {
         [WaitView hiddenWaitView];
    }
}
-(void)requestResultFailed:(SendRequst *)sendR
{
    if(sendR.aDelegate && [sendR.aDelegate respondsToSelector:sendR.aSelector]) {
        if ([NSStringFromSelector(sendR.aSelector) isEqualToString:@"onConfigurationPaseredResult:" ]) {
            [sendR.aDelegate performSelector:NSSelectorFromString(@"onConfigurationPaseredResultFail:") withObject:nil];
        }
    }
    [self.catchArray removeObject:sendR];
    if ([self.catchArray count]==0) {
        [WaitView hiddenWaitView];
    }
}
-(void)cancelRequst
{
    [self.catchArray removeAllObjects];
    [WaitView hiddenWaitView];
}
@end

