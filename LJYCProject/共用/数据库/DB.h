//
//  DB.h
//  FlightProject
//
//  Created by longcd on 12-6-20.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//
// 打开关闭数据库 被  DataBaseClass类来调用
#import <UIKit/UIKit.h>
#import "sqlite3.h"
@interface DB : NSObject

+(sqlite3 *)openDB;
+(void)closeDB:(sqlite3 *)_database;

@end
