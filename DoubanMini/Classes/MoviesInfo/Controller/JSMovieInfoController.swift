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
    var movielistArray:NSMutableArray!;//电影信息列表
    var indicator:UIActivityIndicatorView!;
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
        NSBundle.mainBundle().loadNibNamed("MovieInfo", owner: self, options: nil);
         SetUpView();
    }
     override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated);
    }
 func SetUpView()
 {
    self.title="正在上映";
    var leftbtn:UIButton=UIButton.buttonWithType(UIButtonType.Custom) as UIButton;
    leftbtn.setBackgroundImage(UIImage(named: "refresh_pressed.png"), forState: UIControlState.Normal);
    leftbtn.setBackgroundImage(UIImage(named: "refresh_pressed.png"), forState: UIControlState.Highlighted);
    leftbtn.frame=CGRectMake(0, 0, 32.0, 32.0);
    leftbtn.addTarget(self, action:"refreshData", forControlEvents: UIControlEvents.TouchUpInside);
    var left:UIBarButtonItem=UIBarButtonItem(customView: leftbtn);
    self.navigationItem.setLeftBarButtonItem(left, animated: true);
    
    MovieList.frame=CGRectMake(0, 0,MovieList.frame.size.width, MovieList.frame.size.height-CGFloat( Ktabbar_height));
    if MovieInfoCell==nil
    {
        MovieInfoCell=JSMoviedetialCell(frame: CGRectMake(0, 0, 100, 175));
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
    self.movielistArray=NSMutableArray();
    self.indicator=UIActivityIndicatorView();
    self.indicator.frame=CGRectMake(self.view.bounds.size.width*0.4, self.view.bounds.size.height*0.5, 60, 60);
    self.view.addSubview(self.indicator);
    self.indicator.activityIndicatorViewStyle=UIActivityIndicatorViewStyle.Gray;
 
    //获取数据
    self.getinfoFromDouban();
    }
    //MARK:获取电影数据
    func getinfoFromDouban()
    {
        self.indicator.startAnimating();
        getinfoTool?.getMovieInfoFromDoubanServiceWithBlock({
            (dic:[NSObject : AnyObject]!) -> Void in
            var thedic:NSDictionary = dic;
            self.movielistArray=thedic.valueForKey("entries") as NSMutableArray;
            self.MovieList.reloadData();
            self.indicator.stopAnimating();
            }, failed: { (error:NSError!) -> Void in
                
        });
    }

      //MARK:Collectionview代理
     func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    
            return self.movielistArray.count;
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        var cell:JSMoviedetialCell=collectionView.dequeueReusableCellWithReuseIdentifier(CellIdentifier, forIndexPath: indexPath) as JSMoviedetialCell;
       //在此处传入电影数据
        var movie_name:NSString = ( movielistArray[indexPath.row] as NSDictionary)["title"] as NSString;
        var picurl:NSString=((movielistArray[indexPath.row] as NSDictionary)["images"] as NSDictionary)["medium"] as NSString;
        var rating:NSString=( movielistArray[indexPath.row] as NSDictionary)["rating"] as NSString;
        cell.setMoviedetialCellBy(MovieName: movie_name, MoviePic:picurl, MovieRating: rating.floatValue);
        return cell;
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        //点击进入电影信息详细
    }
 
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    
    }
 //MARK:刷新列表
    func refreshData()
    {
        self.getinfoFromDouban();
    }
}
