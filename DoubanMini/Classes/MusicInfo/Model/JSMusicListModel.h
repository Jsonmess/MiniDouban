//
//  JSMusicListModel.h
//  DoubanMini
//
//  Created by Json on 14-10-8.
//  Copyright (c) 2014年 jsonmess. All rights reserved.
//
/*
 dic[@“result”]
 
 [@“coverImgUrl”]=榜单头像
 [@“name”]=榜单名称
 [@“description”]=榜单描述
 
 
 dic[@"result"][@"tracks"][0][@"mMusic"][@"name"] ----------歌曲名称
 
 dic[@"result"][@"tracks"][0][@"mp3Url”]——————————歌曲地址
 */
#import <Foundation/Foundation.h>

@interface JSMusicListModel : NSObject
-(NSDictionary *)GetMusicListInfo:(NSDictionary *)dic;
+(id)ShareMusicListModel;
@end
