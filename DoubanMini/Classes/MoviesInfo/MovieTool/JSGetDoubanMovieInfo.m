//
//  JSGetDoubanMovieInfo.m
//  DoubanMini
//
//  Created by json on 14/10/22.
//  Copyright (c) 2014年 jsonmess. All rights reserved.
//

#import "JSGetDoubanMovieInfo.h"
#import "HttpTool.h"
@implementation JSGetDoubanMovieInfo


-(void)getMovieInfoFromDoubanServiceWithBlock:(GetInfoSuccess)success Failed:(GetInfoFalse)failed;
{
    [HttpTool HttpSendwithPath:@"http://api.douban.com" path:@"/v2/movie/nowplaying" Params:
                                        @{
                                          @"alt":@"json",
                                          @"apikey":@"0df993c66c0c636e29ecbb5344252a4a"
                                            }
                   PostSuccess:^(id Json){
                       NSDictionary *dic=Json;
                       success(dic);
                      
                                        }
            PostFaild:^(NSError *error){
                failed(error);
                                        } WithMethod:@"GET"];
}
-(void)getMovieDetailInfoFromDoubanServiceWithMovieID:(NSString *)movie_id SuccessBlock:(GetInfoSuccess)success FailedBlock:(GetInfoFalse)failed;
{
    [HttpTool HttpSendwithPath:@"http://api.douban.com" path:[@"/v2/movie/subject" stringByAppendingPathComponent:movie_id] Params:
     @{
       @"alt":@"json",
       @"apikey":@"0df993c66c0c636e29ecbb5344252a4a"
       }
                   PostSuccess:^(id Json){
                       NSDictionary *dic=Json;
                       success(dic);
                       
                   }
                     PostFaild:^(NSError *error){
                         failed(error);
                     } WithMethod:@"GET"];
}


@end
