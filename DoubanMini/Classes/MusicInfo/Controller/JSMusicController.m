//
//  JSMusicController.m
//  DoubanMini
//
//  Created by Json on 14-10-8.
//  Copyright (c) 2014年 jsonmess. All rights reserved.
//

#import "JSMusicController.h"
#import "JSRankingCellTableViewCell.h"
#import "JSMusicListController.h"
#import "HttpTool.h"
#import "MBProgressHUD.h"
#import "JSMusicListModel.h"
@interface JSMusicController ()<UITableViewDataSource,UITableViewDelegate,MBProgressHUDDelegate>
{
    UITableView *_tableView;
    NSArray *DataArray;
    JSMusicListController *MusicList;
    MBProgressHUD *hud;//添加指示器
}
@end

@implementation JSMusicController


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self SetUpView];
    [self LoadDataSource];
   
}
-(void)SetUpView
{
    [self setTitle:@"豆瓣音乐"];
    //添加表格视图
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 10, self.view.bounds.size.width, self.view.bounds.size.height-Ktabbar_height) style:UITableViewStylePlain];
    [_tableView setDelegate:self];
    [_tableView setDataSource:self];
    [_tableView setBackgroundColor:[UIColor clearColor]];
    [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];

    [self.view addSubview:_tableView];
}

-(void)LoadDataSource
{
  NSString *path=[[NSBundle mainBundle]pathForResource:@"Music_ranking.plist" ofType:nil];
    DataArray=[NSArray arrayWithContentsOfFile:path];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return DataArray.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reuse_str=@"RankingCell";
    JSRankingCellTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:reuse_str];
    if (cell==nil) {
        cell=[[JSRankingCellTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuse_str];
    }
    [ cell setIcon_UserNameWithIconImage:DataArray[indexPath.row][@"picture"] RankingName:DataArray[indexPath.row][@"name"] ];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70.0f;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    MusicList =[[JSMusicListController alloc]init];
        [MusicList setTitle:DataArray[indexPath.row][@"name"]];
   //初始化指示器并显示
    hud=[[MBProgressHUD alloc]initWithView:self.view];
    [self.view addSubview:hud];
    [hud setXOffset:0.5f];
    [hud setYOffset:0.5f];
    [hud setColor:KMBProgressBg];
    [hud setLabelText:@"获取歌曲列表..."];
    [hud setDelegate:self];
    [hud show:YES];
    //获取音乐列表
 [self GetMusicListWithId:DataArray[indexPath.row][@"id"]];
    
}
//通过网络获取歌曲列表
-(void)GetMusicListWithId:(NSString *)list_id
{

    [HttpTool HttpSendwithPath:@"http://music.163.com" path:@"/api/playlist/detail" Params:
     @{
       @"updateTime":@"-1",
       @"id":list_id
       
       }

      PostSuccess:^(id Json) {
          NSDictionary *dic=[NSDictionary dictionaryWithDictionary:Json];
          NSDictionary *thedic=  [[JSMusicListModel ShareMusicListModel] GetMusicListInfo:dic];
          [MusicList GetDataSourceWithDic:thedic];
          [hud hide:YES];
          [hud removeFromSuperview];
          [self.navigationController pushViewController:MusicList animated:YES];
      } PostFaild:^(NSError *error) {
          UIAlertView *alert =[[UIAlertView alloc]initWithTitle:@"小提示" message:@"您的网络不给力喔" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
          [alert show];
          [hud hide:YES];
      } WithMethod:@"GET"];
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
