//
//  JSRatingView.swift
//  pingfen
//
//  Created by json on 14/10/24.
//  Copyright (c) 2014年 jsonmess. All rights reserved.
//
/*
    根据传入的float值显示对应星级（1---10）

*/

import UIKit
let star_gray="ic_star_gray@2x.png"
let star_halfred="ic_star_half@2x.png"
let star_red="ic_star_red@2x.png"
@IBDesignable
public class JSRatingView: UIImageView {
    var viewSize:CGSize!;//视图size
    //显示星级
    @IBInspectable   private  var show_star0: UIImageView!;
    @IBInspectable   private  var show_star1: UIImageView!;
    @IBInspectable   private  var show_star2: UIImageView!;
    @IBInspectable   private  var show_star3: UIImageView!;
    @IBInspectable   private  var show_star4: UIImageView!;
//MARK: 初始化
  required public init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder);
    }
    override init(frame: CGRect) {
        super.init(frame:frame);
        viewSize=frame.size;
        self.setUpView();
    }

 private  func setUpView(){
        initSubview();
        //设置子控件fram
        initSubviewFrame();
        //设置view
        
    }
 private func initSubview( )
    {
        if show_star0==nil
        {
            show_star0=UIImageView();
        }
        show_star0.image=UIImage(named:star_gray)!
         show_star0.contentMode=UIViewContentMode.ScaleAspectFit;
        if show_star1==nil
        {
            show_star1=UIImageView();
        }
        show_star1.image=UIImage(named:star_gray)!
        show_star1.contentMode=UIViewContentMode.ScaleAspectFit;
        if show_star2==nil
        {
            show_star2=UIImageView();
        }
        show_star2.image=UIImage(named:star_gray)!
        show_star2.contentMode=UIViewContentMode.ScaleAspectFit;
        if show_star3==nil
        {
            show_star3=UIImageView();
        }
        show_star3.image=UIImage(named:star_gray)!
        show_star3.contentMode=UIViewContentMode.ScaleAspectFit;
        if show_star4==nil
        {
            show_star4=UIImageView();
        }
        show_star4.image=UIImage(named:star_gray)!
        show_star4.contentMode=UIViewContentMode.ScaleAspectFit;
        //添加到self
        self.addSubview(show_star0);
        self.addSubview(show_star1);
        self.addSubview(show_star2);
        self.addSubview(show_star3);
        self.addSubview(show_star4);
        }
  private  func initSubviewFrame()
    {
        show_star0.frame=CGRectMake(0, 2,viewSize.width/5,viewSize.height-4.0);
        show_star1.frame=CGRectMake(CGRectGetMaxX(show_star0.frame), 2,viewSize.width/5,viewSize.height-4.0);
        show_star2.frame=CGRectMake(CGRectGetMaxX(show_star1.frame), 2,viewSize.width/5,viewSize.height-4.0);
        show_star3.frame=CGRectMake(CGRectGetMaxX(show_star2.frame), 2,viewSize.width/5,viewSize.height-4.0);
        show_star4.frame=CGRectMake(CGRectGetMaxX(show_star3.frame), 2,viewSize.width/5,viewSize.height-4.0);
    }

//MARK:根据传入的评分值计算需要显示的星级
 public  func showStarbyRatingValueWith(RatingValue value:Float)
    {
        
        //取整数部分
        var intNum = Int(value*0.5);
        //取小数部分
        var floatNum = value*0.5-Float(intNum)
        //如果小于0
        
        if value<=0{
            return;
        }
        //大于0
        floatNum-=0.5;
        if ( floatNum > 0.2)
        {
            print("进1")
            self.calculateStarNumberByValue(intNum+1, hasHalf: false);
        }else if (floatNum < -0.2){
            print("舍去")
            self.calculateStarNumberByValue(intNum, hasHalf: false);
        }else
        {
          self.calculateStarNumberByValue(intNum, hasHalf: true);
        }
    }
    
    private func calculateStarNumberByValue(number:Int,hasHalf:Bool)
    {
        // 清除之前的分值（初始化）
        self.initSubview();
        //设置新的值
        for (var i=0;i<number;i++)
        {
            var imageview:UIImageView=self.subviews[i] as UIImageView;
            imageview.image=UIImage(named: star_red);
        }
        if hasHalf
        {
           var imageview:UIImageView=self.subviews[number] as UIImageView;
            imageview.image=UIImage(named: star_halfred);
        }
        
    }
  
    
}