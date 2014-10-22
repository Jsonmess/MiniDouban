//
//  JSPlayViewController.m
//  DoubanMini
//
//  Created by Json on 14-9-29.
//  Copyright (c) 2014年 jsonmess. All rights reserved.
//

#import "JSPlayViewController.h"
#import "UIImage+Json_load_image.h"
#import "JSGetFMlistFromDouBan.h"
#import "JSSongInfo.h"
#import "UIImageView+WebCache.h"
#import "JSPlayMusic.h"
#import "AFSoundManager.h"

@interface JSPlayViewController ()<JingRoundViewDelegate>
{
    JSPlayMusic *Play;//播放音乐;
    JSSongInfo *songinfo;//播放的歌曲;
    BOOL PlayIsPause;//播放是否已经暂停;


   
}
@end

@implementation JSPlayViewController

-(void)viewWillAppear:(BOOL)animated
{
 
    //初始化播放实例
    Play =[[JSPlayMusic alloc]init];
    //设置代理
    [Play setNextAlbumDelegate:self];
    self.GetMusic=[JSGetMusicListFromNet ShareGetMusicListFromNet];
    [super viewWillAppear:animated];
    PlayIsPause=NO;
  
//第一次加载歌曲
    if (self.GetMusic.IsFirstLoad) {
        [self RotationTheArrowWithPlaying:kRotationStop];
        [self GetSongListFromDouban];
        self.GetMusic.IsFirstLoad=NO;
    }else
    {
        Play.FistPlay_url=nil;
    }

}
- (void)viewDidLoad
{
    [self AddXibFromBundle];
    [self SetUpView];

    [super viewDidLoad];

}
/**
 *  设置界面
 */
-(void)SetUpView
{
    self.title=@"当前播放";
    UIButton *leftbtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [leftbtn setBackgroundImage:[UIImage imageNamed:@"BackToList.png"] forState:UIControlStateNormal];
    [leftbtn setBackgroundImage:[UIImage imageNamed: @"BackToList.png"] forState:UIControlStateHighlighted];
    [leftbtn addTarget:self action:@selector(BackToList) forControlEvents:UIControlEventTouchUpInside];
    [leftbtn setFrame:CGRectMake(0, 0, 32.0f, 32.0f)];
    UIBarButtonItem *backitem=[[UIBarButtonItem alloc]initWithCustomView:leftbtn];
    self.navigationItem.leftBarButtonItem=backitem;
    //设置旋转界面
    self.RoundView.delegate = self;
    self.RoundView.roundImage =[UIImage imageNamed:@"DBFM.png"];
    self.RoundView.rotationDuration = 8.0;
    self.RoundView.isPlay = NO;
    //设置背景
    [self.BackImage setFrame:self.view.bounds];
    [self.BackImage setImage:[UIImage Load_Image:@"FMPlayBg.png"]];
    
    //设置按钮以及center
    [self.LikeBtn setBackgroundImage:[UIImage imageNamed:@"BtnLike@2x.png"] forState:UIControlStateSelected];
    [self.LikeBtn setHighlighted:NO];
    [self.LikeBtn setCenter:CGPointMake(self.view.bounds.size.width*0.2f, self.view.bounds.size.height-0.8f*Ktabbar_height)];
    
    
    [self.DelBtn setBackgroundImage:[UIImage imageNamed:@"BtnDel@2x.png"] forState:UIControlStateHighlighted];
    [self.DelBtn setCenter:CGPointMake(CGRectGetMaxX(self.LikeBtn.frame)+75.0f, self.view.bounds.size.height-0.8f*Ktabbar_height)];
    
    [self.NextBtn setBackgroundImage:[UIImage imageNamed:@"BtnNext@2x.png"] forState:UIControlStateHighlighted];
    [self.NextBtn setCenter:CGPointMake(CGRectGetMaxX(self.DelBtn.frame)+75.0f, self.view.bounds.size.height-0.8f*Ktabbar_height)];
    
    //设置频道
    if (self.TheChannel==nil) {
        [self.CurrentChannel setText:@"请选择MHz收听"];
    }else{
        [self.CurrentChannel setText:[NSString stringWithFormat:@"%@ MHz",self.TheChannel.ChannelName]];
    }
  //设置指针
    [self RotationTheArrowWithPlaying:kRotationStop];
    
}
-(void)AddXibFromBundle
{
    [[NSBundle mainBundle]loadNibNamed:@"PlayView" owner:self options:nil];
    [self.view setFrame:[UIScreen mainScreen].bounds];
    
}

-(void)setRoundViewImageWithName:(NSString *)imgurl
{
    

    if (songinfo.PictureUrl==nil||[songinfo.PictureUrl isEqual:@""]) {
        self.RoundView.roundImage =[UIImage imageNamed:@"DBFM.png"];
        [self RotationTheArrowWithPlaying:kRotationStop];
    }else
    {
        
        NSURL *url = [NSURL URLWithString:imgurl];
        
        dispatch_queue_t queue =dispatch_queue_create("loadImage",NULL);
        dispatch_async(queue, ^{
            
            NSData *resultData = [NSData dataWithContentsOfURL:url];
     
            
            dispatch_async(dispatch_get_main_queue(), ^{
                    self.RoundView.roundImage=[UIImage imageWithData:resultData];
                 self.RoundView.isPlay=YES;
                //旋转入轨
                [self RotationTheArrowWithPlaying:KRotatonPlay];
            });
            
        });

    }
   
}
-(void)BackToList
{
    [self.navigationController popViewControllerAnimated:YES];
}

//代理方法
-(void)playStatuUpdate:(BOOL)playState
{

    if ([playState ? @"Playing": @"Pause" isEqual:@"Playing"]) {
        [Play PlayMusicWithPlayStatus:kPlayResume];
        [self RotationTheArrowWithPlaying:KRotatonPlay];
        PlayIsPause=NO;
    }else
    {
        [Play PlayMusicWithPlayStatus:kPlayPause];
        [self RotationTheArrowWithPlaying:kRotationPause];
        PlayIsPause=YES;

    }
    
}
-(void)SendShowNextAlbum
{
    [self NextSong:nil];
}
//改变播放音量
- (IBAction)ChangeVolume:(id)sender {
    

    [[AFSoundManager sharedManager]changeVolumeToValue:self.VolumeSlider.value];
}

- (IBAction)AddLikeSong:(UIButton*)sender {
    
    [sender setSelected:sender.isSelected?NO:YES];
    NSLog(@"%@",sender.isSelected?@"喜欢":@"不喜欢");
}

- (IBAction)DeleteSong:(id)sender {
    NSLog(@"删除");
}

- (IBAction)NextSong:(UIButton*)sender {
    [[self class] cancelPreviousPerformRequestsWithTarget:self selector:@selector(ChangeSong:) object:sender];
    [self performSelector:@selector(ChangeSong:) withObject:sender afterDelay:0.3f];
}
-(void)ChangeSong:(id)sender
{
    
    if (self.GetMusic.PlayList.count>0) {
        if (!PlayIsPause) {
            //旋转出轨
            [self RotationTheArrowWithPlaying:kRotationStop];
        }
        
        //删除当前播放对象
        [self.GetMusic.PlayList removeObject:self.GetMusic.PlayList.firstObject];
        //当列表为空时候
        if (self.GetMusic.PlayList.count<=1) {
            //获取歌曲
            [self.GetMusic GetMusicListFromDoubanWithChannelId:self.TheChannel.ChannelId];
        }
        //指示其播放下一首
        if (sender!=nil) {
            [Play PlayMusicWithPlayStatus:KPlayNext];
        }else
        {
            [Play PlayMusicWithPlayStatus:KplayStart];
        }
        Play.IsPlayEnd=YES;
        //取出新的数组首项
        songinfo=self.GetMusic.PlayList.firstObject;
        [self setRoundViewImageWithName:songinfo.PictureUrl];
        [self.CurrentSong setText:songinfo.Title];
        
        
    }
}
/**
 *  第一次加载
 *
 *  @param array 第一次加载
 *  从豆瓣获取指定FM频道的音乐列表
 */
-(void)GetSongListFromDouban
{
    if (self.TheChannel!=nil) {
        
        
        [ JSGetFMlistFromDouBan GetDBDataWithPath:@"http://www.douban.com" path:@"/j/app/radio/people" Params:
         @{
           @"app_name": @"radio_desktop_win",
           @"version": @"100",
           @"user_id":@"",
           @"expire":@"",
           @"token":@"",
           @"channel":[NSString stringWithFormat:@"%@",self.TheChannel.ChannelId],
           @"type":@"n"
           }
         
                                   WithGetSuccess:^(NSMutableArray *FMList) {
                                       [self SetPlayListArray:FMList];
                                       
                                   } GetFailed:^(NSError *error) {

                                   } WithMethod:@"GET"];
    }
}
/**
 *  处理数组
 *
 *  @param array 数组对象
 */
-(void)SetPlayListArray:(NSMutableArray*)array
{
    NSArray *thearray=array[0][@"song"];
    NSDictionary *dic =thearray[0];
    if (songinfo==nil) {
        songinfo=[[JSSongInfo alloc]init];
    }
        songinfo.Albumtitle=dic[@"albumtitle"];
        songinfo.Artist=dic[@"artist"];
        songinfo.PictureUrl=dic[@"picture"];
        songinfo.Company=dic[@"company"];
    songinfo.SongLength=dic[@"length"];
        songinfo.Public_time=dic[@"public_time"];
        songinfo.Title=dic[@"title"];
        songinfo.Song_url=dic[@"url"];
    //将播放url装入播放对象
    Play.FistPlay_url=songinfo.Song_url;
    //预装入第一首歌曲
    [self setRoundViewImageWithName:songinfo.PictureUrl];
    [Play PlayMusicWithPlayStatus:KplayStart];
    [self.CurrentSong setText:songinfo.Title];
    
}
/**
 *  播放针旋转动画
 */
-(void)RotationTheArrowWithPlaying:(enum KRotationStatus)playing
{
    CGAffineTransform transform;
    if (playing==KRotatonPlay) {
            //旋转指针入轨道
        [self.PlayStatusBar.layer setAnchorPoint:CGPointMake(0.755, 0.21)];
        [self.PlayStatusBar.layer setPosition:self.RoundPoint.center];
        transform=CGAffineTransformRotate(self.PlayStatusBar.transform, M_PI_4*1.3/3);
        [UIView animateWithDuration:1.0f animations:^{
            [self.PlayStatusBar setTransform:transform];
        }];
    }else if(playing==kRotationPause)
    {
        
        //旋转指针出轨道
        [self.PlayStatusBar.layer setAnchorPoint:CGPointMake(0.755, 0.21)];
        [self.PlayStatusBar.layer setPosition:self.RoundPoint.center];
        transform =CGAffineTransformRotate(self.PlayStatusBar.transform, -M_PI_4*1.3/3);
        [UIView animateWithDuration:1.0f animations:^{
            [self.PlayStatusBar setTransform:transform];
        }];

    }else
    {
        //旋转指针出轨道
        [self.PlayStatusBar setTransform:CGAffineTransformIdentity];
        [self.PlayStatusBar.layer setAnchorPoint:CGPointMake(0.755, 0.21)];
        [self.PlayStatusBar.layer setPosition:self.RoundPoint.center];
        transform =CGAffineTransformRotate(self.PlayStatusBar.transform, -M_PI_4*1.3/3);
   
        [UIView animateWithDuration:0.6f animations:^{
               [self.PlayStatusBar setTransform:transform];
        }];
        
    }

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}
@end
