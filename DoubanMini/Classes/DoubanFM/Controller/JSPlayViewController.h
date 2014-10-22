//
//  JSPlayViewController.h
//  DoubanMini
//
//  Created by Json on 14-9-29.
//  Copyright (c) 2014年 jsonmess. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JingRoundView.h"
#import "JSChannel.h"
#import "JSGetMusicListFromNet.h"
#import "JSSendShowNextAlbum.h"
enum KRotationStatus
{
    KRotatonPlay=0,
    kRotationPause,
    kRotationStop
    
};
@class JSfmViewController;
@interface JSPlayViewController : UIViewController<JSSendShowNextAlbum>
@property (weak, nonatomic) IBOutlet JingRoundView *RoundView;//旋转view
@property (weak, nonatomic) IBOutlet UIImageView *BackImage;//背景
@property (weak, nonatomic) IBOutlet UIImageView *PlayStatusBar;//指示针
@property (weak, nonatomic) IBOutlet UIButton *LikeBtn;//红心
@property (weak, nonatomic) IBOutlet UIButton *DelBtn;//删除
@property (weak, nonatomic) IBOutlet UIButton *NextBtn;//下一首
@property (weak, nonatomic) IBOutlet UILabel *CurrentChannel;//当前频道名称
@property (weak, nonatomic) IBOutlet UILabel *CurrentSong;
@property (weak, nonatomic) IBOutlet UIImageView *RoundPoint;//轴臂旋转点
@property (strong, nonatomic)  JSChannel *TheChannel;//当前频道
@property (strong, nonatomic)JSGetMusicListFromNet*GetMusic;
@property (weak, nonatomic) IBOutlet UISlider *VolumeSlider;//音量滑块
- (IBAction)ChangeVolume:(id)sender;

- (IBAction)AddLikeSong:(UIButton*)sender;
- (IBAction)DeleteSong:(id)sender;
- (IBAction)NextSong:(UIButton*)sender;



@end
