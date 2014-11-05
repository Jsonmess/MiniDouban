//
//  JSGetDoubanMovieInfo.h
//  DoubanMini
//
//  Created by json on 14/10/22.
//  Copyright (c) 2014年 jsonmess. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^GetInfoSuccess)(NSDictionary *dic);
typedef void(^GetInfoFalse)(NSError *error);
@interface JSGetDoubanMovieInfo : NSObject
//获取电影列表
-(void)getMovieInfoFromDoubanServiceWithBlock:(GetInfoSuccess)success Failed:(GetInfoFalse)failed;
//获取某一部电影详细信息
-(void)getMovieDetailInfoFromDoubanServiceWithMovieID:(NSString *)movie_id SuccessBlock:(GetInfoSuccess)success FailedBlock:(GetInfoFalse)failed;
@end
