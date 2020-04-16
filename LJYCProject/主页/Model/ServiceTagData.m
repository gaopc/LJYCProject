//
//  ServiceTagData.m
//  LJYCProject
//
//  Created by xiemengyue on 13-11-4.
//  Copyright (c) 2013年 longcd. All rights reserved.
//

#import "ServiceTagData.h"
#import "UserLogin.h"
#import "ServiceTag.h"

//@implementation Tag
//
//@synthesize _id,_name,_type;
//
//-(void)dealloc
//{
//    self._id = nil;
//    self._name = nil;
//    self._type = nil;
//    
//    [super dealloc];
//}
//
//@end

@implementation ServiceTagData
@synthesize serviceTagDic;

+(NSDictionary*)getServiceTagData:(NSDictionary*)dic
{
    NSArray *serviceTagList = [dic objectForKey:@"serviceTag"];
    
    NSMutableDictionary *aServiceTagDic = [[[NSMutableDictionary alloc] init] autorelease];
    NSMutableArray *qitaTagAry = [NSMutableArray array];
    NSMutableArray *canyinTagAry = [NSMutableArray array];
    NSMutableArray *zhusuTagAry = [NSMutableArray array];
    NSMutableArray *shineiTagAry = [NSMutableArray array];
    NSMutableArray *shiwaiTagAry = [NSMutableArray array];

    
    if([serviceTagList isKindOfClass:[NSArray class]] && serviceTagList != nil)
    {
        for (NSDictionary *serviceTag in serviceTagList) {
            
            ServiceTag * aTag = [[ServiceTag alloc] init];
            aTag._tag_id = [NSString stringWithFormat:@"%@",[serviceTag objectForKey:@"id"]];
            aTag._tag_name = [NSString stringWithFormat:@"%@",[serviceTag objectForKey:@"name"]];
            aTag._tag_type = [NSString stringWithFormat:@"%@",[serviceTag objectForKey:@"type"]];
            
            switch ([[serviceTag objectForKey:@"type"] intValue]) {
                case 0:
                    [qitaTagAry addObject:aTag];
                    break;
                case 1:
                    [canyinTagAry addObject:aTag];
                    break;
                case 2:
                    [zhusuTagAry addObject:aTag];
                    break;
                case 3:
                    [shineiTagAry addObject:aTag];
                    break;
                case 4:
                    [shiwaiTagAry addObject:aTag];
                    break;
                default:
                    break;
            }

            [aTag release];
        }
        
        if([qitaTagAry count] == 0)
            qitaTagAry = nil;
        if([canyinTagAry count] == 0)
            canyinTagAry = nil;
        if([zhusuTagAry count] == 0)
            zhusuTagAry = nil;
        if([shineiTagAry count] == 0)
            shineiTagAry = nil;
        if([shiwaiTagAry count] == 0)
            shiwaiTagAry = nil;
        
        [aServiceTagDic setObject:qitaTagAry forKey:@"其他"];
        [aServiceTagDic setObject:canyinTagAry forKey:@"餐饮"];
        [aServiceTagDic setObject:zhusuTagAry forKey:@"住宿"];
        [aServiceTagDic setObject:shineiTagAry forKey:@"室内"];
        [aServiceTagDic setObject:shiwaiTagAry forKey:@"室外"];

    }

    return aServiceTagDic;
}
@end
