//
//  RefreshChannels.m
//  DoubanMini
//
//  Created by Json on 14-9-29.
//  Copyright (c) 2014年 jsonmess. All rights reserved.
//

#import "RefreshChannels.h"

@implementation RefreshChannels
/**
 *  获取频道列表
 */
+(void)GetFMChannelsFromDouban
{
    NSString *urlstr=@"http://www.douban.com/j/app/radio/channels";
    NSURL *url=[NSURL URLWithString:urlstr];
    NSURLRequest *request=[NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (connectionError==nil&&data!=nil) {
            NSArray *array=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
            //获取路径
            NSString *path_str=[[NSBundle mainBundle]pathForResource:@"channels.plist" ofType:nil];
            [array writeToFile:path_str atomically:YES];
            
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"频道MHz已成功刷新!" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alert show];
        }
        else
        {
            //  Debuglog(@"%@",connectionError.localizedDescription);
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"刷新频道MHz失败，请检查您的网络!" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alert show];
        }
        
        
    }];
}
@end
