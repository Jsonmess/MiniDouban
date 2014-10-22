//
//  JSListCell.h
//  DoubanMini
//
//  Created by Json on 14-10-5.
//  Copyright (c) 2014年 jsonmess. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JSListCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *ListTitle;//标题
@property (strong, nonatomic) IBOutlet UIView *ContentView;

@end
