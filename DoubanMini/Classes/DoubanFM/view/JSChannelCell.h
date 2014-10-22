//
//  JSChannelCell.h
//  DoubanMini
//
//  Created by Json on 14-9-29.
//  Copyright (c) 2014年 jsonmess. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface JSChannelCell : UITableViewCell
@property(nonatomic,strong) UIImageView *ShowCurrentPlay;//当前频道
@property(nonatomic,strong)UILabel *titleLabel;//频道名
@property(nonatomic,strong)UILabel * mhzLabel;//MHZ
-(void)SetTheChannelName:(NSString*)name WithImageName:(NSString *)igname;

@end
