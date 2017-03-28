//
//  YYFMDBManager.h
//  数据存储 大全
//
//  Created by B2吴XX on 2017/3/27.
//  Copyright © 2017年 QSY. All rights reserved.
//

#import <Foundation/Foundation.h>
@class KCUser,KCStatus;

@interface YYFMDBManager : NSObject

+(instancetype)shareYYFMDBManager;

-(void)createTable;
-(void)addUser:(KCUser *)user;
-(void)addStatus:(KCStatus *)status;
-(void)removeUserByName:(NSString *)name;
-(NSArray *)getAllStatus;
@end
