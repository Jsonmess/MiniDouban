//
//  Oauth_ViewController.h
// DoubanMini
//
//  Created by Json on 14-10-6.
//  Copyright (c) 2014年 Json. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JSSendLoginState.h"
@interface Oauth_ViewController : UIViewController
@property (strong, nonatomic)id<JSSendLoginState>StateDelegate;
@end
