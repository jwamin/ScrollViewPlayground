//
//  ViewController.swift
//  scroll hero
//
//  Created by Joss Manger on 3/25/19.
//  Copyright © 2019 Joss Manger. All rights reserved.
//

import UIKit

class Hero3ViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var textviewTopConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var iamge: UIImageView!
    @IBOutlet weak var proportionalHeightConstraint: NSLayoutConstraint!
    
    var initialHeight:CGFloat!
    
    var initialValueForLayoutConstraint:CGFloat!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.navigationItem.title = "Title"
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print(scrollView.contentOffset)
        let y = scrollView.contentOffset.y
        updateTopConstraint(yValue: y)
        
    }
    
    private func updateTopConstraint(yValue:CGFloat){
        
        let divisor:CGFloat = 2
        
        if((yValue / divisor)  < iamge.intrinsicContentSize.height){
            proportionalHeightConstraint.constant = yValue / divisor
        } else {
            proportionalHeightConstraint.constant = iamge.intrinsicContentSize.height
            
        }
        
        print(proportionalHeightConstraint.constant)
        
    }
    
}

