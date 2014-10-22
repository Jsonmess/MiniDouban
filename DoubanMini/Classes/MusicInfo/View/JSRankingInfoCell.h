//
//  JSRankingInfoCell.h
//  DoubanMini
//
//  Created by Json on 14-10-8.
//  Copyright (c) 2014年 jsonmess. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JSRankingInfoCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *RankingIcon;//榜单图标
@property (strong, nonatomic) IBOutlet UIView *ContentView;
@property (weak, nonatomic) IBOutlet UILabel *RankingName;

@property (weak, nonatomic) IBOutlet UILabel *RankingDetial;//榜单描述

@end
