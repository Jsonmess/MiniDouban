//
//  JSSetingViewController.m
//  DoubanMini
//
//  Created by Json on 14-10-5.
//  Copyright (c) 2014年 jsonmess. All rights reserved.
//

#import "JSSetingViewController.h"
#import "JSSendLogin_outState.h"
#import "JSListCell.h"
#import "JSLoginCell.h"
#import "JSDBaccount.h"
#import "JSUserInfoCell.h"
#import "HttpTool.h"
#import "Sqlite3Manager.h"
#import "Oauth_ViewController.h"
#import "Com_navigationController.h"
#import "UIImage+Json_resize_image.h"
#import "JSAuthorInfoController.h"
#import "JSAdviceController.h"
@interface JSSetingViewController ()<UITableViewDataSource,UITableViewDelegate,JSSendLogin_outState>
{
    NSArray *List;//表格数据数组;
    UITableView *Tableview;//表格视图;
    JSUserInfoCell*UserInfoCell;//用户单元格
    JSListCell*cell;//列表表格
    JSLoginCell *logincell;//登录按钮
    JSDBaccount *account;
}
@end

@implementation JSSetingViewController

- (void)viewDidLoad {

    [super viewDidLoad];
    [self SetUpView];
    
}

-(void)SetUpView
{
    self.title=@"应用设置";
    //加载plist，并初始化数组
   NSString *path= [[NSBundle mainBundle]pathForResource:@"setlist.plist" ofType:nil];
    List=[NSArray arrayWithContentsOfFile:path];

    //添加表格视图
    Tableview=[[UITableView alloc]initWithFrame:CGRectMake(0,0, self.view.bounds.size.width, self.view.bounds.size.height-Ktabbar_height) style:UITableViewStylePlain];
    [Tableview setDelegate:self];
    [Tableview setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [Tableview setBackgroundColor:[UIColor clearColor]];
    [Tableview setDataSource:self];
    [self.view addSubview:Tableview];
    Tableview.contentInset=UIEdgeInsetsMake(0, 0, 10.0f, 0);
    //初始化登录
    logincell=[[JSLoginCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    UserInfoCell=[[JSUserInfoCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    [logincell setDelegate:self];
    //初始化账户
   account=[JSDBaccount ShareDBaccount];
    [account GetUserInfoFromDoubanWithUserId:[account GetAccountFromSqlite3].uid];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark----表格代理
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return List.count+2;//包括用户信息单元格
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        [UserInfoCell addSubview:self.UserCell_info];
        UserInfoCell.selectionStyle=UITableViewCellSelectionStyleNone;
        if(account.dic==nil)
        {
            //从plist里面获取
            NSString *Userpath=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
            Userpath=[Userpath stringByAppendingPathComponent:@"RegistUser.plist"];
            [UserInfoCell setUserIcon_UserNameWithAccount:[NSDictionary dictionaryWithContentsOfFile:Userpath]];
            if ([NSDictionary dictionaryWithContentsOfFile:Userpath]==nil) {
                [self ChangeUserInfo];
            }
        }else
        {
            [UserInfoCell setUserIcon_UserNameWithAccount:account.dic];
        }
        return UserInfoCell;
    }else if(indexPath.row==4)
    {
        logincell.selectionStyle=UITableViewCellSelectionStyleNone;
        return logincell;
    }else{
            cell=[[JSListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
          cell.ListTitle.text= List[indexPath.row-1];
          cell.selectionStyle=UITableViewCellSelectionStyleNone;
            return cell;
    }
    

}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        return 150.0f;
    }
    else
    {
        return 60.0f;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row==3) {
        JSAuthorInfoController *author_info=[[JSAuthorInfoController alloc]init];
        [self.navigationController pushViewController:author_info animated:YES];
    }
    if (indexPath.row==2) {
        JSAdviceController *advice=[[JSAdviceController alloc]init];
        [self.navigationController pushViewController:advice animated:YES];
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

}
#pragma mark---代理方法
-(void)SendLogin_outState
{
    //未登录，弹出授权界面
    Oauth_ViewController *Oauth=[[Oauth_ViewController alloc]init];
    Com_navigationController *Nav_oa=[[Com_navigationController alloc]initWithRootViewController:Oauth];
    //设置代理
    [Oauth setStateDelegate:self];
    [self presentViewController:Nav_oa animated:YES completion:nil];
}
-(void)SendLoginState:(BOOL)state
{

    if (state) {
        //设置内容
        [logincell.LogIn_OutBtn setTitle:@"注销当前用户" forState:UIControlStateNormal];
        [logincell.LogIn_OutBtn setTitle:@"注销当前用户" forState:UIControlStateHighlighted];
    }
     [Tableview reloadData];
}
-(void)ChangeUserInfo
{
    [UserInfoCell.UserIcon setImage:[UIImage imageNamed:@"user_normal.jpg"]];
    [UserInfoCell.UserName setText:@"未登录"];
}
@end
