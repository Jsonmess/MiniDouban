//
//  JSRkMusicList.m
//  DoubanMini
//
//  Created by Json on 14-10-9.
//  Copyright (c) 2014年 jsonmess. All rights reserved.
//

#import "JSRkMusicList.h"

@implementation JSRkMusicList

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
   [[NSBundle mainBundle]loadNibNamed:@"RkMusicList" owner:self options:nil];
        [self.contentView addSubview:self.contenview];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

}
//-(void)setFrame:(CGRect)frame
//{
//    frame.size.height=frame.size.height-2.0f;
//    [super setFrame:frame];
//}
@end
