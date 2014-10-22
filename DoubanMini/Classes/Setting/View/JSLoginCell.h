//
//  JSLoginCell.h
//  DoubanMini
//
//  Created by Json on 14-10-5.
//  Copyright (c) 2014年 jsonmess. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JSSendLogin_outState.h"
@interface JSLoginCell : UITableViewCell<UIActionSheetDelegate>
@property (weak, nonatomic) IBOutlet UIButton *LogIn_OutBtn;//登录按钮
- (IBAction)Login_out:(UIButton *)sender;//登录操作
@property (strong, nonatomic) IBOutlet UIView *ContentView;
@property (strong, nonatomic)id<JSSendLogin_outState>delegate;
@end
