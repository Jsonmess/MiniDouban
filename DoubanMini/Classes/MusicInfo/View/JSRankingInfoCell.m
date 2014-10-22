//
//  JSRankingInfoCell.m
//  DoubanMini
//
//  Created by Json on 14-10-8.
//  Copyright (c) 2014年 jsonmess. All rights reserved.
//

#import "JSRankingInfoCell.h"

@implementation JSRankingInfoCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self LoadNib];
    }
    return self;
}

- (void)LoadNib
{
    [[NSBundle mainBundle]loadNibNamed:@"RankingInfo" owner:self options:nil];
    [self.contentView addSubview: self.ContentView];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
