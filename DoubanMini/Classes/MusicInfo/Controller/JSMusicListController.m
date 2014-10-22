//
//  JSMusicListController.m
//  DoubanMini
//
//  Created by Json on 14-10-8.
//  Copyright (c) 2014年 jsonmess. All rights reserved.
//

#import "JSMusicListController.h"
#import "Tabbar_view.h"
#import "JSRankingInfoCell.h"
#import "UIImageView+WebCache.h"
#import "JSRkMusicList.h"
#import "JSPlayDock.h"
@interface JSMusicListController ()<UITableViewDataSource,UITableViewDelegate>
{
    Tabbar_view *dock;
    NSDictionary *TheDic;//数据源
    UITableView *TheTableView;
    NSString *RankingName;//榜单名
    UIView *headview;
    JSPlayDock *play_dock;//播放工具栏
}
@end

@implementation JSMusicListController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self SetUpView];
}
-(void)SetUpView
{
    UIButton *leftbtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [leftbtn setBackgroundImage:[UIImage imageNamed:@"BackToList.png"] forState:UIControlStateNormal];
    [leftbtn setBackgroundImage:[UIImage imageNamed: @"BackToList.png"] forState:UIControlStateHighlighted];
    [leftbtn addTarget:self action:@selector(BackToRanking) forControlEvents:UIControlEventTouchUpInside];
    [leftbtn setFrame:CGRectMake(0, 0, 32.0f, 32.0f)];
    UIBarButtonItem *backitem=[[UIBarButtonItem alloc]initWithCustomView:leftbtn];
    self.navigationItem.leftBarButtonItem=backitem;
    [self.view setBackgroundColor:[UIColor colorWithRed:246.0f/255.0f green:246.0f/255.0f blue:246.0f/255.0f alpha:1.0f]];
    //隐藏dock
    dock=[Tabbar_view ShareTabbar_view];
    [dock setHidden:YES];
    //添加表格视图
    TheTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, -1, self.view.bounds.size.width, self.view.bounds.size.height-Ktabbar_height) style:UITableViewStylePlain];
    [TheTableView setDelegate:self];
    [TheTableView setDataSource:self];
    [TheTableView setBackgroundColor:[UIColor clearColor]];
    [TheTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.view addSubview:TheTableView];
    //加载xib
    headview= [[NSBundle mainBundle]loadNibNamed:@"HeadView" owner:self options:nil][0];
    //添加播放工具栏
    play_dock=[[JSPlayDock alloc]initWithFrame:CGRectMake(0, self.view.bounds.size.height-Ktabbar_height, self.view.bounds.size.width, Ktabbar_height)];
    [play_dock setUserInteractionEnabled:YES];
    [play_dock GetplayListWithDictionary:TheDic[@"SongList"]];
    [self.view addSubview:play_dock];
}
-(void)GetDataSourceWithDic:(NSDictionary *)dic
{
    TheDic=dic;
    [TheTableView reloadData];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return 1;
    }else
    {
        NSArray *array=TheDic[@"SongList"];
        return array.count;
    }
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  //  NSLog(@"%@",TheDic);
    if (indexPath.section==0) {
        JSRankingInfoCell*ranking_info=[[JSRankingInfoCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        if (TheDic!=nil) {
            [ranking_info.RankingIcon sd_setImageWithURL:[NSURL URLWithString:TheDic[@"coverImg"]] placeholderImage:[UIImage imageNamed: @"CoverIcon.jpg"]options:SDWebImageHighPriority|SDWebImageRetryFailed];
            [ranking_info.RankingDetial setText:[NSString stringWithFormat:@"    %@",TheDic[@"description"]]];
            [ranking_info.RankingName setText:TheDic[@"name"]];
        }
        [ranking_info setSelectionStyle:UITableViewCellSelectionStyleNone];
        return ranking_info;
    }
    else
    {
    static NSString *reuse_str=@"RankingCell";
    JSRkMusicList *cell=[tableView dequeueReusableCellWithIdentifier:reuse_str];
    if (cell==nil) {
        cell=[[JSRkMusicList alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuse_str];
        }
          if (TheDic!=nil) {
         [cell.MusicName setText:TheDic[@"SongList"][indexPath.row][@"music_name"]];
         [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
          }
    return cell;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        return 120.0f;
    }else
    {
    return 50.0f;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==1) {
        [play_dock GetSelectedSongInfo:TheDic[@"SongList"][indexPath.row]Row:indexPath.row];
        
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section==1) {
        return headview;
    }else
        return nil;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==1) {
         return 30.0f;
    }
    else return 0;
}
-(void)BackToRanking
{
    [self.navigationController popViewControllerAnimated:YES];
    //停止播放音乐
    [play_dock StopMusicPlay];
    [dock setHidden:NO];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
