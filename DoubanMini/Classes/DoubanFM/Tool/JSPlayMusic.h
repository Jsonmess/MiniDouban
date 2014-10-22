//
//  JSPlayMusic.h
//  DoubanMini
//
//  Created by Json on 14-10-1.
//  Copyright (c) 2014年 jsonmess. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSSendShowNextAlbum.h"
enum  KPlayStatus
{
   KplayStart=0,//开始播放
    kPlayPause,//播放暂停
    KPlayNext,//下一曲
    kPlayResume,//继续播放
    KPlayStop//播放停止
};
@interface JSPlayMusic : NSObject
/**
 *  只在此处传入歌曲链接播放
 */
@property(nonatomic,strong)NSMutableArray*Play_list;//播放音乐数组
@property(nonatomic,assign)enum KPlayStatus PlayStatus;//播放状态
@property(nonatomic,assign)NSString *FistPlay_url;//首次播放歌曲url
@property(nonatomic,strong) __block id<JSSendShowNextAlbum>NextAlbumDelegate;//通知更换专辑图
@property(nonatomic,assign)BOOL IsPlayEnd;//播放完成？;

-(void)PlayMusicWithPlayStatus:(enum KPlayStatus)status;
+(id)SharePlayMusic;
@end
