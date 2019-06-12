//
//  CardPageControl.swift
//  MySwift
//
//  Created by hechuan on 2019/6/11.
//  Copyright © 2019 hechuan. All rights reserved.
//

import UIKit

class CardPageControl: UIPageControl {
    let controlW = 4.0
    let betweenW = 8.0
    override func layoutSubviews() {
        super.layoutSubviews()
        self.isUserInteractionEnabled = false
//        let originX = self.frame.size.width/2.0 - 2
        let count = subviews.count
        let centerW = Double(count) *  controlW + Double(count - 1) * betweenW
        let startX  = (Double(self.frame.size.width) - centerW)/2.0
        for (index,value) in self.subviews.enumerated() {
            
            value.frame = CGRect.init(x: startX + Double(index) * (controlW + betweenW), y: Double(value.frame.origin.y), width: 4.0, height: 4.0)
            value.layer.cornerRadius = 0
            value.layer.masksToBounds = false
        }
        
    }
    
   
}
