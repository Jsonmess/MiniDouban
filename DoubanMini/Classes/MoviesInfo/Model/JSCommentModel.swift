//
//  JSCommentModel.swift
//  DoubanMini
//
//  Created by jsonmess on 14/11/5.
//  Copyright (c) 2014年 jsonmess. All rights reserved.
//
/*
模型：
rating:评分
name：评论用户昵称
avatar:评论用户头像url
content:评论内容

*/
import UIKit

public class JSCommentModel: NSObject {
    public var rating:NSString?;//评分
    public var name:NSString?;//评论用户昵称
    public var avatar:NSString?;//评论用户头像url
    public var content:NSString?;//评论内容
    
    init(Comment:NSDictionary?)
    {
        super.init();
        self.setvalueWith(Comment);
    }
    
    private func setvalueWith(com:NSDictionary!)
    {
       if com != nil
       {
        self.rating=(com["rating"] as NSDictionary)["value"] as? NSString;
        self.name=(com["author"] as NSDictionary)["name"] as? NSString;
        self.avatar=(com["author"] as NSDictionary)["avatar"] as? NSString;
        self.content=(com["author"] as NSDictionary)["content"] as? NSString;
        }
        
    }
}
