//
//  ViewController.swift
//  DRPageControl_Swift
//
//  Created by xqzh on 16/7/6.
//  Copyright © 2016年 xqzh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var v:DRPageControl?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        v = DRPageControl(frame: CGRectMake(0, 70, 375, 20))
        v!.backgroundColor = UIColor.cyanColor()
        v!.numberOfPages = 5
        v!.currentPage = 0
        v!.dotColor = UIColor.whiteColor()
        v!.dotSize  = 15
        self.view.addSubview(v!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        v!.currentPage += 1
    }


}

