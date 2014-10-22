//
//  JSPlayMusic.m
//  DoubanMini
//
//  Created by Json on 14-10-1.
//  Copyright (c) 2014年 jsonmess. All rights reserved.
//

#import "JSPlayMusic.h"
#import "AFSoundManager.h"
#import "JSGetMusicListFromNet.h"
#import "JSSongInfo.h"
@interface JSPlayMusic()
{
  
    BOOL IsPlayPause;//播放暂停？;
      JSGetMusicListFromNet *MusicList;//音乐列表对象
    JSSongInfo *info;//音乐对象；
    BOOL InterruptAutoPlay;//中断自动播放
}
@end
@implementation JSPlayMusic


static  JSPlayMusic*_instance;
#pragma mark----创建单例模板
+(id)SharePlayMusic
{
    if (_instance==nil) {
        _instance=[[self alloc]init];
    
}
    return _instance;
}
+(id)allocWithZone:(NSZone *)zone
{
    //防止多个线程运行时候，创建多个对象
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance=[super allocWithZone:zone];
    });
    return _instance;
}
-(id)init
{
    if (self=[super init]) {
   
        IsPlayPause=NO;
        InterruptAutoPlay=NO;
        _IsPlayEnd=YES;
    
        MusicList=[JSGetMusicListFromNet ShareGetMusicListFromNet];
        //初始化播放列表
        self.Play_list=MusicList.PlayList;
        
    }
    return self;
}
/**
 *  根据传入的播放状态操作播放
 *
 *  @param status 播放状态
 */
-(void)PlayMusicWithPlayStatus:(enum KPlayStatus)status

{
    switch (status) {
            //开始播放
        case 0:
             IsPlayPause=NO;
            InterruptAutoPlay=NO;
            //IsPlayEnd=YES;
            
            [self AutoPlayMusicFromPlayList];
            break;
            //播放暂停
            case 1:
                [[AFSoundManager sharedManager]pause];
                IsPlayPause=YES;
            break;
            
            //播放下一首
            case 2:
            InterruptAutoPlay=YES;
            //IsPlayEnd=YES;
            [self AutoPlayMusicFromPlayList];
            break;
            //播放继续
            case 3:
           [[AFSoundManager sharedManager]resume];

            InterruptAutoPlay=NO;
            break;
            //播放停止
            case 4:
            InterruptAutoPlay=YES;
            [[ AFSoundManager sharedManager] stop];
            break;
            
        default:
            break;
    }
}
-(void)AutoPlayMusicFromPlayList
{
    NSString *Str_Url=nil;
     if (self.FistPlay_url!=nil) {
         Str_Url=self.FistPlay_url;
         self.FistPlay_url=nil;

     }else
     {
         if (self.Play_list.count>0) {
             //取出音乐列表对象表选项
             info=MusicList.PlayList.firstObject;
             Str_Url=info.Song_url;
            if (!(self.Play_list.count>0))
                {
                    //获取新的播放列表
                    self.Play_list=MusicList.PlayList;
                    [self AutoPlayMusicFromPlayList];
                }
         }
       
         
     }

 //   NSLog(@"Str_Url%@----\n%@",Str_Url,self.Play_list);
    [[AFSoundManager sharedManager]startStreamingRemoteAudioFromURL:Str_Url andBlock:^(int percentage, CGFloat elapsedTime, CGFloat timeRemaining, NSError *error, BOOL finished) {
   ///     NSLog(@"%@",finished==YES?@"完成":@"未完成");
       if (finished) {
                            if (InterruptAutoPlay) {
                             InterruptAutoPlay=NO;
                                return ;
                                  } else{
                                      [[AFSoundManager sharedManager]stop];
                                      [self.NextAlbumDelegate SendShowNextAlbum];
                                       //_IsPlayEnd=NO;
                                      
                                        }
              }
      

    }];
}
@end
