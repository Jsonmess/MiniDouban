//
//  JSPlayDock.m
//  DoubanMini
//
//  Created by Json on 14-10-10.
//  Copyright (c) 2014年 jsonmess. All rights reserved.
//

#import "JSPlayDock.h"
#import "AFSoundManager.h"
@interface JSPlayDock()
{
    NSArray *TheArray;//播放列表;
    NSDictionary *SelectPlay;//选中音乐
    NSInteger count ;//播放控制
    BOOL InterruptAutoPlay;//中断自动播放
    BOOL FirstPlay;//未选中时候，首次播放
    BOOL IsPlayPause;//播放暂停？;
}
@end
@implementation JSPlayDock
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        [self SetUpView];
        [self addSubview:self.DockView];
        //初始化
        count=0;
        InterruptAutoPlay=NO;
        FirstPlay=YES;
        IsPlayPause=NO;
    }
    return self;
}
//设置界面和按钮
-(void)SetUpView
{
    [[NSBundle mainBundle]loadNibNamed:@"PlayDock" owner:self options:nil];
    [self.PlayButton setImage:[UIImage imageNamed:@"Dock_play.png"] forState:UIControlStateNormal];
    [self.PlayButton setImage:[UIImage imageNamed:@"PlayStop.png"] forState:UIControlStateSelected];
    [self.PlayButton setHighlighted:NO];
    [self.PlayNext setImage:[UIImage imageNamed:@"BtnNext_n@2x.png"] forState:UIControlStateNormal];
    [self.PlayNext setImage:[UIImage imageNamed:@"BtnNext@2x.png"] forState:UIControlStateHighlighted];
    [self.LikeSong setImage:[UIImage imageNamed:@"BtnLike_n.png"] forState:UIControlStateNormal];
    [self.LikeSong setImage:[UIImage imageNamed:@"BtnLike.png"] forState:UIControlStateSelected];
}
-(void)GetplayListWithDictionary:(NSArray *)ListArray
{
    TheArray=ListArray;
}
-(void)GetSelectedSongInfo:(NSDictionary*)songinfo Row:(NSInteger)row
{
    SelectPlay=songinfo;
    count=row;
    [self PlayMusicWithPlayState:kPlayStart];
    [self.PlayButton setSelected:YES];
}
- (IBAction)ActionPlay:(UIButton*)sender {
    [sender setSelected:sender.isSelected?NO:YES];
    if (FirstPlay) {
        [self PlayMusicWithPlayState:kPlayStart];
        FirstPlay=NO;
    }else
    {
        [self PlayMusicWithPlayState:sender.isSelected?KPlayResume:KPlayPause];
    }

      NSLog(@"%@",sender.isSelected?@"暂停":@"播放");
}
- (IBAction)ActionNext:(id)sender {
    [self PlayMusicWithPlayState:KPlayNext];
      NSLog(@"下一首");
}

- (IBAction)ActionLike:(UIButton*)sender {
    [sender setSelected:sender.isSelected?NO:YES];
    NSLog(@"%@",sender.isSelected?@"喜欢":@"不喜欢");
}
//停止播放音乐
-(void)StopMusicPlay
{
    [self PlayMusicWithPlayState:KPlayStop];
}
-(void)PlayMusicWithPlayState:(enum KPlayState)state
{
    switch (state) {
            //开始播放
        case 0:
            IsPlayPause=NO;
            InterruptAutoPlay=NO;
            [self AutoPlayMusicFromPlayList];//自动循环播放
            break;
            //播放暂停
        case 1:
            [[AFSoundManager sharedManager]pause];
             IsPlayPause=YES;
            break;
            //播放继续
        case 2:
            [[AFSoundManager sharedManager]resume];
             InterruptAutoPlay=NO;
            break;
              //下一曲
        case 3:
            InterruptAutoPlay=YES;
            [[AFSoundManager sharedManager]stop];
            count+=1;
            [self AutoPlayMusicFromPlayList];
            break;
            //播放停止
        default:
            InterruptAutoPlay=YES;
            [[AFSoundManager sharedManager]stop];
            break;
    }
}
-(void)AutoPlayMusicFromPlayList
{
    NSDictionary *songinfo=nil;
    NSString *Str_Url=nil;
   if (SelectPlay!=nil) {
       songinfo=SelectPlay;
       SelectPlay=nil;
       
   }else
    {
     if (TheArray.count>0) {
            //取出音乐字典
            songinfo=TheArray[count];
            if (count<=1) {
              count++;
             }else count+=0.5;
        //停止自动播放
        if (count>=TheArray.count) {
             return;
              }
          }

    }
    //取出音乐字典中的歌曲名
    self.SongName.text=songinfo[@"music_name"];
    //取出音乐字典中的播放url
    Str_Url=songinfo[@"music_url"];
    
   [[AFSoundManager sharedManager]startStreamingRemoteAudioFromURL:Str_Url andBlock:^(int percentage, CGFloat elapsedTime, CGFloat timeRemaining, NSError *error, BOOL finished) {
       if (finished) {
           if (InterruptAutoPlay) {
               InterruptAutoPlay=NO;
               return ;
           } else{
               [[AFSoundManager sharedManager]stop];
           }
       }
    }];
    
}

@end
