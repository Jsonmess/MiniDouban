//
//  JSMovieDetialViewController.swift
//  DoubanMini
//
//  Created by jsonmess on 14/11/2.
//  Copyright (c) 2014年 jsonmess. All rights reserved.
//

import UIKit

class JSMovieDetialViewController: UIViewController {

    var getinfoTool:JSGetDoubanMovieInfo?;
    var theMovie:JSMovieModel?;
    var movieid:NSString?;
    override func viewDidLoad() {
        self.title="title";
        super.viewDidLoad()
        self.GetMovieDataFromDouban();
        // Do any additional setup after loading the view.
    }
    func setMovieId(theid:NSString)
    {
       self.movieid=theid;
        
    }
    func GetMovieDataFromDouban()
    {
        if getinfoTool==nil
        {
            getinfoTool=JSGetDoubanMovieInfo();
        }
        getinfoTool?.getMovieDetailInfoFromDoubanServiceWithMovieID(movieid, successBlock: { (dic:[NSObject : AnyObject]!) -> Void in
           //初始化电影模型
             var thedic:NSDictionary = dic;
            self.theMovie=JSMovieModel(movieInfo: dic);
            NSLog("%@", self.theMovie!);
            }, failedBlock: { (error:NSError!) -> Void in
            
        })
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
