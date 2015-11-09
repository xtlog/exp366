//
//  ViewController.swift
//  ex366
//
//  Created by xtlog on 15/10/21.
//  Copyright (c) 2015年 sxnic. All rights reserved.
//

import UIKit
import SDWebImage

class ViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var imageScroll: UIScrollView!
    
    @IBOutlet weak var imagePctl: UIPageControl!
    
    var timer:NSTimer!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //let testObejct : AVObject = AVObject(className: "TestObject")
        //testObejct["foo"] = " test success"
        //testObejct.save()
        
        
        
        
        pictureGallery();
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func pictureGallery(){   //实现图片滚动播放；
        //image width
        let imageW:CGFloat = self.imageScroll.frame.size.width;//获取ScrollView的宽作为图片的宽；
        let imageH:CGFloat = self.imageScroll.frame.size.height;//获取ScrollView的高作为图片的高；
        let imageY:CGFloat = 0;//图片的Y坐标就在ScrollView的顶端；
        
        //加载图片列表数据
        let query : AVQuery = AVQuery(className: "TopicContent")
        
        query.findObjectsInBackgroundWithBlock { (result, err) -> Void in
            if ((err) != nil){
                NSLog("loadData error", result.count)
            }else{
                
                
                let totalCount:NSInteger = result.count;//轮播的图片数量；
                for index in 0..<totalCount{
                    let imageView:UIImageView = UIImageView();
                    let imageX:CGFloat = CGFloat(index) * imageW;
                    imageView.frame = CGRectMake(imageX, imageY, imageW, imageH);//设置图片的大小，注意Image和ScrollView的关系，其实几张图片是按顺序从左向右依次放置在ScrollView中的，但是ScrollView在界面中显示的只是一张图片的大小，效果类似与画廊；
                    //let name:String = String(format: "gallery%d", index+1);
                    let object:AVObject = result[index] as! AVObject;
                    let url = object.objectForKey("titleImage") as! String
                    let imgurl = NSURL(string:url)
                    //图片数据
                    //let wimage:SDImageCache = SDImageCache();
                    imageView.sd_setImageWithURL(imgurl)
                    
                    //imageView.image = UIImage(data: data!)
                    self.imageScroll.showsHorizontalScrollIndicator = false;//不设置水平滚动条；
                    self.imageScroll.addSubview(imageView);//把图片加入到ScrollView中去，实现轮播的效果；
                }
                
                //需要非常注意的是：ScrollView控件一定要设置contentSize;包括长和宽；
                let contentW:CGFloat = imageW * CGFloat(totalCount);//这里的宽度就是所有的图片宽度之和；
                self.imageScroll.contentSize = CGSizeMake(contentW, 0);
                self.imageScroll.pagingEnabled = true;
                self.imageScroll.delegate = self;
                self.imagePctl.numberOfPages = totalCount;//下面的页码提示器；
                self.addTimer()
                
                
            }
        }

        
    }
    
    func nextImage(sender:AnyObject!){//图片轮播；
        var page:Int = self.imagePctl.currentPage;
        if(page == 1){   //循环；
            page = 0;
        }else{
            page++;
        }
        let x:CGFloat = CGFloat(page) * self.imageScroll.frame.size.width;
        self.imageScroll.contentOffset = CGPointMake(x, 0);//注意：contentOffset就是设置ScrollView的偏移；
    }
    
    func addTimer(){   //图片轮播的定时器；
        self.timer = NSTimer.scheduledTimerWithTimeInterval(5, target: self, selector: "nextImage:", userInfo: nil, repeats: true);
    }
    
 

}

