//
//  Extensions.swift
//  MySwift
//
//  Created by hechuan on 2019/5/9.
//  Copyright © 2019 hechuan. All rights reserved.
//

import Foundation
import UIKit

extension UIColor{
  class  var randomColor: UIColor {
        get{
        let red = CGFloat(arc4random()%256)/255.0
                    let green = CGFloat(arc4random()%256)/255.0
                    let blue = CGFloat(arc4random()%256)/255.0
                    return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
        }
    }
}
