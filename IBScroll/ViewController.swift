//
//  ViewController.swift
//  IBScroll
//
//  Created by Joss Manger on 2/7/19.
//  Copyright © 2019 Joss Manger. All rights reserved.
//

import UIKit

class ViewController: UIViewController {


    override func viewDidLoad() {
        super.viewDidLoad()
        print("view loaded")
        // Do any additional setup after loading the view, typically from a nib.
        //scroll.contentSize = image.image?.size
    }


}

class BlockView : UIView{
    
    override class var layerClass : AnyClass {
        return CAShapeLayer.self
    }
    
    func initAnimation(){
        var rotation = CATransform3DMakeRotation(CGFloat(degreesToRadians: 180), 0, 0, 1)

        layer.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        rotation.m34 = 1.0 / 250
        CATransaction.begin()
        let basic = CABasicAnimation(keyPath: "transform")
        basic.fromValue = CATransform3DIdentity
        basic.toValue = rotation
        basic.repeatCount = .infinity
        basic.duration = 10.0
        basic.fillMode = .both
        
        
        let group = CAAnimationGroup()
        group.duration = 2.0
        group.repeatCount = .infinity
        
        let path = CABasicAnimation(keyPath: "strokeStart")
        path.fromValue = 0.0
        path.toValue = 1.0
        path.duration = 0.5
        path.fillMode = .both
        path.beginTime = 0.5
        //
    
        let path2 = CABasicAnimation(keyPath: "strokeEnd")
        path2.fromValue = 0.0
        path2.toValue = 1.0
        path2.duration = 0.5
        path2.fillMode = .both
        //path2.timeOffset = CACurrentMediaTime()

        
        group.animations = [path2,path]
        
        
        self.layer.add(group, forKey: "stroke")
        self.layer.add(basic, forKey: "rotation")
        
        CATransaction.commit()
    }
    
    override func awakeFromNib() {
        //self.backgroundColor = UIColor.white
        print("loaded")
    
        initAnimation()
        
    }
    
    func initShapeLayer(){
        guard let layer = self.layer as? CAShapeLayer else {
            print("no worky")
            return
        }
        
        layer.path = CGPath(rect: self.bounds, transform: nil)
        
        layer.strokeStart = 0
        layer.strokeEnd = 1.0
        layer.lineCap = .round
        //layer.lineDashPattern = []
        layer.strokeColor = UIColor.randomNamedColor().cgColor
        layer.lineWidth = 10.0
        layer.fillColor = UIColor.randomNamedColor().cgColor
    }
    
    override func draw(_ rect: CGRect) {
        
       initShapeLayer()
        
    }
    
}
