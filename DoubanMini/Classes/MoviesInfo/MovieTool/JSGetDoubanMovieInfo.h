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
-(void)getMovieInfoFromDoubanServiceWithBlock:(GetInfoSuccess)success Failed:(GetInfoFalse)failed;
@end
