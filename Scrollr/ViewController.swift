//
//  ViewController.swift
//  Scrollr
//
//  Created by Joss Manger on 2/6/19.
//  Copyright © 2019 Joss Manger. All rights reserved.
//

import UIKit

enum ScrollVisible:Int{
    case visible = 0
    case partial
    case hidden
}

class ViewController: UIViewController,UIScrollViewDelegate {
    
    var scrollview:ScrollViewWithDrawing!
    var headerview:UIView!
    var itemvisible:ScrollVisible = .visible
    var button:UIButton!
    var buttonstate = true
    
    var set1:[NSLayoutConstraint]!
    var set2:[NSLayoutConstraint]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        self.view.backgroundColor = UIColor.cyan
        self.view.layer.borderColor = UIColor.red.cgColor
        self.view.layer.borderWidth = 2.0
        self.view.translatesAutoresizingMaskIntoConstraints = false
        let inset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        let insetFrame = self.view.bounds.inset(by: inset)
        let scrollviewFrame = CGRect(origin: .zero, size: CGSize(width:insetFrame.width, height:insetFrame.height*4))
        scrollview = ScrollViewWithDrawing(frame: insetFrame)
        
        scrollview.translatesAutoresizingMaskIntoConstraints = false
        
        scrollview.contentSize = scrollviewFrame.size
        
        
        let contentinset = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
        scrollview.contentInset = contentinset
        scrollview.contentOffset = .zero
        
        scrollview.delegate = self
        scrollview.backgroundColor = UIColor.yellow
        self.view.addSubview(scrollview)
        
        let testview = UIView(frame: CGRect(origin: CGPoint(x: 0, y: 60), size: CGSize(width: scrollviewFrame.width, height: 100)))
        testview.translatesAutoresizingMaskIntoConstraints = false
        testview.backgroundColor = UIColor.black
        scrollview.addSubview(testview)
        
        
        headerview = UIView(frame: CGRect(origin: .zero, size: CGSize(width: self.view.bounds.width, height: 100)))
        headerview.backgroundColor = UIColor.red
        view.addSubview(headerview)
        
        button = UIButton(frame: CGRect(origin: .zero, size: CGSize(width: 50, height: 50)))
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor.green
        button.addTarget(self, action: #selector(scrollToTop), for: .touchUpInside)
        button.layer.cornerRadius = 50
        self.view.addSubview(button)
        addConstraints()
        
       
        
    }
    
    @objc func scrollToTop(){
        scrollview.setContentOffset(.zero, animated: true)
        scrollview.layoutIfNeeded()
    }
    
    func addConstraints(){
        if(button.constraints.count == 0){
            var constraints = [NSLayoutConstraint]()
            let views = ["button":button] as [String:Any]
            constraints += NSLayoutConstraint.constraints(withVisualFormat: "H:[button(==100)]-|", options: [], metrics: nil, views: views)
            constraints += NSLayoutConstraint.constraints(withVisualFormat: "V:[button]-|", options: [], metrics: nil, views: views)
            let arConstriant = NSLayoutConstraint(item: button, attribute: .height, relatedBy: .equal, toItem: button, attribute: .width, multiplier: 1.0, constant: 0)
//            let radiusConstant = NSLayoutConstraint(item: button.layer.cornerRadius, attribute: .notAnAttribute, relatedBy: .equal, toItem: button, attribute: .height, multiplier: 0.5, constant: 1.0)
//            constraints.append(radiusConstant)
            constraints.append(arConstriant)
            
            set1 = constraints
            //NSLayoutConstraint.activate(constraints)
            
            constraints = [NSLayoutConstraint]()
            constraints += NSLayoutConstraint.constraints(withVisualFormat: "H:[button(==100)]-100-|", options: [], metrics: nil, views: views)
            constraints += NSLayoutConstraint.constraints(withVisualFormat: "V:[button]-|", options: [], metrics: nil, views: views)
            let arConstriant2 = NSLayoutConstraint(item: button, attribute: .height, relatedBy: .equal, toItem: button, attribute: .width, multiplier: 1.0, constant: 0)
            constraints.append(arConstriant2)
            set2 = constraints
            NSLayoutConstraint.activate(set1)
          
        }
    }
    
    func scrollViewDidScrollToTop(_ scrollView: UIScrollView) {
        print("scrolled to top")
        animateButton(true)
    }
    
    @objc
    func animateButton(_ open:Bool = false){

        
        
        //self.view.removeConstraints(view.constraints)
        
        //(buttonstate) ? NSLayoutConstraint.activate(set2) : NSLayoutConstraint.activate(set1)
        
        if(buttonstate != open){
            print("animate button called")
            UIView.animate(withDuration: 0.5) {
                self.button.transform = (self.buttonstate) ? CGAffineTransform(translationX: 150, y: 0) : CGAffineTransform.identity
                
            }
            
            buttonstate = open
        }
        
       
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        print(scrollview.contentOffset)
        
        if scrollview.contentOffset.y < 0{
            animateButton(false)
        } else {
            animateButton(true)
        }
        
        
        let view = scrollview.subviews[0]
        if(scrollview.bounds.contains(view.frame)){
            if(itemvisible != .visible){
                print("view is fully visible")
                itemvisible = .visible
            }
        } else if (scrollview.bounds.intersects(view.frame)) {
            if(itemvisible != .partial){
                print("view partially hidden")
                itemvisible = .partial
            }
        } else {
            if(itemvisible != .hidden){
                print("view fully hidden")
                itemvisible = .hidden
            }
        }
        
        if((scrollView.contentOffset.y)<100){
            headerview.isHidden = false
            //print("\(scrollView.contentOffset.y+44.0) in range around the 100 point mark")
            headerview.layer.opacity = 1-Float((scrollView.contentOffset.y) / 100)
        } else {
            headerview.isHidden = true
            //print(scrollView.contentOffset.y)
        }
        
        
    }
    
}

class ScrollViewWithDrawing : UIScrollView {
    
    
    
    //    override func draw(_ rect: CGRect) {
    //
    //        let context = UIGraphicsGetCurrentContext()
    //        print(rect)
    //        let myStride = CGFloat(60)
    //        context?.setLineWidth(1.0)
    //        context?.setLineWidth(myStride)
    //
    //        var stripeTracker = false
    //        for i in stride(from: 0, to: rect.height, by: myStride){
    //            context?.beginPath()
    //            let start = CGPoint(x: 0, y: i)
    //            let end = CGPoint(x: rect.width, y: i)
    //            let color = (stripeTracker) ? UIColor.blue.cgColor : UIColor.yellow.cgColor
    //            context?.setStrokeColor(color)
    //            print("\((color==UIColor.blue.cgColor) ? "blue":"yellow") at \(start.y)")
    //            context?.move(to: start)
    //            context?.addLine(to: end)
    //            stripeTracker = !stripeTracker
    //            context?.strokePath()
    //        }
    //
    //
    //
    //
    //
    //    }
    
}

