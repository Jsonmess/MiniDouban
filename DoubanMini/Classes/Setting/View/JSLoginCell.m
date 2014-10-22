//
//  JSLoginCell.m
//  DoubanMini
//
//  Created by Json on 14-10-5.
//  Copyright (c) 2014年 jsonmess. All rights reserved.
//

#import "JSLoginCell.h"
#import "JSDBaccount.h"
#import "Sqlite3Manager.h"
@interface JSLoginCell()
{
    BOOL IsLogin;//是否登录?
}@end
@implementation JSLoginCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self LoadXib];
        [self setBackgroundColor:[UIColor clearColor]];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

   
}
-(void)LoadXib
{
    [[NSBundle mainBundle]loadNibNamed:@"Login_out" owner:self options:nil];
    [self.contentView addSubview:self.ContentView];
    JSDBaccount *account=[JSDBaccount ShareDBaccount];
    [account GetAccountFromSqlite3];
    if (account.uid!=nil) {
        [self.LogIn_OutBtn setTitle:@"注销当前用户" forState:UIControlStateNormal];
        [self.LogIn_OutBtn setTitle:@"注销当前用户" forState:UIControlStateHighlighted];
    }else
    {
        [self.LogIn_OutBtn setTitle:@"登录豆瓣FM" forState:UIControlStateNormal];
        [self.LogIn_OutBtn setTitle:@"登录豆瓣FM" forState:UIControlStateHighlighted];
    }
}
- (IBAction)Login_out:(UIButton *)sender {
    
    Sqlite3Manager*mnger=[[Sqlite3Manager alloc]init];
    NSString *Userpath=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    Userpath= [Userpath stringByAppendingPathComponent:@"DoubanMini.sqlite3"];
    [mnger OpenDataBaseWithPath:Userpath];
    JSDBaccount *account=[[JSDBaccount alloc]init];
    NSString *sql=@"SELECT uid,accessToken,expires_in FROM Account";
    
    [mnger SearchDataFromDataBaseWithSql:sql Success:^(sqlite3_stmt *stmt)
     {
         if  ( SQLITE_ROW==  sqlite3_step(stmt))
         {
             account.uid=[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 0)];
         }
         else if (SQLITE_ROW!=  sqlite3_step(stmt)) {
             account.uid=nil;
         }
 
     } Failed:^{
     }];
    
    
    
    if (account.uid!=nil) {
        UIActionSheet *actionsheet=[[UIActionSheet alloc]initWithTitle:@"提示" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"确认注销" otherButtonTitles:nil];
        [actionsheet setActionSheetStyle:UIActionSheetStyleBlackTranslucent];
        [actionsheet showInView:self];
        //如果确定注销？IsLogin=no;
        //删除授权信息
   
#warning  计算过期时间。。。？？？
       
    }else
    {
        [self.delegate SendLogin_outState];
       
    }
    
}

//代理方法
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==0) {
        //确认注销
        //删除数据表中数据--清空数据库中的账户授权表并清空account对象
        [[JSDBaccount ShareDBaccount]DeleteTheAccount];
        [self.LogIn_OutBtn setTitle:@"登录豆瓣FM" forState:UIControlStateNormal];
        [self.LogIn_OutBtn setTitle:@"登录豆瓣FM" forState:UIControlStateHighlighted];
        //删除plist文件
        NSFileManager *filemanager=[NSFileManager defaultManager];
        NSString *Userpath=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
        Userpath= [Userpath stringByAppendingPathComponent:@"RegistUser.plist"];
        [filemanager removeItemAtPath:Userpath error:nil];
        //设置默认的图片和昵称
        [self.delegate ChangeUserInfo];
       
        
  
    }
}
@end
