//
//  DB.m
//  FlightProject
//
//  Created by longcd on 12-6-20.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//
// 打开关闭数据库
#import "DB.h"

@implementation DB
#define SQL_BUSY_SLEEP_MIC 500 //500 毫秒.


+(void) createTables
{
//    char *errorMessage;
//    
//    NSString *createSQL = nil;
//    //1 创建舱位信息表
//    createSQL = @"create table if not exists BunkInfo(airport_code text , cabin_code text, cabin_name text,standard_cabin_code text , primary key(airport_code,cabin_code) );";
//    if(sqlite3_exec(database, [createSQL UTF8String], NULL, NULL, &errorMessage)!=SQLITE_OK)
//    {
//        sqlite3_close(database);
//        NSAssert1(0, @"Error creating table flightquery: %s", errorMessage);
//    }
//    //2 创建可直达的城市
//    createSQL = @"create table if not exists DirectCity(id integer primary key, fromcity_code text , arrcity_code text );";
//    if(sqlite3_exec(database, [createSQL UTF8String], NULL, NULL, &errorMessage)!=SQLITE_OK)
//    {
//        sqlite3_close(database);
//        NSAssert1(0, @"Error creating table flightquery: %s", errorMessage);
//    }
//    //3 创建城市信息
//    createSQL = @"create table if not exists Citys(city_class text , city_code text primary key, airport_name text, city_name text, city_spell text, city_abbreviation text, city_hot text, isShowInCityList text);";
//    if(sqlite3_exec(database, [createSQL UTF8String], NULL, NULL, &errorMessage)!=SQLITE_OK)
//    {
//        sqlite3_close(database);
//        NSAssert1(0, @"Error creating table flightquery: %s", errorMessage);
//    }
//    //4 创建航空公司信息
//    createSQL = @"create table if not exists Airlines(airline_code text primary key, airline_name text, airline_name_abbreviation text, airline_telephone text);";
//    if(sqlite3_exec(database, [createSQL UTF8String], NULL, NULL, &errorMessage)!=SQLITE_OK)
//    {
//        sqlite3_close(database);
//        NSAssert1(0, @"Error creating table flightquery: %s", errorMessage);
//    }
//    //5 创建设备信息
//    createSQL = @"create table if not exists DeviceAddress(id integer primary key, city_name text, longitude text, latitude text, address text);";
//    if(sqlite3_exec(database, [createSQL UTF8String], NULL, NULL, &errorMessage)!=SQLITE_OK)
//    {
//        sqlite3_close(database);
//        NSAssert1(0, @"Error creating table flightquery: %s", errorMessage);
//    }
//    //6 创建版本信息
//    createSQL = @"create table if not exists Versions(table_name text primary key, version text);";
//    if(sqlite3_exec(database, [createSQL UTF8String], NULL, NULL, &errorMessage)!=SQLITE_OK)
//    {
//        sqlite3_close(database);
//        NSAssert1(0, @"Error creating table flightquery: %s", errorMessage);
//    }
//    //7 创建操作日志
//    createSQL = @"create table if not exists OptionLog(id integer primary key, table_name text, option text, option_time time not null default current_timestamp, result text, backup text);";
//    if(sqlite3_exec(database, [createSQL UTF8String], NULL, NULL, &errorMessage)!=SQLITE_OK)
//    {
//        sqlite3_close(database);
//        NSAssert1(0, @"Error creating table flightquery: %s", errorMessage);
//    }
//    //8 创建航班号查询记录
//    createSQL = @"create table if not exists Flight_Num_History(id integer primary key, flight_no text, option text, date time not null default current_timestamp);";
//    if(sqlite3_exec(database, [createSQL UTF8String], NULL, NULL, &errorMessage)!=SQLITE_OK)
//    {
//        sqlite3_close(database);
//        NSAssert1(0, @"Error creating table flightquery: %s", errorMessage);
//    }
//    //9 创建起降低查询记录
//    createSQL = @"create table if not exists Flight_City_History(id integer primary key, start_city_code text, start_city text,  end_city_code text, end_city text);";
//    if(sqlite3_exec(database, [createSQL UTF8String], NULL, NULL, &errorMessage)!=SQLITE_OK)
//    {
//        sqlite3_close(database);
//        NSAssert1(0, @"Error creating table flightquery: %s", errorMessage);
//    }


}

+(sqlite3 *)openDB
{
//    if (database) {
//        return database;
//    }
    
    sqlite3 *database = nil; //NSDocumentDirectory  NSCachesDirectory
	NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
	NSString *sqlFilePath = [docPath stringByAppendingPathComponent:@"database.sqlite"];
    NSFileManager *fm = [NSFileManager defaultManager];//文件管理器
    if ([fm fileExistsAtPath:sqlFilePath] == NO) {
        NSError *error = nil;
        NSString *originFilePath = [[NSBundle mainBundle] pathForResource:@"database" ofType:@"sqlite"];
        if([fm copyItemAtPath:originFilePath toPath:sqlFilePath error:&error] == NO)
        {
            NSLog(@"创建数据库的时候出现了错误：%@",[error localizedDescription]);
        }
    }

    if (sqlite3_open([sqlFilePath UTF8String], &database) == SQLITE_OK) {
       //[self createTables];
        sqlite3_busy_timeout(database, SQL_BUSY_SLEEP_MIC);
    }
    else {
        sqlite3_close(database);
        database = nil;
    }
    
	return database;

}
+(void)closeDB:(sqlite3 *)_database
{
    if(_database)
	{
		sqlite3_close(_database);//关闭数据库
		_database = nil;
	}
}
@end
