//
//  YYFMDBManager.m
//  数据存储 大全
//
//  Created by B2吴XX on 2017/3/27.
//  Copyright © 2017年 QSY. All rights reserved.
//

#import "YYFMDBManager.h"
#import "FMDB.h"
#import "KCUser.h"
#import "KCStatus.h"

@interface YYFMDBManager ()
{
    FMDatabase *_db;
}

@end
@implementation YYFMDBManager

+(instancetype)allocWithZone:(struct _NSZone *)zone
{
    static YYFMDBManager *instance;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        instance = [super allocWithZone:zone];
    });
    
    return instance;
}

+(instancetype)shareYYFMDBManager
{
    return [[self alloc]init];
}


-(void)createTable{
    NSString *path = [NSTemporaryDirectory() stringByAppendingPathComponent:@"tmp.db"];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:path]) {
        _db = [FMDatabase databaseWithPath:path];
        
        if ([_db open]) {
            NSString *sql = @"CREATE TABLE User (Id integer PRIMARY KEY AUTOINCREMENT,name text,screenName text, profileImageUrl text,mbtype text,city text);"
            "CREATE TABLE Status (Id integer PRIMARY KEY AUTOINCREMENT,source text,createdAt date,\"text\" text,user integer REFERENCES User (Id))";
            [_db executeStatements:sql];
        }
    }
}

-(void)addUser:(KCUser *)user{
    NSString *sql=[NSString stringWithFormat:@"INSERT INTO User (name,screenName, profileImageUrl,mbtype,city) VALUES('%@','%@','%@','%@','%@')",user.name,user.screenName, user.profileImageUrl,user.mbtype,user.city];
    
    BOOL isSuccessful = [_db executeUpdate:sql];
    if (isSuccessful) {
        NSLog(@"add user successfully！！");
    }else{
         NSLog(@"error = %@", [_db lastErrorMessage]);
    }
}

-(void)addStatus:(KCStatus *)status{
    NSString *sql=[NSString stringWithFormat:@"INSERT INTO Status (source,createdAt,\"text\" ,user) VALUES('%@','%@','%@','%@')",status.source,status.createdAt,status.text,status.user.Id];
    BOOL isSuccessful = [_db executeUpdate:sql];
    if (isSuccessful) {
        NSLog(@"add status successfully！！");
    }else{
        NSLog(@"error = %@", [_db lastErrorMessage]);
    }
}

-(void)removeUserByName:(NSString *)name{
    NSString *sql=[NSString stringWithFormat:@"DELETE FROM User WHERE name='%@'",name];
    BOOL isSuccessful = [_db executeUpdate:sql];
    if (isSuccessful) {
        NSLog(@"delete user successfully！！");
    }else{
        NSLog(@"error = %@", [_db lastErrorMessage]);
    }
}

-(NSArray *)getAllStatus{
    
    NSString *sql=@"SELECT Id, source,createdAt,\"text\" ,user FROM Status ORDER BY Id";
    //执行查询SQL语句，返回查询结果
    FMResultSet *result = [_db executeQuery:sql];
    NSMutableArray *array = [NSMutableArray array];
    //获取查询结果的下一个记录
    while ([result next]) {
        //根据字段名，获取记录的值，存储到字典中
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        int num  = [result intForColumn:@"Id"];
        NSString *name = [result stringForColumn:@"source"];
        NSString *sex  = [result stringForColumn:@"createdAt"];
        dict[@"Id"] = @(num);
        dict[@"source"] = name;
        dict[@"createdAt"] = sex;
        //把字典添加进数组中
        [array addObject:dict];
    }
    return array;
}

@end
