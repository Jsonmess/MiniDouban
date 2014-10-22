//
//  JSRankingCellTableViewCell.m
//  DoubanMini
//
//  Created by Json on 14-10-8.
//  Copyright (c) 2014年 jsonmess. All rights reserved.
//

#import "JSRankingCellTableViewCell.h"

@implementation JSRankingCellTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {

        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
        [self setBackgroundColor:[UIColor clearColor]];
        [self LoadXib];
    }
    return self;
}

-(void)LoadXib
{
    
   [[NSBundle mainBundle]loadNibNamed:@"JSRankingCellTableViewCell" owner:self options:nil];
    [self.contentView addSubview:self.Contentview];
    
}
//设置内容
-(void)setIcon_UserNameWithIconImage:(NSString *)imgName RankingName:(NSString *)name
{
    [self.Name setText:name];
    [self.IconView setImage:[UIImage imageNamed:imgName]];
  
}

@end
