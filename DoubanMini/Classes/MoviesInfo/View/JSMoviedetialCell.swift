//
//  JSMoviedetialCell.swift
//  DoubanMini
//
//  Created by json on 14/10/28.
//  Copyright (c) 2014年 jsonmess. All rights reserved.
//

import UIKit

class JSMoviedetialCell: UICollectionViewCell {

    @IBOutlet weak var moviePicture: UIImageView!
    @IBOutlet weak var movieName: UILabel!
    @IBOutlet weak var movieScore: UIImageView!
    @IBOutlet weak var movieScoreValue: UILabel!
    
    @IBOutlet var theCell: UICollectionViewCell!
        //MARK:初始化
    override init(frame: CGRect) {
        super.init(frame: frame);
          self.setUpView();
    }
    override init() {
        super.init();
    }
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

func setUpView()
{
    //loadNib
NSBundle.mainBundle().loadNibNamed("JSMoviedetialCell", owner: self, options: nil);
    self.contentView.addSubview(theCell);
    }
    
}
