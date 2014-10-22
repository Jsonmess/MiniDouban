//
//  JSDBaccount.m
//  DoubanMini
//
//  Created by Json on 14-10-6.
//  Copyright (c) 2014年 jsonmess. All rights reserved.
//

#import "JSDBaccount.h"
#import "Sqlite3Manager.h"
#import "HttpTool.h"
@interface JSDBaccount()
{
    Sqlite3Manager *_manager;
}
@end
@implementation JSDBaccount
static JSDBaccount *_instance;
#pragma mark----创建账户单例

+(id)allocWithZone:(NSZone *)zone
{
    //防止多个线程运行时候，创建多个对象
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance=[super allocWithZone:zone];
    });
    return _instance;
}

+(JSDBaccount *)ShareDBaccount
{
    if (_instance ==nil) {
        _instance=[[self alloc]init];//这个会默认调用allocWithZone

    }
//    //每次获取下用户数据
//    if (_instance.uid!=nil) {
//        [_instance GetUserInfoFromDoubanWithUserId:_instance.uid];
//    }
    return _instance;
    
}
-(id)init
{
    if (self=[super init]) {
          _manager=[[Sqlite3Manager alloc]init];
        //打开数据库并保存账户信息
        [self OpenDataBase];
        
    }
    return self;
}
-(void)OpenDataBase
{
  
    //在程序document目录下建立数据库，直接在主目录下得数据存在只读权限
    NSString *path=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    path=[path stringByAppendingPathComponent:@"DoubanMini.sqlite3"];
    [_manager OpenDataBaseWithPath:path];
    
    
}
-(void)SaveAccount:(NSString *)accesstoken Uid:(NSString *)uid Expire:(NSString *)expires_in
{
    NSString *sql=[NSString stringWithFormat:@"INSERT INTO Account (accessToken,uid,expires_in) values('%@','%@','%@')",accesstoken,uid,expires_in];
    [_manager InsertDataOrTableToDataBaseWithSql:sql];
}
-(void)CreateTableWithSql:(NSString *)sql
{
    [_manager InsertDataOrTableToDataBaseWithSql:sql];
}
-(void)SaveAccountToSqlite3WithAccessToken:(NSString *)accesstoken Uid:(NSString *)uid Expire:(NSString *)expires_in
{

    //创建账户表
    [self CreateTableWithSql:@"CREATE TABLE IF NOT EXISTS Account (uid text NOT NULL PRIMARY KEY,accessToken text NOT NULL,expires_in text NOT NULL)"];
    [self SaveAccount:accesstoken Uid:uid Expire:expires_in];
    
}

-(JSDBaccount *)GetAccountFromSqlite3
{
        NSString *sql=@"SELECT uid,accessToken,expires_in FROM Account";
    [self OpenDataBase];
    [_manager SearchDataFromDataBaseWithSql:sql Success:^(sqlite3_stmt *stmt)
    {
        
        while   ( SQLITE_ROW==  sqlite3_step(stmt))
        {
            self.uid=[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 0)];
            self.accessToken=[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 1)];
            self.expires_in=[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 2)];  
        }
        
    } Failed:^{
        self.uid=nil;
        self.accessToken=nil;
        self.expires_in=nil;
        self.dic=nil;
    }];
    
    
    return self;
}
-(void)DeleteTheAccount
{
    [_manager InsertDataOrTableToDataBaseWithSql:@"DELETE FROM Account"];
    self.uid=nil;
    self.accessToken=nil;
    self.expires_in=nil;
    self.dic=nil;
}
//授权成功后获取用户的详细信息;
-(void)GetUserInfoFromDoubanWithUserId:(NSString *)user_id
{
    [HttpTool HttpSendwithPath:@"https://api.douban.com" path:[NSString stringWithFormat:@"/v2/user/%@",user_id] Params:nil PostSuccess:^(id Json) {
        //存入Plist文件
        //获取路径
        NSString *Userpath=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
        Userpath=[Userpath stringByAppendingPathComponent:@"RegistUser.plist"];
        NSDictionary *dic=[NSDictionary dictionaryWithDictionary:Json];
        [dic writeToFile:Userpath atomically:YES];
        self.dic=dic;
    } PostFaild:^(NSError *error) {
        
    } WithMethod:@"GET"];
    

}


@end
