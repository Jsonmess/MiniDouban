//
//  JSfmViewController.m
//  DoubanMini
//
//  Created by Json on 14-9-28.
//  Copyright (c) 2014年 jsonmess. All rights reserved.
//

#import "JSfmViewController.h"
#import "JSPlayViewController.h"
#import "RefreshChannels.h"
#import "JSChannelCell.h"
#import "JSGetMusicListFromNet.h"
#define KheadHeight 30.0f
@interface JSfmViewController ()<UIAlertViewDelegate,UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *Channels;//频道数组

    UITableView *_Tablelist;
    JSChannelCell *oldCell;//上一次选中的单元格
    NSIndexPath *oldpath;//上一次选中的单元格index
    JSPlayViewController *playcontroller;//播放视图
    JSGetMusicListFromNet*GetMusic;//获取音乐列表对象
}
@end

@implementation JSfmViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    //初始化index
    oldpath=[NSIndexPath indexPathForRow:-1 inSection:-1];
    //初始化频道数组

    Channels=[NSMutableArray array];
    //初始化获取播放列表对象
    GetMusic=[JSGetMusicListFromNet ShareGetMusicListFromNet];
    [self SetUpView];
   

}
/**
 *  设置视图
 */
-(void)SetUpView
{
  //设置导航栏按钮
    self.title=@"豆瓣FM";
    UIButton *leftbtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [leftbtn setBackgroundImage:[UIImage imageNamed: @"refresh_pressed.png"] forState:UIControlStateNormal];
    [leftbtn setBackgroundImage:[UIImage imageNamed: @"refresh_pressed.png"] forState:UIControlStateHighlighted];
    [leftbtn addTarget:self action:@selector(WriteTheNewNote) forControlEvents:UIControlEventTouchUpInside];
    [leftbtn setFrame:CGRectMake(0, 0, 32.0f, 32.0f)];
    UIBarButtonItem *left=[[UIBarButtonItem alloc]initWithCustomView:leftbtn];
    [self.navigationItem setLeftBarButtonItem:left];
    
    UIButton *rightbtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [rightbtn setBackgroundImage:[UIImage imageNamed: @"Nav_play.png"] forState:UIControlStateNormal];
    [rightbtn setBackgroundImage:[UIImage imageNamed: @"Nav_play.png"] forState:UIControlStateHighlighted];
    [rightbtn addTarget:self action:@selector(PushToPlayView) forControlEvents:UIControlEventTouchUpInside];
    [rightbtn setFrame:CGRectMake(0, 0, 35.0f, 37.0f)];
    UIBarButtonItem *right=[[UIBarButtonItem alloc]initWithCustomView:rightbtn];
    [self.navigationItem setRightBarButtonItem:right];
    
    //初始化数据--读取plist文件
    NSString *filepath=[[NSBundle mainBundle]pathForResource:@"channels.plist" ofType:nil];
    NSArray *array=[NSDictionary dictionaryWithContentsOfFile:filepath][@"channels"];
    //遍历数组
    //特例频道对象
    for (NSDictionary *dic in array) {
        JSChannel *cl=[[JSChannel alloc]init];
        cl.ChannelName=dic[@"name"];
        cl.ChannelId=dic[@"channel_id"];
        [Channels addObject:cl];
    }

    //添加表格视图
     [self AddTableView];
}
-(void)AddTableView
{
    _Tablelist=[[UITableView alloc]initWithFrame:CGRectMake(0,0, self.view.bounds.size.width, self.view.bounds.size.height-Ktabbar_height) style:UITableViewStylePlain];
    [_Tablelist setDataSource:self];
    [_Tablelist setDelegate:self];
    [_Tablelist setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [_Tablelist setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:_Tablelist];
}
#pragma mark---表格代理方法
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return 2;
            break;
        default:
  
            return Channels.count-1;//除去私人频道
            break;
    }
}

-(JSChannelCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reusedstr=@"ChannelCell";
    JSChannelCell *cell=[tableView dequeueReusableCellWithIdentifier:reusedstr ];
    if (cell==nil) {
     cell=[[JSChannelCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reusedstr];
    }
   //JSChannelCell* cell=[[JSChannelCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    JSChannel * cnel=Channels[indexPath.row+1];
    switch (indexPath.section) {
        case 0:
            if (indexPath.row==0) {
                [cell SetTheChannelName:@"私人兆赫" WithImageName:@"playAnimation_play.png" ];
            }else
            {
               [cell SetTheChannelName:@"我的喜爱"  WithImageName:@"playAnimation_play.png"];
            }
            break;
            
        default:
            
            [ cell SetTheChannelName:cnel.ChannelName WithImageName:@"playAnimation_play.png"];
            break;
         
    }
    [cell.titleLabel setHidden:NO];
    [cell.mhzLabel setHidden:NO];
    if (oldpath.section==indexPath.section&&oldpath.row==indexPath.row) {
       [cell.ShowCurrentPlay setHidden:NO];
    }else{
        [cell.ShowCurrentPlay setHidden:YES];
   }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.0f;
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, KheadHeight)];
    UILabel*label=[[UILabel alloc]init];
    [label setTextColor:[UIColor colorWithRed:173/255.0f green:173/255.0f blue:173/255.0f alpha:1.0f]];
    [label setFont:[UIFont systemFontOfSize:14.0f]];
    if (section==0) {
        [label setText:@" 我的兆赫"];
    }else
    {
        [label setText:@" 热门兆赫"];
    }
    [label setFrame:CGRectMake(10.0f,0, self.view.bounds.size.width,28.0f)];
    [view setBackgroundColor:[UIColor colorWithRed:230/255.0f green:230/255.0f blue:230/255.0f alpha:0.8f]];
    [view addSubview:label];
    return view;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return KheadHeight;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    if (oldCell==nil) {
        oldCell=(JSChannelCell*)[tableView cellForRowAtIndexPath:indexPath];
        [oldCell.ShowCurrentPlay setHidden:NO];
        oldpath=indexPath;

    }else
    {
   JSChannelCell*newthecell= (JSChannelCell*)[tableView cellForRowAtIndexPath:indexPath];
    
    [newthecell.ShowCurrentPlay setHidden:NO];
       if (oldpath.section==indexPath.section&&oldpath.row==indexPath.row) {
           [oldCell.ShowCurrentPlay setHidden:NO];
       }else
       {
        [oldCell.ShowCurrentPlay setHidden:YES];
           
       }
        oldCell=newthecell;
        oldpath= indexPath;

    }
    [tableView reloadData];
    //设置播放界面
    playcontroller =[[JSPlayViewController alloc]init];
    JSChannel *jsl=[[JSChannel alloc]init];
    if (indexPath.section==0) {
        
        switch (indexPath.row) {
            case 0:
                jsl.ChannelName=@"私人兆赫";
                jsl.ChannelId=@"0";
                break;
                
            default:
               jsl.ChannelId=@"10";//红心未知
#warning 红心未知
                jsl.ChannelName=@"我的喜爱";
                break;
            }
        playcontroller.TheChannel=jsl;
        //获取音乐列表
        [GetMusic GetMusicListFromDoubanWithChannelId:jsl.ChannelId];
    }else
    {
    playcontroller.TheChannel=Channels[indexPath.row+1];
        //获取音乐列表
        jsl=Channels[indexPath.row+1];
        [GetMusic GetMusicListFromDoubanWithChannelId:jsl.ChannelId];
    
    }

    [self.navigationController pushViewController:playcontroller animated:YES];
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"小提示" message:@"如果出现没有声音，请点击下一首" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alert show];
    GetMusic.IsFirstLoad=YES;
    
}

//写新的说说
-(void)WriteTheNewNote
{

    [RefreshChannels GetFMChannelsFromDouban];
       //刷新表格
    [_Tablelist reloadData];
    
}
//写新的
-(void)PushToPlayView
{
    if (playcontroller==nil) {
         playcontroller =[[JSPlayViewController alloc]init];
    }
    playcontroller.GetMusic=GetMusic;
     [self.navigationController pushViewController:playcontroller animated:YES];
  GetMusic.IsFirstLoad=NO;
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
