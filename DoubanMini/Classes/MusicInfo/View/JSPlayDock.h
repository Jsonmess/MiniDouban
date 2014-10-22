//
//  JSPlayDock.h
//  DoubanMini
//
//  Created by Json on 14-10-10.
//  Copyright (c) 2014年 jsonmess. All rights reserved.
//

#import <UIKit/UIKit.h>
enum KPlayState
{
    kPlayStart=0,
    KPlayPause,
    KPlayResume,
    KPlayNext,
    KPlayStop//播放停止
};
@interface JSPlayDock : UIImageView
@property (weak, nonatomic) IBOutlet UIButton *PlayButton;
@property (weak, nonatomic) IBOutlet UIButton *PlayNext;
@property (weak, nonatomic) IBOutlet UIButton *LikeSong;
@property (strong, nonatomic) IBOutlet UIView *DockView;
@property (weak, nonatomic) IBOutlet UILabel *SongName;//歌曲名称

- (IBAction)ActionPlay:(UIButton*)sender;
- (IBAction)ActionNext:(id)sender;
- (IBAction)ActionLike:(UIButton*)sender;
-(void)GetplayListWithDictionary:(NSArray *)ListArray;//播放列表
-(void)GetSelectedSongInfo:(NSDictionary*)songinfo Row:(NSInteger)row;//获取选中歌曲信息
-(void)StopMusicPlay;
@end
