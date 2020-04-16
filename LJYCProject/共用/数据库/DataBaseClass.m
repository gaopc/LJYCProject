//
//  DataBaseClass.m
//  FlightProject
//
//  Created by longcd on 12-6-4.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "DataBaseClass.h"

@interface DataBaseClass (privite)

+(NSString *) SelectStringWithArray:(NSArray *) array;  // 返回字符串  数组中元素用逗号分隔
+(NSString *) InsertIntoStringWithArray:(NSArray *)array;  // 返回字符串  ？，？。。。。
+(NSString *) UpdateStringWithArray:(NSArray *)array;  // 返回字符串  数组中元素 =？，分隔
+(void) wirteLogWithTablename:(NSString *)tablename option:(NSString *)option result:(NSString *)result backup:(NSString *)backup ;  // 写日志

@end

@implementation DataBaseClass (privite)

+(NSString *) SelectStringWithArray:(NSArray *) array
{
    NSMutableString * str = [NSMutableString stringWithFormat:@"%@",[array objectAtIndex:0]];
    for (int i = 1; i < [array count]; i++) {
        [str appendFormat:@"%@",[NSString stringWithFormat:@", %@",[array objectAtIndex:i]]];
    }
    return str;
}
+(NSString *) InsertIntoStringWithArray:(NSArray *)array
{
    NSMutableString * str = [NSMutableString stringWithString:@"?"];
    for (int i = 1; i < [array count]; i++) {
        [str appendString:@",?"];
    }
    return str;
}
+(NSString *) UpdateStringWithArray:(NSArray *)array
{
    NSMutableString * str = [NSMutableString stringWithFormat:@"%@=?",[array objectAtIndex:0]];
    for (int i = 1; i < [array count]; i++) {
        [str appendFormat:@"%@",[NSString stringWithFormat:@",  %@=?",[array objectAtIndex:i]]];
    }
    return str;
}
+(void) wirteLogWithTablename:(NSString *)tablename option:(NSString *)option  result:(NSString *)result backup:(NSString *)backup
{
    //打开数据库
    sqlite3 *db = [DB openDB];
    sqlite3_stmt *stmt = nil;
    @try {
        
        NSString * sql = [NSString stringWithFormat:INSERT,@"OptionLog",@"table_name,option,option_time,result,backup",@"?,?,datetime('now'),?,?"];
        
        if (sqlite3_prepare_v2(db, [sql UTF8String], -1, &stmt, nil) == SQLITE_OK) {
            sqlite3_bind_text(stmt, 1, [tablename UTF8String],-1,NULL);
            sqlite3_bind_text(stmt, 2, [option UTF8String],-1,NULL);
            sqlite3_bind_text(stmt, 3, [result UTF8String],-1,NULL);
            sqlite3_bind_text(stmt, 4, [backup UTF8String],-1,NULL);
        }
        int result = sqlite3_step(stmt);
        if (result != SQLITE_DONE) {
            NSLog( @"%d",result);
        }
        
    }
    @catch (NSException *exception) {
    }
    @finally
    {
        sqlite3_finalize(stmt);
        [DB closeDB:db];
    }
    
}

@end

@implementation DataBaseClass

+(NSArray *) selectWithElem:(NSArray *)elem WithTablename:(NSString *)tableName WithConditions:(NSString *)conditions
{
    NSMutableArray *dataArray = nil;
    sqlite3 *db = [DB  openDB];
    sqlite3_stmt *stmt = nil;
    NSString * sql = [NSString stringWithFormat:SELECT,[self SelectStringWithArray:elem],conditions];
    //NSLog(@"%@",sql);
    int result = sqlite3_prepare_v2(db, [sql  UTF8String], -1, &stmt, nil);
    if(result == SQLITE_OK)
    {
        dataArray = [[NSMutableArray alloc] init];
        while(SQLITE_ROW == sqlite3_step(stmt))
        {
            NSMutableArray * aRecode = [NSMutableArray array];
            for (int i=0; i<[elem count]; i++) {
                const char * str =  (const char *)sqlite3_column_text(stmt, i);
                if (str) {
                    [aRecode addObject:[NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, i)]];
                }
                else
                {
                    [aRecode addObject:@""];
                }
            }
            [dataArray addObject:aRecode];
        }
        //[self wirteLogWithTablename:tableName option:@"查询"  result:@"成功" backup:@""];
    }
    else
    {
        NSLog(@"find all failed with result:%d",result);
        //[self wirteLogWithTablename:tableName option:@"查询"  result:@"失败" backup:@""];
    }
    sqlite3_finalize(stmt);//结束sql
    [DB closeDB:db];
    return [dataArray autorelease];
}
+(BOOL) insertWithTable:(NSString *)table WithElem:(NSArray *)elem WithData:(NSArray *)dataArray
{
    
    BOOL returnBool = FALSE;
    //打开数据库
    sqlite3 *db = [DB openDB];
    char* errorMsg;
    sqlite3_stmt *stmt = nil;
    @try {
        if (sqlite3_exec(db, "BEGIN", NULL, NULL, &errorMsg) == SQLITE_OK) 
        {
            
            //NSLog(@"启动事物成功");
            [self wirteLogWithTablename:table option:@"插入"  result:@"" backup:@"启动事物成功"];

            NSString * sql = [NSString stringWithFormat:INSERT,table,[self SelectStringWithArray:elem],[self InsertIntoStringWithArray:elem]];
            for (int i = 0; i<[dataArray count]; i++)
            {
                if (sqlite3_prepare_v2(db, [sql UTF8String], -1, &stmt, nil) == SQLITE_OK) 
                {
                    NSArray * elemData = [dataArray objectAtIndex:i];
                    for (int j = 0; j < [elemData count]; j++) 
                    {
                        NSString * cloumn = [NSString stringWithFormat:@"%@",[elemData objectAtIndex:j]];
                        sqlite3_bind_text(stmt, j+1, [cloumn UTF8String],-1,NULL);
                    }
                }
                int result = sqlite3_step(stmt);
                if (result == SQLITE_DONE) {
                    returnBool = YES;
                    //[self wirteLogWithTablename:table option:@"插入"  result:@"成功" backup:@""];
                }
                else {
                    NSString * errorResult = [NSString stringWithFormat:@"第%d条插入失败",i];
                    returnBool = FALSE;
                    [self wirteLogWithTablename:table option:@"插入"  result:errorResult backup:@""];
                    break;
                }
            }
            
            if (sqlite3_exec(db, "COMMIT", NULL, NULL, &errorMsg) == SQLITE_OK) 
            {
                //NSLog(@"提交事务成功");
            }
        }
        else 
        {
            NSLog(@"启动事物失败");
            [self wirteLogWithTablename:table option:@"插入"  result:@"失败" backup:@"事物启动失败"];
            sqlite3_free(errorMsg);
        }
    }
    @catch (NSException *exception) {
        if( sqlite3_exec(db, "ROLLBACK", NULL, NULL, &errorMsg) == SQLITE_OK)
        {
            NSLog(@"回滚事物成功");
            [self wirteLogWithTablename:table option:@"插入"  result:@"失败" backup:@"出现异常，回滚事物成功"];
        }
        else 
        {
            NSLog(@"回滚事物失败");
            [self wirteLogWithTablename:table option:@"插入"  result:@"失败" backup:@"出现异常，回滚事物失败"];
            sqlite3_free(errorMsg);
        }
    }
    @finally
    {
        sqlite3_finalize(stmt);
        [DB closeDB:db];
    }
    return returnBool;
}

+(BOOL) updateWithTable:(NSString *)table WithElem:(NSArray *)elem WithData:(NSArray *)dataArray WithWhere:(NSString *) where
{
    BOOL returnBool = FALSE;
    //打开数据库
    sqlite3 *db = [DB openDB];
    char* errorMsg;
    sqlite3_stmt *stmt = nil;
    @try {
        if (sqlite3_exec(db, "BEGIN", NULL, NULL, &errorMsg) == SQLITE_OK) 
        {
            //NSLog(@"启动事物成功");
            [self wirteLogWithTablename:table option:@"更新"  result:@"" backup:@"启动事物成功"];
            NSString * sql = [NSString stringWithFormat:UPDATE,table,where?[[self UpdateStringWithArray:elem] stringByAppendingFormat:@"%@",where] : [self UpdateStringWithArray:elem]];
            //NSLog(@"%@",sql);
            for (int i = 0; i<[dataArray count]; i++) 
            {
                if (sqlite3_prepare_v2(db, [sql UTF8String], -1, &stmt, nil) == SQLITE_OK) {
                    NSArray * elemData = [dataArray objectAtIndex:i];
                    for (int j = 0; j < [elemData count]; j++) {
                        NSString * cloumn = [NSString stringWithFormat:@"%@",[elemData objectAtIndex:j]];
                        sqlite3_bind_text(stmt, j+1, [cloumn UTF8String],-1,NULL);
                    }
                }
                int result = sqlite3_step(stmt);
                if (result == SQLITE_DONE) {
                    //NSLog( @"%@",result);
                    //[self wirteLogWithTablename:table option:@"更新"  result:@"成功" backup:@""];
                    returnBool = YES;
                }
                else {
                    NSString * errorResult = [NSString stringWithFormat:@"第%d条更新失败",i];
                    [self wirteLogWithTablename:table option:@"更新"  result:errorResult backup:@"回滚失败"];
                    returnBool = FALSE;
                    break;
                }
            }
            if (sqlite3_exec(db, "COMMIT", NULL, NULL, &errorMsg) == SQLITE_OK) 
            {
                //NSLog(@"提交事务成功");
            }
        }
        else 
        {
            //NSLog(@"启动事物失败");
            [self wirteLogWithTablename:table option:@"更新"  result:@"失败" backup:@"启动事物失败"];
            sqlite3_free(errorMsg);
        }
    }
    @catch (NSException *exception) {
        if( sqlite3_exec(db, "ROLLBACK", NULL, NULL, &errorMsg) == SQLITE_OK)
        {
            //NSLog(@"回滚事物成功");
            [self wirteLogWithTablename:table option:@"更新"  result:@"异常" backup:@"回滚事物成功"];
        }
        else 
        {
            //NSLog(@"回滚事物失败");
            [self wirteLogWithTablename:table option:@"更新"  result:@"异常" backup:@"回滚事物失败"];
            sqlite3_free(errorMsg);
        }
    }
    @finally
    {
        sqlite3_finalize(stmt);
        [DB closeDB:db];
    }
    return returnBool;
}

+(BOOL) deleteWithTable:(NSString *)table
{
    sqlite3 *db = [DB openDB];
    NSString * sql = [NSString stringWithFormat:DELETE,table];
    //NSLog(@"%@",sql);
    sqlite3_stmt *stmt = nil;
    sqlite3_prepare_v2(db, [sql UTF8String], -1, &stmt, nil);
    int result = sqlite3_step(stmt);
    sqlite3_finalize(stmt);
    [DB closeDB:db];
    if (result == SQLITE_DONE) {
        [self wirteLogWithTablename:table option:@"删除整个表数据"  result:@"成功" backup:@""];
        return YES;
    }
    else {
        [self wirteLogWithTablename:table option:@"删除整个表数据"  result:@"失败" backup:@""];
        return NO;
    }
}
+(BOOL) deleteWithTable:(NSString *)table WithARecord:(NSString *) where
{
    sqlite3 *db = [DB openDB];
    NSString * sql = [NSString stringWithFormat:DeleteWhere,table,where];
    //NSLog(@"%@",sql);
    sqlite3_stmt *stmt = nil;
    sqlite3_prepare_v2(db, [sql UTF8String], -1, &stmt, nil);
    int result = sqlite3_step(stmt);
    sqlite3_finalize(stmt);
    [DB closeDB:db];
    if (result == SQLITE_DONE) {
        [self wirteLogWithTablename:table option:@"删除表中的某条记录"  result:@"成功" backup:@""];
        return YES;
    }
    else {
        [self wirteLogWithTablename:table option:@"删除表中的某条记录"  result:@"失败" backup:@""];
        return NO;
    }
}

@end
