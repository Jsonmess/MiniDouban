//
//  JSLoadUrlImage.m
//  DoubanMini
//
//  Created by jsonmess on 14/10/31.
//  Copyright (c) 2014年 jsonmess. All rights reserved.
//

#import "JSLoadUrlImage.h"

@implementation JSLoadUrlImage
+(UIImageView *)getimageWithUrl:(NSString*)url
{
    UIImageView *imageview=[[UIImageView alloc]init];
    [imageview sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"defaultmovie@2x.png"] options:SDWebImageDownloaderLowPriority|SDWebImageRetryFailed ];
    return imageview;
}
@end
