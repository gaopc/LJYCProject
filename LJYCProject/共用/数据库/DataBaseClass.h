//
//  DataBaseClass.h
//  FlightProject
//
//  Created by longcd on 12-6-4.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

// 抽象的sql语句  被  DataClass类调用
/*
 
 使用方法：
 一. 查询方法
       1. 参数elem，指的是要查询的列名的集合
       2. 参数tablename，值得是查询的表的名称，可以是多个表名(用逗号分隔)，在这里只用作写日志，在拼接sql语句的时候该参数无用
       3. 参数conditions，指的是sql语句中from后面的字符串
       4. 返回是一个二维数组（一列N行 ）每一行都是一条记录
 二. 插入方法
       1. 参数table，指的是表名
       2. 参数elem，指的是要查询的列名的集合
       3. 参数dataArray，指的是要插入的数据的集合，是个二维数组（一列N行 ）每一行都是一条数据
       4. 返回布尔类型，表示是否插入成功
 三. 修改方法
       1. 参数table，指的是表名
       2. 参数elem，指的是要查询的列名的集合
       3. 参数dataArray，指的是要插入的数据的集合，是个二维数组（一列N行 ）每一行都是一条数据
       4. 返回布尔类型，表示是否插入成功
 四. 删除方法
       1. 参数table，指的是表名
       2. 返回布尔类型，表示是否插入成功
 五. 删除方法
       1. 参数table，指的是表名
       2. 参数where，指的是删除某个条件下的一些记录 
       3. 返回布尔类型，表示是否插入成功
 
 总结：以上方法使用时的参数和宏定义一一对应
 
 */
#import <Foundation/Foundation.h>
#import "DB.h"

#define  SELECT  @" select %@ from %@"
#define  INSERT @" insert or replace into %@ (%@) values (%@) "
#define  UPDATE @" update %@ set %@ "
#define  DELETE @" delete from %@ "
#define  DeleteWhere @ " delete from %@ where %@"

@interface DataBaseClass : NSObject

+(NSArray *) selectWithElem:(NSArray *)elem WithTablename:(NSString *)tableName WithConditions:(NSString *)conditions; 
+(BOOL) insertWithTable:(NSString *)table WithElem:(NSArray *)elem WithData:(NSArray *)dataArray; 
+(BOOL) updateWithTable:(NSString *)table WithElem:(NSArray *)elem WithData:(NSArray *)dataArray WithWhere:(NSString *) where;
+(BOOL) deleteWithTable:(NSString *)table;
+(BOOL) deleteWithTable:(NSString *)table WithARecord:(NSString *) where;

@end
 