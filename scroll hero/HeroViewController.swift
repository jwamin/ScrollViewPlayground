//
//  ViewController.swift
//  scroll hero
//
//  Created by Joss Manger on 3/25/19.
//  Copyright © 2019 Joss Manger. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    @IBOutlet weak var scrollView: UIScrollView!
    
    var initialValueForLayoutConstraint:CGFloat!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        initialValueForLayoutConstraint = topConstraint.constant
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print(scrollView.contentOffset)
        let y = scrollView.contentOffset.y
        updateTopConstraint(yValue: y)
        
    }
    
    private func updateTopConstraint(yValue:CGFloat){
        
        if(yValue > initialValueForLayoutConstraint){
            topConstraint.constant = 0
        } else {
            topConstraint.constant = initialValueForLayoutConstraint - yValue
        }
        
        
        
        print(topConstraint.constant)
        
    }

}

class Hero2ViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var iamge: UIImageView!

    
    var initialValueForLayoutConstraint:CGFloat!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        initialValueForLayoutConstraint = topConstraint.constant
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print(scrollView.contentOffset)
        let y = scrollView.contentOffset.y
        updateTopConstraint(yValue: y)
        
    }
    
    private func updateTopConstraint(yValue:CGFloat){
        
        if(yValue > initialValueForLayoutConstraint){
            topConstraint.constant = 0
        } else {
            topConstraint.constant = initialValueForLayoutConstraint - yValue
        }
        
        
        
        print(topConstraint.constant)
        
    }
    
}

