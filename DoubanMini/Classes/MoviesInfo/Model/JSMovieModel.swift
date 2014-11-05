//
//  JSMovieModel.swift
//  DoubanMini
//
//  Created by jsonmess on 14/11/5.
//  Copyright (c) 2014年 jsonmess. All rights reserved.
//
/*
模型：
ratings_count：评分人数
average：评分星级
pubdate：上映时间
durations:电影长度数组
genres：影片分类
summary：影片简介
photos_count：影片截图数量
photos:影片预览图数组
trailer_urls:电影预告片url数组

*/
import UIKit

public class JSMovieModel: NSObject {
    public var  ratings_count:NSString?;//评分人数
    public var  average:NSString?;//评分星级
    public var  pubdate:NSString?;//上映时间
    public var  durations:NSString?;//电影长度数组
    public var  genres:NSString?;//影片分类
    public var  summary:NSString?;//影片简介
    public var  photos_count:NSString?;//影片截图数量
    public var  photos:NSArray?;//影片预览图数组
    public var  trailer_urls:NSString?;//电影预告片url数组
    public var  Comments:NSMutableArray?;//评论数组
    
    init(movieInfo:NSDictionary?)
    {
        super.init();
        self.setValueWithDictionary(movieInfo);
    }
    
    private func setValueWithDictionary(dic:NSDictionary!)
    {
     
    }
}
