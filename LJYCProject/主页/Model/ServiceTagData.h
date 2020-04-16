//
//  ServiceTagData.h
//  LJYCProject
//
//  Created by xiemengyue on 13-11-4.
//  Copyright (c) 2013年 longcd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ServiceTagData : NSObject

@property(nonatomic,retain) NSDictionary *serviceTagDic;

+(NSDictionary*)getServiceTagData:(NSDictionary*)dic;
@end
