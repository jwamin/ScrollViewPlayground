//
//  Extensions.swift
//  Scrollr
//
//  Created by Joss Manger on 2/13/19.
//  Copyright © 2019 Joss Manger. All rights reserved.
//

import UIKit

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

extension CGFloat{
    init(degreesToRadians:Float){
        self = CGFloat(degreesToRadians * (.pi/180.0));
    }
}
