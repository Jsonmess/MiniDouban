//
//  JSAuthorInfoController.m
//  DoubanMini
//
//  Created by Json on 14-10-7.
//  Copyright (c) 2014年 jsonmess. All rights reserved.
//

#import "JSAuthorInfoController.h"
#import "Tabbar_view.h"
@interface JSAuthorInfoController()
{
    Tabbar_view *dock;
}
@end
@implementation JSAuthorInfoController
-(void)viewDidLoad
{
    [self SetUpTheView];
}

-(void)SetUpTheView
{
    self.title=@"作者信息";
    //设置返回按钮
    UIButton *leftbtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [leftbtn setBackgroundImage:[UIImage imageNamed:@"Back_Setting.png"] forState:UIControlStateNormal];
    [leftbtn setBackgroundImage:[UIImage imageNamed: @"Back_Setting.png"] forState:UIControlStateHighlighted];
    [leftbtn addTarget:self action:@selector(BackToSetting) forControlEvents:UIControlEventTouchUpInside];
    [leftbtn setFrame:CGRectMake(0, 0, 28.0f, 28.0f)];
    UIBarButtonItem *backitem=[[UIBarButtonItem alloc]initWithCustomView:leftbtn];
    self.navigationItem.leftBarButtonItem=backitem;
    //加载xib
    [[NSBundle mainBundle]loadNibNamed:@"UserInfo" owner:self options:nil];
    [self.ShowInfo setFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    //隐藏底部DOCK
  dock=[Tabbar_view ShareTabbar_view];
    [dock setHidden:YES];
    //加载txt
    [self LoadAuthorInfoTXT];
    
}
-(void)BackToSetting
{
    [self.navigationController popViewControllerAnimated:YES];
    [dock setHidden:NO];
}
-(void)LoadAuthorInfoTXT
{
  NSString *file_path =[[NSBundle mainBundle]pathForResource:@"AboutAuthor.txt" ofType:nil];
    NSString *content=[NSString stringWithContentsOfFile:file_path encoding:NSUTF8StringEncoding error:nil];

    [self.ShowInfo loadHTMLString:content baseURL:nil];
    
}
@end
