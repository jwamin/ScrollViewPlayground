//
//  ViewController.swift
//  Stacky
//
//  Created by Joss Manger on 3/22/19.
//  Copyright © 2019 Joss Manger. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func viewSafeAreaInsetsDidChange() {
        view.layoutIfNeeded()
    }

}

@IBDesignable final class CirclularView:UIView {
    
    override var frame: CGRect{
        didSet{
            self.layer.cornerRadius = frame.width / 2
        }
    }
    
    var shadowRadius:CGFloat = 0.0 {
        didSet{
            self.layer.shadowRadius = shadowRadius
        }
    }
    
   var shadowColor:UIColor = UIColor.black {
        didSet{
            self.layer.shadowColor = shadowColor.cgColor
        }
    }
    
    var shadowOffset:CGSize = CGSize(width: 10, height: 10) {
        didSet{
            self.layer.shadowOffset = shadowOffset
        }
    }
    
    override func prepareForInterfaceBuilder() {
        awakeFromNib()
    }
    
    override func awakeFromNib() {
        self.layer.shadowPath = CGPath(ellipseIn: self.bounds, transform: nil)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowOffset = shadowOffset
    }

    override func layoutSubviews() {
        self.layer.cornerRadius = frame.width / 2
        awakeFromNib()
    }
    
    
    
}
