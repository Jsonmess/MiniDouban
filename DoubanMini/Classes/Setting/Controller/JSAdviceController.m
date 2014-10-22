//
//  JSAdviceController.m
//  DoubanMini
//
//  Created by Json on 14-10-7.
//  Copyright (c) 2014年 jsonmess. All rights reserved.
//

#import "JSAdviceController.h"
#import "Tabbar_view.h"
#import <MessageUI/MessageUI.h>
@interface JSAdviceController ()<MFMailComposeViewControllerDelegate,UITextViewDelegate>
{
    Tabbar_view *dock;
    MFMailComposeViewController *mailPicker;
}
@end

@implementation JSAdviceController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self SetUpView];
    // Do any additional setup after loading the view from its nib.
}

-(void)SetUpView
{
    self.title=@"用户吐槽";
    //设置返回按钮
    UIButton *leftbtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [leftbtn setBackgroundImage:[UIImage imageNamed:@"Back_Setting.png"] forState:UIControlStateNormal];
    [leftbtn setBackgroundImage:[UIImage imageNamed: @"Back_Setting.png"] forState:UIControlStateHighlighted];
    [leftbtn addTarget:self action:@selector(BackToSetting) forControlEvents:UIControlEventTouchUpInside];
    [leftbtn setFrame:CGRectMake(0, 0, 28.0f, 28.0f)];
    UIBarButtonItem *backitem=[[UIBarButtonItem alloc]initWithCustomView:leftbtn];
    self.navigationItem.leftBarButtonItem=backitem;
    //隐藏底部DOCK
    dock=[Tabbar_view ShareTabbar_view];
    [dock setHidden:YES];
    [self.AdviceFiled setDelegate:self];

}
-(void)BackToSetting
{
    [self.navigationController popViewControllerAnimated:YES];
    [dock setHidden:NO];
}
- (IBAction)SendAdvice:(id)sender {
    if (self.AdviceFiled.text==nil) {
        UIAlertView *alt=[[UIAlertView alloc]initWithTitle:@"提示" message:@"您还是说点什么吧" delegate:self cancelButtonTitle:@"确认" otherButtonTitles: nil];
        [alt show];
    }else
    {
        [self sendMailInApp];
    }
}
//激活邮件功能
- (void)sendMailInApp
{
    Class mailClass = (NSClassFromString(@"MFMailComposeViewController"));
    if (![mailClass canSendMail]) {
        [self alertWithMessage:@"您没有设置邮件账户"];
        return;
    }
    [self displayMailPicker];
}

//调出邮件发送窗口
- (void)displayMailPicker
{
 mailPicker = [[MFMailComposeViewController alloc] init];
    mailPicker.mailComposeDelegate = self;
    
    //设置主题
    [mailPicker setSubject: @"Mini豆瓣意见反馈"];
    //添加收件人
    NSArray *toRecipients = [NSArray arrayWithObject: @"jsonmess@gmail.com"];
    [mailPicker setToRecipients: toRecipients];
    //添加抄送
    NSArray *ccRecipients = [NSArray arrayWithObjects:@"jsonmess@gmail.com", @"646147651@qq.com", nil];
    [mailPicker setCcRecipients:ccRecipients];
    //添加密送
    NSArray *bccRecipients = [NSArray arrayWithObjects:@"", nil];
    [mailPicker setBccRecipients:bccRecipients];

    
    NSString *emailBody = self.AdviceFiled.text;
    [mailPicker setMessageBody:emailBody isHTML:YES];
    [self presentViewController:mailPicker animated:YES completion:nil];
}

#pragma mark ---实现 代理
- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    //关闭邮件发送窗口
    [self dismissViewControllerAnimated:YES completion:nil];
    NSString *msg;
    switch (result) {
        case MFMailComposeResultCancelled:
            msg = @"您已取消编辑邮件！";
            break;
        case MFMailComposeResultFailed:
            msg = @"抱歉，试图保存或者发送邮件失败！";
            break;
        default:
            msg = @"";
            break;
    }
    [self alertWithMessage:msg];
}
-(void)alertWithMessage:(NSString *)msg
{
    if(msg!=nil||![msg isEqual:@""])
    {
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:msg delegate:self cancelButtonTitle:@"确认" otherButtonTitles: nil];
    [alert show];
    }
}
//代理方法
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString*)text
{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
