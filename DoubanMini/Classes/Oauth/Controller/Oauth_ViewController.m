//
//  Oauth_ViewController.m
//  DoubanMini
//
//  Created by Json on 14-10-6.
//  Copyright (c) 2014年 Json. All rights reserved.
//

#import "Oauth_ViewController.h"
#import "Json_cfg.h"
#import "MBProgressHUD.h"
#import "MainController.h"
#import "HttpTool.h"
#import "JSDBaccount.h"
@interface Oauth_ViewController ()<UIWebViewDelegate,MBProgressHUDDelegate>
{
    UIWebView *_webview;
    MBProgressHUD *_mbprogresshud;
}
@end

@implementation Oauth_ViewController

- (void)viewDidLoad
{
    self.title=@"授权登录";
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    _webview=[[UIWebView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].applicationFrame.size.width, [UIScreen mainScreen].applicationFrame.size.height)];
    [_webview setBackgroundColor:[UIColor colorWithRed:240.0f/255.0f green:240.0f/255.0f blue:240.0f/255.0f alpha:1.0f]];
    [self.view addSubview: _webview];
    //请求授权界面
    NSURL *url=[NSURL URLWithString:[NSString stringWithFormat:@"%@?client_id=%@&redirect_uri=%@&response_type=%@",KregisterUrl,KappKey,Kappredirect_url,Kresponse_type]];
    NSURLRequest *request=[NSURLRequest requestWithURL: url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:4.0f];
    [_webview loadRequest:request];
    [_webview setDelegate:self];
    
    //设置返回按钮
    UIButton *leftbtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [leftbtn setBackgroundImage:[UIImage imageNamed:@"Back_Setting.png"] forState:UIControlStateNormal];
    [leftbtn setBackgroundImage:[UIImage imageNamed: @"Back_Setting.png"] forState:UIControlStateHighlighted];
    [leftbtn addTarget:self action:@selector(BackToSetting) forControlEvents:UIControlEventTouchUpInside];
    [leftbtn setFrame:CGRectMake(0, 0, 28.0f, 28.0f)];
    UIBarButtonItem *backitem=[[UIBarButtonItem alloc]initWithCustomView:leftbtn];
    self.navigationItem.leftBarButtonItem=backitem;
}
#pragma mark--UIWebview的代理方法
-(void)webViewDidStartLoad:(UIWebView *)webView
{
    //添加指示器
    MBProgressHUD *hud=[[MBProgressHUD alloc]initWithView:self.view];
    [self.view addSubview:hud];
    hud.dimBackground=YES;
    hud.delegate=self;
    hud.color=KMBProgressBg;
    hud.labelText=@"加载授权页面...";
	hud.removeFromSuperViewOnHide = YES;
    [hud show:YES];
    _mbprogresshud=hud;
}
-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    //这里进行拦截--根据request判断是否授权成功
    NSString *back_url=request.URL.absoluteString;
   
    if([back_url rangeOfString:@"access_denied"].length>0)
    {
       //用户拒绝授权,返回应用设置
        [ self dismissViewControllerAnimated:YES completion:nil];
        return YES;
    }
    else{
        NSRange range=[back_url rangeOfString:@"code="];
        if (range.length!=0) {
            if (!_mbprogresshud.hidden) {
                 [_mbprogresshud setHidden:YES];
                 MBProgressHUD *hud=[[MBProgressHUD alloc]initWithView:self.view];
                 [self.view addSubview:hud];
                 hud.dimBackground=YES;
                 hud.delegate=self;
                 hud.labelText=@"正在登陆...";
                 hud.color=KMBProgressBg;
                 hud.removeFromSuperViewOnHide = YES;
                 [hud show:YES];
                 }
                 //截取字符串
                 NSInteger index=range.location+range.length; //起点是‘=’
                 NSString *thecode=[back_url substringFromIndex:index];
        
              [self GetAccessToken:thecode];
        
            return NO;
            }
            else
                {
                    return YES;
                }
            }
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    if (error) {
        if (!_mbprogresshud.hidden) {
            [_mbprogresshud setHidden:YES];
            MBProgressHUD *hud=[[MBProgressHUD alloc]initWithView:self.view];
            [self.view addSubview:hud];
            hud.mode=MBProgressHUDModeText;
            hud.dimBackground=NO;
            hud.color=KMBProgressBg;
            hud.delegate=self;
            hud.labelText=@"加载失败";
            hud.detailsLabelText=@"网络故障，请检查后返回重试！";
            hud.removeFromSuperViewOnHide = YES;
            [hud show:YES];
        
        }
    }
}
-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    if (!_mbprogresshud.hidden) {
        [_mbprogresshud setHidden:YES];
    }
    
    
}
#pragma mark---获取授权成功后的AccessToken

/**
 *  获取AccessToken
 *
 *  @param thecode 从重定向url中截取的code
 */
-(void)GetAccessToken:(NSString *)thecode
{
    
    [HttpTool HttpSendwithPath:@"https://www.douban.com" path:@"/service/auth2/token" Params:@{
                        @"client_id":KappKey,
                        @"client_secret":KappSecret,
                        @"grant_type":@"authorization_code",
                        @"code":thecode,
                        @"redirect_uri":Kappredirect_url
                        
                        }
                   PostSuccess:^(id Json) {
                     
      //隐藏所有指示器
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    //创建账号对象
    JSDBaccount *account=[JSDBaccount ShareDBaccount];
   [account SaveAccountToSqlite3WithAccessToken:Json[@"access_token"] Uid:Json[@"douban_user_id"]Expire:Json[@"expires_in"]];
                       [self GetUserinfo:Json[@"douban_user_id"]];
               
                    
    }
                     PostFaild:^(NSError *error) {
                         
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    
    
    } WithMethod:@"POST"];
    
    
}
-(void)BackToSetting
{
    //没有授权情况下返回。
    [self dismissViewControllerAnimated:YES completion:nil];

}
-(void)GetUserinfo:(NSString *)user_id
{
    [HttpTool HttpSendwithPath:@"https://api.douban.com" path:[NSString stringWithFormat:@"/v2/user/%@",user_id] Params:nil PostSuccess:^(id Json) {
        //存入Plist文件
        //获取路径
        NSString *Userpath=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
        Userpath=[Userpath stringByAppendingPathComponent:@"RegistUser.plist"];
        NSDictionary *dic=[NSDictionary dictionaryWithDictionary:Json];
        [dic writeToFile:Userpath atomically:YES];
       JSDBaccount *account=[JSDBaccount ShareDBaccount];
        account.dic=dic;
        //返回应用设置界面
        [self.StateDelegate SendLoginState:YES];
        [self dismissViewControllerAnimated:YES completion:nil];
    } PostFaild:^(NSError *error) {
        
    } WithMethod:@"GET"];
}
@end
