//
//  JSRankingCellTableViewCell.h
//  DoubanMini
//
//  Created by Json on 14-10-8.
//  Copyright (c) 2014年 jsonmess. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JSRankingCellTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *IconView;//榜单图标
@property (weak, nonatomic) IBOutlet UILabel *Name;//榜单名称
@property (weak, nonatomic) IBOutlet UIView *Contentview;

-(void)setIcon_UserNameWithIconImage:(NSString *)imgName RankingName:(NSString *)name;
@end
