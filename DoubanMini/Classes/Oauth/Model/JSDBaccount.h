//
//  JSDBaccount.h
//  DoubanMini
//
//  Created by Json on 14-10-6.
//  Copyright (c) 2014年 jsonmess. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface JSDBaccount : NSObject
@property(nonatomic,copy)NSString *accessToken;//授权令牌
@property(nonatomic,copy)NSString *uid;//用户Id
@property(nonatomic,copy)NSString *expires_in;//授权过期时间
@property(nonatomic,strong)NSDictionary *dic;
+(JSDBaccount *)ShareDBaccount;
-(void)OpenDataBase;
-(JSDBaccount *)GetAccountFromSqlite3;
-(void)SaveAccountToSqlite3WithAccessToken:(NSString *)accesstoken Uid:(NSString *)uid Expire:(NSString *)expires_in;
-(void)GetUserInfoFromDoubanWithUserId:(NSString *)user_id;
-(void)DeleteTheAccount;
@end
