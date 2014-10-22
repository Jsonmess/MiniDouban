//
//  JSGetFMlistFromDouBan.m
//  DoubanMini
//
//  Created by Json on 14-10-1.
//  Copyright (c) 2014年 jsonmess. All rights reserved.
//

#import "JSGetFMlistFromDouBan.h"
#import "AFNetworking.h"
#import "HttpTool.h"
@implementation JSGetFMlistFromDouBan
+(void)GetDBDataWithPath:(NSString *)baseURL path:(NSString *)path Params:(NSDictionary *)param WithGetSuccess:(GetDBDataSuccess)success GetFailed:(GetDBDataFailed)failed  WithMethod:(NSString *)method ;
{
    [HttpTool HttpSendwithPath:baseURL path:path Params:param PostSuccess:^(id Json) {
    
       success([NSMutableArray arrayWithObject:Json]);
      
        } PostFaild:^(NSError *error) {
        
        failed(error);
    } WithMethod:method];
    
    
}
@end
