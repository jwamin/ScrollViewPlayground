//
//  ViewController.swift
//  CodeScroller
//
//  Created by Joss Manger on 2/11/19.
//  Copyright © 2019 Joss Manger. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var scrollView:UIScrollView!
    var stacker:UIStackView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.backgroundColor = UIColor.red
        scrollView = UIScrollView(frame: self.view.frame)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = UIColor.white
        scrollView.isPagingEnabled = false
        
        stacker = UIStackView(frame: scrollView.frame)
        stacker.translatesAutoresizingMaskIntoConstraints = false
        
        stacker.axis = .vertical
        stacker.alignment = .fill
        stacker.distribution = .equalSpacing
        
        if(!scrollView.isPagingEnabled){
            stacker.spacing = 10
        }
        
        for _ in 0...20{
            let view = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 100, height: 100)))
            view.translatesAutoresizingMaskIntoConstraints = false
            view.backgroundColor = UIColor.randomNamedColor()
            print(view.backgroundColor == UIColor.white || view.backgroundColor == UIColor.clear)
            if(view.backgroundColor == UIColor.white || view.backgroundColor == UIColor.clear){
                view.layer.borderColor = UIColor.black.cgColor
                view.layer.borderWidth = 1.0
            }
            stacker.addArrangedSubview(view)
        }
        
        scrollView.addSubview(stacker)
        scrollView.contentSize = stacker.frame.size
        view.addSubview(scrollView)
        
        setupConstraints()
        
    }
    
    func adjustSpacing(){
        let height = self.view.frame.height
        stacker.spacing = (height - 100) / 2
    }
    
    override func viewWillLayoutSubviews() {
        print("will layout subviews")
        
    }
    
    func setupConstraints(){
        
        if(self.view.constraints.count == 0){
            var views = ["scroll":scrollView,"stack":stacker]
            for (index,arranged) in stacker.arrangedSubviews.enumerated(){
                views["arranged"+String(index)] = arranged
            }
            var constraints = [NSLayoutConstraint]()
            print(views.keys)
            //scrollview constraints
            //constraints += NSLayoutConstraint.constraints(withVisualFormat: "H:|-[scroll]-|", options: [], metrics: nil, views: views)
            //constraints += NSLayoutConstraint.constraints(withVisualFormat: "V:|-[scroll]-|", options: [], metrics: nil, views: views)
            constraints += NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[scroll]-0-|", options: [], metrics: nil, views: views)
            constraints += NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[scroll]-0-|", options: [], metrics: nil, views: views)
            constraints += NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[stack]-0-|", options: [], metrics: nil, views: views)
            constraints += NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[stack]-0-|", options: [], metrics: nil, views: views)
            let centerConstraint = NSLayoutConstraint(item: stacker, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1.0, constant: 0.0)
            constraints += NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[stack]", options: [], metrics: nil, views: views)
            
            
            if(scrollView.isPagingEnabled){
                constraints += NSLayoutConstraint.constraints(withVisualFormat: "H:[arranged0(==100)]", options: [], metrics: nil, views: views)
                constraints += NSLayoutConstraint.constraints(withVisualFormat: "V:[arranged0(scroll)]", options: [], metrics: nil, views: views)
            } else {
                constraints += NSLayoutConstraint.constraints(withVisualFormat: "[arranged0(==100)]", options: [], metrics: nil, views: views)
                constraints += [NSLayoutConstraint(item: views["arranged0"], attribute: .height, relatedBy: .equal, toItem: views["arranged0"], attribute: .width, multiplier: 1.0, constant: 0.0)]
            }
            

            
            //constraints += NSLayoutConstraint.constraints(withVisualFormat: "V:[arranged0(==100)]", options: [], metrics: nil, views: views)
            constraints.append(centerConstraint)
            
            for index in 1..<(stacker.arrangedSubviews.count){
                print("arranged"+String(index))
                constraints += [
                    NSLayoutConstraint(item: views["arranged"+String(index)], attribute: .height, relatedBy: .equal, toItem: views["arranged0"], attribute: .height, multiplier: 1.0, constant: 0.0),
                     NSLayoutConstraint(item: views["arranged"+String(index)], attribute: .width, relatedBy: .equal, toItem: views["arranged0"], attribute: .width, multiplier: 1.0, constant: 0.0)
                ]
                
            }
            
            NSLayoutConstraint.activate(constraints)
            
            
        }
        
    }


}

extension UIColor{
    static func randomNamedColor()->UIColor{
        
        let colors = [
            UIColor.black,
            UIColor.darkGray,
            UIColor.lightGray,
            UIColor.white,
            UIColor.gray,
            UIColor.red,
            UIColor.green,
            UIColor.blue,
            UIColor.cyan,
            UIColor.yellow,
            UIColor.magenta,
            UIColor.orange,
            UIColor.purple,
            UIColor.brown,
            UIColor.clear
        ]
        
        return colors[Int(arc4random_uniform(UInt32(colors.count)))]
      
    }
}
