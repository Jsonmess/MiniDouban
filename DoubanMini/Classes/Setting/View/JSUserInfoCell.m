//
//  JSUserInfoCell.m
//  DoubanMini
//
//  Created by Json on 14-10-6.
//  Copyright (c) 2014年 jsonmess. All rights reserved.
//

#import "JSUserInfoCell.h"
#import "JSDBaccount.h"
#import "UIImageView+WebCache.h"
@implementation JSUserInfoCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self LoadXib];
        [self setBackgroundColor:[UIColor clearColor]];
        [self.UserName setFont:[UIFont systemFontOfSize:15.0f]];
       //刷新获取用户详细数据
        NSString *user_id=[[JSDBaccount ShareDBaccount]GetAccountFromSqlite3].uid;
        [[JSDBaccount ShareDBaccount]GetUserInfoFromDoubanWithUserId:user_id];
        
    }
    return self;
}

-(void)LoadXib
{
    [[NSBundle mainBundle]loadNibNamed:@"JSUserInfo" owner:self options:nil];
    [self.contentView addSubview:self.ContentView];
    //设置用户图标为圆形
    self.UserIcon.layer.cornerRadius=self.UserIcon.frame.size.width*0.5f;
    self.UserIcon.clipsToBounds=YES;


}
//设置内容
-(void)setUserIcon_UserNameWithAccount:(NSDictionary*)dic
{
    [self.UserName setText:dic[@"name"]];
   [self.UserIcon sd_setImageWithURL:dic[@"large_avatar"] placeholderImage: [UIImage imageNamed:@"user_normal.jpg"] options:SDWebImageHighPriority|SDWebImageRetryFailed |SDWebImageContinueInBackground];
    if (dic[@"large_avatar"]==nil) {
        [self.UserIcon setImage:[UIImage imageNamed:@"user.normal.jpg"]];
    }
}

@end
