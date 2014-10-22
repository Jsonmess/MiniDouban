//
//  JSGetMusicListFromNet.m
//  DoubanMini
//
//  Created by Json on 14-10-2.
//  Copyright (c) 2014年 jsonmess. All rights reserved.
//

#import "JSGetMusicListFromNet.h"
#import "JSGetFMlistFromDouBan.h"
#import "JSSongInfo.h"
@interface JSGetMusicListFromNet()
{

}
@end
@implementation JSGetMusicListFromNet
//创建为单例
static  JSGetMusicListFromNet*_instance;
#pragma mark----创建单例
+(id)ShareGetMusicListFromNet
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
    
    self=[super init];
    if (self) {
        self.PlayList=[NSMutableArray array];
        self.PlayUrl_List=[NSMutableArray array];
  
    }
    return self;
}
-(void)GetMusicListFromDoubanWithChannelId:(NSString*)channel_id
{
    [ JSGetFMlistFromDouBan GetDBDataWithPath:@"http://www.douban.com" path:@"/j/app/radio/people" Params:
     @{
       @"app_name": @"radio_desktop_win",
       @"version": @"100",
       @"user_id":@"",
       @"expire":@"",
       @"token":@"",
       @"channel":[NSString stringWithFormat:@"%@",channel_id],
       @"type":@"n"
       }
     
                               WithGetSuccess:^(NSMutableArray *FMList) {
                                   [self SetPlayListArray:FMList];
                                
                               } GetFailed:^(NSError *error) {
                                   UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"连接豆瓣失败，请返回FM列表重试!" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
                                   [alert show];
                               } WithMethod:@"GET"];

}

/**
 *  处理数组
 *
 *  @param array 数组对象
 */
-(void)SetPlayListArray:(NSMutableArray*)array
{
    NSArray *thearray=array[0][@"song"];
    //清空数组
    [_PlayList removeAllObjects];
    [_PlayUrl_List removeAllObjects];
    for (NSDictionary *dic in thearray ) {
        JSSongInfo*info=[[JSSongInfo alloc]init];
        info.Albumtitle=dic[@"albumtitle"];
        info.Artist=dic[@"artist"];
        info.PictureUrl=dic[@"picture"];
        info.SongLength=dic[@"length"];
        info.Company=dic[@"company"];
        info.Public_time=dic[@"public_time"];
        info.Title=dic[@"title"];
        info.Song_url=dic[@"url"];
        [_PlayList addObject:info];
        [_PlayUrl_List addObject:info.Song_url];
        
    }
}
@end
