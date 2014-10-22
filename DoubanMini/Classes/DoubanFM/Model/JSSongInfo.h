//
//  JSSongInfo.h
//  DoubanMini
//
//  Created by Json on 14-10-1.
//  Copyright (c) 2014年 jsonmess. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JSSongInfo : NSObject
@property(nonatomic,strong)NSString*Albumtitle;//专辑名称
@property(nonatomic,strong)NSString*Artist;//歌手
@property(nonatomic,strong)NSString*PictureUrl;//专辑图片
@property(nonatomic,strong)NSString*Company;//专辑发行公司
@property(nonatomic,strong)NSString*Public_time;//发行时间
@property(nonatomic,strong)NSString*SongLength;//歌曲时长
@property(nonatomic,strong)NSString*Title;//歌名
@property(nonatomic,strong)NSString*Song_url;//歌曲链接
@end
