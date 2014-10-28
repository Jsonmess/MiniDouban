//
//  JSMovieInfoController.swift
//  DoubanMini
//
//  Created by json on 14/10/24.
//  Copyright (c) 2014年 jsonmess. All rights reserved.
//

import UIKit

let MovieCellSize = CGSizeMake(100.0, 160.0)//cellsize
let CellIdentifier:NSString = "movieinfoCell" //cell重用标识
class JSMovieInfoController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate {

//定义变量
    @IBOutlet weak var MovieList: UICollectionView!;
    
    var MovieInfoCell: JSMoviedetialCell?;
    var getinfoTool:JSGetDoubanMovieInfo?;
   //function
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override init() {
        super.init();
       
    }
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil);
    }
    override func viewDidLoad() {
        super.viewDidLoad();
         SetUpView();
    }

 func SetUpView()
 {
    self.title="豆瓣电影";
  NSBundle.mainBundle().loadNibNamed("MovieInfo", owner: self, options: nil);
    MovieList.frame=CGRectMake(0, 0,MovieList.frame.size.width, MovieList.frame.size.height-CGFloat( Ktabbar_height));
    if MovieInfoCell==nil
    {
        MovieInfoCell=JSMoviedetialCell(frame: CGRectMake(0, 0, 100, 160));
    }
    MovieList.dataSource=self;
    MovieList.delegate=self;
    //rigister cell
    MovieList.registerClass(MovieInfoCell?.classForCoder, forCellWithReuseIdentifier: CellIdentifier);
    self.view.addSubview(MovieList);
    //获取豆瓣电影数据
    if getinfoTool==nil
    {
        getinfoTool=JSGetDoubanMovieInfo();
    }
    getinfoTool?.getMovieInfoFromDoubanService();
 }

      //MARK:Collectionview代理
     func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 40;
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        var cell:JSMoviedetialCell=collectionView.dequeueReusableCellWithReuseIdentifier(CellIdentifier, forIndexPath: indexPath) as JSMoviedetialCell;
       //在此处传入电影数据
        return cell;
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        //点击进入电影信息详细
    }
 
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    
    }
 
}
