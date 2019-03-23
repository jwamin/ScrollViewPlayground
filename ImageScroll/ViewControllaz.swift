//
//  ViewController.swift
//  ImageScroll
//
//  Created by Joss Manger on 2/11/19.
//  Copyright © 2019 Joss Manger. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var desiredX: NSLayoutConstraint!
    @IBOutlet weak var desiredY: NSLayoutConstraint!
    @IBOutlet weak var marker: UIView!
    @IBOutlet weak var imgview: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    var shouldAnimate:Bool = false
    var animating:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //scrollView.contentSize = imgview.image?.size ?? CGSize.zero
        imgview.frame.size = imgview.image!.size
        
        scrollView.delegate = self
        
        //setZoomParameters(scrollView.bounds.size)
        //centerImage()
        
        
        
        
    }

    func setZoomParameters(_ scrollViewSize:CGSize){
        let imagesize = imgview.bounds.size
        let widthscale = scrollViewSize.width / imagesize.width
        let heightScale = scrollViewSize.height / imagesize.height
        let minscale = min(widthscale, heightScale)
        
        scrollView.minimumZoomScale = minscale
        scrollView.maximumZoomScale = 4.0
        scrollView.zoomScale = minscale
        
    }
    
    func centerImage(){
        let scrollviewSize = scrollView.bounds.size
        let imagesize = imgview.frame.size
        let horizontalSpace = imagesize.width < scrollviewSize.width ? (scrollviewSize.width - imagesize.width) / 2 : 0
        let verticalSpace = imagesize.height < scrollviewSize.height ? (scrollviewSize.height - imagesize.height) / 2 : 0
        
        scrollView.contentInset = UIEdgeInsets(top: verticalSpace, left: horizontalSpace, bottom: verticalSpace, right: horizontalSpace)
    }
    
    override func viewWillLayoutSubviews() {
        //setZoomParameters(scrollView.bounds.size)
        //centerImage()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        setMarkerColor()
        animate()
    }

    func animate(){
        
        if !shouldAnimate {
            marker.layer.removeAnimation(forKey: "bounce anim")
            animating = false
            return
        }
        
        if(animating){
            return
        }
        
        
        
        let animation = CASpringAnimation(keyPath: "position")
        let newPosition = CGPoint(x: marker.layer.position.x, y: marker.layer.position.y+10)
        animation.initialVelocity = 20
        animation.mass = 1
        animation.damping = 10
        animation.stiffness = 10
        animation.toValue = newPosition
        animation.duration = 1
        animation.repeatCount = .infinity
        animation.autoreverses = true
        
        CATransaction.begin()
        marker.layer.add(animation, forKey: "bounce anim")
        animating = true
        CATransaction.commit()
    }
    
    private func setMarkerColor(){
        let currentPoint = marker.frame.origin
        let desiredPoint = CGPoint(x: desiredX.constant, y: desiredY.constant)
        print(currentPoint,desiredPoint)
        
        if(currentPoint == desiredPoint) {
            print("match")
            marker.backgroundColor = UIColor.green
            shouldAnimate = true
        } else {
            print("nah")
            marker.backgroundColor = UIColor.red
            shouldAnimate = false
        }
        
    }
    
    
}

extension ViewController : UIScrollViewDelegate{
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imgview
    }
}
