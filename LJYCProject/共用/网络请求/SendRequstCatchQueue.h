//
//  SendRequstCatchQueue.h
//  FlightProject
//
//  Created by longcd on 12-6-6.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

/* 本类用于生成请求队列 */
#import <UIKit/UIKit.h>
#import "SendRequst.h"
#import "WaitView.h"
#import "MyExtend.h"

typedef enum {
    Default,
    Member,
    NoMember,
    DidNoMember,
} UserType;

@interface SendRequstCatchQueue : NSObject<SendRequstDelegate,WaitViewDelegate>

@property (nonatomic,retain) NSMutableArray * catchArray;
@property (nonatomic,assign) SEL  aSelector;
@property (nonatomic,retain) id aDelegate;

+(SendRequstCatchQueue *)shareSendRequstCatchQueue;
// 三期
-(void)sendRequstCatchQueue:(ASIFormDataRequest *)theRequest Selector:(SEL)aselector Delegate :(id)adelegate needUserType:(UserType)needUserType;

@end
