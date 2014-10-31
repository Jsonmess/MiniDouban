//
//  JSLoadUrlImage.h
//  DoubanMini
//
//  Created by jsonmess on 14/10/31.
//  Copyright (c) 2014年 jsonmess. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIImageView+WebCache.h"
@interface JSLoadUrlImage : NSObject
+(UIImageView *)getimageWithUrl:(NSString*)url;
@end
