//
//  JSMoviedetialCell.swift
//  DoubanMini
//
//  Created by json on 14/10/28.
//  Copyright (c) 2014年 jsonmess. All rights reserved.
//

import UIKit

public class JSMoviedetialCell: UICollectionViewCell {

    @IBOutlet  public weak var moviePicture: UIImageView!;
    @IBOutlet  public weak var movieName: UILabel!;
    @IBOutlet  public weak var movieScore: UIImageView!;
    @IBOutlet  public weak var movieScoreValue: UILabel!;
    
    @IBOutlet var theCell: UICollectionViewCell!;
    var ratingview:JSRatingView?;
        //MARK:初始化
    override init(frame: CGRect) {
        super.init(frame: frame);
          self.setUpView();
    }
    override init() {
        super.init();
    }
  public  required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private  func setUpView()
    {
        //loadNib
        NSBundle.mainBundle().loadNibNamed("JSMoviedetialCell", owner: self, options: nil);
        if ratingview==nil
        {
            ratingview=JSRatingView(frame:self.movieScore.bounds);
        }
        self.movieScore.addSubview(ratingview!);
        self.contentView.addSubview(theCell);
        
    }
    
    //MARK:传入电影名称、电影海报、电影评分
    public func setMoviedetialCellBy(MovieName name:NSString,MoviePic picurl:NSString, MovieRating rating:Float)
    {
        var  queue: dispatch_queue_attr_t=dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        self.movieName.text=name;
        self.ratingview?.showStarbyRatingValueWith(RatingValue: rating);
        //电影海报--使用多线程主线程更新视图
        dispatch_async(queue, { () -> Void in
               var imageview:UIImageView=JSLoadUrlImage.getimageWithUrl(picurl);
            //主线程更新
            dispatch_sync(dispatch_get_main_queue(), { () -> Void in
              self.moviePicture.image=imageview.image;
            });
        });
        self.movieScoreValue.text=NSString(format: "%.1f", rating);
    }
}
