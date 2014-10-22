//
//  JSGetFMlistFromDouBan.h
//  DoubanMini
//
//  Created by Json on 14-10-1.
//  Copyright (c) 2014年 jsonmess. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^GetDBDataSuccess)(NSMutableArray *FMList);
typedef void (^GetDBDataFailed)(NSError *error);
@interface JSGetFMlistFromDouBan : NSObject
+(void)GetDBDataWithPath:(NSString *)baseURL path:(NSString *)path Params:(NSDictionary *)param WithGetSuccess:(GetDBDataSuccess)success GetFailed:(GetDBDataFailed)failed  WithMethod:(NSString *)method;
@end
