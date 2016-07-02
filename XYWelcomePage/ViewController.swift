//
//  ViewController.swift
//  XYWelcomePage
//
//  Created by 酸奶 on 16/7/2.
//  Copyright © 2016年 Color. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UIScrollViewDelegate {

    var scrollView = UIScrollView()
    var pageControl = UIPageControl()
    var btn = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //配置pageControl
        pageControl.center = CGPointMake(self.view.frame.width/2, self.view.frame.height-30)
        pageControl.currentPageIndicatorTintColor = UIColor.redColor()
        pageControl.pageIndicatorTintColor = UIColor.whiteColor()
        pageControl.numberOfPages = 4
        pageControl.addTarget(self, action: #selector(scrollViewDidEndDecelerating), forControlEvents: UIControlEvents.ValueChanged)
        //配置scrollView
        scrollView.frame = self.view.bounds
        scrollView.contentSize = CGSizeMake(4*self.view.frame.width, 0)
        scrollView.pagingEnabled = true
        scrollView.bounces = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.delegate = self
        self.view.addSubview(scrollView)
        for i in 0...3
        {
            let image = UIImage(named: "\(i+1)")
            let imageView = UIImageView(frame: CGRectMake(0, 0, self.view.frame.width, self.view.frame.height))
            imageView.image = image
            var frame = imageView.frame
            frame.origin.x = CGFloat(i)*frame.size.width
            imageView.frame = frame
            scrollView.addSubview(imageView)
            self.view.addSubview(pageControl)
        }

    }
    
    //按钮点击事件
    func buttonClick(button:UIButton)
    {
        //界面的跳转
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let rootVC = sb.instantiateViewControllerWithIdentifier("root")
        self.presentViewController(rootVC, animated: true, completion: nil)
    }
    
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        let index = Int(scrollView.contentOffset.x / self.view.frame.size.width)    //获取当前页数
        pageControl.currentPage = index
        //在这里添加按钮的渐入效果,当页面滑到第4页时出现
        if(index == 3)
        {
            self.btn.frame = CGRectMake(3*self.view.frame.width, self.view.frame.height, self.view.frame.width, 50)
            self.btn.setTitle("开启Swift之旅", forState: UIControlState.Normal)
            self.btn.titleLabel?.font = UIFont.systemFontOfSize(20)
            self.btn.setTitleColor(UIColor.grayColor(), forState: UIControlState.Highlighted)
            self.btn.backgroundColor = UIColor.orangeColor()
            self.btn.alpha = 0
            self.btn.addTarget(self, action: #selector(buttonClick), forControlEvents: UIControlEvents.TouchUpInside)
            UIView.animateWithDuration(1.5, delay: 0.5, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
                self.btn.frame = CGRectMake(3*self.view.frame.width, self.view.frame.height-100, self.view.frame.width, 50)
                self.btn.alpha = 1
                //注意把按钮添加到scrollView上,不要添加到imageView上,会无法点击
                self.scrollView.addSubview(self.btn)
                }, completion: nil)
        }
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

