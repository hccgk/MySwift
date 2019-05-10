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
    ///返回一个随机颜色的类方法
  class  var randomColor: UIColor {
        get{
        let red = CGFloat(arc4random()%256)/255.0
                    let green = CGFloat(arc4random()%256)/255.0
                    let blue = CGFloat(arc4random()%256)/255.0
                    return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
        }
    }
}

extension Date {
    
    /// 获取当前 秒级 时间戳 - 10位
    var timeStamp : String {
        let timeInterval: TimeInterval = self.timeIntervalSince1970
        let timeStamp = Int(timeInterval)
        return "\(timeStamp)"
    }
    
    /// 获取当前 毫秒级 时间戳 - 13位
    var milliStamp : String {
        let timeInterval: TimeInterval = self.timeIntervalSince1970
        let millisecond = CLongLong(round(timeInterval*1000))
        return "\(millisecond)"
    }
}
