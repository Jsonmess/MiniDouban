//
//  JSUserInfoCell.h
//  DoubanMini
//
//  Created by Json on 14-10-6.
//  Copyright (c) 2014年 jsonmess. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JSUserInfoCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *UserIcon;//用户图标
@property (weak, nonatomic) IBOutlet UILabel *UserName;//用户昵称
@property (weak, nonatomic) IBOutlet UIView *ContentView;
-(void)setUserIcon_UserNameWithAccount:(NSDictionary*)dic;
@end
