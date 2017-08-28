//
//  ViewController.swift
//  SwiftStudy
//
//  Created by bianjianfeng on 2017/8/12.
//  Copyright © 2017年 Jeff_Bian. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    private var _tableview:UITableView?
    var tableview:UITableView?{
        if _tableview == nil {
            _tableview = UITableView(frame: CGRect.zero)
            _tableview?.backgroundColor = UIColor.clearColor()
            _tableview?.dataSource = self
            _tableview?.delegate = self
            _tableview?.separatorStyle = UITableViewCellSeparatorStyleSingleLine
            _tableview?.showsVerticalScrollIndicator = false
            _tableview?.scrollsToTop = false
            _tableview?.contentInset = UIEdgeInsetsMake(0, 0, 49, 0)
            let leftLineView = UIView(frame: CGRect(x: 0, y: 8, width: 3, height: 28))
            leftLineView.backgroundColor = XT_MAINCOLOR
            _tableview?.addSubview(leftLineView)
//            self.leftLineView = leftLineView
        }
        return _tableview!
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

