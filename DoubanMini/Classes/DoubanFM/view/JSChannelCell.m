//
//  JSChannelCell.m
//  DoubanMini
//
//  Created by Json on 14-9-29.
//  Copyright (c) 2014年 jsonmess. All rights reserved.
//

#import "JSChannelCell.h"
#import "UIImage+Json_resize_image.h"

@implementation JSChannelCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundView=[[UIImageView alloc]initWithImage: [UIImage ResizeThePicture:@"cell_bg@2x.png" WithUIEdgeInserts: UIEdgeInsetsMake(10, 10, 10, 10) resizingMode:UIImageResizingModeStretch]];
        self.selectedBackgroundView =[[UIImageView alloc]initWithImage: [UIImage ResizeThePicture:@"cell_bg@2x.png" WithUIEdgeInserts: UIEdgeInsetsMake(10, 10, 10, 10) resizingMode:UIImageResizingModeStretch]];
        //添加子控件
        [self AddSubviewToContentView];
    }
    return self;
}
//添加子控件
-(void)AddSubviewToContentView
{
    _titleLabel=[[UILabel alloc]init];
    [_titleLabel setFont:[UIFont systemFontOfSize:15.0f]]; //字体大小
    [_titleLabel setHidden:YES];
    [self.contentView addSubview:_titleLabel];
    
    _mhzLabel=[[UILabel alloc]init];
    [_mhzLabel setText:@"MHz"];
    [_mhzLabel setFont:[UIFont systemFontOfSize:10.0f]]; //字体大小
    [_mhzLabel setHidden:YES];
    [self.contentView addSubview:_mhzLabel];
    
    _ShowCurrentPlay=[[UIImageView alloc]init];
    

    [self.contentView addSubview:_ShowCurrentPlay];
    
}

//设置内容
-(void)SetTheChannelName:(NSString*)name WithImageName:(NSString *)igname
{
    NSString *text=[NSString stringWithFormat:@" %@",name];
    CGSize textsize=[text sizeWithFont:[UIFont systemFontOfSize:17.0f]];
    [_titleLabel setFont:[UIFont systemFontOfSize:17.0f]];
    [_titleLabel setFrame:CGRectMake(10.0f, 15.0f, textsize.width, textsize.height+10.0f)];
    [_titleLabel setText:text];
    [_mhzLabel setFrame:CGRectMake(CGRectGetMaxX(_titleLabel.frame)+10.0f, 35.0f, 40.0f, 14.0f)];
    [_ShowCurrentPlay setImage:[UIImage imageNamed:igname]];
    [_ShowCurrentPlay setFrame:CGRectMake(self.bounds.size.width-40.0f, 20.0f, 20.0f, 20.0f)];
}

@end
