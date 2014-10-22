//
//  JSGetMusicListFromNet.h
//  DoubanMini
//
//  Created by Json on 14-10-2.
//  Copyright (c) 2014年 jsonmess. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JSGetMusicListFromNet : NSObject
@property (strong, nonatomic)NSMutableArray *PlayList;//歌曲列表;
@property (strong, nonatomic)NSMutableArray *PlayUrl_List;//歌曲Url列表;
@property (assign, nonatomic)BOOL IsFirstLoad;//第一次加载;
-(void)GetMusicListFromDoubanWithChannelId:(NSString*)channel_id;
+(id)ShareGetMusicListFromNet;
@end
