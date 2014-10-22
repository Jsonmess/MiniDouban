//
//  JSMusicListModel.m
//  DoubanMini
//
//  Created by Json on 14-10-8.
//  Copyright (c) 2014年 jsonmess. All rights reserved.
//

#import "JSMusicListModel.h"
#define KsongNumber 50//部分榜单歌曲数目太多，所以只截取前50首音乐信息

@interface JSMusicListModel()
{
    NSString *coverImg;//榜单头像
    NSString *name;//榜单名称
    NSString *description;//榜单描述
    NSString *music_url;//音乐地址
    NSString *music_name;//歌曲名
    NSInteger num;
}
@end
@implementation JSMusicListModel

static  JSMusicListModel*_instance;
#pragma mark----创建单例模板
+(id)ShareMusicListModel
{
    if (_instance==nil) {
        _instance=[[self alloc]init];//这个会默认调用allocWithZone

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
       
    }
    return self;
}
//解析并提取榜单Json返回的数据
-(NSDictionary *)GetMusicListInfo:(NSDictionary *)dic;
{
    num=0;
    coverImg=dic[@"result"][@"coverImgUrl"];
    name=dic[@"result"][@"name"];
   description=dic[@"result"][@"description"];

    NSMutableArray *Songinfo=[NSMutableArray array];
    for (NSDictionary *dictionary in dic[@"result"][@"tracks"]) {

        music_name=dictionary[@"name"];
        music_url=dictionary[@"mp3Url"];
        NSDictionary *d=@{@"music_name": music_name,
                          @"music_url": music_url
                          };
        num++;
        if (num>=KsongNumber||num>=(int)dic[@"result"][@"trackCount"]) {
            break;
        }
        [Songinfo addObject:d];
    }
    NSDictionary *Thedic=@{
                           @"SongList":Songinfo,
                           @"description":description,
                           @"coverImg": coverImg,
                           @"name":name
                           };
    
    return Thedic;

}
@end
