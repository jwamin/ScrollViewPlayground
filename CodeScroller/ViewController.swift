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
    var pagingSwitch:UISwitch!
    var constraints:[NSLayoutConstraint] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.backgroundColor = UIColor.red
        self.view.translatesAutoresizingMaskIntoConstraints = false
        
        
        scrollView = UIScrollView(frame: self.view.frame)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = UIColor.white
        scrollView.isPagingEnabled = false
        
        stacker = UIStackView(frame: scrollView.frame)
        stacker.translatesAutoresizingMaskIntoConstraints = false
        
        stacker.axis = .vertical
        stacker.alignment = .center
        stacker.distribution = .equalSpacing
        
        for _ in 0...20{
            let view = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 100, height: 100)))
            view.translatesAutoresizingMaskIntoConstraints = false
            
            let funkySubview = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 100, height: 100)))
            funkySubview.backgroundColor = UIColor.randomNamedColor()
            funkySubview.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(funkySubview)

            stacker.addArrangedSubview(view)
        }
        
        setupViews()
        
        scrollView.addSubview(stacker)
        
        view.addSubview(scrollView)
        
        pagingSwitch = UISwitch()
        pagingSwitch.isOn = scrollView.isPagingEnabled
        pagingSwitch.translatesAutoresizingMaskIntoConstraints = false
        pagingSwitch.addTarget(self, action: #selector(changed(_:)), for: .valueChanged)
        let rotation = CGFloat(-45 * (.pi/180.0));
        pagingSwitch.transform = CGAffineTransform(rotationAngle: rotation)
        view.addSubview(pagingSwitch)
        
        print(view.constraints, "before constraint fn",view.frame.size)
        setupConstraints()
        print("initial setup done",self.constraints.count,self.view.constraints.count)
    }
    
    private func setupViews(){
        for view in stacker.arrangedSubviews{
            let subview = view.subviews[0]
            var viewref:UIView
            if(scrollView.isPagingEnabled){
                view.backgroundColor = UIColor.white
                subview.isHidden = false
                stacker.spacing = 0
                viewref = subview
            } else {
                view.backgroundColor = UIColor.randomNamedColor()
                subview.isHidden = true
                stacker.spacing = 10
                viewref = view
            }
            
            if(viewref.backgroundColor == UIColor.white || viewref.backgroundColor == UIColor.clear){
                viewref.layer.borderColor = UIColor.black.cgColor
                viewref.layer.borderWidth = 1.0
            }
        }

    }
    
    @objc
    func changed(_ sender:Any){
        print("trying change")
        self.view.removeConstraints(self.constraints)
        constraints.removeAll()
        scrollView.isPagingEnabled = pagingSwitch.isOn
        setupViews()
        setupConstraints()
        print("done",self.constraints.count,self.view.constraints.count)
    }
    
    func removeAllConstraints(view:UIView,recursive:Bool){
        
        //print("deactivating \(view.constraints.count) constraints at \(view)")
        view.removeConstraints(view.constraints)
        
        if(recursive){
            //print("recursive")
            for subview in view.subviews{
                removeAllConstraints(view: subview, recursive: true)
            }
        }
        
        
    }
    
    func adjustSpacing(){
        let height = self.view.frame.height
        stacker.spacing = (height - 100) / 2
    }
    
    override func viewWillLayoutSubviews() {
        print("will layout subviews")
        print(view.constraints.count)
    }
    
    func setupConstraints(){
        
        if(self.constraints.count == 0){
            var views = ["scroll":scrollView!,"stack":stacker!,"switch":pagingSwitch] as [String:Any]
            for (index,arranged) in stacker.arrangedSubviews.enumerated(){
                views["arranged"+String(index)] = arranged
            }
            var constraints = [NSLayoutConstraint]()
            
            //constrain switch to bottom right
            constraints += NSLayoutConstraint.constraints(withVisualFormat: "H:[switch]-|", options: [], metrics: nil, views: views)
            constraints += NSLayoutConstraint.constraints(withVisualFormat: "V:[switch]-|", options: [], metrics: nil, views: views)
            
            //scrollview constraints, pin scrollview to four corners of superview
            constraints += NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[scroll]-0-|", options: [], metrics: nil, views: views)
            constraints += NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[scroll]-0-|", options: [], metrics: nil, views: views)
            
            //scrollview constraints, pin stackview to four corners of scrollview, this sets up the content area
            constraints += NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[stack]-0-|", options: [], metrics: nil, views: views)
            constraints += NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[stack]-0-|", options: [], metrics: nil, views: views)
            
            
            if(scrollView.isPagingEnabled){
                //if paging is set, set the arranged subview ("page") to the height of the scrollview, this ensures 100% height pages
                constraints += NSLayoutConstraint.constraints(withVisualFormat: "H:[arranged0(scroll)]", options: [], metrics: nil, views: views)
                constraints += NSLayoutConstraint.constraints(withVisualFormat: "V:[arranged0(scroll)]", options: [], metrics: nil, views: views)
            } else {
                //if not, set arranged subview heights to be 100
                constraints += NSLayoutConstraint.constraints(withVisualFormat: "[arranged0(==100)]", options: [], metrics: nil, views: views)
                constraints += [NSLayoutConstraint(item: views["arranged0"]!, attribute: .height, relatedBy: .equal, toItem: views["arranged0"], attribute: .width, multiplier: 1.0, constant: 0.0)]
                
                let centerXConstraint = NSLayoutConstraint(item: stacker, attribute: .centerX, relatedBy: .equal, toItem: scrollView, attribute: .centerX, multiplier: 1.0, constant: 0)
                constraints.append(centerXConstraint)
            }
            

            for index in 1..<(stacker.arrangedSubviews.count){
                
                let currentView = views["arranged"+String(index)] as! UIView
                
                constraints += [
                    NSLayoutConstraint(item: currentView, attribute: .height, relatedBy: .equal, toItem: views["arranged0"], attribute: .height, multiplier: 1.0, constant: 0.0),
                    NSLayoutConstraint(item: currentView, attribute: .width, relatedBy: .equal, toItem: views["arranged0"], attribute: .width, multiplier: 1.0, constant: 0.0)
                ]
                
            }
            
            if(scrollView.isPagingEnabled){
       
                for page in stacker.arrangedSubviews{
                    let subview = page.subviews[0]
                    
                    constraints += [
                        NSLayoutConstraint(item: subview, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1.0, constant: 100),
                        NSLayoutConstraint(item: subview, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1.0, constant: 100),
                        NSLayoutConstraint(item:subview, attribute: .centerX, relatedBy: .equal, toItem: page, attribute: .centerX, multiplier: 1.0, constant: 0.0),
                        NSLayoutConstraint(item:subview, attribute: .centerY, relatedBy: .equal, toItem: page, attribute: .centerY, multiplier: 1.0, constant: 0.0)
                    ]
                }
            }
            
            self.constraints = constraints
            print("activating \(constraints.count) constraints")
            NSLayoutConstraint.activate(constraints)
            
            
        }
        
    }
    
    
}


