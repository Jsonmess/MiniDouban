//
//  JSListCell.m
//  DoubanMini
//
//  Created by Json on 14-10-5.
//  Copyright (c) 2014年 jsonmess. All rights reserved.
//

#import "JSListCell.h"

@implementation JSListCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self LoadXib];
        [self setBackgroundColor:[UIColor clearColor]];
        
        [self.ListTitle setTextColor:[UIColor blackColor]];
        [self.ListTitle setFont:[UIFont systemFontOfSize:18.0f]];

    }
    return self;
}

-(void)LoadXib
{
    [[NSBundle mainBundle]loadNibNamed:@"JSListCell" owner:self options:nil];
    [self.contentView addSubview:self.ContentView];
}

-(void)SetUserIcon_UserName
{
    
}
@end
