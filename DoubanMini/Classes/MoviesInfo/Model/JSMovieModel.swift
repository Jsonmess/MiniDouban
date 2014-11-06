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
    public var  genres:NSArray?;//影片分类
    public var  summary:NSString?;//影片简介
    public var  photos_count:NSString?;//影片截图数量
    public var  photos:NSArray?;//影片预览图数组
    public var  trailer_urls:NSString?;//电影预告片url数组
    public var  Comments:NSMutableArray?;//评论数组
    
    init(movieInfo:NSDictionary?)
    {
        super.init();
        self.setValueWithDictionary(movieInfo!);
    }
    
    private func setValueWithDictionary(dic:NSDictionary)
    {
        self.ratings_count=NSString(format: "%d", (dic["ratings_count"] as NSInteger));
        self.average=NSString(format: "%d", (dic["rating"] as NSDictionary)["average"] as NSInteger);
        
        self.pubdate=dic["pubdate"] as? NSString;
        self.durations=(dic["durations"] as NSArray)[0] as? NSString;
        self.genres=dic["genres"] as? NSArray;
        self.summary=dic["summary"] as? NSString;
        self.photos_count=NSString(format: "%d", dic["photos_count"] as NSInteger);
        self.photos=dic["photos"] as? NSArray;
        
        //对预告片url处理
        self.trailer_urls=(dic["trailer_urls"] as NSArray)[0] as? NSString;
        //处理评论数组
       self.Comments=self.SetCommentsArray(dic["popular_comments"] as NSArray)
    }
    private func SetCommentsArray(array:NSArray)->NSMutableArray
    {
        var comments:NSMutableArray!=NSMutableArray();
        for thecomment in array
        {
            var comment:JSCommentModel=JSCommentModel(Comment: thecomment as? NSDictionary);
            comments.addObject(comment);
        }
        return comments!;
    }
}
